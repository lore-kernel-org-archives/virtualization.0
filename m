From: tgingold@free.fr
Subject: Re: [kvm-ia64-devel] [09/17] [PATCH] kvm/ia64: Add mmio decoder for
	kvm/ia64.
Date: Sun, 30 Mar 2008 16:34:30 +0200
Message-ID: <1206887670.47efa4f6290f8__4608.07737331397$1206887952$gmane$org@imp.free.fr>
References: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF7@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF7@pdsmsx415.ccr.corp.intel.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Selon "Zhang, Xiantao" <xiantao.zhang@intel.com>:

> >From 5f82ea88c095cf89cbae920944c05e578f35365f Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Wed, 12 Mar 2008 14:48:09 +0800
> Subject: [PATCH] kvm/ia64: Add mmio decoder for kvm/ia64.
[...]
> +			post_update = (inst.M5.i << 7) + inst.M5.imm7;
> +			if (inst.M5.s)
> +				temp -= post_update;
> +			else
> +				temp += post_update;

The sign extension is not done correctly here.  (This has been fixed in Xen
code).

> +			post_update = (inst.M3.i << 7) + inst.M3.imm7;
> +			if (inst.M3.s)
> +				temp -= post_update;
> +			else
> +				temp += post_update;

Ditto.

> +		post_update = (inst.M10.i << 7) + inst.M10.imm7;
> +		if (inst.M10.s)
> +			temp -= post_update;
> +		else
> +			temp += post_update;

Ditto.

> +		post_update = (inst.M10.i << 7) + inst.M10.imm7;
> +		if (inst.M10.s)
> +			temp -= post_update;
> +		else
> +			temp += post_update;

Ditto.

> +		post_update = (inst.M15.i << 7) + inst.M15.imm7;
> +		if (inst.M15.s)
> +			temp -= post_update;
> +		else
> +			temp += post_update;

Ditto.

Tristan.
