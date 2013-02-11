From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH] virtio_console: Use virtio device index to generate port
	name
Date: Mon, 11 Feb 2013 14:12:52 +0100
Message-ID: <CAJK669aD7S4kxm3fo401v2ni1LubNAB=96aB1uWsd9NmBKjzQw@mail.gmail.com>
References: <1358425397-4584-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125092008.GC30483@amit.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0988808696419781816=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130125092008.GC30483@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============0988808696419781816==
Content-Type: multipart/alternative; boundary=047d7b2e3f069c0d4204d572aafc

--047d7b2e3f069c0d4204d572aafc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2013 at 10:20 AM, Amit Shah <amit.shah@redhat.com> wrote:

> On (Thu) 17 Jan 2013 [13:23:17], sjur.brandeland@stericsson.com wrote:
> > From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> >
> > Use virtio device index for creating unique device port names.
> > Current index allocation in virtio is based on a monotonically
> > increasing variable "index". A better handling of this is to
> > use device index which is allocated by ida.
>
> This should be fine.  I'm wondering, though, if there's something else
> you need from the naming scheme (esp. considering the next patch)?
>

This current patch solves the most critical issue - that the device name
changes for every modem reboot. This is a show-stopper for me. So it would
be
great if this patch could go upstream. The other problem that device name
is non-deterministic is currently only a theoretical problem as we have
only one
remoteproc device.

Regards,
Sjur

--047d7b2e3f069c0d4204d572aafc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 25, 2013 at 10:20 AM, Amit Shah <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:amit.shah@redhat.com" target=3D"_blank"=
>amit.shah@redhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<div class=3D"im">On (Thu) 17 Jan 2013 [13:23:17], <a href=3D"mailto:sjur.b=
randeland@stericsson.com">sjur.brandeland@stericsson.com</a> wrote:<br>
&gt; From: Sjur Br=C3=A6ndeland &lt;<a href=3D"mailto:sjur.brandeland@steri=
csson.com">sjur.brandeland@stericsson.com</a>&gt;<br>
&gt;<br>
&gt; Use virtio device index for creating unique device port names.<br>
&gt; Current index allocation in virtio is based on a monotonically<br>
&gt; increasing variable &quot;index&quot;. A better handling of this is to=
<br>
&gt; use device index which is allocated by ida.<br>
<br>
</div>This should be fine. =C2=A0I&#39;m wondering, though, if there&#39;s =
something else<br>
you need from the naming scheme (esp. considering the next patch)?<br></blo=
ckquote><div><br></div><div>This current patch solves the most critical iss=
ue - that the device name</div><div>changes for every modem reboot. This is=
 a show-stopper for me. So it would be</div>
<div>great if this patch could go upstream.=C2=A0The other problem that dev=
ice name</div><div>is non-deterministic is=C2=A0currently only a=C2=A0theor=
etical problem as we have only one</div><div>remoteproc device.</div><div><=
br></div><div>
Regards,</div><div>Sjur</div></div>

--047d7b2e3f069c0d4204d572aafc--

--===============0988808696419781816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0988808696419781816==--
