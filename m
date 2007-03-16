From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
 console infrastructure for Xen console
Date: Fri, 16 Mar 2007 03:41:23 -0800
Message-ID: <20070316034123.9de92632.akpm@linux-foundation.org>
References: <20070316095851.GB301@elte.hu>
	<C2202295.BA49%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933603AbXCPLmI@vger.kernel.org>
In-Reply-To: <C2202295.BA49%keir@xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keir Fraser <keir@xensource.com>
Cc: Ingo Molnar <mingo@elte.hu>, Keir Fraser <Keir.Fraser@xensource.com>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Mar 2007 10:31:49 +0000 Keir Fraser <keir@xensource.com> wrote:

> On 16/3/07 09:58, "Ingo Molnar" <mingo@elte.hu> wrote:
> 
> >> These mb()'s are pretty standard for lock-free producer/consumer
> >> rings. Write descriptor /then/ write the updated producer. Read the
> >> producer /then/ read any descriptors revealed by this new producer
> >> value.
> > 
> > then use rmb()/wmb(). Rarely does a ring protocol truly need mb().
> 
> It's needed for writing data /after/ reading the consumer index that shows
> you have space to write. Looking through xenbus_comms.c I think all the
> barriers are correct except there is a spurious extra mb() in xb_read(),
> where there is a later rmb() which is sufficient by itself. All the others
> have a purpose.
> 

If Ingo couldn't work this out from reading the code then nobody else can,
and we have a maintainability problem which can only be solved with
adequate commenting.
