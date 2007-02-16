From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
 vmalloc areas
Date: Fri, 16 Feb 2007 17:12:31 +0000
Message-ID: <C1FB967F.998B%keir__37519.3322696306$1171646044$gmane$org@xensource.com>
References: <C1FB9605.9988%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932506AbXBPRMg@vger.kernel.org>
In-Reply-To: <C1FB9605.9988%keir@xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keir Fraser <keir@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 17:10, "Keir Fraser" <keir@xensource.com> wrote:

> On 16/2/07 16:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
> 
>> Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
>> the rest of this code is generic.  I guess I could just move it all to
>> arch/i386/mm.
> 
> This whole thing isn't an issue on ia64 (they no-op lock_vm_area) and
> powerpc doesn't use any of the Xen driver code at this time.
> vmalloc_sync_all is supported by both i386 and x86_64, so we can make the
> call conditional on CONFIG_X86 so that ia64 will continue to build. This is
> what I've done in xen-unstable.


In fact that file is only built for i386 and x86_64, so there really is no
problem with using vmalloc_sync_all() directly and without ifdef.

 -- Keir
