From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 19:06:58 +0000
Message-ID: <C1FBB152.99B0%keir__8266.96462831951$1171652910$gmane$org@xensource.com>
References: <45D5E98B.4070904@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D5E98B.4070904@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Keir Fraser <keir@xensource.com>
Cc: Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 17:27, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

>  In fact that file is only built for i386 and x86_64, so there really is =
no
>> problem with using vmalloc_sync_all() directly and without ifdef.
>>   =

> =

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
