From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Wed, 10 Jul 2013 17:20:40 +0530
Message-ID: <51DD4A90.7040507@linux.vnet.ibm.com>
References: <1372171802.3804.30.camel@oc2024037011.ibm.com>
	<51CAAA26.4090204@linux.vnet.ibm.com>
	<20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
	<51CB2AD9.5060508@linux.vnet.ibm.com>
	<51DBD3C2.2040807@linux.vnet.ibm.com>
	<20130710103325.GP24941@redhat.com>
	<51DD445C.5070801@linux.vnet.ibm.com>
	<20130710114150.GU24941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130710114150.GU24941@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, Andrew Jones <drjones@redhat.com>, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/10/2013 05:11 PM, Gleb Natapov wrote:
> On Wed, Jul 10, 2013 at 04:54:12PM +0530, Raghavendra K T wrote:
>>>> Ingo, Gleb,
>>>>
>>>>  From the results perspective, Andrew Theurer, Vinod's test results are
>>>> pro-pvspinlock.
>>>> Could you please help me to know what will make it a mergeable
>>>> candidate?.
>>>>
>>> I need to spend more time reviewing it :) The problem with PV interfaces
>>> is that they are easy to add but hard to get rid of if better solution
>>> (HW or otherwise) appears.
>>
>> Infact Avi had acked the whole V8 series, but delayed for seeing how
>> PLE improvement would affect it.
>>
> I see that Ingo was happy with it too.
>
>> The only addition from that series has been
>> 1. tuning the SPIN_THRESHOLD to 32k (from 2k)
>> and
>> 2. the halt handler now calls vcpu_on_spin to take the advantage of
>> PLE improvements. (this can also go as an independent patch into
>> kvm)
>>
>> The rationale for making SPIN_THERSHOLD 32k needs big explanation.
>> Before PLE improvements, as you know,
>> kvm undercommit scenario was very worse in ple enabled cases.
>> (compared to ple disabled cases).
>> pvspinlock patches behaved equally bad in undercommit. Both had
>> similar reason so at the end there was no degradation w.r.t base.
>>
>> The reason for bad performance in PLE case was unneeded vcpu
>> iteration in ple handler resulting in high yield_to calls and double
>> run queue locks.
>> With pvspinlock applied, same villain role was played by excessive
>> halt exits.
>>
>> But after ple handler improved, we needed to throttle unnecessary halts
>> in undercommit for pvspinlock to be on par with 1x result.
>>
> Make sense. I will review it ASAP. BTW the latest version is V10 right?
>

Yes. Thank you.
