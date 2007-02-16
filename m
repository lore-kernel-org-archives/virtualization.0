From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 09:27:39 -0800
Message-ID: <45D5E98B.4070904@goop.org>
References: <C1FB967F.998B%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FB967F.998B%keir@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <keir@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> On 16/2/07 17:10, "Keir Fraser" <keir@xensource.com> wrote:
>
>   
>> On 16/2/07 16:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
>>
>>     
>>> Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
>>> the rest of this code is generic.  I guess I could just move it all to
>>> arch/i386/mm.
>>>       
>> This whole thing isn't an issue on ia64 (they no-op lock_vm_area) and
>> powerpc doesn't use any of the Xen driver code at this time.
>> vmalloc_sync_all is supported by both i386 and x86_64, so we can make the
>> call conditional on CONFIG_X86 so that ia64 will continue to build. This is
>> what I've done in xen-unstable.
>>     
>
>
> In fact that file is only built for i386 and x86_64, so there really is no
> problem with using vmalloc_sync_all() directly and without ifdef.
>   

I had moved it to mm/vmalloc.c in response to previous review comments
(namely, its not Xen specific, so it shouldn't live in the Xen part of
the tree).

    J
