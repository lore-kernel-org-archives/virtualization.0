From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/virtio: fix vq wait_event condition
Date: Fri, 20 Apr 2018 10:12:17 +0000
Message-ID: <CAPM=9txAe2J8FsxynD0SaUHOcjeGOZnXRqhxtu7VMgUJEVz2yA@mail.gmail.com>
References: <20180403095904.11152-1-kraxel@redhat.com>
	<20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8288221594213831039=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, amagloire@blackberry.com
List-Id: virtualization@lists.linuxfoundation.org

--===============8288221594213831039==
Content-Type: multipart/alternative; boundary="089e082f6ac0effaf2056a44eca0"

--089e082f6ac0effaf2056a44eca0
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Dave Airlie <airlied@redhat.com>

On Fri., 20 Apr. 2018, 17:23 Gerd Hoffmann, <kraxel@redhat.com> wrote:

> On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:
> > Wait until we have enough space in the virt queue to actually queue up
> > our request.  Avoids the guest spinning in case we have a non-zero
> > amount of free entries but not enough for the request.
>
> Ping airlied, can you please either pick it up or review so I can commit
> myself?
>
> thanks,
>   Gerd
>
> > Cc: stable@vger.kernel.org
> > Reported-by: Alain Magloire <amagloire@blackberry.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c
> b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > index 48e4f1df6e..020070d483 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > @@ -293,7 +293,7 @@ static int
> virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
> >       ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
> >       if (ret == -ENOSPC) {
> >               spin_unlock(&vgdev->ctrlq.qlock);
> > -             wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
> > +             wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt
> + incnt);
> >               spin_lock(&vgdev->ctrlq.qlock);
> >               goto retry;
> >       } else {
> > @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct
> virtio_gpu_device *vgdev,
> >       ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
> >       if (ret == -ENOSPC) {
> >               spin_unlock(&vgdev->cursorq.qlock);
> > -             wait_event(vgdev->cursorq.ack_queue, vq->num_free);
> > +             wait_event(vgdev->cursorq.ack_queue, vq->num_free >=
> outcnt);
> >               spin_lock(&vgdev->cursorq.qlock);
> >               goto retry;
> >       } else {
> > --
> > 2.9.3
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--089e082f6ac0effaf2056a44eca0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by=
: Dave Airlie &lt;<a href=3D"mailto:airlied@redhat.com">airlied@redhat.com<=
/a>&gt;</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri.,=
 20 Apr. 2018, 17:23 Gerd Hoffmann, &lt;<a href=3D"mailto:kraxel@redhat.com=
">kraxel@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:<br>
&gt; Wait until we have enough space in the virt queue to actually queue up=
<br>
&gt; our request.=C2=A0 Avoids the guest spinning in case we have a non-zer=
o<br>
&gt; amount of free entries but not enough for the request.<br>
<br>
Ping airlied, can you please either pick it up or review so I can commit<br=
>
myself?<br>
<br>
thanks,<br>
=C2=A0 Gerd<br>
<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Reported-by: Alain Magloire &lt;<a href=3D"mailto:amagloire@blackberry=
.com" target=3D"_blank" rel=3D"noreferrer">amagloire@blackberry.com</a>&gt;=
<br>
&gt; Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" =
target=3D"_blank" rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/vir=
tio/virtgpu_vq.c<br>
&gt; index 48e4f1df6e..020070d483 100644<br>
&gt; --- a/drivers/gpu/drm/virtio/virtgpu_vq.c<br>
&gt; +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c<br>
&gt; @@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(str=
uct virtio_gpu_device *vgdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtqueue_add_sgs(vq, sgs, outcnt, i=
ncnt, vbuf, GFP_ATOMIC);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -ENOSPC) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp=
;vgdev-&gt;ctrlq.qlock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(vgdev-&gt;=
ctrlq.ack_queue, vq-&gt;num_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(vgdev-&gt;=
ctrlq.ack_queue, vq-&gt;num_free &gt;=3D outcnt + incnt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;v=
gdev-&gt;ctrlq.qlock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_g=
pu_device *vgdev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0=
, vbuf, GFP_ATOMIC);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -ENOSPC) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp=
;vgdev-&gt;cursorq.qlock);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(vgdev-&gt;=
cursorq.ack_queue, vq-&gt;num_free);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_event(vgdev-&gt;=
cursorq.ack_queue, vq-&gt;num_free &gt;=3D outcnt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;v=
gdev-&gt;cursorq.qlock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank" rel=3D=
"noreferrer">dri-devel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mai=
lman/listinfo/dri-devel</a><br>
</blockquote></div>

--089e082f6ac0effaf2056a44eca0--

--===============8288221594213831039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8288221594213831039==--
