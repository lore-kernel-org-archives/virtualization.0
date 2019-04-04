From: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <stephane.marchesin@gmail.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Wed, 3 Apr 2019 20:15:34 -0700
Message-ID: <CACP_E++MiVx1MSsvYkPKMePi5og4ZmbrPfRAm=Xf0CCet3u2vA__38342.1342748747$1555717767$gmane$org@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5913422303956153938=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============5913422303956153938==
Content-Type: multipart/alternative; boundary="000000000000c4a5b20585abca5a"

--000000000000c4a5b20585abca5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2019 at 7:58 PM David Airlie <airlied@redhat.com> wrote:

> On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Time to kill some bad sample code people are copying from ;)
> >
> > This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> > function is pretty much the only function which is carried over largely
> > unmodified.  Everything else is upside down.
> >
> > It is a single monster patch.  But given that it does some pretty
> > fundamental changes to the drivers workflow and also reduces the code
> > size by roughly 70% I think it'll still be alot easier to review than a
> > longish baby-step patch series.
> >
> > Changes summary:
> >  - Given the small amout of video memory (4 MB) the cirrus device has
> >    the rewritten driver doesn't try to manage buffers there.  Instead
> >    it will blit (memcpy) the active framebuffer to video memory.
>
> Does it get any slower, with TTM I just wrote it to migrate just the
> frontbuffer in/out of VRAM on modeset, won't we end up with more
> copies now?
>
> >  - All gem objects are stored in main memory and are manged using the
> >    new shmem helpers.  ttm is out.
> >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> >    that too by default.  There was a module parameter which enables 24/=
32
> >    bpp support and disables higher resolutions (due to cirrus hardware
> >    constrains).  That parameter wasn't reimplemented.
> This might be the big sticking point, this is a userspace regression
> for a feature that was explicitly added a few years ago, can we really
> get away without it?
>

Chrome OS testing in VMs was one of the consumers of 32bpp on cirrus, and
we have gotten rid of cirrus in favor of virtio gpu, so we'd be fine. Of
course I can't speak for other consumers :)

St=C3=A9phane



>
> The rest looks good though!
> Dave.
>
> >  - The simple display pipeline is used.
> >  - The generic fbdev emulation is used.
> >  - It's a atomic driver now.
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--000000000000c4a5b20585abca5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 3, 2019 at 7:58 PM David =
Airlie &lt;<a href=3D"mailto:airlied@redhat.com">airlied@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Apr 3, 2019 at 5:23 PM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.co=
m" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Time to kill some bad sample code people are copying from ;)<br>
&gt;<br>
&gt; This is a complete rewrite of the cirrus driver.=C2=A0 The cirrus_mode=
_set()<br>
&gt; function is pretty much the only function which is carried over largel=
y<br>
&gt; unmodified.=C2=A0 Everything else is upside down.<br>
&gt;<br>
&gt; It is a single monster patch.=C2=A0 But given that it does some pretty=
<br>
&gt; fundamental changes to the drivers workflow and also reduces the code<=
br>
&gt; size by roughly 70% I think it&#39;ll still be alot easier to review t=
han a<br>
&gt; longish baby-step patch series.<br>
&gt;<br>
&gt; Changes summary:<br>
&gt;=C2=A0 - Given the small amout of video memory (4 MB) the cirrus device=
 has<br>
&gt;=C2=A0 =C2=A0 the rewritten driver doesn&#39;t try to manage buffers th=
ere.=C2=A0 Instead<br>
&gt;=C2=A0 =C2=A0 it will blit (memcpy) the active framebuffer to video mem=
ory.<br>
<br>
Does it get any slower, with TTM I just wrote it to migrate just the<br>
frontbuffer in/out of VRAM on modeset, won&#39;t we end up with more<br>
copies now?<br>
<br>
&gt;=C2=A0 - All gem objects are stored in main memory and are manged using=
 the<br>
&gt;=C2=A0 =C2=A0 new shmem helpers.=C2=A0 ttm is out.<br>
&gt;=C2=A0 - Only DRM_FORMAT_RGB565 (depth 16) is supported.=C2=A0 The old =
driver does<br>
&gt;=C2=A0 =C2=A0 that too by default.=C2=A0 There was a module parameter w=
hich enables 24/32<br>
&gt;=C2=A0 =C2=A0 bpp support and disables higher resolutions (due to cirru=
s hardware<br>
&gt;=C2=A0 =C2=A0 constrains).=C2=A0 That parameter wasn&#39;t reimplemente=
d.<br>
This might be the big sticking point, this is a userspace regression<br>
for a feature that was explicitly added a few years ago, can we really<br>
get away without it?<br></blockquote><div><br></div><div>Chrome OS testing =
in VMs was one of the consumers of 32bpp on cirrus, and we have gotten rid =
of cirrus in favor of virtio gpu, so we&#39;d be fine. Of course I can&#39;=
t speak for other consumers :)</div><div><br></div><div>St=C3=A9phane</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
The rest looks good though!<br>
Dave.<br>
<br>
&gt;=C2=A0 - The simple display pipeline is used.<br>
&gt;=C2=A0 - The generic fbdev emulation is used.<br>
&gt;=C2=A0 - It&#39;s a atomic driver now.<br>
&gt;<br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a></blockquote></div></div>

--000000000000c4a5b20585abca5a--

--===============5913422303956153938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5913422303956153938==--
