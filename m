From: Dan Hecht <dhecht@vmware.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and disable
	unsupported config options.
Date: Tue, 13 Feb 2007 14:53:38 -0800
Message-ID: <45D24172.9020800@vmware.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.542511707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070213221830.542511707@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/13/2007 02:17 PM, Jeremy Fitzhardinge wrote:
> The XEN config option enables the Xen paravirt_ops interface, which is
> installed when the kernel finds itself running under Xen. (By some
> as-yet fully defined mechanism, implemented in a future patch.)
> =

> Xen is no longer a sub-architecture, so the X86_XEN subarch config
> option has gone.
> =

> The disabled config options are:
> - PREEMPT: Xen doesn't support it
> - HZ: set to 100Hz for now, to cut down on VCPU context switch rate.
>   This will be adapted to use tickless later.
> - kexec: not yet supported
> =


I assume you plan to eventually get all this stuff working but just want =

to prevent configurations that the Xen paravirt-ops isn't ready for at =

the moment?

Instead can you do it this way:

config XEN
     depends on PARAVIRT && !PREEMPT && HZ_100 && !DOUBLEFAULT && !KEXEC


thanks,
Dan


> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> =

> ---
>  arch/i386/Kconfig       |    7 +++++--
>  arch/i386/Kconfig.debug |    1 +
>  arch/i386/xen/Kconfig   |   10 ++++++++++
>  kernel/Kconfig.hz       |    4 ++--
>  kernel/Kconfig.preempt  |    1 +
>  5 files changed, 19 insertions(+), 4 deletions(-)
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -192,6 +192,8 @@ config PARAVIRT
>  	  under a hypervisor, improving performance significantly.
>  	  However, when run without a hypervisor the kernel is
>  	  theoretically slower.  If in doubt, say N.
> +
> +source "arch/i386/xen/Kconfig"
>  =

>  config ACPI_SRAT
>  	bool
> @@ -298,12 +300,12 @@ config X86_UP_IOAPIC
>  =

>  config X86_LOCAL_APIC
>  	bool
> -	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER) || X86_G=
ENERICARCH
> +	depends on X86_UP_APIC || (((X86_VISWS || SMP) && !X86_VOYAGER) || X86_=
GENERICARCH)
>  	default y
>  =

>  config X86_IO_APIC
>  	bool
> -	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER)) || X86=
_GENERICARCH
> +	depends on X86_UP_IOAPIC || ((SMP && !(X86_VISWS || X86_VOYAGER)) || X8=
6_GENERICARCH)
>  	default y
>  =

>  config X86_VISWS_APIC
> @@ -743,6 +745,7 @@ source kernel/Kconfig.hz
>  =

>  config KEXEC
>  	bool "kexec system call"
> +	depends on !XEN
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
>  	  current kernel, and to start another kernel.  It is like a reboot
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/Kconfig.debug
> +++ b/arch/i386/Kconfig.debug
> @@ -79,6 +79,7 @@ config DOUBLEFAULT
>  config DOUBLEFAULT
>  	default y
>  	bool "Enable doublefault exception handler" if EMBEDDED
> +	depends on !XEN
>  	help
>            This option allows trapping of rare doublefault exceptions that
>            would otherwise cause a system to silently reboot. Disabling t=
his
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ b/arch/i386/xen/Kconfig
> @@ -0,0 +1,10 @@
> +#
> +# This Kconfig describes xen options
> +#
> +
> +config XEN
> +	bool "Enable support for Xen hypervisor"
> +	depends PARAVIRT
> +	default y
> +	help
> +	  This is the Linux Xen port.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/Kconfig.hz
> +++ b/kernel/Kconfig.hz
> @@ -3,7 +3,7 @@
>  #
>  =

>  choice
> -	prompt "Timer frequency"
> +	prompt "Timer frequency" if !XEN
>  	default HZ_250
>  	help
>  	 Allows the configuration of the timer frequency. It is customary
> @@ -49,7 +49,7 @@ endchoice
>  =

>  config HZ
>  	int
> -	default 100 if HZ_100
> +	default 100 if HZ_100 || XEN
>  	default 250 if HZ_250
>  	default 300 if HZ_300
>  	default 1000 if HZ_1000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -35,6 +35,7 @@ config PREEMPT_VOLUNTARY
>  =

>  config PREEMPT
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
> +	depends on !XEN
>  	help
>  	  This option reduces the latency of the kernel by making
>  	  all kernel code (that is not executing in a critical section)
> =
