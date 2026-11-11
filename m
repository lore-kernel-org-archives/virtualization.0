Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378069;
	b=cDa79BEFtdhiXOwDiBdxAuAV6QFIInDhQwxNUP9SLiSqQu6hBZQ77rzwPzk2Ebv2AW0R
	 PHtGeVOpoS6zAO+XPtoDC2yIXVhF0bX2gqNVc0MjubR1t3BbELvSVS1ud7xlrPiOMLicH
	 PUkFCRZZurO81aP7g5YDcLsJT1uaTVnynpjGm8qN23CcQesGVw+GpiOKwnGNWWWV5wEPo
	 SfqRnpHBXpCmOdc5wbsoV2gVlhQ9Wdbw2zD9Yd+uj9TkdyTca9NoOv8VS+wLd07ty4C9O
	 RuduFPDd/JiWdEcAagTumnh/q2Ay19wy7BIO4AbJEc1GufCLhPeqL8nE14QdePY6TZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378069;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gk10iAipootKDuphXlBaSfulHOQgb/5kn4KkIR7xN6E=;
	b=oPUj1MAmGy0WR1fkL/LfDbaNDi+SLT1OnmWt5u4R8lxTfZN0Fu3LuVGpkxC1dlLBVkiZ
	 wWazoiPczvY0bo0TIjZW0IZ/RMs/4+ZpCxzGnJDPXSCohCkzsoyfk3i1P3c9IjTLYTEfc
	 snEuI20vpzXssag2lT2N82/4AbN3sGo2AQutx+ypJe6kBnLsqF+2ak0kRNVgnWV5/siqB
	 VhvSSFFgfcd+P+ZxVKVvwAvywFVRtjqvm+6/SN+nJr5ik+58sXMLLkJJ3mCHO1QcmQOp/
	 jCCnFUKw5gf6JbXwG41wC0CSAdTBkYeoZ4bNOorrEXI5cPstmFDq48FAaoEutLBlMRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CptqLT3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21211606A324
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CptqLT3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7454F1F00A05;
	Wed, 11 Nov 2026 06:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378068;
	bh=Gk10iAipootKDuphXlBaSfulHOQgb/5kn4KkIR7xN6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CptqLT3sPstMC2yilDZtq+/+QB87i7nlzAZUgAXLcU705BVf1QbpCDn8UCRciQL4z
	 4eGcR1Pmkcc7RIZ5mRTrsGFCIJczjQas/E5lQ+yzOJ3hM1yuQxJ8ewuoRJQfA5/xHK
	 8lZycdP5TXksPryO/1Volkyv4Wf7qCq2DaamxowQdKwGzLof1xHowtnLCqQnM55jYM
	 YRc+3dKFfodIzm7uVf8Q37CC0DfF5knSpFG4a9gn1bqCEEuQz1C5osMGdjAADgxqVb
	 kxJMSmBTXe+eZfIbPyILUJ4HjSwcFznESVIwmTfi8aQE0oOCb2eQk9EneIWgHCIUmv
	 S6vP+LgAEFuRg==
Message-ID: <sashiko-outbox-208430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 13/16] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-14-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:21:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D13

