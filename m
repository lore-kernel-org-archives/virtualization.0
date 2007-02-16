From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd cache
Date: Fri, 16 Feb 2007 12:33:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702161229360.26650@schroedinger.engr.sgi.com>
References: <20070216022449.739760547@goop.org> <20070216022531.047039320@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946111AbXBPUdL@vger.kernel.org>
In-Reply-To: <20070216022531.047039320@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007, Jeremy Fitzhardinge wrote:

> Remove the ctor for the pgd cache.  There's no point in having the
> cache machinery do this via an indirect call when all pgd are freed in
> the one place anyway.

Great. We finally get rid of this evil ..... 

On second throughts:

Are you sure that you understand what you are modifying? The ctor is not 
called when you allocate an object but when the slab allocates it. Freeing 
an object does not make the slab free it. It will hold it for the next
kmalloc. So you may just have reduced performance somewhat by addiung 
additional ctor processing and possibly disturbed the preservation of 
cache hot pgds.
