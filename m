From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: 13 Apr 2007 14:27:09 +0200
Message-ID: <p738xcw7942.fsf@bingen.suse.de>
References: <461EE9E5.6060403@vmware.com> <C2450C95.D3F6%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753521AbXDML3K@vger.kernel.org>
In-Reply-To: <C2450C95.D3F6%keir@xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keir Fraser <keir@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, David Rientjes <rientjes@google.com>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser <keir@xensource.com> writes:

> On 13/4/07 03:24, "Zachary Amsden" <zach@vmware.com> wrote:
> 
> >> You do know that P6 and higher don't do locked bus references as long
> >> as the value is in the cache, right?
> > 
> > Yes.  Even then, last time I clocked instructions, xchg was still slower
> > than read / write, although I could be misremembering.  And it's not
> > totally clear that they will always be in cached state, however, and for
> > SMP, we still want to drop the implicit lock in cases where the
> > processor might not know they are cached exclusive, but we know there
> > are no other racing users.  And there are plenty of old processors out
> > there to still make it worthwhile.
> 
> LOCKed instruction suck really badly on the netburst microarchitecture (like
> factor of 10x, or not far off). I think it's probably because of their side
> effect of serialising memory accesses, causing horrible pipeline stalls.

Unfortunately they tend to be HyperThreaded usually (except for early ones 
and Celerons) and need the LOCK anyways.

-Andi
