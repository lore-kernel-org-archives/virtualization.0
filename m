From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
 vmalloc areas
Date: Fri, 16 Feb 2007 19:06:58 +0000
Message-ID: <C1FBB152.99B0%keir__802.499490282749$1171652895$gmane$org@xensource.com>
References: <45D5E98B.4070904@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946061AbXBPTHH@vger.kernel.org>
In-Reply-To: <45D5E98B.4070904@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Keir Fraser <keir@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 17:27, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

>  In fact that file is only built for i386 and x86_64, so there really is no
>> problem with using vmalloc_sync_all() directly and without ifdef.
>>   
> 
> I had moved it to mm/vmalloc.c in response to previous review comments
> (namely, its not Xen specific, so it shouldn't live in the Xen part of
> the tree).

Then the call will have to be CONFIG_X86. I hadn't realised powerpc were
also using lock_vm_area. However I suspect that the x86 issue that those
functions were written doesn't even exist on powerpc, or any other non-x86
architecture.

I guess we should change the name of alloc_vm_area, by the way. Perhaps
alloc_vm_area_sync() or similar, to give some hint of what it's doing and
how it differs from other vmalloc-area functions?

 -- Keir
