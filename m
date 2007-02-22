From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 21:55:57 +1100
Message-ID: <1172141757.13378.76.camel@localhost.localdomain>
References: <45DCFB6E.2010806@goop.org>
	<1172115803.13378.63.camel@localhost.localdomain>
	<45DD6EF7.9060808@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45DD6EF7.9060808@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-02-22 at 02:22 -0800, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > On Wed, 2007-02-21 at 18:09 -0800, Jeremy Fitzhardinge wrote:
> >   =

> >> Here's the new patching patch.  It compiles, but it doesn't, you know,
> >> boot, as such.
> >>     =

> >
> > OK, there are several separate things here.
> > (1) Get rid of the PARAVIRT_IRQ_DISABLE etc constants in favour of
> > offsetof within the structure.
> > (2) Change (almost) all the paravirt hooks to be patchable.
> > (3) Genericise the infrastructure to table-driven.
> >
> > These should probably become separate patches, in fact.
> >   =

> =

> OK, here's something which is more presentable, and it even boots (at
> least under Xen; haven't tried native).
> =

> paravirt-patch-rename-paravirt_patch.patch

Great.

> paravirt-use-offset-site-ids.patch

Cool.

> paravirt-fix-clobbers.patch
>  - misc cleanups

Cool.

> paravirt-patchable-call-wrappers.patch
>  - wrap a large number of the paravirt calls with the magic to make the
> callsites patchable.  More are possible; this is just a good first step.

Ugly, but I originally played with alternatives for a long time and mine
were no prettier.

> paravirt-patch-machinery.patch
>  - the actual patching machinery, which is function-pointer driven
> rather than table driven now.

Not quite so sure on this one.  We loop through calling
paravirt_ops.patch() for each patch.  In the native case, this calls
paravirt_patcher with a fn pointer, which is simply called by
paravirt_patcher.

I would think you want to replace paravirt_patcher's patch =3D=3D NULL case
with a special "paravity_patch_default", and then have to paravirt_ops
patch function call that specifically when it wants a default.

Also, I think you can leave the native table almost as-is, eg:

static const struct native_insns
{
       const char *start, *end;
} native_insns[] =3D {
       [PARAVIRT_PATCH(irq_disable)] =3D { start_cli, end_cli },
       [PARAVIRT_PATCH(irq_enable)] =3D { start_sti, end_sti },
...
};
static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned l=
en)
{
       unsigned int insn_len;

       /* Don't touch it if we don't have a replacement */
       if (type >=3D ARRAY_SIZE(native_insns) || !native_insns[type].start)
               return paravirt_patch_default(type, clobbers, insns, len);
       insn_len =3D native_insns[type].end - native_insns[type].start;

       /* Similarly if we can't fit replacement. */
       if (len < insn_len)
               return paravirt_patch_default(type, clobbers, insns, len);

       return paravirt_patch_insns(insns, len, native_insns[type].start, na=
tive_insns[type].end);
}

Actually, your paravirt_patch_insns has similar logic anyway, so this
code could collapse (it should fall back to paravirt_patch_default tho
IMHO).

Thanks for doing this work!
Rusty.
