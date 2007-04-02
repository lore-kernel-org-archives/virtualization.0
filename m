From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 12/17] Consistently wrap paravirt ops callsites to make
 them patchable
Date: Mon, 02 Apr 2007 00:20:08 -0700
Message-ID: <4610AEA8.7010604@goop.org>
References: <20070402055652.610711908@goop.org> <20070402055705.090656820@goop.org> <200704020911.50623.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753349AbXDBHUX@vger.kernel.org>
In-Reply-To: <200704020911.50623.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Can you please add some comments to the code explaining this a little?
> Best would be perhaps a overview document in Documentation too.
>   

Yes, OK.

>> +#define PVOP_CALL0(__rettype, __op)					\
>>     
>
> The __s shouldn't be needed for the macro arguments because
> there is no shared name space with the caller.
>   

Yes.  I was more concerned about "op" clashing with variables used
within the macro, but that's not an issue now.

>> +	({								\
>> +		__rettype __ret;					\
>> +		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
>> +			unsigned long long __tmp;			\
>> +			unsigned long __ecx;				\
>> +			asm volatile(paravirt_alt(PARAVIRT_CALL)	\
>>     
>
> Not having the volatile would probably generate better code, but it 
> seems much safer for now.
>   

I think it has to be there, though perhaps the "memory" is sufficient to
make sure all the calls get generated.  We don't want gcc to eliminate
any of these calls because it thinks they can be CSEd.

> And the cc clobber is also not needed
>   

I get conflicting advice about this.  I think Linus mentioned that the
gcc people would prefer it to be there explicitly, even though its
currently implied.


    J
