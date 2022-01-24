Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEECEC433F5
	for <virtualization@archiver.kernel.org>; Mon, 24 Jan 2022 11:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90993605A2;
	Mon, 24 Jan 2022 11:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3q4IjYeLApJ; Mon, 24 Jan 2022 11:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AF8A60E4A;
	Mon, 24 Jan 2022 11:32:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED06AC0031;
	Mon, 24 Jan 2022 11:32:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B150DC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 916B440275
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:32:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgfM79E8inl9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:32:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C14DA403FD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643023926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qORMnoIdgKPzaKMb6YWMbi2BpiXpkDZcr/xPk+9njEw=;
 b=RisK8b27MWALvW7aE8fwyK5165hPJBeG7Q13Ei6xkp1rGtbunMmhJG2Ye+FnirPa8C+swD
 n2ygv3nBQMw/PREAKRXOo77Vx9l61WsNjjljA4nfZw4yfrd0BpBigT3Xh2ROEpkBVq5HGE
 I1TyGrEBkasilOJJKJI73j8eDZ7/vRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-CSH3-giRNCe3megBcHYkmA-1; Mon, 24 Jan 2022 06:32:02 -0500
X-MC-Unique: CSH3-giRNCe3megBcHYkmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE2B4814243;
 Mon, 24 Jan 2022 11:32:01 +0000 (UTC)
Received: from localhost (unknown [10.39.195.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF3410589B1;
 Mon, 24 Jan 2022 11:31:50 +0000 (UTC)
Date: Mon, 24 Jan 2022 11:31:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <Ye6OJdi2M1EBx7b3@stefanha-x1.localdomain>
References: <20220114090508.36416-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220114090508.36416-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============0590800459620644371=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0590800459620644371==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MUPe2nEeErvXt6ea"
Content-Disposition: inline


--MUPe2nEeErvXt6ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime.
>=20
> We are not caching the avail index, so when the device will call
> vhost_get_vq_desc(), it will find the old value in the cache and
> it will read the avail index again.

I think this wording is clearer because we do keep a cached the avail
index value, but the issue is we don't update it:
s/We are not caching the avail index/We do not update the cached avail
index value/

>=20
> It would be better to refresh the cache every time we read avail
> index, so let's change vhost_enable_notify() caching the value in
> `avail_idx` and compare it with `last_avail_idx` to check if there
> are new buffers available.
>=20
> Anyway, we don't expect a significant performance boost because
> the above path is not very common, indeed vhost_enable_notify()
> is often called with unlikely(), expecting that avail index has
> not been updated.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v1:
> - improved the commit description [MST, Jason]
> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, str=
uct vhost_virtqueue *vq)
>  		       &vq->avail->idx, r);
>  		return false;
>  	}
> +	vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> =20
> -	return vhost16_to_cpu(vq, avail_idx) !=3D vq->avail_idx;
> +	return vq->avail_idx !=3D vq->last_avail_idx;

vhost_vq_avail_empty() has a fast path that's missing in
vhost_enable_notify():

  if (vq->avail_idx !=3D vq->last_avail_idx)
      return false;

--MUPe2nEeErvXt6ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHujiUACgkQnKSrs4Gr
c8j4FQgAqGNimsQXmBYd5xvOIaFAPOU7K643vUM2nqHYrdNnPg2GVtVXiyulBb0N
gyajwW3HtC/CjTsb0mTXhAeHHiHJ+0ImiFGCsPrYhwwDQE9fK9QTwVNW0P++Suc1
yvHSZtUCHzoy9MxvTtfzPGFFZvyCnFCAM+VR3mTPvV6d5X9kM1iMMb4SOMP3eEJ5
Sr56/F6EgVy6IRHk5jw4b50dv/PXGkemVBToPYM1lJKpk6QItPkhO1Oz6cju47+l
/sEYr52mKCa+j4HT4wg9cOZQwrP9FzDmr41yDHQsz/4hLllTilrz4WxiwMU5hUsc
HGd9PcRpzj36BwxUcI3kzjr6yf9Sjw==
=t889
-----END PGP SIGNATURE-----

--MUPe2nEeErvXt6ea--


--===============0590800459620644371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0590800459620644371==--

