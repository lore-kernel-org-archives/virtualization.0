From: Bo Gan <ganb@vmware.com>
Subject: Re: Re: [PATCH 40/70] x86/sev-es: Setup per-cpu GHCBs for the runtime
 handler
Date: Wed, 22 Apr 2020 18:33:13 -0700
Message-ID: <1a164e55-19dd-a20b-6837-9f425cfac100@vmware.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-41-joro@8bytes.org>
 <A7DF63B4-6589-4386-9302-6B7F8BE0D9BA@vmware.com>
 <20200415155302.GD21899@suse.de>
Reply-To: <ganb@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415155302.GD21899@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 4/15/20 8:53 AM, Joerg Roedel wrote:
> Hi Mike,
> 
> On Tue, Apr 14, 2020 at 07:03:44PM +0000, Mike Stunes wrote:
>> set_memory_decrypted needs to check the return value. I see it
>> consistently return ENOMEM. I've traced that back to split_large_page
>> in arch/x86/mm/pat/set_memory.c.
> 
> I agree that the return code needs to be checked. But I wonder why this
> happens. The split_large_page() function returns -ENOMEM when
> alloc_pages() fails. Do you boot the guest with minal RAM assigned?
> 
> Regards,
> 
> 	Joerg
> 

I just want to add some context around this. The call path that lead to 
the failure is like the following:

	__alloc_pages_slowpath
	__alloc_pages_nodemask
	alloc_pages_current
	alloc_pages
	split_large_page
	__change_page_attr
	__change_page_attr_set_clr
	__set_memory_enc_dec
	set_memory_decrypted
	sev_es_init_ghcbs
	trap_init   -> before mm_init (in init/main.c)
	start_kernel
	x86_64_start_reservations
	x86_64_start_kernel
	secondary_startup_64

At this time, mem_init hasn't been called yet (which would be called by 
mm_init). Thus, the free pages are still owned by memblock. It's in 
mem_init (x86/mm/init_64.c) that memblock_free_all gets called and free 
pages are released.

During testing, I've also noticed that debug_pagealloc=1 will make the 
issue disappear. That's because with debug_pagealloc=1, 
probe_page_size_mask in x86/mm/init.c will not allow large pages 
(2M/1G). Therefore, no split_large_page would happen. Similarly, if CPU 
doesn't have X86_FEATURE_PSE, there won't be large pages either.

Any thoughts? Maybe split_large_page should get pages from memblock at 
early boot?

Bo
