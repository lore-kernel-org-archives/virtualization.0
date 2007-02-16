From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 11:26:19 -0600
Message-ID: <1171646779.20683.5.camel@basalt>
References: <C1FB9605.9988%keir@xensource.com>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FB9605.9988%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>, Jimi Xenidis <jimix@watson.ibm.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-16 at 17:10 +0000, Keir Fraser wrote:
> 
> 
> On 16/2/07 16:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
> 
> > Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
> > the rest of this code is generic.  I guess I could just move it all to
> > arch/i386/mm.
> 
> This whole thing isn't an issue on ia64 (they no-op lock_vm_area) and
> powerpc doesn't use any of the Xen driver code at this time.

Not sure what you mean? PowerPC uses pretty much all of the Xen driver
code: event channels, blkfront/back, netfront/back, console, etc.

-- 
Hollis Blanchard
IBM Linux Technology Center
