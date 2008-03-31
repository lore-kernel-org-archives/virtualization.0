From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [01/17]PATCH  Add API for allocating dynamic TR resouce. V8
Date: Mon, 31 Mar 2008 15:41:41 +0200
Message-ID: <47F0EA15.9030408__12454.2089798071$1206971444$gmane$org@de.ibm.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104823F@pdsmsx415.ccr.corp.intel.com>
Reply-To: carsteno@de.ibm.com
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
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> +/*  mca_insert_tr
> + *
> + *  Switch rid when TR reload and needed!
> + *  iord: 1: itr, 2: itr;
> + *
> +*/
> +static void mca_insert_tr(u64 iord)
> +{
> +
> +	int i;
> +	u64 old_rr;
> +	struct ia64_tr_entry *p;
> +	unsigned long psr;
> +	int cpu = smp_processor_id();
What if CONFIG_PREEMPT is on, and we're being preempted and scheduled 
to a different CPU here? Are we running preempt disabled here? If so, 
the function header should state that this function needs to be called 
preempt_disabled.

> +/*
> + * ia64_insert_tr in virtual mode. Allocate a TR slot
> + *
> + * target_mask : 0x1 : itr, 0x2 : dtr, 0x3 : idtr
> + *
> + * va 	: virtual address.
> + * pte 	: pte entries inserted.
> + * log_size: range to be covered.
> + *
> + * Return value:  <0 :  error No.
> + *
> + *		  >=0 : slot number allocated for TR.
> + */
> +int ia64_itr_entry(u64 target_mask, u64 va, u64 pte, u64 log_size)
> +{
> +	int i, r;
> +	unsigned long psr;
> +	struct ia64_tr_entry *p;
> +	int cpu = smp_processor_id();
Same here.

> +/*
> + * ia64_purge_tr
> + *
> + * target_mask: 0x1: purge itr, 0x2 : purge dtr, 0x3 purge idtr.
> + *
> + * slot: slot number to be freed.
> + */
> +void ia64_ptr_entry(u64 target_mask, int slot)
> +{
> +	int cpu = smp_processor_id();
> +	int i;
> +	struct ia64_tr_entry *p;
Here again.
