From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: [PATCH 3/16] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Thu, 01 Nov 2007 11:48:30 -0200
Message-ID: <4729D92E.2030108__38532.9311284751$1193924983$gmane$org@redhat.com>
References: <1193858101367-git-send-email-gcosta@redhat.com>
	<11938581073775-git-send-email-gcosta@redhat.com>
	<11938581133479-git-send-email-gcosta@redhat.com>
	<1193858118284-git-send-email-gcosta@redhat.com>
	<47295AA7.9090507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47295AA7.9090507@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Fitzhardinge escreveu:
> Glauber de Oliveira Costa wrote:
>> This patch introduces, and patch callers when needed, native
>> versions for read/write_crX functions, clts and wbinvd.
>>
>> Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>> ---
>>  arch/x86/mm/pageattr_64.c   |    3 +-
>>  include/asm-x86/system_64.h |   60 ++++++++++++++++++++++++++++++------------
>>  2 files changed, 45 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/mm/pageattr_64.c b/arch/x86/mm/pageattr_64.c
>> index c40afba..59a52b0 100644
>> --- a/arch/x86/mm/pageattr_64.c
>> +++ b/arch/x86/mm/pageattr_64.c
>> @@ -12,6 +12,7 @@
>>  #include <asm/processor.h>
>>  #include <asm/tlbflush.h>
>>  #include <asm/io.h>
>> +#include <asm/paravirt.h>
>>  
>>  pte_t *lookup_address(unsigned long address)
>>  { 
>> @@ -77,7 +78,7 @@ static void flush_kernel_map(void *arg)
>>  	   much cheaper than WBINVD. */
>>  	/* clflush is still broken. Disable for now. */
>>  	if (1 || !cpu_has_clflush)
>> -		asm volatile("wbinvd" ::: "memory");
>> +		wbinvd();
>>  	else list_for_each_entry(pg, l, lru) {
>>  		void *adr = page_address(pg);
>>  		clflush_cache_range(adr, PAGE_SIZE);
>> diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
>> index 4cb2384..b558cb2 100644
>> --- a/include/asm-x86/system_64.h
>> +++ b/include/asm-x86/system_64.h
>> @@ -65,53 +65,62 @@ extern void load_gs_index(unsigned);
>>  /*
>>   * Clear and set 'TS' bit respectively
>>   */
>> -#define clts() __asm__ __volatile__ ("clts")
>> +static inline void native_clts(void)
>> +{
>> +	asm volatile ("clts");
>> +}
>>  
>> -static inline unsigned long read_cr0(void)
>> -{ 
>> +static inline unsigned long native_read_cr0(void)
>> +{
>>  	unsigned long cr0;
>>  	asm volatile("movq %%cr0,%0" : "=r" (cr0));
>>  	return cr0;
>>  }
>>   
> 
> This is a pre-existing bug, but it seems to me that these read/write crX
> asms should have a constraint to stop the compiler from reordering them
> with respect to each other.  The brute-force approach would be to add
> "memory" clobbers, but the subtle fix would be to add a variable which
> is only used to sequence:
> 
I in fact have seen bugs with mixed reads and writes to the same cr,
(cr4), but adding the volatile
flag to the read function seemed to fix it. Yet, I agree with you that
the theorectical problem exists for the reorder, and your proposed fix
seems fine (although if we're really desperate about memory usage, we
can use a char instead a int and save 3 bytes!)

It also just ocurred to me that this part of the patch can also go into
the consolidation part. So I'll respin it.

Thanks for the comment
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Remi - http://enigmail.mozdev.org

iD8DBQFHKdkujYI8LaFUWXMRAhV2AKDPIjwGQnoLtldys/OWtIEs6biwxwCg1Jd/
o36S+qcb4sWJ6peqhrSRnos=
=YmeC
-----END PGP SIGNATURE-----
