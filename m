Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CD44AB88
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776289; cv=fail; b=nFz1C6Qnbzlqql0f/eW7dbZ+m+ttgvNGQ850uxpAfzLd1HmTAAFRdBLQYQE8fym3lCXmxbS097lXy6T744GKX6tOf+9Q8NK3sKUlnlVdJBZ1hlcadMawsooxN2QTqcU/mMJSEGLi5Vmw82AQMEJ9LERDcfqsNc+bB+v7JpuRKCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776289; c=relaxed/simple;
	bh=Oqx/l3rviU3aX6pHP28Vdd7aIxHWEvQAMMcf7e8LKzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIPgoM27GxLb06uF7NRQ7zcQVQyx2eTJUsXrbJBXiyBAJNvvBmVDcSLc0P6XdoSw8yoWf9y8ERIoABRXz9y7Y4YP1x/4BBp+1zfgkmT43lj/VktHAgdZDw4XCp4aH85jcV4xrirqQSsvz296MO4IJaY9IUe1aORZSra98I5EDec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=kGgKe5xz; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="kGgKe5xz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5F31400F5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.772
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2lTy0idEkcn for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2026 10:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B3B3400D5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788776285;
	b=bqgxUehrziji6Ywwywkjft9e8C9DCSwGcPgg3UoM9mYZZrI/SVJEzVg42Pv4zeG4mNu5
	 wTodXM377juyJFG/buyvoVDjApUNJi1pc55wBjtPiEca7W5vfAJy/yKvzsRxL9U3+mirt
	 EutEiflwEMw/4hVbOhFsr6WDOruc+NKl6BnEfgIwxgYeiOFxDmfxlZb22nGlS24lrWer0
	 isk7BHat++gk5EQfp7QvXfdIoE5XF+sko/jGJ7WMCmdCed0eWIg6c/6i4WqJrFcyi73UO
	 bDDIyoLEFcdcJb1kQ+UZtLJfJEtJ6rLHK7aUj4hiDV5kgdRmVbSNRLe7X3SBXqKDEGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788776285;
	h=X-Greylist:Received-SPF:DKIM-Signature:Received:Received:
	 X-UD-Smtp-Session:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Oqx/l3rviU3aX6pHP28Vdd7aIxHWEvQAMMcf7e8LKzg=;
	b=j9iXE/1ObmYq1wvLEfIzCMckZlfrCWRgMfLaj95G0tNCUcaHMVFkDQDSHFm+7Be0XTqO
	 mIOnIeoNUkaC5NY8ALQdpTX/Z/TVvOSzmQjp3eNK5g5ZmuKdtfCGjWtOFg00mbtTyxL7V
	 UwPK+VWRUh3yKpaQgX2CdeDzQlQuXQM1GtC5lmvhfxBhbm8suzb+RPIf2H0oLcFi8oeNl
	 o/SyJeVR/lh0G3RRGvVwLnsm3vy0zX3LWf0jJjJmEEFlTFjed4LzKH61dRYbORBXI7Qgv
	 xg188yO8NK927rzd5SPkeI4WpKOcx9FK/nWtgpXaNCch4wFfwAbSoXSr4OYbtKqQU1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=none header.from=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=kGgKe5xz;
	arc=none smtp.remote-ip=194.117.254.33
X-Greylist: delayed 400 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 07 Sep 2026 10:18:02 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=kGgKe5xz
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=<UNKNOWN> 
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B3B3400D5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Oqx/
	l3rviU3aX6pHP28Vdd7aIxHWEvQAMMcf7e8LKzg=; b=kGgKe5xzk5G9f+YBdfS+
	6JCCGrAmHq0orRiWmQTKNqKK75JyxFJSUGWU6Hgh/32ZJaIK5nwwKw2o1x5tfDYk
	iSOHzjRXOzPybG0AG0QYGO8OUlGgoDb364pO2pHYJQ8rLorrs6OcnnZ/262QHODA
	MkboVHl8gHmpKRh+0BoI3eDYaSQNUi/DNsX2n7U4aMA+KvXF9FCw6H6WhJV7RX6R
	3jA+TIuM3diI0k7LSVK22kpUkDyAiMH4mwjwy463TJOozMWa1qUBL3xVSU2iXP9L
	KmF4IwIBfXP0urVCarlBdbmtYZvI1eK1pLz9xK1POeFkJtGYepTceUYGKxGl05+c
	Ng==
Received: (qmail 2343451 invoked from network); 7 Sep 2026 12:11:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Sep 2026 12:11:17 +0200
X-UD-Smtp-Session: l3s3148p1@tnjA1uFaQp8ujnsC
Date: Mon, 7 Sep 2026 12:11:17 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, Chris Mason <clm@fb.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	virtualization@lists.linux-foundation.org, ksummit@lists.linux.dev
Subject: Re: How is sashiko bot deciding whom to Cc?
Message-ID: <ap6Nwf94aq2dk3WD@ninjato>
References: <20260907055646-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ukpn3ScpmSWIkEka"
Content-Disposition: inline
In-Reply-To: <20260907055646-mutt-send-email-mst@kernel.org>

--Ukpn3ScpmSWIkEka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> So it picked some mailing lists but not others, and some specific people.
>=20
> Is that opt-in somehow? I'll be happy to get Cc'd on the auto-review emai=
l.

To get me CCed with Renesas specific topics I sent a PR to modify this
file:

https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.t=
oml


--Ukpn3ScpmSWIkEka
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqejcEACgkQFA3kzBSg
KbaU2Q/+LbU/+mSXPvVLMjs6D+LVE70LG0Whq76bO4zbytOfYavmIG3oJ/PfHYPy
0kA7r8MoKcJG9aPri2eQnCKshhkd9DhUZA4dsLi/ojuF2WPu4LyW6ebf9udjcE23
Qwc8kVe8qIShZzWHz8QXlrTQIpAfJf0Sjm1bL7XCte8f2BFys+LuXV4LLHSSLQpj
JTlGvNz1YPd162sUDNUR4TDBfXZpBLJqbIcp6mAESDAf5Wc5VtJ7o6ypjjQSUeI3
Xe50WgwWj/j/jr4LCOnlnlXO60U6gt2kcNf8IzCubAOCGkKVWjuGKqmAFrA9Z0il
44nnphDpQ9MbGU5uj9PjWdDXruirnGcwQ9hoClVMx8jfrutH8pO6m7XG4pN8br5W
+P1jtKimQhPw7/wVbTPktX5UADMMT1F/CdjsB7sZHD8MFuQAeaHkBuVUb+ufyAjL
5FlhyxwvPxeMP740ZbZjLO9Uo4Q2feySR9RI6BH7LAQ0ul0DsyZw7FM+v7iGMomY
/TRiBrpA1R7E4eK0qHOcJAnVQZWkO8xLNGrQok1D26QnR6Nwov2Wq2430hQNGNP2
YkoJIFRgEGEvFHRnGwNHDTVeR2gP1udQEfdv3i8yko6EFPaMv6GxtfWilGRpzU1c
cp4/xbjEg5qQTU93jIhEHgPi6keQqIyoU5tR5Qd4G6kq3/gKGjI=
=lhkt
-----END PGP SIGNATURE-----

--Ukpn3ScpmSWIkEka--
