From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 20/28] ia64/xen: domU xen machine vector without dma api.
Date: Thu, 21 Feb 2008 15:08:15 -0800
Message-ID: <47BE045F.6000604__30211.7555206225$1203635635$gmane$org@goop.org>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
	<20080221091904.811793000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080221091904.811793000@ls.local.valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yamahata@valinux.co.jp
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

yamahata@valinux.co.jp wrote:
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index 78f28d8..9c17a46 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -118,6 +118,10 @@ acpi_get_sysname(void)
>  		return "hpzx1";
>  	} else if (!strcmp(hdr->oem_id, "SGI")) {
>  		return "sn2";
> +#ifdef CONFIG_XEN
> +	} else if (is_running_on_xen() && !strcmp(hdr->oem_id, "XEN")) {
> +		return "xen";
> +#endif
>  	}

Is the #ifdef necessary?  Couldn't you make is_running_on_xen() just 
evaluate to 0 in the non-Xen case?

    J
