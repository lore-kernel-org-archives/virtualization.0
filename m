From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Fri, 02 Mar 2007 23:17:10 -0800
Message-ID: <45E920F6.7060806@vmware.com>
References: <200703020254.l222smBB009668@zach-dev.vmware.com> <45E79529.9000305@goop.org> <45E79C72.4000806@goop.org> <45E7C4DD.1040403@vmware.com> <45E7C80E.1020107@goop.org> <45E7F405.6020507@vmware.com> <45E8571F.1050509@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751189AbXCCHRN@vger.kernel.org>
In-Reply-To: <45E8571F.1050509@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Those are bugs that can occur, but they don't apply in this case.  The
> vmi implementation of kmap_atomic_pte() would be:
>
> static void *vmi_kmap_atomic_pte(struct page *page, enum km_type type)
> {
> 	void *ptep = kmap_atomic(page, type);
> 	vmi_map_pt_hook(type, ptep, page_to_pfn(page));
> 	return ptep;
> }
>
> Right?  Which is functionally identical to the code in your patch,
> except wrapped up in a new function.
>   

Yes, but the hook point now happens before the page table mapping.  Not 
that it should cause a problem.  But we've been testing things the 
original way for over a year now, and if we want to get the fix upstream 
for 2.6.21, it seems better to upstream a more tested fix rather than a 
new way of doing things, even if it is identical in theory.

That said, I have no problems with the approach you propose going 
forward.  I just don't think it is appropriate for an -rc release, 
because it provides no tangible benefit for any of the in-kernel code, 
and causes a lot of retesting.  I still believe there is almost zero 
risk to doing things the way you propose.  But I am also a firm believer 
in shipping what is tested and working unless there is a compelling 
reason to do otherwise.  And if Xen is not going to be in 2.6.21, the 
compelling reason becomes getting the code working for both of us for 
2.6.22 - so let's do that, and keep the patches from Andrew's -mm tree 
around to make sure that we have a suitable patch base that can be 
applied to 2.6.21 for any distros that are willing to pick up the Xen 
paravirt-ops.

Sound reasonable?

Zach
