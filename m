From: Leandro Dorileo <l@dorileo.org>
Subject: Re: [PATCH] virtio_balloon: don't call virtio_has_feature() twice on
	init_vqs()
Date: Mon, 27 Jan 2014 23:27:18 -0200
Message-ID: <CADmRX69JztcLUGhX-QS+M39s66qqsY4Wwj+8Rt6vW_E1k3bKHA@mail.gmail.com>
References: <1390679972-1406-1-git-send-email-l@dorileo.org>
	<87ppndyn54.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3905479913277035303=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87ppndyn54.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============3905479913277035303==
Content-Type: multipart/alternative; boundary=089e015373bc99706604f0fdb905

--089e015373bc99706604f0fdb905
Content-Type: text/plain; charset=ISO-8859-1

Hi Rusty,

On Mon, Jan 27, 2014 at 10:18 PM, Rusty Russell <rusty@rustcorp.com.au>wrote:

> Leandro Dorileo <l@dorileo.org> writes:
> > Cchange init_vqs() to avoid calling twice the virtio_has_feature()
> > - attempting to find out if VIRTIO_BALLOON_F_STATS_VQ feature was
> negotiated -
> > consequently we prevent unnecessarily running the drivers' feature_table
> more
> > than needed.
> >
> > Signed-off-by: Leandro Dorileo <l@dorileo.org>
>
> Hi Leandro,
>
>         This seems like a premature optimization.  The current code is
> fairly clear, and there's no performance issue with init_vqs.
>
>

Indeed, rethinking the patch and reviewing the code path it seems to be no
gain,
It's just called on probe and restore operations. As you said a premature
optimization.

Thanks...



> Am I missing something?
> Rusty.
>
> > ---
> >  drivers/virtio/virtio_balloon.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c
> b/drivers/virtio/virtio_balloon.c
> > index 34bdaba..41771c1 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -320,19 +320,21 @@ static int init_vqs(struct virtio_balloon *vb)
> >       vq_callback_t *callbacks[] = { balloon_ack, balloon_ack,
> stats_request };
> >       const char *names[] = { "inflate", "deflate", "stats" };
> >       int err, nvqs;
> > +     bool stats;
> >
> >       /*
> >        * We expect two virtqueues: inflate and deflate, and
> >        * optionally stat.
> >        */
> > -     nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3
> : 2;
> > +     stats = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ);
> > +     nvqs = stats ? 3 : 2;
> >       err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks,
> names);
> >       if (err)
> >               return err;
> >
> >       vb->inflate_vq = vqs[0];
> >       vb->deflate_vq = vqs[1];
> > -     if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> > +     if (stats) {
> >               struct scatterlist sg;
> >               vb->stats_vq = vqs[2];
> >
> > --
> > 1.8.5.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--089e015373bc99706604f0fdb905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Rusty,<div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Mon, Jan 27, 2014 at 10:18 PM, Rusty Russell <span dir=3D"=
ltr">&lt;<a href=3D"mailto:rusty@rustcorp.com.au" target=3D"_blank">rusty@r=
ustcorp.com.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">Leandro Dorileo &lt;<a hre=
f=3D"mailto:l@dorileo.org">l@dorileo.org</a>&gt; writes:<br>
&gt; Cchange init_vqs() to avoid calling twice the virtio_has_feature()<br>
&gt; - attempting to find out if VIRTIO_BALLOON_F_STATS_VQ feature was nego=
tiated -<br>
&gt; consequently we prevent unnecessarily running the drivers&#39; feature=
_table more<br>
&gt; than needed.<br>
&gt;<br>
&gt; Signed-off-by: Leandro Dorileo &lt;<a href=3D"mailto:l@dorileo.org">l@=
dorileo.org</a>&gt;<br>
<br>
</div>Hi Leandro,<br>
<br>
=A0 =A0 =A0 =A0 This seems like a premature optimization. =A0The current co=
de is<br>
fairly clear, and there&#39;s no performance issue with init_vqs.<br>
<br></blockquote><div><br></div><div><br></div><div>Indeed, rethinking the =
patch and reviewing the code path it seems to be no gain,</div><div>It&#39;=
s just called on probe and restore operations. As you said a premature opti=
mization.</div>
<div><br></div><div>Thanks...</div><div><br></div><div>=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">
Am I missing something?<br>
Rusty.<br>
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0drivers/virtio/virtio_balloon.c | 6 ++++--<br>
&gt; =A01 file changed, 4 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_b=
alloon.c<br>
&gt; index 34bdaba..41771c1 100644<br>
&gt; --- a/drivers/virtio/virtio_balloon.c<br>
&gt; +++ b/drivers/virtio/virtio_balloon.c<br>
&gt; @@ -320,19 +320,21 @@ static int init_vqs(struct virtio_balloon *vb)<b=
r>
&gt; =A0 =A0 =A0 vq_callback_t *callbacks[] =3D { balloon_ack, balloon_ack,=
 stats_request };<br>
&gt; =A0 =A0 =A0 const char *names[] =3D { &quot;inflate&quot;, &quot;defla=
te&quot;, &quot;stats&quot; };<br>
&gt; =A0 =A0 =A0 int err, nvqs;<br>
&gt; + =A0 =A0 bool stats;<br>
&gt;<br>
&gt; =A0 =A0 =A0 /*<br>
&gt; =A0 =A0 =A0 =A0* We expect two virtqueues: inflate and deflate, and<br=
>
&gt; =A0 =A0 =A0 =A0* optionally stat.<br>
&gt; =A0 =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 nvqs =3D virtio_has_feature(vb-&gt;vdev, VIRTIO_BALLOON_F_ST=
ATS_VQ) ? 3 : 2;<br>
&gt; + =A0 =A0 stats =3D virtio_has_feature(vb-&gt;vdev, VIRTIO_BALLOON_F_S=
TATS_VQ);<br>
&gt; + =A0 =A0 nvqs =3D stats ? 3 : 2;<br>
&gt; =A0 =A0 =A0 err =3D vb-&gt;vdev-&gt;config-&gt;find_vqs(vb-&gt;vdev, n=
vqs, vqs, callbacks, names);<br>
&gt; =A0 =A0 =A0 if (err)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;<br>
&gt;<br>
&gt; =A0 =A0 =A0 vb-&gt;inflate_vq =3D vqs[0];<br>
&gt; =A0 =A0 =A0 vb-&gt;deflate_vq =3D vqs[1];<br>
&gt; - =A0 =A0 if (virtio_has_feature(vb-&gt;vdev, VIRTIO_BALLOON_F_STATS_V=
Q)) {<br>
&gt; + =A0 =A0 if (stats) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist sg;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 vb-&gt;stats_vq =3D vqs[2];<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.5.3<br>
</div></div>--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</blockquote></div><br></div></div></div>

--089e015373bc99706604f0fdb905--

--===============3905479913277035303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3905479913277035303==--
