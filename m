From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Thu, 11 Jul 2013 14:43:03 +0530
Message-ID: <51DE771F.7070805__24118.6620587998$1373533812$gmane$org@linux.vnet.ibm.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<1372171802.3804.30.camel@oc2024037011.ibm.com>
	<51CAAA26.4090204@linux.vnet.ibm.com>
	<20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
	<20130626161130.GB18152@redhat.com>
	<51CB2AD9.5060508@linux.vnet.ibm.com>
	<51DBD3C2.2040807@linux.vnet.ibm.com>
	<20130710103325.GP24941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130710103325.GP24941@redhat.com>
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

On 07/10/2013 04:03 PM, Gleb Natapov wrote:
[...] trimmed

>>> Yes. you are right. dynamic ple window was an attempt to solve it.
>>>
>>> Probelm is, reducing the SPIN_THRESHOLD is resulting in excess halt
>>> exits in under-commits and increasing ple_window may be sometimes
>>> counter productive as it affects other busy-wait constructs such as
>>> flush_tlb AFAIK.
>>> So if we could have had a dynamically changing SPIN_THRESHOLD too, that
>>> would be nice.
>>>
>>
>> Gleb, Andrew,
>> I tested with the global ple window change (similar to what I posted
>> here https://lkml.org/lkml/2012/11/11/14 ),
> This does not look global. It changes PLE per vcpu.

Okay. Got it. I was thinking it would change the global value. But IIRC
  It is changing global sysfs value and per vcpu ple_window.
Sorry. I missed this part yesterday.

>
>> But did not see good result. May be it is good to go with per VM
>> ple_window.
>>
>> Gleb,
>> Can you elaborate little more on what you have in mind regarding per
>> VM ple_window. (maintaining part of it as a per vm variable is clear
>> to
>>   me), but is it that we have to load that every time of guest entry?
>>
> Only when it changes, shouldn't be to often no?

Ok. Thinking how to do. read the register and writeback if there need
to be a change during guest entry?
