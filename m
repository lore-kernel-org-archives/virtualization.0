Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37789530DF0;
	Tue, 22 Sep 2026 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084625; cv=none; b=tkgAw4piTvXUU9iwQLVFJBsMvOLU2HrUHdwx8kzptsnOLBRfi+jnyYRlZd+InS8Og4JheQXoZ3Qt/KSF9IeLj9RvKs+XiaD/Dae5SIxMQRmN8IosQdC2KoHSlAgoJeBq/oYqFkqaWYMi8nTQh8PtjXs3+AeuvrnOdqB1KGxbPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084625; c=relaxed/simple;
	bh=zifqKVqaPTCl3e5OxmDGRSORA6rzQBBnH09k3jHycOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mJOZPG1bxTVkqIXHIgrPhHcRYePcKVqcPIIPkZTOLUKa3wWT0sqcE83YIlxkntDOvIfqi8j6Wlj3L6yZ+NqJtVZovsZVl8th2iFt4EP6oCZxK/SmCSAWXP992h72YwZrHGAhlRE8uNnDWxspJ6fiIMqPJEb1IyjnMtGpKb63ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+vLAMLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+vLAMLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAF81F000FF;
	Tue, 22 Sep 2026 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084623;
	bh=zifqKVqaPTCl3e5OxmDGRSORA6rzQBBnH09k3jHycOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+vLAMLm9oMzkqIgD0KfAVeqbNMgwCG8dtA+qjd1ehm2J+6cjZsQmQd0rycwfVLsa
	 WwDf2b1UPr0ktq/t3/LVApphSQ1nr1JhhwgB9lGxQcRqot4C9vUstDjVA5YP3ilKz1
	 j4xJeXmz4sC1yDdo7/0D1AaRJrycWBRM5Jh/ajIBXJ8IXfnbFDaWuP4qReEmwNKmpu
	 nf4ofOV6LypsEsgFQp23JvEhG7YYmOeJFhqToGSd/eqQjpeXZxC4auFL00d+JNk19I
	 UMN/Ltk15nvws+l3CIKlXBuK6YoGmerCNLV1JARX9QkFT7vqh2Xod3EUYPoqs9KRSA
	 0MBYzB0CIof8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 5/8] vsock: treat TCP_CLOSING as once-established
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:43 +0000
Message-Id: <20260922134343.7FAF81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> When connect() is scheduled out awaiting TCP_SYN_SENT -> TCP_ESTABLISHED,
> socket may already transition TCP_ESTABLISHED -> TCP_CLOSING
> (VIRTIO_VSOCK_OP_RST) or have sk_err set (VIRTIO_VSOCK_OP_RW). Short
> circuit the logic; do not assume a non-zero sk_err signifies a failed
> connect. connect() should return the status of connection attempt itself,
> not what followed.
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D5

