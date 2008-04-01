From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [04/17] [PATCH] Add kvm arch-specific core code for kvm/ia64.-V8
Date: Tue, 01 Apr 2008 13:49:30 +0200
Message-ID: <47F2214A.90407__37844.6679249921$1207051120$gmane$org@de.ibm.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048245@pdsmsx415.ccr.corp.intel.com>
	<47F0FAA5.2090109@de.ibm.com>
	<42DFA526FC41B1429CE7279EF83C6BDC01048488@pdsmsx415.ccr.corp.intel.com>
	<47F1E9F8.6010801@de.ibm.com>
	<42DFA526FC41B1429CE7279EF83C6BDC0104870C@pdsmsx415.ccr.corp.intel.com>
	<47F2159B.5060709@de.ibm.com>
	<42DFA526FC41B1429CE7279EF83C6BDC01048735@pdsmsx415.ccr.corp.intel.com>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01048735@pdsmsx415.ccr.corp.intel.com>
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
>>> Carsten Otte wrote:
>>>> Zhang, Xiantao wrote:
>>>>> Hi, Carsten
>>>>>      Why do you think it is racy?  In this function,
>>>>> target_vcpu->arch.launched should be set to 1 for the first run,
>>>>> and keep its value all the time.  Except the first IPI to wake up
>>>>> the vcpu, all IPIs received by target vcpu should go into "else"
>>>>> condition. So you mean the race condition exist in "else"  code ?
>>>> For example to lock against destroying that vcpu. Or, the waitqueue
>>>> may become active after if (waitqueue_active()) and before
>>>> wake_up_interruptible(). In that case, the target vcpu might sleep
>>>> and not get waken up by the ipi.
>>> I don't think it may cause issue, because the target vcpu at least
>>> can be waken up by the timer interrupt.
>>>
>>> But as you said,  x86 side also have the same race issue ?
>> As far as I can tell, x86 does'nt have that race.
> 
> Hi, Carsten
> 	I can't understand why it only exist at IA64 side. Thank you! 
> Xiantao
Well, x86 does'nt signal the target processor by accessing the vcpu 
data structure. They use the IPI signal for that as far as I can see.
And s390 does have an explicit lock for this purpose. Itanium however, 
does not have a lock but does access the target vcpu struct.
