From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [01/17]PATCH  Add API for allocating dynamic TR resouce. V8
Date: Tue, 01 Apr 2008 09:48:09 +0200
Message-ID: <47F1E8B9.3010806__29996.3845209733$1207036501$gmane$org@de.ibm.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104823F@pdsmsx415.ccr.corp.intel.com>
	<47F0EA15.9030408@de.ibm.com>
	<42DFA526FC41B1429CE7279EF83C6BDC010483DA@pdsmsx415.ccr.corp.intel.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC010483DA@pdsmsx415.ccr.corp.intel.com>
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
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, carsteno@de.ibm.com, Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, "Xu, Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> Carsten Otte wrote:
>> Zhang, Xiantao wrote:
>>> +/*  mca_insert_tr
>>> + *
>>> + *  Switch rid when TR reload and needed!
>>> + *  iord: 1: itr, 2: itr;
>>> + *
>>> +*/
>>> +static void mca_insert_tr(u64 iord)
>>> +{
>>> +
>>> +	int i;
>>> +	u64 old_rr;
>>> +	struct ia64_tr_entry *p;
>>> +	unsigned long psr;
>>> +	int cpu = smp_processor_id();
>> What if CONFIG_PREEMPT is on, and we're being preempted and scheduled
>> to a different CPU here? Are we running preempt disabled here? If so,
>> the function header should state that this function needs to be called
>> preempt_disabled.
> 
> The function insert one TR to local TLB, and doesn't allow preempt
> before and after the call, so the caller should be with preempt_disable
> before calling into this routine. 
> Maybe the descripiton of this function should contain "Called with
> preempt disabled!".  Does it make sense ?
Yea, I think a comment would help in that case :-).
