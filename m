Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC96DC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 11:12:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9759420738
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 11:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlGBTw5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FDBD88460;
	Fri, 21 Aug 2020 11:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3k27SCwaETeP; Fri, 21 Aug 2020 11:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CD1018836E;
	Fri, 21 Aug 2020 11:12:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF34AC0889;
	Fri, 21 Aug 2020 11:12:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 557BBC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4BF6886BB2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IdfCAoiIQ4fz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:12:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B7AC186B7C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598008322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HysSoligsnejQVX48NzOeALqwMxdO9BYkCkDmiwtFg=;
 b=OlGBTw5xZvt5oJLWPMg1p+jBMGGdy68KB6AIeZp/LqwrMW6CaJFlMoeDLKvnxk8gfhaDm5
 KNjnaiI+bXlz5zLiUC95S/MFzGg9s9tSksLJ78p5rkomzm3jnECK2wzfYbzlHASTa8vuoE
 ayIiytV754nP2PqPBRISgREGYhgzhmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-AjbPm1I-MD-nH2eBPfQ0kg-1; Fri, 21 Aug 2020 07:11:58 -0400
X-MC-Unique: AjbPm1I-MD-nH2eBPfQ0kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53BB3393B2;
 Fri, 21 Aug 2020 11:11:57 +0000 (UTC)
Received: from localhost (ovpn-113-166.ams2.redhat.com [10.36.113.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB7719C78;
 Fri, 21 Aug 2020 11:11:52 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:11:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
Message-ID: <20200821111151.GB205318@stefanha-x1.localdomain>
References: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, mst@redhat.com, linuxarm@huawei.com,
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
Content-Type: multipart/mixed; boundary="===============7286244042886149744=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7286244042886149744==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 09:19:15AM +0800, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8/q/cACgkQnKSrs4Gr
c8jTgQf9HU2+C89RVtHBpnAWRYLnOumoDji/XAVh0k9gbsnEzPWi9heg9b2ts6sq
boXUk6lb4MOiIORwrIcoj5NhiTVze3jgV6FVFIMLvAg+6BdZJlK307NBwy7GFyyJ
22kYlzvrBbgKV+wAxHxtkCsp6/+5Jx41jQ+VcS0mUI2RwZQw0hT7QO3ekrxuIWeV
qSjgxDQQYF23l0p9WVHTswfdQdxxVpXLjEfK+ktUy4tFh/j7QsgMSnsGaUOBEa98
y3YQP7YzqrYkI8k+HVIUcEq9tzYWhJhKSw2hbmi1U18SoN0L3Qdiv2KVx1VfYuW8
RquRSG6o11Aa3f3BU9HEES1ZuwO8SA==
=xB59
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--


--===============7286244042886149744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7286244042886149744==--

