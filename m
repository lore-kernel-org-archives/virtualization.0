From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Mon, 4 Feb 2013 21:29:22 +0100
Message-ID: <CAJK669aVu_h-ZJnNF0yWBvzfvfj2NSNxDkuHSmJxdUGLNtjOcQ@mail.gmail.com>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3276173133279869166=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============3276173133279869166==
Content-Type: multipart/alternative; boundary=f46d042f9590d0f57404d4ebf2cc

--f46d042f9590d0f57404d4ebf2cc
Content-Type: text/plain; charset=UTF-8

Hi Rusty,

On Thu, Jan 17, 2013 at 11:29 AM, Rusty Russell <rusty@rustcorp.com.au>wrote:

> Getting use of virtio rings correct is tricky, and a recent patch saw
> an implementation of in-kernel rings (as separate from userspace).
>
> This patch attempts to abstract the business of dealing with the
> virtio ring layout from the access (userspace or direct); to do this,
> we use function pointers, which gcc inlines correctly.


I have been using your patches for a while in my test setup without any
issues with vringh. The only thing I'm missing is export of symbols.
My current caif_virtio driver expects vringh to be a module exporting
symbols. Is this something you are planning to add?

I guess my vringh related stuff should go into your tree together with your
vringh patches...
Would you be willing to take this via your tree, provided that I get acks
from the right people?

Regards,
Sjur

--f46d042f9590d0f57404d4ebf2cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rusty,<br><br><div class=3D"gmail_quote">On Thu, Jan 17, 2013 at 11:29 A=
M, Rusty Russell <span dir=3D"ltr">&lt;<a href=3D"mailto:rusty@rustcorp.com=
.au" target=3D"_blank">rusty@rustcorp.com.au</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
Getting use of virtio rings correct is tricky, and a recent patch saw<br>
an implementation of in-kernel rings (as separate from userspace).<br>
<br>
This patch attempts to abstract the business of dealing with the<br>
virtio ring layout from the access (userspace or direct); to do this,<br>
we use function pointers, which gcc inlines correctly.</blockquote><div><br=
></div><div>I have been using your patches for a while in my test setup wit=
hout any</div><div>issues with vringh. The only thing I&#39;m missing is ex=
port of symbols.</div>
<div>My current=C2=A0caif_virtio=C2=A0driver expects=C2=A0vringh=C2=A0to be=
 a module exporting</div><div>symbols. Is this something=C2=A0you are plann=
ing to add?</div><div><br></div><div><div><div>I guess my vringh related st=
uff should go into your tree together with your vringh patches...</div>
<div>Would you be willing to take this via your tree, provided that I get a=
cks from the right people?</div></div></div><div><br></div><div>Regards,</d=
iv><div>Sjur</div><div><br></div></div>

--f46d042f9590d0f57404d4ebf2cc--

--===============3276173133279869166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3276173133279869166==--
