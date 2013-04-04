From: Dmitry Fleytman <dmitry@daynix.com>
Subject: Re: [PATCH 1/2 V3] virtio-spec: dynamic network offloads configuration
Date: Thu, 4 Apr 2013 10:51:08 +0300
Message-ID: <CAGHCxhd=xr2yfhxN7_8iF9jJ_yBQaemV+V1TU08A9jAVhPK6xw@mail.gmail.com>
References: <1364902740-24948-1-git-send-email-dmitry@daynix.com>
	<1364902740-24948-2-git-send-email-dmitry@daynix.com>
	<87ehes5s18.fsf@rustcorp.com.au>
	<20130403112515.GC19122@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6817353327460536295=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130403112515.GC19122@redhat.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, virtualization <virtualization@lists.linux-foundation.org>, Ronen Hod <rhod@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============6817353327460536295==
Content-Type: multipart/alternative; boundary=089e0122f7b0efe83104d9843cb1

--089e0122f7b0efe83104d9843cb1
Content-Type: text/plain; charset=ISO-8859-1

Ok, sending new patches...


On Wed, Apr 3, 2013 at 2:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Apr 03, 2013 at 11:50:19AM +1030, Rusty Russell wrote:
> > Dmitry Fleytman <dmitry@daynix.com> writes:
> > > From: Dmitry Fleytman <dfleytma@redhat.com>
> > >
> > > Virtio-net driver currently negotiates network offloads
> > > on startup via features mechanism and have no ability to
> > > change offloads state later.
> > > This patch introduced a new control command that allows
> > > to configure device network offloads state dynamically.
> > > The patch also introduces a new feature flag
> > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > >
> > > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> >
> > (BTW, I like to be CC'd on these things directly, so I don't miss them)
> >
> > The idea is fine.
> >
> > But I dislike the duplication of constants: let's just use the feature
> > bits directly:
> >
> > #define VIRTIO_NET_F_GUEST_CSUM       1       /* Guest handles pkts w/
> partial csum */
> > #define VIRTIO_NET_F_GUEST_TSO4       7       /* Guest can handle TSOv4
> in. */
> > #define VIRTIO_NET_F_GUEST_TSO6       8       /* Guest can handle TSOv6
> in. */
> > #define VIRTIO_NET_F_GUEST_ECN        9       /* Guest can handle TSO[6]
> w/ ECN in. */
> > #define VIRTIO_NET_F_GUEST_UFO        10      /* Guest can handle UFO
> in. */
> >
> > You want this, because you have to test against them anyway before
> > trying to re-enable them.
> >
> > And secondly, it'll be much clearer if you don't say "change" but
> > "disable and re-enable", which is what's actually allowed.
> >
> > Thanks,
> > Rusty.
>
> Okay and let's make command it bigger, say 64 bit then,
> in case we add lots of feature bits in the future?
>
>
>

--089e0122f7b0efe83104d9843cb1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, sending=A0new patches...</div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">On Wed, Apr 3, 2013 at 2:25 PM, Micha=
el S. Tsirkin <span dir=3D"ltr">&lt;<a href=3D"mailto:mst@redhat.com" targe=
t=3D"_blank">mst@redhat.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On W=
ed, Apr 03, 2013 at 11:50:19AM +1030, Rusty Russell wrote:<br>
&gt; Dmitry Fleytman &lt;<a href=3D"mailto:dmitry@daynix.com">dmitry@daynix=
.com</a>&gt; writes:<br>
&gt; &gt; From: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@redhat.com">=
dfleytma@redhat.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Virtio-net driver currently negotiates network offloads<br>
&gt; &gt; on startup via features mechanism and have no ability to<br>
&gt; &gt; change offloads state later.<br>
&gt; &gt; This patch introduced a new control command that allows<br>
&gt; &gt; to configure device network offloads state dynamically.<br>
&gt; &gt; The patch also introduces a new feature flag<br>
&gt; &gt; VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Dmitry Fleytman &lt;<a href=3D"mailto:dfleytma@red=
hat.com">dfleytma@redhat.com</a>&gt;<br>
&gt;<br>
&gt; (BTW, I like to be CC&#39;d on these things directly, so I don&#39;t m=
iss them)<br>
&gt;<br>
&gt; The idea is fine.<br>
&gt;<br>
&gt; But I dislike the duplication of constants: let&#39;s just use the fea=
ture<br>
&gt; bits directly:<br>
&gt;<br>
&gt; #define VIRTIO_NET_F_GUEST_CSUM =A0 =A0 =A0 1 =A0 =A0 =A0 /* Guest han=
dles pkts w/ partial csum */<br>
&gt; #define VIRTIO_NET_F_GUEST_TSO4 =A0 =A0 =A0 7 =A0 =A0 =A0 /* Guest can=
 handle TSOv4 in. */<br>
&gt; #define VIRTIO_NET_F_GUEST_TSO6 =A0 =A0 =A0 8 =A0 =A0 =A0 /* Guest can=
 handle TSOv6 in. */<br>
&gt; #define VIRTIO_NET_F_GUEST_ECN =A0 =A0 =A0 =A09 =A0 =A0 =A0 /* Guest c=
an handle TSO[6] w/ ECN in. */<br>
&gt; #define VIRTIO_NET_F_GUEST_UFO =A0 =A0 =A0 =A010 =A0 =A0 =A0/* Guest c=
an handle UFO in. */<br>
&gt;<br>
&gt; You want this, because you have to test against them anyway before<br>
&gt; trying to re-enable them.<br>
&gt;<br>
&gt; And secondly, it&#39;ll be much clearer if you don&#39;t say &quot;cha=
nge&quot; but<br>
&gt; &quot;disable and re-enable&quot;, which is what&#39;s actually allowe=
d.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Rusty.<br>
<br>
</div></div>Okay and let&#39;s make command it bigger, say 64 bit then,<br>
in case we add lots of feature bits in the future?<br>
<br>
<br>
</blockquote></div><br></div>

--089e0122f7b0efe83104d9843cb1--

--===============6817353327460536295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6817353327460536295==--
