From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] mm: fix comment formatting in
	asm-generic/pgtable.h:__ptep_modify_prot_
Date: Tue, 03 Jun 2008 00:53:43 +0100
Message-ID: <48448807.7020601@goop.org>
References: <patchbomb.1212192268@localhost> <20080602111339.GB18586@elte.hu>
	<4843EF6A.20305@goop.org>
	<200806030946.00434.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200806030946.00434.rusty@rustcorp.com.au>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Monday 02 June 2008 23:02:34 Jeremy Fitzhardinge wrote:
>   
>> Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
>> ---
>>  include/asm-generic/pgtable.h |   14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> ===================================================================
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -201,9 +201,11 @@
>>  					     unsigned long addr,
>>  					     pte_t *ptep)
>>  {
>> -	/* Get the current pte state, but zero it out to make it
>> -	   non-present, preventing the hardware from asynchronously
>> -	   updating it. */
>> +	/*
>> +	 * Get the current pte state, but zero it out to make it
>> +	 * non-present, preventing the hardware from asynchronously
>> +	 * updating it.
>> +	 */
>>     
>
> Since there is debate over whether winged comments are a feature, I'm not sure 
> this can be termed a "fix".
>   

I don't feel all that strongly about it in this case.  I'm not a huge 
fan of winged style for inline comments like this, but it is consistent 
with the rest of the file, and the comment is (just) long enough to make 
it not look completely stupid.

>>  {
>> -	/* The pte is non-present, so there's no hardware state to
>> -	   preserve. */
>> +	/*
>> +	 * The pte is non-present, so there's no hardware state to
>> +	 * preserve.
>> +	 */
>>  	set_pte_at(mm, addr, ptep, pte);
>>  }
>>     
>
> This will fit in one line, no? 
>   

Yes, but changing it would mean going to the effort of regenerating the 
patch.

    J
