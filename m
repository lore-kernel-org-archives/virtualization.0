From: Strelenko Yuri A <strel@ioc.ac.ru>
Subject: Slackware-11.0, Kernel-2.6.20, lguest-137.patch : compiling problem
Date: Wed, 7 Feb 2007 17:44:31 +0300
Message-ID: <20070207174431.61f285cd@nmr3.ioc.ac.ru>
Reply-To: strel@ioc.ac.ru
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
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

  Please, explain me, what is the problem in compiling kernel-2.6.20
patched with lguest-137.patch in Slackware-11.0:

  LD [M]  drivers/kvm/kvm-intel.o
  LD [M]  drivers/kvm/kvm-amd.o
  CC      drivers/lguest/lguest_bus.o
  LD      drivers/lguest/built-in.o
  AS [M]  drivers/lguest/hypervisor.o
drivers/lguest/hypervisor.S: Assembler messages:
drivers/lguest/hypervisor.S:162: Error: bad expression
drivers/lguest/hypervisor.S:162: Error: missing ')'
drivers/lguest/hypervisor.S:162: Error: junk at end of line, first
unrecognized character is `2' drivers/lguest/hypervisor.S:162: Error:
bad expression drivers/lguest/hypervisor.S:162: Error: missing ')'
drivers/lguest/hypervisor.S:162: Error: junk at end of line, first
unrecognized character is `2'
   and so on ....

	With best wishes and kind regards, Yuri Strelenko.

-- =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dr. Yuri A. Strelenko	=

N.D.Zelinsky Institute of Organic Chemistry
Leninsky prospect 47,119991 Moscow, Russia =

Tel    :      (7-095) 135 9094
Fax    :      (7-095) 135 5328
e-mail :      strel@ioc.ac.ru =

www    :      http://nmr.ioc.ac.ru
GPG-Key: http://nmr.ioc.ac.ru/Staff/StrelenkoYA/GnuPG/Strelenko.gpg
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
