From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Virtio_console usage of early printk
Date: Tue, 23 Mar 2010 09:17:58 +0100
Message-ID: <201003230917.58142.borntraeger__25224.1629678339$1269332318$gmane$org@de.ibm.com>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
	<20100323021620.GA4088@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100323021620.GA4088@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: =?iso-8859-1?q?Fran=E7ois_Diakhate?= <fdiakh@gmail.com>, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 23 M=E4rz 2010 03:16:20 schrieb Amit Shah:
> On (Mon) Mar 22 2010 [18:45:47], Fran=E7ois Diakhate wrote:
> > the console. Does the attached patch seem valid ? Feedback from s390
> > and powerpc users who use this functionality would be appreciated.
> =

> Looks OK to me, Christian, others, could you comment on this please?

Looks good and boot tested with kuli on s390.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> > From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
> > From: =3D?utf-8?q?Fran=3DC3=3DA7ois=3D20Diakhat=3DC3=3DA9?=3D <fdiakh@g=
mail.com>
> > Date: Thu, 18 Mar 2010 14:48:20 +0100
> > Subject: virtio: console: Fix early_put_chars usage
> > =

> > Currently early_put_chars is not used by virtio_console because it can =
only be used once a port has been found, at which point it's too late becau=
se it is no longer needed. This patch should fix it.
> > ---
> >  drivers/char/virtio_console.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > =

> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_consol=
e.c
> > index f404ccf..691ba21 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -645,13 +645,13 @@ static int put_chars(u32 vtermno, const char *buf=
, int count)
> >  {
> >  	struct port *port;
> >  =

> > +	if (unlikely(early_put_chars))
> > +		return early_put_chars(vtermno, buf, count);
> > +
> >  	port =3D find_port_by_vtermno(vtermno);
> >  	if (!port)
> >  		return 0;
> >  =

> > -	if (unlikely(early_put_chars))
> > -		return early_put_chars(vtermno, buf, count);
> > -
> >  	return send_buf(port, (void *)buf, count);
> >  }
