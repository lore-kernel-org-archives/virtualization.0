From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 21/70] x86/boot/compressed/64: Add function to map a page
 unencrypted
Date: Fri, 20 Mar 2020 14:02:13 -0700
Message-ID: <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-22-joro@8bytes.org>
 <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On 3/20/20 1:53 PM, David Rientjes wrote:
>> +
>> +	/* Clear encryption flag and write new pte */
>> +	pte = pte_clear_flags(*ptep, _PAGE_ENC);
>> +	set_pte(ptep, pte);
>> +
>> +	/* Flush TLB to map the page unencrypted */
>> +	write_cr3(top_level_pgt);
>> +
> Is there a guarantee that this flushes the tlb if cr3 == top_level_pgt 
> alrady without an invlpg?

Ahh, good catch.

It *never* flushes global pages.  For a generic function like this, that
seems pretty dangerous because the PTEs it goes after could quite easily
be Global.  It's also not _obviously_ correct if PCIDs are in play
(which I don't think they are on AMD).

A flush_tlb_global() is probably more appropriate.  Better yet, is there
a reason not to use flush_tlb_kernel_range()?  I don't think it's
necessary to whack the entire TLB for one PTE set.
