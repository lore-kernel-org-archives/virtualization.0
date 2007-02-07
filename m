From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Slackware-11.0, Kernel-2.6.20, lguest-137.patch : compiling
	problem
Date: Thu, 08 Feb 2007 10:54:26 +1100
Message-ID: <1170892466.11736.26.camel@localhost.localdomain>
References: <20070207174431.61f285cd@nmr3.ioc.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070207174431.61f285cd@nmr3.ioc.ac.ru>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: strel@ioc.ac.ru
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-02-07 at 17:44 +0300, Strelenko Yuri A wrote:
>   Please, explain me, what is the problem in compiling kernel-2.6.20
> patched with lguest-137.patch in Slackware-11.0:
> =

>   LD [M]  drivers/kvm/kvm-intel.o
>   LD [M]  drivers/kvm/kvm-amd.o
>   CC      drivers/lguest/lguest_bus.o
>   LD      drivers/lguest/built-in.o
>   AS [M]  drivers/lguest/hypervisor.o
> drivers/lguest/hypervisor.S: Assembler messages:
> drivers/lguest/hypervisor.S:162: Error: bad expression
> drivers/lguest/hypervisor.S:162: Error: missing ')'
> drivers/lguest/hypervisor.S:162: Error: junk at end of line, first
> unrecognized character is `2' drivers/lguest/hypervisor.S:162: Error:
> bad expression drivers/lguest/hypervisor.S:162: Error: missing ')'
> drivers/lguest/hypervisor.S:162: Error: junk at end of line, first
> unrecognized character is `2'

Hi Yuri!

	Hmm, this is very odd.  Looks like it's barfing on the IRQ_STUB macro.
Can you do two things for me?

1) Please confirm that your line 162 is:
	IRQ_STUBS 0 1 return_to_host		/* First two traps */

2) Then please send me the output of "as --version", eg:
	GNU assembler 2.17 Debian GNU/Linux

Perhaps I accidentally used a new gas feature?

Thanks!
Rusty.
