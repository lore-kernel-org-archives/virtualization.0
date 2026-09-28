Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA33AAF54
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574287; cv=none; b=SO3YuDlTZwoMEaF/idfgp0kyksN/4MC2XPB8NlW5bsyJk4lt8EJ+ctPaSP70SOUi0U/5bBduzajsbrGGMZf5uV+4+WbiiIsDRtfGwyXpikIPWAR0VDqMiGFWfs5ntNRGt1NVJVrldad4jbSpffABNxLK5JzuNhB5K2n/jpgy60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574287; c=relaxed/simple;
	bh=n7TQcskFvA/+VIuLWJkjbz5bV1YhO00hbPKdtt2PdYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRZmZDCb77vGgtlMn0KMKgSVUnqUWdhDLU9hSMDCUcrEY81YMSYXPZCCiNCYD9hl5uKR/IPae5EpZcnYKmYUs5sKKmrCt2EzMrdWzZUA8Gqfn0CUjkuqyLrHQgUua0Al1u5CxReDsZskB+dLm+s7pFJhRc8EdLnuvCuk6X1X6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bod5nmwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bod5nmwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4621F000FF;
	Mon, 28 Sep 2026 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574281;
	bh=n7TQcskFvA/+VIuLWJkjbz5bV1YhO00hbPKdtt2PdYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bod5nmwWKlE7GsjoE3T3qxpuKAaLRNPt6+AVc/tuQW86zLm9m2lGFiyGl0A8gALJA
	 9HozQjZZX4w2h/LrmlK4nEK3R8Bjkn+5kkf4HrrwjTrqUyOTc5wsncVFW9qLYoFGa8
	 ixw9Nijj6dW+A/sOBajjwrXYSH9NyvyExILPPEbbpVA106rKImUr97gvcoOoNyE+7Z
	 V7Ggb4IvZVSlAnIEIT6Q43i3gl4vOitQmd2b6QrSUwKlPqq/DO1u8x9KB46Lcj64IW
	 byO48xilMAnkWG4XNOOMMsZ0TIFpFPY2tDf/esyz1M5qIndGv59DAbAYTtT1xTE+W4
	 0np9azbQMmLFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/13] cpumask: Introduce cpumask_intersects_and
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260928053728.797539-3-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:44:41 +0000
Message-Id: <20260928054441.8E4621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Introduce bitmap_intersects_and() to determine whether the intersection
> of three bitmaps is non-empty. Unlike cpumask_first_and_and(), this
> returns immediately when an intersecting word is found and does not
> calculate the first matching bit.
>=20
> Add cpumask_intersects_and() as the corresponding cpumask wrapper.
>=20
> A subsequent patch uses the helper to determine whether a task
> has a CPU that is present in its affinity mask, the preferred CPU mask,
> and task possible CPU mask.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D2

