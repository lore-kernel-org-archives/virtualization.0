From: Andrew Morton <akpm@osdl.org>
Subject: Re: Paravirt-ops next steps
Date: Thu, 9 Nov 2006 19:58:12 -0800
Message-ID: <20061109195812.ae224c9d.akpm@osdl.org>
References: <4553F1A2.2050802@vmware.com>
	<20061109193744.94d7afa2.akpm@osdl.org>
	<4553F676.4030303@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4553F676.4030303@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 09 Nov 2006 19:48:06 -0800
Zachary Amsden <zach@vmware.com> wrote:

> Andrew Morton wrote:
> > It'd be better to develop and test this work on top of Thomas's stuff, =
as
> > that's what 2.6.20 will doubtless look like.  That means working against
> > -mm.  Once Thomas's patches are in mainline then the patches will apply=
 to
> > Andi's tree too and I can send them over to him.
> >
> > That way, the patch-applying-order equals mainstream-merging-order equa=
ls
> > chronological-writing-order, which is generally a good thing.
> >   =

> =

> Sounds sane.  Are Thomas's patches in -rc5-mm1?

Yes.  That patch series was today dropped and remerged, but it won't have
changed much at all.

>  If so, we should rebase =

> paravirt-ops, although I don't want to lose any paravirt patches that =

> you've dropped because they were merged to Andi.

Anything that's in Andi's tree is in -mm too, so when patches are moved
mm->andi->mainline nothing will change from your POV.

>  Don't know if that is =

> the case, but I did see a bunch of "merged into a subsystem tree" drops =

> from -mm related to paravirt.

Some of them went mm->andi, others were folded into others and remain in
-mm, but the net effect is unaltered from your POV.
