Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB347209A;
	Tue, 15 Sep 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465922; cv=none; b=qLAnCRPXXUMzseRyqZ60IyadEfFJQYY7UypmVhGKh3B7rvPG14I6gSiWBZwXlSeEnRjg8Kd391XUnEyb0/ksgnmLWGjLSTcGE6+dZuznQ4E2JNgCAGvyGyKjJJHP1KbCwREX1TcMM3RxIA1vvuxRV6QYV/SJofpMtWSrv/6+tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465922; c=relaxed/simple;
	bh=JSFuyrgs9fT4P2gy5jAv94CWWFzY9mYd6PgLwR2kAFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q4Uvv03Z+1zKhMzLFx7mCrzBFFY0RNZrdrYw7/7toy4KsMYyQIooCxGEwJSEICub/w5K+zdC2P+JEOyU5HY+3lUWkFHlEtCLzvQjVrM51PgduVv4HKgwDwIT17M7U94bjKPoZx8Q8sawaIjD3Udn+N9CfdHAwxgn1qzg6ysqIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luge6HxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luge6HxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6AD1F00893;
	Tue, 15 Sep 2026 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465921;
	bh=JSFuyrgs9fT4P2gy5jAv94CWWFzY9mYd6PgLwR2kAFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luge6HxZEcC40grjqPhobaAfZVHeAY9B0TvSECKqnctY+ccEMyjW2ipSc9swEFCHN
	 apLAmCnaHtk7jemmAnrspf7VLVr8tBjAOssju7Do4zvrKddlfZEygQoeY/507aK8JA
	 I/TcQ25br5qU60sA/wEDZ4ljzJdyTzqXquGWHGDe4zv45WUZ1gpbHany+032DoZyUj
	 GqEw3rqEpnjZP574fCzxQzMnIMTMWzqUDbMWEaXiYlnXzsY/OxpZPdhYQLUbu2suVd
	 QHWlVrB/+a/U1xI1GXKQLEE2slKj+RDByinO4ZFSJS/fboyMUM4f5CCpeINMq5IxpH
	 a5qv73CpYVvgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vhost-scsi: do not relock event vq mutex on
 send_evt fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260915094244.7900-3-physicalmtea@gmail.com>
References: <20260915094244.7900-1-physicalmtea@gmail.com>
 <20260915094244.7900-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:52:00 +0000
Message-Id: <20260915095201.5B6AD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> vhost_scsi_send_evt() is called with the event virtqueue mutex held.
> If the worker is gone, the fallback currently calls
> vhost_scsi_complete_events(), which tries to acquire the same mutex again
> and deadlocks the caller.
>=20
> Split event completion into a helper for callers that already hold the
> mutex and a locking wrapper for the event worker. Use the helper on the
> fallback path.
>=20
> Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel=
.org/
> Fixes: b1b2ce58ed23 ("vhost-scsi: Handle vhost_vq_work_queue failures for=
 events")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915094244.7900=
-1-physicalmtea@gmail.com?part=3D2

