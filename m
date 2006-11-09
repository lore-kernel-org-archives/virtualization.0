From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: 9 Nov 2006 08:31:58 +0100
Message-ID: <20061109073158.GB11760@muc.de>
References: <1163034102.15681.6.camel@localhost.localdomain>
	<20061108172014.b4bcea17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Date: Thu, 9 Nov 2006 08:31:58 +0100
Content-Disposition: inline
In-Reply-To: <20061108172014.b4bcea17.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 08, 2006 at 05:20:14PM -0800, Andrew Morton wrote:
> On Thu, 09 Nov 2006 12:01:42 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> =

> > OK, at least two patches got dropped on the way from the mm tree to
> > Andi's tree: the desc.h cleanup, and the processor.h rearrangement.
> > Merging into Andi's tree without these patches must have been a
> > nightmare 8(
> > =

> > Andi then tried to fix it with x86_64-mm-paravirt-compile.patch but then
> > it didn't boot so he disabled it in x86_64-mm-paravirt-broken.patch  =

> > =

> > This patch undoes those two patches and rearranges processor.h correctly
> > so the kernel compiles and boots with CONFIG_PARAVIRT.  Andi's
> > "paravirt-compile" patch also cleans up the spinlock header, which is
> > good but should probably be patched separately.
> =

> Fun.  Andi, I have a mountain of fixes against your tree.  Whatever you
> do, don't change anything!  I'll get it all sent over later today.

I think for the paravirt ops stuff it would be best to respin it -- e.g.
let Rusty submit a new clean patchkit. That's much better than trying
to add lots of fixup patches. =


I'll go through the other patches.

-Andi
