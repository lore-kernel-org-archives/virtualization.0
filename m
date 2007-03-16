From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/26] Xen-paravirt_ops: Xen guest
 implementation for paravirt_ops interface
Date: Fri, 16 Mar 2007 12:26:27 -0700
Message-ID: <45FAEF63.5080308@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070316092137.GL23174@elte.hu> <45FAD35F.8040404@goop.org>
	<20070316185923.GA15209@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316185923.GA15209@infradead.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Hellwig <hch@infradead.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Hellwig wrote:
> On Fri, Mar 16, 2007 at 10:26:55AM -0700, Jeremy Fitzhardinge wrote:
>   
>> +#ifdef CONFIG_HIGHPTE
>> +	.kmap_atomic_pte = native_kmap_atomic_pte,
>> +#else
>> +	.kmap_atomic_pte = paravirt_nop,
>> +#endif
>>     
>
> This is ifdefing is quite ugly.  Shouldn't native_kmap_atomic_pte
> just be a noop in the !CONFIG_HIGHPTE case?
>   

Yes, but the trouble is that asm/highmem.h simply isn't included in the
!HIGHMEM case, so I can't put anything in there, and putting anything
pv_ops related into linux/highmem.h isn't appropriate either.

>> -void *kmap_atomic(struct page *page, enum km_type type)
>> +void *_kmap_atomic(struct page *page, enum km_type type, pgprot_t prot)
>>     
>
> We normally call our "secial" function __foo, not _foo.  But in this
> case it really should have a more meaningfull name like
> kmap_atomic_prot anyway.
>   

OK.

>> +void *kmap_atomic(struct page *page, enum km_type type)
>> +{
>> +	return _kmap_atomic(page, type, kmap_prot);
>>     
>
> And this one should probably be an inline.
>   

OK, if you think it makes a difference.

>> +static inline void *native_kmap_atomic_pte(struct page *page, enum km_type type)
>> +{
>> +	return kmap_atomic(page, type);
>> +}
>> +
>> +#ifndef CONFIG_PARAVIRT
>> +#define kmap_atomic_pte(page, type)	kmap_atomic(page, type)
>> +#endif
>>     
>
> This is all getting rather ugly just for your pagetable hackery.
>   

Well, I could promote kmap_atomic_pte to a first-class interface, but it
seems like overkill.

    J
