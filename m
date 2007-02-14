From: Dan Hecht <dhecht@vmware.com>
Subject: Re: [patch 05/21] Xen-paravirt: paravirt_ops: allocate a fixmap slot
Date: Tue, 13 Feb 2007 17:23:41 -0800
Message-ID: <45D2649D.4080508@vmware.com>
References: <20070213221729.772002682@goop.org> <20070213221829.845132535@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751486AbXBNBYO@vger.kernel.org>
In-Reply-To: <20070213221829.845132535@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/13/2007 02:17 PM, Jeremy Fitzhardinge wrote:
> Allocate a fixmap slot for use by a paravirt_ops implementation.  Xen
> uses this to map the hypervisor's shared info page, which doesn't have
> a pseudo-physical page number, and therefore can't be mapped
> ordinarily.
> 

Why doesn't Xen allocate the shared_info page from the pseudo-physical 
space?  Doesn't it already have to steal pages from the pseudo-physical 
space for e.g. initial page tables, console, etc?  Why not do the same 
for shared_info, and then you don't need a reserve the fixmap slot.

Dan
