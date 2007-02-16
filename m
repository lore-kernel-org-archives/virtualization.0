From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
 vmalloc areas
Date: Fri, 16 Feb 2007 11:10:08 +0000
Message-ID: <C1FB4190.98FA%keir__16387.6729355708$1171624260$gmane$org@xensource.com>
References: <20070216091843.GB28196@muc.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750713AbXBPLKO@vger.kernel.org>
In-Reply-To: <20070216091843.GB28196@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org




On 16/2/07 09:18, "Andi Kleen" <ak@muc.de> wrote:

>> It's for populating the pagetable in a vmalloc area.  There's magic in
> 
> If the lazy setup doesn't work for you you can always call vmalloc_sync()
> early.

vmalloc_sync_all()? That's a great idea. We can put that in alloc_vm_area()
and kill {lock,unlock}_vm_area() which is a nice interface simplification.

 Thanks!
 Keir
