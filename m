From: Dmitry Fleytman <dmitry@daynix.com>
Subject: Re: [PATCH 0/2] virtio-spec: dynamic network offloads configuration
Date: Wed, 27 Mar 2013 19:49:50 +0200
Message-ID: <CAGHCxhfMHRJ5_rCiAaP5pBLuDB4mPHvcRnVnFgbPeYCLMMXi2g@mail.gmail.com>
References: <1364391798-8058-1-git-send-email-dmitry@daynix.com>
	<20130327152750.GC29249@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2399506703058716653=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327152750.GC29249@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============2399506703058716653==
Content-Type: multipart/alternative; boundary=14dae9340a1d58725804d8ebab23

--14dae9340a1d58725804d8ebab23
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 27, 2013 at 5:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 27, 2013 at 03:43:16PM +0200, Dmitry Fleytman wrote:
> > From: Dmitry Fleytman <dfleytma@redhat.com>
> >
> > One of recently introduced Windows features (RSC)
> > requires network driver to be able to enable and disable
> > HW LRO offload on the fly without device reinitialization.
> >
> > Current Virtio specification doesn't support this requirement.
> > The solution proposed by following spec patch is to add
> > a new control command for this purpose.
> >
> > The same solution may be used in Linux driver for ethtool interface
> > implementation.
> >
> > Patch for QEMU mainline that implements this specification change
> > attached as well for reference.
>
> A minor note: sticking _GUEST_ in the command name
> might be a good idea.
> Sents some more minor comments per-patch.
>
>
[DF] Ok, will be fixed and resubmitted.


>
> > Dmitry Fleytman (1):
> >   virtio-net: dynamic network offloads configuration
> >
> >  hw/virtio-net.c | 110
> +++++++++++++++++++++++++++++++++++++++++++++++---------
> >  hw/virtio-net.h |  19 ++++++++++
> >  2 files changed, 113 insertions(+), 16 deletions(-)
> >
> > --
> > 1.8.1.4
>

--14dae9340a1d58725804d8ebab23
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Mar 27, 2013 at 5:27 PM, Michael S. Tsirkin <span =
dir=3D"ltr">&lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@red=
hat.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"g=
mail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Mar 27, 2013 at 03=
:43:16PM +0200, Dmitry Fleytman wrote:<br>
&gt; From: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@redhat.com">dfley=
tma@redhat.com</a>&gt;<br>
&gt;<br>
&gt; One of recently introduced Windows features (RSC)<br>
&gt; requires network driver to be able to enable and disable<br>
&gt; HW LRO offload on the fly without device reinitialization.<br>
&gt;<br>
&gt; Current Virtio specification doesn&#39;t support this requirement.<br>
&gt; The solution proposed by following spec patch is to add<br>
&gt; a new control command for this purpose.<br>
&gt;<br>
&gt; The same solution may be used in Linux driver for ethtool interface<br=
>
&gt; implementation.<br>
&gt;<br>
&gt; Patch for QEMU mainline that implements this specification change<br>
&gt; attached as well for reference.<br>
<br>
</div>A minor note: sticking _GUEST_ in the command name<br>
might be a good idea.<br>
Sents some more minor comments per-patch.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div><=
br></div><div style>[DF] Ok, will be fixed and resubmitted.</div><div>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">
<br>
&gt; Dmitry Fleytman (1):<br>
&gt; =A0 virtio-net: dynamic network offloads configuration<br>
&gt;<br>
&gt; =A0hw/virtio-net.c | 110 +++++++++++++++++++++++++++++++++++++++++++++=
++---------<br>
&gt; =A0hw/virtio-net.h | =A019 ++++++++++<br>
&gt; =A02 files changed, 113 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.1.4<br>
</div></div></blockquote></div><br></div></div>

--14dae9340a1d58725804d8ebab23--

--===============2399506703058716653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2399506703058716653==--
