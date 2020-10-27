Return-Path: <SRS0=a9Wa=EC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E63C55178
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 17:43:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECB3206DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 17:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECB3206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36EA887287;
	Tue, 27 Oct 2020 17:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93I+vNrYUMam; Tue, 27 Oct 2020 17:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B907A87284;
	Tue, 27 Oct 2020 17:43:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9450C0859;
	Tue, 27 Oct 2020 17:43:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18D14C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 17:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0603387287
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 17:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DQdFXajuqyh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 17:43:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0042.hostedemail.com
 [216.40.44.42])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0CA7F87284
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 17:43:21 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id A20FC1801C5D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 17:08:12 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 45489182CED2A;
 Tue, 27 Oct 2020 17:08:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake71_590ddfb2727d
X-Filterd-Recvd-Size: 4916
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Tue, 27 Oct 2020 17:08:04 +0000 (UTC)
Message-ID: <2767969b94fd66db1fb0fc13b5783ae65b7deb2f.camel@perches.com>
Subject: Re: [PATCH 3/8] vhost: vringh: use krealloc_array()
From: Joe Perches <joe@perches.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 27 Oct 2020 10:08:02 -0700
In-Reply-To: <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
References: <20201027121725.24660-1-brgl@bgdev.pl>
 <20201027121725.24660-4-brgl@bgdev.pl>
 <20201027112607-mutt-send-email-mst@kernel.org>
 <685d850347a1191bba8ba7766fc409b140d18f03.camel@perches.com>
 <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Gustavo Padovan <gustavo@padovan.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-drm <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 David Rientjes <rientjes@google.com>,
 virtualization@lists.linux-foundation.org,
 linux-media <linux-media@vger.kernel.org>, Robert Richter <rric@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-gpio <linux-gpio@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, netdev <netdev@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Pekka Enberg <penberg@kernel.org>, James Morse <james.morse@arm.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 2020-10-27 at 17:58 +0100, Bartosz Golaszewski wrote:
> On Tue, Oct 27, 2020 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> > =

> > On Tue, 2020-10-27 at 11:28 -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 27, 2020 at 01:17:20PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > =

> > > > Use the helper that checks for overflows internally instead of manu=
ally
> > > > calculating the size of the new array.
> > > > =

> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > =

> > > No problem with the patch, it does introduce some symmetry in the cod=
e.
> > =

> > Perhaps more symmetry by using kmemdup
> > ---
> > =A0drivers/vhost/vringh.c | 23 ++++++++++-------------
> > =A01 file changed, 10 insertions(+), 13 deletions(-)
> > =

> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 8bd8b403f087..99222a3651cd 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -191,26 +191,23 @@ static int move_to_indirect(const struct vringh *=
vrh,
> > =A0static int resize_iovec(struct vringh_kiov *iov, gfp_t gfp)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0struct kvec *new;
> > -       unsigned int flag, new_num =3D (iov->max_num & ~VRINGH_IOV_ALLO=
CATED) * 2;
> > +       size_t new_num =3D (iov->max_num & ~VRINGH_IOV_ALLOCATED) * 2;
> > +       size_t size;
> > =

> > =A0=A0=A0=A0=A0=A0=A0=A0if (new_num < 8)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0new_num =3D 8;
> > =

> > -       flag =3D (iov->max_num & VRINGH_IOV_ALLOCATED);
> > -       if (flag)
> > -               new =3D krealloc(iov->iov, new_num * sizeof(struct iove=
c), gfp);
> > -       else {
> > -               new =3D kmalloc_array(new_num, sizeof(struct iovec), gf=
p);
> > -               if (new) {
> > -                       memcpy(new, iov->iov,
> > -                              iov->max_num * sizeof(struct iovec));
> > -                       flag =3D VRINGH_IOV_ALLOCATED;
> > -               }
> > -       }
> > +       if (unlikely(check_mul_overflow(new_num, sizeof(struct iovec), =
&size)))
> > +               return -ENOMEM;
> > +
> =

> The whole point of using helpers such as kmalloc_array() is not doing
> these checks manually.

Tradeoffs for in readability for overflow and not mistyping or doing
the multiplication of iov->max_num * sizeof(struct iovec) twice.

Just fyi:

the realloc doesn't do a multiplication overflow test as written so the
suggestion is slightly more resistant to defect.

   =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
