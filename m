Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28E572673
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097927; cv=none; b=beKWWJlCAdzyp9wHTzQBcwYWeoUU1oPM5/OOet9eAOBhwmyI7zR9wWIHxFUdSY7ZcEMrNMKaTJ3+tzcKEyO/Hl+e+MypyIObFUPLIOzHlIBELHraJCDTB0++eRaytJv9iTyLGqiJCygcoh8NURiEidPMdxjyz6uLTn2lXw4Jx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097927; c=relaxed/simple;
	bh=kI/AmNx7HPF9jziuH4ljvoAt4TFIMNRKMQ48ylm9CSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OzvdKxX3oTcuhPNVXRQoyk4ZbJyoPWibWsiz1IxtuBA8Q/ihgb5z8xlq9io/ltqLP7jXrt8KZG0WxugqjYTvtdM9FXdImrVNEiAkeZksZ3ZCr357NUX9VrDi5hz6LovouMFHUYp1dL9u3zpcz2O5v2GzoD0f1asTLS2yDQoAP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIO6cCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIO6cCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C8B1F000FF;
	Tue, 22 Sep 2026 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097925;
	bh=kI/AmNx7HPF9jziuH4ljvoAt4TFIMNRKMQ48ylm9CSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwIO6cCKaF/yWIc1CEbqzm+y7jLdS/BINV5k4lHcux6rWTnE3ApzJs2TZtJOdZX5X
	 YStXHBJQcoiirbPV2uMbnXTlrw88zGy1fC8ZjA76U7/e7e2caAWDEhKjVWW05bU6sw
	 FHAENX4FIlPf8qY7khw/7crBAemJmjl8vLXYwzzSume1qtGe+CPbkKy70r9VRe11ca
	 Ll5Rp7PbHpKLRbEU+CjvyQnCDkuVIwgIQShaUe43NyZt76WohMSghw3CGMWMKhRCVi
	 JHZ0eYAqMtej58R1zu63N0BqvF8Rtmc5lBp/8KGxUl862GhlcAMNJd0dDC0MxxMmm2
	 3uOXh6RhF5F/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio: update multi-line comments to the preferred
 style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Karanam" <sid9.karanam@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260922171636.201408-1-sid9.karanam@gmail.com>
References: <20260922171636.201408-1-sid9.karanam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:25:24 +0000
Message-Id: <20260922172525.46C8B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Some multi-line comments were not in the kernel coding style.
>=20
> Signed-off-by: Siddharth Karanam <sid9.karanam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922171636.2014=
08-1-sid9.karanam@gmail.com?part=3D1

