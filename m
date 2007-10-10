From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops
 into smaller pv_*_ops
Date: Wed, 10 Oct 2007 11:02:50 -0700
Message-ID: <470D13CA.3000202@goop.org>
References: <470BC758.1030504@goop.org> <200710101635.10139.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756541AbXJJSDp@vger.kernel.org>
In-Reply-To: <200710101635.10139.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Huh, thought I did a more complete reply to this.  Must have farted on it.

Rusty Russell wrote:
> Thanks Jeremy, I've actually taken time to finally review this in detail (I'm 
> assuming you'll refactor as necessary after the x86 arch merger).
>   

Yep.

>> +struct paravirt_ops paravirt_ops;
>> +
>>     
>
> Do you actually need to define this?  See below...
>
>   
>> +DEF_NATIVE(, ud2a, "ud2a");
>>     
>
> Hmm, that's ugly.  It was ugly before, but it's uglier now.  Maybe just 
> use "unsigned char ud2a[] = { 0x0f, 0x0b };" in paravirt_patch_default?
>   

Yeah, its not pretty.  I'll have another go.

>>  }
>>
>>  struct paravirt_ops paravirt_ops = {
>>     
> ...
>   
>> +	.pv_info = {
>> +		.name = "bare hardware",
>> +		.paravirt_enabled = 0,
>> +		.kernel_rpl = 0,
>> +		.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
>> +	},
>>     
>
> This is the bit I don't get.  Why not just declare struct pv_info pvinfo, etc, 
> and use the declaration of struct paravirt_ops to get your unique 
> offset-based identifiers for patching?
>   

Given an op id number in .parainstructions, the patching code needs to
be able to index into something to get the corresponding function
pointer.  If each pv_* structure is its own little unrelated structure,
then the id has to be a <structure, id> tuple, which just complicates
things.  If I pack them all into a single structure then it becomes a
simple offset calculation.

That said, there's no need for pv_info to be in that structure, since it
contains no function pointers.  I'll move it out.

    J
