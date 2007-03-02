From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Thu, 01 Mar 2007 22:29:58 -0800
Message-ID: <45E7C466.1030006@goop.org>
References: <200703020254.l222smBB009668@zach-dev.vmware.com> <45E79529.9000305@goop.org> <45E79C72.4000806@goop.org> <45E7C306.4080400@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422966AbXCBG37@vger.kernel.org>
In-Reply-To: <45E7C306.4080400@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> That doesn't quite work, since we need to know which of the two -
> KM_PTE0 or KM_PTE1 is being mapped.  But it could be moved to before
> the mapping, as you need, and take this as a parameter. 

Err, kmap_atomic_pte gets passed the type - KM_PTE0 or KM_PTE1.

    J
