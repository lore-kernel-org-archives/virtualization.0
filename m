From: Zachary Amsden <zach@vmware.com>
Subject: Compile error with !CONFIG_PARAVIRT
Date: Fri, 08 Dec 2006 05:36:20 -0800
Message-ID: <45796A54.6050903@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

FYI - I was working on some changes, and just noticed this with =

!CONFIG_PARAVIRT.

  CC      arch/i386/kernel/alternative.o
arch/i386/kernel/alternative.c:436: error: ?apply_paravirt? undeclared =

here (not in a function)
arch/i386/kernel/alternative.c:436: warning: type defaults to ?int? in =

declaration of ?apply_paravirt?
arch/i386/kernel/alternative.c:437: error: ?__start_parainstructions? =

undeclared here (not in a function)
arch/i386/kernel/alternative.c:437: warning: type defaults to ?int? in =

declaration of ?__start_parainstructions?
arch/i386/kernel/alternative.c:438: error: ?__stop_parainstructions? =

undeclared here (not in a function)
arch/i386/kernel/alternative.c:438: warning: type defaults to ?int? in =

declaration of ?__stop_parainstructions?
make[1]: *** [arch/i386/kernel/alternative.o] Error 1
make: *** [arch/i386/kernel] Error 2

Any takers, or should I wait till Chris finishes rebasing against -git?

Zach
