From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH for stable] x86/spinlocks/paravirt: Fix memory corruption
	on unlock
Date: Wed, 25 Feb 2015 11:14:38 +0100
Message-ID: <54EDA08E.5080901__44348.4755502597$1424859310$gmane$org@de.ibm.com>
References: <1424769899-14158-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150224141731.GA16033@kroah.com>
	<20150224144737.GA26074@gmail.com>
	<54ECC0A1.1080802@linux.vnet.ibm.com>
	<20150224183844.GA8654@kroah.com> <20150225100806.GA7134@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150225100806.GA7134@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: jeremy@goop.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, oleg@redhat.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am 25.02.2015 um 11:08 schrieb Ingo Molnar:
> 
> * Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>>>> It's:
>>>>
>>>>  d6abfdb20223 x86/spinlocks/paravirt: Fix memory corruption on unlock
>>>
>>> Yes, This is the original patch. Please note I have taken out the
>>> READ_ONCE changes from the original patch to avoid build warnings
>>> mentioned below.
>>> (Those READ_ONCE changes were cosmetic and was not present in the
>>> previous versions)
>>>
>>>>
>>>> You'll also need this fix from Linus to avoid (harmless)
>>>> build warnings:
>>>>
>>>>  dd36929720f4 kernel: make READ_ONCE() valid on const arguments
>>>
>>> So this may not be absolutely necessary with the current patch.
>>
>> I'd prefer to be as close as possible to the upstream 
>> patch.  So if applying both of these patches will work, 
>> I'd much rather do that. Changing patches when 
>> backporting them to stable for no good reason than to 
>> clean things up, just confuses everyone involved.
>>
>> Let's keep our messy history :)
> 
> By all means!
> 
> You'll first need to cherry-pick these commits:
> 


>  927609d622a3 kernel: tighten rules for ACCESS ONCE
>  c5b19946eb76 kernel: Fix sparse warning for ACCESS_ONCE
>  dd36929720f4 kernel: make READ_ONCE() valid on const arguments

If you go before 3.19, you will also need

   230fa253df63 kernel: Provide READ_ONCE and ASSIGN_ONCE
   43239cbe79fc kernel: Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)


> 
> That's the minimum set you will need for backporting, due 
> to overlapping changes to the ACCESS_ONCE() definition.
> 
> and then apply this commit:
> 
>  d6abfdb20223 x86/spinlocks/paravirt: Fix memory corruption on unlock

the alternative might be to replace READ_ONCE with ACCESS_ONCE when
doing the backport.
This depends on how important you consider backporting the ACCESS_ONCE fixes.

Christian
