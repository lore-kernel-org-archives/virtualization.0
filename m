From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 13/28] ia64/xen: introduce xen hypercall routines necessary
	for domU.
Date: Thu, 21 Feb 2008 15:47:10 -0800
Message-ID: <47BE0D7E.7080301__33446.2927225561$1203638432$gmane$org@goop.org>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
	<20080221091902.716789000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080221091902.716789000@ls.local.valinux.co.jp>
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
> +static inline unsigned long
> +HYPERVISOR_machtophys(unsigned long mfn)
> +{
> +	unsigned long ret = mfn;
> +	if (is_running_on_xen())
>   

Do you often call hypercalls when not booting under Xen?  It seems to me 
this check should have already been done at a higher layer, and it 
needn't be repeated here.

> +		ret = __HYPERVISOR_machtophys(mfn);
> +	return ret;
> +}

    J
