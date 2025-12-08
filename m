Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0582DC779
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209262; cv=none; b=XfAyd5W3ytgw0oxkJ/bT8jCGsPaKwJpvk72kQI/cVLwFBqSsNRkcMZs/68Tu3Ha0yGIuwUUKAKkW5L4gMEBaabrp/SGdamqay4uz5fU8EKUK7ZtC1BhJ+UqWrIgJ3CLodboSPAU2KG4UI0q3/OpYoe/dqULnrsjWEo0FsiTvU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209262; c=relaxed/simple;
	bh=OVTRU43Y8iq9jUvQUUyZEMdf6yAVz8c+fJZkaLWTRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx+cVXB4IDzIX3xT0nc+vrOaMlHQqnORGg7UgBfaJGdvzKA8xpVtJz2ryhZMnSD1qb+PNFNIxw8nt3bWfpw9GCk2FZgr4JSR1ep99jQMZ2V8sVtGY1rX4VlzUY696LFTFHowwQjsoGxBZL4IPXX4tPMjKT1JHOCTE97gujac+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiGzDiai; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiGzDiai"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13458608C5
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 15:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.46
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8C9xfVY7feQr for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 15:54:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08BF060880
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08BF060880
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TiGzDiai
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08BF060880
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765209258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+fzhReh8EtCE8bREBvU+OX1gSfPrhaD/fQ9jUc7a9w=;
	b=TiGzDiai3QgGWJTRCN4G8UefLkl9NT88I1m+rhqDWx59i+llDpLRnwNePp8XEDzInwvkfb
	Ksk7I5iTx7O4StGDr7YBmrRgxr1jVrI3pxTPzM0y2Ekf6utySMHjIo/PHe22TpEa2cUj0j
	08gwI7wtGqmphzpCqTCbi+jyp2Bf7RE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-BKRltJU9MqqLldLTcuwOEQ-1; Mon,
 08 Dec 2025 10:54:16 -0500
X-MC-Unique: BKRltJU9MqqLldLTcuwOEQ-1
X-Mimecast-MFC-AGG-ID: BKRltJU9MqqLldLTcuwOEQ_1765209255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A4319560A5;
	Mon,  8 Dec 2025 15:54:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 633491800451;
	Mon,  8 Dec 2025 15:54:14 +0000 (UTC)
Date: Mon, 8 Dec 2025 10:54:12 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, oren@nvidia.com,
	aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH 1/1] virtio: add driver_override support
Message-ID: <20251208155412.GB1346548@fedora>
References: <20251208143925.32246-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2IwqIqsCwx9tJmDY"
Content-Disposition: inline
In-Reply-To: <20251208143925.32246-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--2IwqIqsCwx9tJmDY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 04:39:25PM +0200, Max Gurtovoy wrote:
> Add support for the 'driver_override' attribute to Virtio devices. This
> allows users to control which Virtio bus driver binds to a given Virtio
> device.
>=20
> If 'driver_override' is not set, the existing behavior is preserved and
> devices will continue to auto-bind to the first matching Virtio bus
> driver.
>=20
> Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h  |  4 ++++
>  2 files changed, 38 insertions(+)

What is the use case? Is there something missing in existing drivers
that cannot be added to them by extending the code?

Stefan

--2IwqIqsCwx9tJmDY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmk29KQACgkQnKSrs4Gr
c8iDoQf/e9e8heNPGsQkG+yYiVATiQ0QZvNbSoJCcznQe3lCT8x+cXGZf1t8Nj05
WGWTEwLd3tCe77FaqRBUoj5hSPt1TC3+p29ytDenLV8QU5m9/1jgGo9i80U8o+oV
dAmo36NB3ZocipjH43bTBDLMiMieBOY6eRdnsj1sVRXvKFC1vXO2z6HTQfwTVcGX
NO1N/zyEophSqjeYwpwGZAzPm3C6yhbglkdsTTCbZsK/kRtz3DIT+gyIUJrt61n5
IddCUsNC3QYeuLjCF/6s8fP5C/MvG5KIQRPANARqM3GYSDMCYVpzgDGxZiZIkOj7
zkv1kmTEuJb1wcnOHbOuBeo9V0XmKw==
=UrfE
-----END PGP SIGNATURE-----

--2IwqIqsCwx9tJmDY--

