From: Jes Sorensen <jes@sgi.com>
Subject: Re: [07/17][PATCH] kvm/ia64: Add TLB virtulization support.-V8
Date: Tue, 01 Apr 2008 10:49:39 +0200
Message-ID: <47F1F723.4010900__11121.5938035913$1207040148$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104824B@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC0104824B@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
>>From 6b731c15afa8cec84f16408c421c286f1dd1b7d3 Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Wed, 12 Mar 2008 13:45:40 +0800
> Subject: [PATCH] KVM:IA64 : Add TLB virtulization support.
> 
> vtlb.c includes tlb/VHPT virtulization.
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>

Hi Xiantao,

Just a clarification question on this one:


> +void machine_tlb_purge(u64 va, u64 ps)
> +{
> +	ia64_ptcl(va, ps << 2);
> +}

What is the purpose of machine_tlb_purge()? Is it supposed to do a
global purge of the tlb on the host machine? If so, how does this macro
differ from platform_global_tlb_purge()?

I am mentioning this because it's very important to keep in mind that
the regular tlb purging instructions are not functional on all ia64
platforms, which is why we have special implementations via the
machine vector interface.

Cheers,
Jes
