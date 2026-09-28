Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AC3955D2
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574396; cv=none; b=lFB80mvKMge3LVvFQhNimPhirsYI2lgjcrezklPjlQkOZyREHM/JhSoD7Nt2Kvk5ksXrHqJ0eI3/ZfMEEUAnPdJ4PVles8OfRCCppwA37m0sZCVrUYK1cFUm6mSzhm8WyKvPUIO1LbEO8Ki+vVwmJFteS5XLM6p7E7lSzv1u6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574396; c=relaxed/simple;
	bh=tuIgvh5DjfEE7ndcTR3IjPd6PL63RHYRDjk1TmbcMkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVPjOTynuW8fAQWcRwdKAvRGVevvrtVY7sYLbzcYMRfPB/h9e5MqDYnyw78E7dVtjGaIrCTLIBW+9HtUs+zOGZK0j7KFRjeyZgdHYkSmxU3/ak4o5BaWN6cqGyFyg5FI74rTI3ff0cvo022Svi7MYFR6ficHxyn7XNFtTYE7i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J17GjSzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J17GjSzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD381F000FF;
	Mon, 28 Sep 2026 05:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574393;
	bh=tuIgvh5DjfEE7ndcTR3IjPd6PL63RHYRDjk1TmbcMkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J17GjSzV5K+f9CPQsAhtT8EVG0xZ+8JIg68JolLSpPxCaaZWtoNVv4RWBb29lzLb4
	 7GuH5m8U1hdJAOUg1cxoU/3Q5VqKZcEhF/YKbNrBEsbRpRhJDOrOxLvLgyZKE7iWl4
	 BQasa5NxUR5hh2NSE5rFziaDT5zivgXLa0S5IhcVHTM7YRQ/TUNNN+x+MuOCJtb2Js
	 7CByjtZGTjWSzeqJEKnItt/nMu92mji5DjLmA0TYPQ78an2fMMve4ul5Ve4kdPD9B1
	 vUI5/OGObg52MlCDHFro4yVsweAePQ7jPZFMS0/RmoMWob0OpTdEW97+SNBj+aT9Dd
	 ltqJ9keUg6m2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/13] virt/steal_governor: Add control knobs for
 handling steal values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260928053728.797539-12-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-12-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:46:32 +0000
Message-Id: <20260928054633.3CD381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> These are the knobs to control the steal_governor.
>=20
> interval_ms:
> How often steal governor checks for steal time.
> (Default: 1000 i.e 1 second)
> This controls how fast steal governor driver reacts to changes to
> the contention of physical CPUs.
> Can be set between 100 to 100000. i.e. 100ms to 100seconds.
> 100ms is kept as minimum to ensure few meaningful steal values
> accumulate even with HZ=3D100.
>=20
> low_threshold:
> lower threshold value in percentage * 100.
> (Default: 200, i.e 2% steal is considered as low threshold)
> This determines what values should be considered as nil/no steal values.
> [ ... ]
>=20
> Documentation is available at: Documentation/driver-api/steal-governor.rst
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D11

