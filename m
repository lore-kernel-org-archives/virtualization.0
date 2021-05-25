Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D145C47086
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 13:21:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D570E6141C
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 13:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D570E6141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96F2683C8C;
	Tue, 25 May 2021 13:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SItMC9rTTh2; Tue, 25 May 2021 13:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 264DD83C7C;
	Tue, 25 May 2021 13:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020D4C000E;
	Tue, 25 May 2021 13:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E0CFC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4E5B40191
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oRBt3QqtOvs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8A8D403BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621948866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNt+DjVfGGIxrVvGjGmM2V8MGzWk+ZVdoTSHQp30M6w=;
 b=Llq6nAkrJQ3nYldz/rdojmyhG5Byz4Wm/evoEIxu32+pe23S+dLuVTGQDpd7jMji+P0ju+
 Sv5KTdND+vCB7rTBB9HiwPc0vvLRZUe6LN51BfIldClqYBsQQXMD6AZ+dxWnBP1ArAyy7t
 o9MUqhRisV8CKzd4Ik+BKQ9AH/4KX+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-c7s7ocZ1NLmyw36_7g7jGg-1; Tue, 25 May 2021 09:21:02 -0400
X-MC-Unique: c7s7ocZ1NLmyw36_7g7jGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11D28107ACCD;
 Tue, 25 May 2021 13:21:01 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1205D6AC;
 Tue, 25 May 2021 13:20:49 +0000 (UTC)
Date: Tue, 25 May 2021 14:20:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKz5sQPPNdccztHh@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
 <YKypgi2qcYVTgYdv@T590>
MIME-Version: 1.0
In-Reply-To: <YKypgi2qcYVTgYdv@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============8515181396462981691=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8515181396462981691==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GTdFGyW7Xz8tnV5A"
Content-Disposition: inline


--GTdFGyW7Xz8tnV5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 03:38:42PM +0800, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
> > On 24/05/21 16:59, Christoph Hellwig wrote:
> > > On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > > > Possible drawbacks of this approach:
> > > >=20
> > > > - Hardware virtio_blk implementations may find virtqueue_disable_cb=
()
> > > >    expensive since it requires DMA. If such devices become popular =
then
> > > >    the virtio_blk driver could use a similar approach to NVMe when
> > > >    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> > > >=20
> > > > - If a blk_poll() thread is descheduled it not only hurts polling
> > > >    performance but also delays completion of non-REQ_HIPRI requests=
 on
> > > >    that virtqueue since vq notifications are disabled.
> > >=20
> > > Yes, I think this is a dangerous configuration.  What argument exists
> > > again just using dedicated poll queues?
> >=20
> > There isn't an equivalent of the admin queue in virtio-blk, which would
> > allow the guest to configure the desired number of poll queues.  The nu=
mber
> > of queues is fixed.
>=20
> Dedicated vqs can be used for poll only, and I understand VM needn't to k=
now
> if the vq is polled or driven by IRQ in VM.
>=20
> I tried that in v5.4, but not see obvious IOPS boost, so give up.
>=20
> https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll

Hey, that's cool. I see a lot of similarity between our patches :).

Stefan

--GTdFGyW7Xz8tnV5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCs+bEACgkQnKSrs4Gr
c8gpvwf9Gsszvx3thnjSlUHG86t1HZE4scSNI6lprmUa91+ClXSNycaUbWeVwhFb
RtBBVcKmNyhhn/GKBlczjmVd5BepVijB8cQflfk2gVVol4c/4IfckdlAuhn4SM2F
FAcyRrUqV17bUzOMCWpnN50nSHaGFBGxnJncMb04WdaM23J+Mi8PfD/ixcRkJCQq
ZDAR51KF4iHXK5eSC4dPnQ3MI40NZRBnyxT+09k8c522XdAT55GUbQeAxAtvA5Mm
5jr5DfO1SRrCZyKstnEVZTu6cN+2Y7sunsJ/9sR+VNKTAMpCuX29EyDOxTZBB8fd
SVNiZeqFPX42bPVbwvacmEC35OHJ7w==
=wyc4
-----END PGP SIGNATURE-----

--GTdFGyW7Xz8tnV5A--


--===============8515181396462981691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8515181396462981691==--

