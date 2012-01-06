From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Fri, 6 Jan 2012 16:59:13 +0000
Message-ID: <alpine.DEB.2.00.1201061648440.3150@kaball-desktop>
References: <1325867990-15018-1-git-send-email-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325867990-15018-1-git-send-email-drjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 6 Jan 2012, Andrew Jones wrote:
> XEN_DOM0 is a silent option that has been automatically selected when
> CONFIG_XEN is selected since 6b0661a5e6fbf. If this option was changed
> to a menu configurable option then it would only give users the ability
> to compile out about 100 kbytes of code.

I think that it is less than that because backends are not tied to dom0
in any way, even though currently they cannot be compiled without
XEN_DOM0.
Running a network or block backend in domU is a well known
configuration.
Therefore the code compiled out only amounts to about 10K.


> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 8795480..0725228 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -78,8 +78,9 @@ config XEN_DEV_EVTCHN
>  
>  config XEN_BACKEND
>  	bool "Backend driver support"
> -	depends on XEN_DOM0
>  	default y
> +	depends on XEN && PCI_XEN && SWIOTLB_XEN
> +	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
>  	help
>  	  Support for backend device drivers that provide I/O services
>  	  to other virtual machines.

I think we can trimmer the dependency list here: after all backends can
be run in unpriviledged guests as well (see driver domains).
So I think it should depend only on XEN.
