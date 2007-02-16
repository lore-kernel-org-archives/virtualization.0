From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 11:26:33 -0800
Message-ID: <45D60569.2050702@goop.org>
References: <C1FBB450.99B6%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FBB450.99B6%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> Hmmm... Actually looks like a bunch of architectures do lazy sync of the
> vmalloc area, although neither ia64 nor powerpc does so. However, all
> current users of the alloc_vm_area() function would be okay since none of
> the other lazy-syncing architectures are supported by Xen.
>   

Well, assuming that alloc_vm_area() has some non-Xen use, the right
thing is for archs to export vmalloc_sync_all(), and just use that from
common code.

    J
