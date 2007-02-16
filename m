From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 11:10:08 +0000
Message-ID: <C1FB4190.98FA%keir__23551.6273220584$1171624336$gmane$org@xensource.com>
References: <20070216091843.GB28196@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216091843.GB28196@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org




On 16/2/07 09:18, "Andi Kleen" <ak@muc.de> wrote:

>> It's for populating the pagetable in a vmalloc area.  There's magic in
> =

> If the lazy setup doesn't work for you you can always call vmalloc_sync()
> early.

vmalloc_sync_all()? That's a great idea. We can put that in alloc_vm_area()
and kill {lock,unlock}_vm_area() which is a nice interface simplification.

 Thanks!
 Keir
