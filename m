From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 21/70] x86/boot/compressed/64: Add function to map a page
 unencrypted
Date: Fri, 20 Mar 2020 15:26:09 -0700
Message-ID: <9b69d49f-969c-5720-5723-f89ff0e000c0@intel.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-22-joro@8bytes.org>
 <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
 <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
 <20200320221213.GK5122@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200320221213.GK5122@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Rientjes <rientjes@google.com>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 3/20/20 3:12 PM, Joerg Roedel wrote:
> On Fri, Mar 20, 2020 at 02:02:13PM -0700, Dave Hansen wrote:
>> It *never* flushes global pages.  For a generic function like this, that
>> seems pretty dangerous because the PTEs it goes after could quite easily
>> be Global.  It's also not _obviously_ correct if PCIDs are in play
>> (which I don't think they are on AMD).
>>
>> A flush_tlb_global() is probably more appropriate.  Better yet, is there
>> a reason not to use flush_tlb_kernel_range()?  I don't think it's
>> necessary to whack the entire TLB for one PTE set.
> 
> This code runs before the actual kernel image is decompressed, so there
> is no PCID and no global pages (I think CR4.PGE is still 0). So a
> cr3-write is enough to flush the TLB. Also the TLB-flush helpers of the
> running kernel are not available here.

Geez, I always forget about the compressed code. :)  Good point about PCIDs.

In any case, I thought this all came through initialize_identity_maps(),
which does, for instance:

        mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;

Where:

#define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)

That looks like it has the Global bit set.  Does that not apply here
somehow?
