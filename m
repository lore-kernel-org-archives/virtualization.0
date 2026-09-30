Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3736F8E6
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784574; cv=none; b=Vjiv6wMBeqVddILs40tUomzUe/F0Rss96TKovi4fzW7Ow4iEz0x7Re9haiZElHmxsakY28qsHE0czs1dgImOyUofb0RaDgIE0TRWzXy81OECBqrsZBve6BnX5aC3rDKSejzuK7kVwvyYhQAnwQ96P18P27pt3MbLFtEuYB+kGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784574; c=relaxed/simple;
	bh=uPJPeVxV2ALEFeicNRoh5CNi/IVCJwZGm/WfZBmo/ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PhiPmoKgaQENFo26SqENNg3aR/0oB0GO9E8ySAfDkEN0WZeBybhW5CaG2uT/9Wafq0ydjJMslxb+Ao6cLBeYgEKWKh8iF7rAAlmxzvVV+EvOSMt7vbZOpgN6/Z5nJ0nXb/wGiwVSwLVQLBTGPZGcZxvKqfGy9+suY5RX/PEmeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUuw6ol6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUuw6ol6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB71F0089D;
	Wed, 30 Sep 2026 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790784569;
	bh=uPJPeVxV2ALEFeicNRoh5CNi/IVCJwZGm/WfZBmo/ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUuw6ol6AyzyB9mL3hiZtCGArzoZDkFIozwATLESq+tPShqtanH2OP7JBJA4qrsBo
	 B6+cwLrC1uwvBBvevqrn8DuGD0swMRIK7oBMqRL+jKUheiCoqd59bU4P5+188J1kGM
	 /Bju0XkxSs6oxAu+NR8nNGsuLIGBpuEjPSIsaxVgS+jjMIXG3IlYLEJUSovtL5/8qO
	 miZwk4zOH4ji/1yCqkJaEvH76jo9JbtkWvi1+wvVi7A55NNY0GUIfxbZIYQkEyYILf
	 Su0UInY/QDm9Vs1EWXLsvK6L3JFUa81R5a2RpM792nG40E0r+/Ynf+Ud3UdCOJqlnC
	 V5Jd0Vq8HfdFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v1] vdpa/ifcvf: Time out and report device reset
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260930155920.1684465-1-oss.patchbox@gmail.com>
References: <20260930155920.1684465-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:09:28 +0000
Message-Id: <20260930160929.4DFB71F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> ifcvf_reset() writes 0 to device_status and polls it without a bound,
> and ifcvf_vdpa_reset() always returns 0. A device that does not finish
> the reset, or one that was surprise-removed and reads back 0xff, keeps
> the caller in the reset path forever.
>=20
> Bound the poll with readx_poll_timeout() and return -ETIMEDOUT from
> .reset, so that callers such as VHOST_VDPA_SET_STATUS(0) see the failure
> instead of hanging. Stop right away with -ENODEV once the device reads
> back all ones and is no longer present, as there is nothing left to
> wait for.
>=20
> Fixes: 386a26208524 ("vDPA/ifcvf: synchronize irqs in the reset routine")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930155920.1684=
465-1-oss.patchbox@gmail.com?part=3D1

