From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
 vmalloc areas
Date: Fri, 16 Feb 2007 17:10:29 +0000
Message-ID: <C1FB9605.9988%keir__34304.8608433039$1171645872$gmane$org@xensource.com>
References: <45D5DFF3.6040005@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964890AbXBPRKd@vger.kernel.org>
In-Reply-To: <45D5DFF3.6040005@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org




On 16/2/07 16:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
> the rest of this code is generic.  I guess I could just move it all to
> arch/i386/mm.

This whole thing isn't an issue on ia64 (they no-op lock_vm_area) and
powerpc doesn't use any of the Xen driver code at this time.
vmalloc_sync_all is supported by both i386 and x86_64, so we can make the
call conditional on CONFIG_X86 so that ia64 will continue to build. This is
what I've done in xen-unstable.

 -- Keir
