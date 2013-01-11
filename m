From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] virtio: suppress kmemleak false positive
Date: Fri, 11 Jan 2013 16:32:12 +0200
Message-ID: <CAEnQRZCvNZ_1OF7Jc43Oo10ADQEMVgqdTJZG7KG7m9yNoQDBfg@mail.gmail.com>
References: <1357912303-17026-1-git-send-email-alex.mihai.c@gmail.com>
	<20130111140231.GA31281@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4186317346166009154=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130111140231.GA31281@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4186317346166009154==
Content-Type: multipart/alternative; boundary=f46d043bdef04b43f004d30429db

--f46d043bdef04b43f004d30429db
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2013 at 4:02 PM, Catalin Marinas <catalin.marinas@arm.com>w=
rote:

> On Fri, Jan 11, 2013 at 01:51:43PM +0000, Alexandru Copot wrote:
> > While doing simple IPv6 tests in KVM virtual machines,
> > (add an IPv6 address to eth0) kmemleak complains about
> > an unreferenced object:
> >
> > unreferenced object 0xffff88001e804120 (size 32):
> >   comm "softirq", pid 0, jiffies 4294900928 (age 631.544s)
> >   hex dump (first 32 bytes):
> >     28 cb fd 1d 00 00 00 00 0c 00 00 00 01 00 01 00  (...............
> >     02 d0 83 1d 00 00 00 00 6e 00 00 00 00 00 00 00  ........n.......
> >   backtrace:
> >     [<ffffffff815ed721>] kmemleak_alloc+0x21/0x50
> >     [<ffffffff8111d0b0>] __kmalloc+0xe0/0x160
> >     [<ffffffff81362b7c>] virtqueue_add_buf+0x1fc/0x3d0
> >     [<ffffffff8140cbd3>] start_xmit+0x153/0x3a0
> >     [<ffffffff8150887e>] dev_hard_start_xmit+0x21e/0x470
> >     [<ffffffff815247ce>] sch_direct_xmit+0xfe/0x280
> >     [<ffffffff81509014>] dev_queue_xmit+0x1f4/0x5d0
> >     [<ffffffff81592e91>] ip6_finish_output2+0x101/0x450
> >     [<ffffffff81595ae8>] ip6_finish_output+0x98/0x200
> >     [<ffffffff81595ca1>] ip6_output+0x51/0x1b0
> >     [<ffffffff815b51af>] mld_sendpack+0x19f/0x360
> >     [<ffffffff815b59b4>] mld_ifc_timer_expire+0x194/0x290
> >     [<ffffffff8104b794>] call_timer_fn+0x74/0xf0
> >     [<ffffffff8104bb1b>] run_timer_softirq+0x18b/0x220
> >     [<ffffffff81045f81>] __do_softirq+0xe1/0x1c0
> >     [<ffffffff8160a4fc>] call_softirq+0x1c/0x30
> >
> > Seems the function vring_add_indirect stores an array of
> > struct vring_desc by using virt_to_phys and kmemleak
> > doesn't track the pointer.
> >
> > The following patch can fix this.
> >
> > Signed-off-by: Alexandru Copot <alex.mihai.c@gmail.com>
> > CC: Daniel Baluta <dbaluta@ixiacom.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index ffd7e7d..e0b591b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/kmemleak.h>
> >
> >  /* virtio guest is communicating with a virtual "device" that actually
> runs on
> >   * a host processor.  Memory barriers are used to control SMP effects.
> */
> > @@ -140,6 +141,7 @@ static int vring_add_indirect(struct vring_virtqueu=
e
> *vq,
> >       desc =3D kmalloc((out + in) * sizeof(struct vring_desc), gfp);
> >       if (!desc)
> >               return -ENOMEM;
> > +     kmemleak_not_leak(desc);
>
> Please add a comment above this call in case people later wonder why
> this annotation is needed.
>
>
Thanks C=C4=83t=C4=83lin.

So, kememleak cannot handle this kind of pointer aliases?
Also, I wonder if phys_to_virt(virt_to_phys(x)) =3D=3D x holds true all the
time.

thanks,
Daniel.

--f46d043bdef04b43f004d30429db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jan 11, 2013 at 4:02 PM, Catalin=
 Marinas <span dir=3D"ltr">&lt;<a href=3D"mailto:catalin.marinas@arm.com" t=
arget=3D"_blank">catalin.marinas@arm.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Fri, Jan 11, 2013 at 01:51:43PM =
+0000, Alexandru Copot wrote:<br>
&gt; While doing simple IPv6 tests in KVM virtual machines,<br>
&gt; (add an IPv6 address to eth0) kmemleak complains about<br>
&gt; an unreferenced object:<br>
&gt;<br>
&gt; unreferenced object 0xffff88001e804120 (size 32):<br>
&gt; =C2=A0 comm &quot;softirq&quot;, pid 0, jiffies 4294900928 (age 631.54=
4s)<br>
&gt; =C2=A0 hex dump (first 32 bytes):<br>
&gt; =C2=A0 =C2=A0 28 cb fd 1d 00 00 00 00 0c 00 00 00 01 00 01 00 =C2=A0(.=
..............<br>
&gt; =C2=A0 =C2=A0 02 d0 83 1d 00 00 00 00 6e 00 00 00 00 00 00 00 =C2=A0..=
......n.......<br>
&gt; =C2=A0 backtrace:<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff815ed721&gt;] kmemleak_alloc+0x21/0x50<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8111d0b0&gt;] __kmalloc+0xe0/0x160<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81362b7c&gt;] virtqueue_add_buf+0x1fc/0x3d0=
<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8140cbd3&gt;] start_xmit+0x153/0x3a0<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8150887e&gt;] dev_hard_start_xmit+0x21e/0x4=
70<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff815247ce&gt;] sch_direct_xmit+0xfe/0x280<br=
>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81509014&gt;] dev_queue_xmit+0x1f4/0x5d0<br=
>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81592e91&gt;] ip6_finish_output2+0x101/0x45=
0<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81595ae8&gt;] ip6_finish_output+0x98/0x200<=
br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81595ca1&gt;] ip6_output+0x51/0x1b0<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff815b51af&gt;] mld_sendpack+0x19f/0x360<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff815b59b4&gt;] mld_ifc_timer_expire+0x194/0x=
290<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8104b794&gt;] call_timer_fn+0x74/0xf0<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8104bb1b&gt;] run_timer_softirq+0x18b/0x220=
<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff81045f81&gt;] __do_softirq+0xe1/0x1c0<br>
&gt; =C2=A0 =C2=A0 [&lt;ffffffff8160a4fc&gt;] call_softirq+0x1c/0x30<br>
&gt;<br>
&gt; Seems the function vring_add_indirect stores an array of<br>
&gt; struct vring_desc by using virt_to_phys and kmemleak<br>
&gt; doesn&#39;t track the pointer.<br>
&gt;<br>
&gt; The following patch can fix this.<br>
&gt;<br>
&gt; Signed-off-by: Alexandru Copot &lt;<a href=3D"mailto:alex.mihai.c@gmai=
l.com">alex.mihai.c@gmail.com</a>&gt;<br>
&gt; CC: Daniel Baluta &lt;<a href=3D"mailto:dbaluta@ixiacom.com">dbaluta@i=
xiacom.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/virtio/virtio_ring.c | 2 ++<br>
&gt; =C2=A01 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring=
.c<br>
&gt; index ffd7e7d..e0b591b 100644<br>
&gt; --- a/drivers/virtio/virtio_ring.c<br>
&gt; +++ b/drivers/virtio/virtio_ring.c<br>
&gt; @@ -23,6 +23,7 @@<br>
&gt; =C2=A0#include &lt;linux/slab.h&gt;<br>
&gt; =C2=A0#include &lt;linux/module.h&gt;<br>
&gt; =C2=A0#include &lt;linux/hrtimer.h&gt;<br>
&gt; +#include &lt;linux/kmemleak.h&gt;<br>
&gt;<br>
&gt; =C2=A0/* virtio guest is communicating with a virtual &quot;device&quo=
t; that actually runs on<br>
&gt; =C2=A0 * a host processor. =C2=A0Memory barriers are used to control S=
MP effects. */<br>
&gt; @@ -140,6 +141,7 @@ static int vring_add_indirect(struct vring_virtque=
ue *vq,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 desc =3D kmalloc((out + in) * sizeof(struct vring=
_desc), gfp);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (!desc)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
&gt; + =C2=A0 =C2=A0 kmemleak_not_leak(desc);<br>
<br>
</div></div>Please add a comment above this call in case people later wonde=
r why<br>
this annotation is needed.<br>
<span class=3D"HOEnZb"></span><br></blockquote></div><br>Thanks C=C4=83t=C4=
=83lin. <br><br>So, kememleak cannot handle this kind of pointer aliases?<b=
r>Also, I wonder if  phys_to_virt(virt_to_phys(x)) =3D=3D x holds true all =
the time.<br>
<br>thanks,<br>Daniel.<br><br><br><br><br><br><br>

--f46d043bdef04b43f004d30429db--

--===============4186317346166009154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4186317346166009154==--
