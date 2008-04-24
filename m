From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Thu, 24 Apr 2008 13:52:20 +0200
Message-ID: <48107474.8010400__21281.9190383472$1209038484$gmane$org@sgi.com>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<1207716549755-git-send-email-yamahata@valinux.co.jp>
	<yq08wz6l0jd.fsf@jaguar.mkp.net>
	<20080422101113.GH28863%yamahata@valinux.co.jp>
	<480DD4A7.9020207@sgi.com>
	<20080423025414.GA7679%yamahata@valinux.co.jp>
	<480F41CE.3000803@sgi.com>
	<20080424111913.GB15640%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080424111913.GB15640%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> On Wed, Apr 23, 2008 at 04:03:58PM +0200, Jes Sorensen wrote:
>> Isaku Yamahata wrote:
>>>> I'd rather have PARAVIRT_NR_IRQ set from Kconfig if possible given that
>>>> all of these are constants anyway. If we cannot do that, then it would
>>>> be better to do the #if FOO_NR_IRQ > PARAVIRT_NR_IRQ in the various
>>>> header files for Xen/KVM/lguest so we don't get the clutter in the main
>>>> makefile.
>>> Unfotunately Kconfig doesn't support arithmetic comparison.
>>> So do you want something like the followings?
>> IMHO, that would be better.
> 
> How about this?
> Eventually I found another way which doesn't use #undef trick.
> ASM_OFFSET_C is somewhat tricky, but much better, I suppose.

Hi Isaku,

Yes, this looks like a much nicer way to solve the problem IMHO.

> +/*
> + * PARAVIRT_NR_IRQS is defined by asm-offsets.c as
> + * max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, ...) depending on config.
> + */
> +#ifndef ASM_OFFSETS_C
> +#include <asm/asm-offsets.h>
> +#define NR_IRQS	PARAVIRT_NR_IRQS
>  #endif
>  
>  static __inline__ int

Shouldn't this be defined as IA64_NATIVE_NR_IRQS? I wouldn't do the
#ifndef ASM_OFFSETS_C part, you should be able to just include it
unconditionally.

Cheers,
Jes
