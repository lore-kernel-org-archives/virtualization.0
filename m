Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF892C32796
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 17:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EFAE40BE1;
	Wed, 24 Aug 2022 17:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EFAE40BE1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7Mt02Nk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hzgl4zLtPl9J; Wed, 24 Aug 2022 17:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD8D740BAC;
	Wed, 24 Aug 2022 17:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BD8D740BAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC9BC0032;
	Wed, 24 Aug 2022 17:32:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 660EDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D8F58267F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:32:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D8F58267F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7Mt02Nk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KErlKUzP8CW7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70212825E6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70212825E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661362353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SxvzmbfXBys/uUI/1Xzbbd4NhELb1JncuSp2gy3f7o=;
 b=K7Mt02NkHdeVS6jMKLQkiLxDC7AjpLlxTT26W5K6ta/wwJiPL7H1T0QkRKKgEJ0jd/VXGj
 loKd2B8NnDw0+IUTJHY4G8FH15kY2zwPJXbdLTeZ8LgWFUjZa+IuvFMFxnrVOfqMMajoEX
 WYoeRszwOH/6SYVvUs6vm71Xh6j+T10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-4ATjl8YdPNSzaGtmbrR8pQ-1; Wed, 24 Aug 2022 13:32:28 -0400
X-MC-Unique: 4ATjl8YdPNSzaGtmbrR8pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB66E18812C0;
 Wed, 24 Aug 2022 17:32:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40BFB40CF8EF;
 Wed, 24 Aug 2022 17:32:26 +0000 (UTC)
Date: Wed, 24 Aug 2022 13:32:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kim Suwan <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwZgqf5kMqKHwcxR@fedora>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora>
 <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: acourbot@chromium.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============4656752721026547888=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4656752721026547888==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wZ49M233+TjXIU1/"
Content-Disposition: inline


--wZ49M233+TjXIU1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> Hi Stefan,
>=20
> On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_b=
lk_vq *vq,
> > >                       virtblk_unmap_data(req, vbr);
> > >                       virtblk_cleanup_cmd(req);
> > >                       rq_list_add(requeue_list, req);
> > > +             } else {
> > > +                     blk_mq_start_request(req);
> > >               }
> >
> > The device may see new requests as soon as virtblk_add_req() is called
> > above. Therefore the device may complete the request before
> > blk_mq_start_request() is called.
> >
> > rq->io_start_time_ns =3D ktime_get_ns() will be after the request was
> > actually submitted.
> >
> > I think blk_mq_start_request() needs to be called before
> > virtblk_add_req().
> >
>=20
> But if blk_mq_start_request() is called before virtblk_add_req()
> and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> virtio_queue_rq().
>=20
> With regard to the race condition between virtblk_add_req() and
> completion, I think that the race condition can not happen because
> virtblk_add_req() holds vq lock with irq saving and completion side
> (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> Moreover, virtblk_done() is irq context so I think it can not be
> executed until virtblk_add_req() releases the lock.

I agree there is no race condition regarding the ordering of
blk_mq_start_request() and request completion. The spinlock prevents
that and I wasn't concerned about that part.

The issue is that the timestamp will be garbage. If we capture the
timestamp during/after the request is executing, then the collected
statistics will be wrong.

Can you look for another solution that doesn't break the timestamp?

FWIW I see that the rq->state state machine allows returning to the idle
state once the request has been started: __blk_mq_requeue_request().

Stefan

--wZ49M233+TjXIU1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMGYKkACgkQnKSrs4Gr
c8hF+gf6AhXhzLB6TCjRg/U/ved3Yj0e/lR75NkPlvmJiGu3ncW3AU01UY5hFNoO
9S2+RbCGhGSNji8n8Rqu4OxDAZaRgYJ1USCDhZs4HF+lNU/IHTUYoge29pcqyCoW
PI6bWLpY0luidnMqxKlcLsAExsl7u+vlxUOBGxlgvgKEP1V3HHCs8/spBiMEJRUJ
Kp1xxPWP439HxTZm1BSDFwXx+aWakWDEXzF8qPBu9hvyhDtVjCaedWXDjKQPqxHh
xvmd+n9qLMkOQyp8s8z1CUP/hbH2p7fXQB6F5YI0G2HMfrSfWbN2MrmeRB4g/ZD3
Frb0ABhrgQnbuVDLB/nsaM/ewyYzjQ==
=S6B9
-----END PGP SIGNATURE-----

--wZ49M233+TjXIU1/--


--===============4656752721026547888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4656752721026547888==--

