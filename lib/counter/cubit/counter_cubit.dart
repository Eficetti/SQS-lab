import 'package:aws_sqs_api/sqs-2012-11-05.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  final uuid = const Uuid();
  final client = SQS(
    region: 'us-east-1',
    credentials: AwsClientCredentials(
      accessKey: '',
      secretKey: '',
    ),
    client: http.Client(),
  );

  Future<void> increment() async {
    final messageGroupId = uuid.v1();
    final messageDuplicationId = uuid.v1();

    const queueUrl =
        '';

    await client.sendMessage(
      queueUrl: queueUrl,
      // messageBody: 'Message $state',
      messageBody: 'Prueba de dupes',
      messageGroupId: 'messageGroupId22',
      messageDeduplicationId: messageDuplicationId,
      messageAttributes: {
        'messageGroupId': MessageAttributeValue(
          dataType: 'String',
          stringValue: 'WEBHOOK POST GOAL',
        ),
        'messageDeduplicationId': MessageAttributeValue(
          dataType: 'String',
          stringValue: 'WEBHOOK POST GOAL',
        ),
      },
    );

    emit(state + 1);
  }

  void decrement() => emit(state - 1);
}
