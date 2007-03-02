From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Thu, 01 Mar 2007 19:08:25 -0800
Message-ID: <45E79529.9000305@goop.org>
References: <200703020254.l222smBB009668@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422740AbXCBDIg@vger.kernel.org>
In-Reply-To: <200703020254.l222smBB009668@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Provide a PT map hook for HIGHPTE kernels to designate where they are mapping
> page tables.  This information is required so the physical address of PTE
> updates can be determined; otherwise, the mm layer would have to carry the
> physical address all the way to each PTE modification callsite, which is
> even more hideous that the macros required to provide the proper hooks.
>
> So lets not mess up arch neutral code to achieve this, but keep the horror
> in an #ifdef HIGHPTE in include/asm-i386/pgtable.h.  I had to use macros
> here because some types are not yet defined in all the include paths for
> this header.
>
> This patch is absolutely required for HIGHPTE kernels to operate properly
> with VMI.
>   

Hm, I don't think this interface will work for Xen.  In Xen, whenever a
pagetable page gets mapped, it must be mapped RO.  map_pt_hook gets
called after the mapping has already been created, so its too late for Xen.

I was planning on adding kmap_atomic_pte() for use in pte_offset_map*(),
which would be wired through to paravirt_ops to allow Xen to make this a
RO mapping.  Would this be sufficient for you to do your vmi thing?

    J
