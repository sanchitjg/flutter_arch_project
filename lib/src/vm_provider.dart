import 'package:provider/provider.dart';

import 'icontroller.dart';
import 'view_model.dart';

class VMProvider<P extends ViewModel> extends ChangeNotifierProvider<P> {

  VMProvider({
    super.key,
    super.child,
    required Create<P> create,
    super.builder,
    super.lazy,
  }) : super(
    create: (context){
      return context.read<IController>()
          .addVM(create(context), key) as P;
    },
  );

}