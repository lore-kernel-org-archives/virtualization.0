From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 05 Mar 2007 17:14:30 -0800
Message-ID: <45ECC076.9050209@goop.org>
References: <20070305120631.GA14105@elte.hu>		<1173101297.26165.39.camel@localhost.localdomain>	<1173142644.4644.6.camel@localhost.localdomain> <45ECBDDC.8080708@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933753AbXCFBOf@vger.kernel.org>
In-Reply-To: <45ECBDDC.8080708@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Rusty Russell wrote:
>> On Tue, 2007-03-06 at 00:28 +1100, Rusty Russell wrote:
>>  
>>> On Mon, 2007-03-05 at 13:06 +0100, Ingo Molnar wrote:
>>>    
>>>> Subject: [patch] paravirt: VDSO page is essential
>>>> From: Ingo Molnar <mingo@elte.hu>
>>>>
>>>> commit 3bbf54725467d604698721384d858b5983b87e8f disables the VDSO
>>>> for CONFIG_PARAVIRT kernels. This #ifdeffery was a bad change: the
>>>> VDSO is an essential component of Linux, and this change forces all
>>>> of them to use int $0x80 - including sane ones like KVM. (If a
>>>> hypervisor does not handle the VDSO properly then it can work
>>>> things around via the vdso=0 boot option. Or CONFIG_PARAVIRT should
>>>> not have been merged. But in any case, it is a basic taste issue:
>>>> we DO NOT #ifdef around core features like this!)
>>>>       
>>> I agree with the criticism, dislike the snarly comments, and disagree
>>> with this patch.
>>>     
>>
>> And my patch was pretty crack-induced too.  Sorry.
>>
>> I shouldn't have been thinking about using CONFIG options at all: we
>> should simply disable the vdso if CONFIG_COMPAT_VDSO=y when we
>> *actually* reserve top memory.
>>
>> This still need some work (doing that now), but do people like the idea?
>>
>> The current "vdso_disabled" flag merely disabled the ELF note, so it
>> needs to be made a little stronger, to not set up the vdso at all.
>>   
>
> I had just sent this out for internal review...
>

I think Jan's approach is better if it works (since there's no
compromise), but this is better if you want to get something working in
the near term.

    J
