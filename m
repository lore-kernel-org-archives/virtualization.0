Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05028C47084
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 13:19:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C87161420
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 13:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C87161420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3911A83065;
	Tue, 25 May 2021 13:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irbRW_0k88Sa; Tue, 25 May 2021 13:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D11C582EB6;
	Tue, 25 May 2021 13:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B303AC000E;
	Tue, 25 May 2021 13:19:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB7CDC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFCDB607A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPkCG0bb-BoG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92B7B6063B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621948782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZxaIXMKBL2xYZBd8FBb6gCvi6cm3iqOYV73SsLQBnI=;
 b=WJxcNj0ycMUie3dKTJkmvCp5LscJ5AMstMVXbu0pG3jRf51zgCCuAzumzNMnAy37qmpS9w
 xGadnA2/L2sEJN1oc3xxqC30uCOTgHraNzM7yzaM2sy7KvbC0VH4Iqc9vAJoC1zTRboGvd
 J6I6S9TiGO4WEChLCgsvKBQ5+kWumos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-4G8AXiD4MC6vQu30vdl2ng-1; Tue, 25 May 2021 09:19:32 -0400
X-MC-Unique: 4G8AXiD4MC6vQu30vdl2ng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D733100945E;
 Tue, 25 May 2021 13:19:31 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15982100760F;
 Tue, 25 May 2021 13:19:23 +0000 (UTC)
Date: Tue, 25 May 2021 14:19:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKz5WqaeU0R0jQMu@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <20210524145928.GA3873@lst.de>
MIME-Version: 1.0
In-Reply-To: <20210524145928.GA3873@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============3546173323483954244=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3546173323483954244==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FcfGVErKD3SlOPsb"
Content-Disposition: inline


--FcfGVErKD3SlOPsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 04:59:28PM +0200, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > Possible drawbacks of this approach:
> >=20
> > - Hardware virtio_blk implementations may find virtqueue_disable_cb()
> >   expensive since it requires DMA. If such devices become popular then
> >   the virtio_blk driver could use a similar approach to NVMe when
> >   VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> >=20
> > - If a blk_poll() thread is descheduled it not only hurts polling
> >   performance but also delays completion of non-REQ_HIPRI requests on
> >   that virtqueue since vq notifications are disabled.
>=20
> Yes, I think this is a dangerous configuration.  What argument exists
> again just using dedicated poll queues?

Aside from what Paolo described (the lack of a hardware interface to
designate polling queues), the poll_queues=3DN parameter needs to be added
to the full guest and host software stack. Users also need to learn
about this so they can enable it in all the places. This is much more
hassle for users to configure. The dynamic polling mode approach
requires no configuration.

Paolo's suggestion is to notify the driver when irqs need to be
re-enabled if the polling thread is descheduled. I actually have a
prototype that achieves something similar here:
https://gitlab.com/stefanha/linux/-/commits/cpuidle-haltpoll-virtqueue

It's a different approach from the current patch series: the cpuidle
driver provides poll_start/stop() callbacks and virtio_blk participates
in cpuidle-haltpoll. That means all virtio-blk devices temporarily use
polling mode while the vCPU is doing cpuidle-haltpoll polling. The neat
thing about the cpuidle approach is:
1. Applications don't need to set the RWF_HIPRI flag!
2. Other drivers besides virtio_blk can participate in polling too.

Maybe we should go with cpuidle polling instead?

Stefan

--FcfGVErKD3SlOPsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCs+VoACgkQnKSrs4Gr
c8iQxwgAmR9W7hmYqTRjXDc7N6m7WlEUvC5lJOdzS6z9lyWow8E4NbsDC3bWMGRA
FqBeqV/uXR7quNHf2SlUJRYU8vCiHklVo2GuEVi28frjrI+a1jNIAYqgreDPruWp
raBsSoXtEiYp7hbNFxTbRV78h/NiM/YB5SaVLSW5X+0JTbIDvQ3Too7VZeDfvdki
ia88AtFEQ19hFnvIMnnEPu/Lh6J71U2opqacHvBqJMfFJGIQotpBlnHc/uwW+GQ6
Uys7SGQ073N8tZStszYefcPI0QRiptiIAE08DO40KlLjKtBHt1hc5QAd3y89y5el
ZSupk+mYJLpzLXQUB+VvLAINMtu2Og==
=PIq+
-----END PGP SIGNATURE-----

--FcfGVErKD3SlOPsb--


--===============3546173323483954244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3546173323483954244==--

