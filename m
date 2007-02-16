From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 17:12:31 +0000
Message-ID: <C1FB967F.998B%keir__3198.12090970135$1171646043$gmane$org@xensource.com>
References: <C1FB9605.9988%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <C1FB9605.9988%keir@xensource.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Keir Fraser <keir@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 17:10, "Keir Fraser" <keir@xensource.com> wrote:

> On 16/2/07 16:46, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:
> =

>> Yes, that would work.  Unfortunately that's i386 arch-specific, whereas
>> the rest of this code is generic.  I guess I could just move it all to
>> arch/i386/mm.
> =

> This whole thing isn't an issue on ia64 (they no-op lock_vm_area) and
> powerpc doesn't use any of the Xen driver code at this time.
> vmalloc_sync_all is supported by both i386 and x86_64, so we can make the
> call conditional on CONFIG_X86 so that ia64 will continue to build. This =
is
> what I've done in xen-unstable.


In fact that file is only built for i386 and x86_64, so there really is no
problem with using vmalloc_sync_all() directly and without ifdef.

 -- Keir
