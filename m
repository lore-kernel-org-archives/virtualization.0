From: Jes Sorensen <jes@sgi.com>
Subject: Re: [01/17]PATCH  Add API for allocating dynamic TR resouce. V8
Date: Mon, 31 Mar 2008 11:03:45 +0200
Message-ID: <47F0A8F1.2090109__39941.48144634$1206974970$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104823F@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC0104823F@pdsmsx415.ccr.corp.intel.com>
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

Hi Xiantao,

I general I think the code in this patch is fine. I have a couple of
nit-picking comments:

> +	if (target_mask&0x1) {

The formatting here isn't quite what most of the kernel does. It would
be better if you added spaces so it's a little easier to read, ie:

	if (target_mask & 0x1) {

> +		p = &__per_cpu_idtrs[cpu][0][0];
> +		for (i = IA64_TR_ALLOC_BASE; i <= per_cpu(ia64_tr_used,
> cpu);
> +								i++,
> p++) {
> +			if (p->pte&0x1)

Same thing here.

> +#define RR_TO_RID(rr) ((rr)<<32>>40)

I would prefer to have this one defined like this:

#define RR_TO_RID(rr)	(rr >> 8) & 0xffffff

It should generate the same code, but is more intuitive for the reader.

Otherwise I think this patch is fine - this is really just cosmetics.

Cheers,
Jes
