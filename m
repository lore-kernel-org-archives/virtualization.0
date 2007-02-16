From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 19:19:44 +0000
Message-ID: <C1FBB450.99B6%Keir.Fraser@cl.cam.ac.uk>
References: <C1FBB152.99B0%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FBB152.99B0%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 19:06, "Keir Fraser" <keir@xensource.com> wrote:

>> I had moved it to mm/vmalloc.c in response to previous review comments
>> (namely, its not Xen specific, so it shouldn't live in the Xen part of
>> the tree).
> 
> Then the call will have to be CONFIG_X86. I hadn't realised powerpc were
> also using lock_vm_area. However I suspect that the x86 issue that those
> functions were written doesn't even exist on powerpc, or any other non-x86
> architecture.

Hmmm... Actually looks like a bunch of architectures do lazy sync of the
vmalloc area, although neither ia64 nor powerpc does so. However, all
current users of the alloc_vm_area() function would be okay since none of
the other lazy-syncing architectures are supported by Xen.

 -- Keir
