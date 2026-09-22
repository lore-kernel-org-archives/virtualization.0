Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8546F48C;
	Tue, 22 Sep 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084623; cv=none; b=DuiF4B3UZe169aejeibIv8+hyx8dIO2555QRO8BPxyj/JEqWBkaikHAoM4n70oSkjZVyz5NytrbEQl6gCx3PSaOn/gARhN8J7OhTags2bMz1rFlxkwIJUYJIIZYqfNpm/zZTBI2UIItlNRYCeIVVDx/R759jlY3KG7cdjSLpvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084623; c=relaxed/simple;
	bh=D9OsdyA7aZAkKKttfQT3qEkpX4+/hE0BAiVciR+edJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U127tnWBo17ZENZGqEdAdP2GB0kfkSFeaFp76M5T8eZzqe8cP7N5kGi94afcfjp+EKHVK3plfd4BYVFwAHArnYmmFvPAAY4tpCHUvuxO3xZlhNoO6T95b/e7yTSGNNqOQBEtG62Nmx7gncmd71oxi9Xhd2zP4KTHATdSNtMW/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnsHmp7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnsHmp7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4B51F00898;
	Tue, 22 Sep 2026 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084621;
	bh=D9OsdyA7aZAkKKttfQT3qEkpX4+/hE0BAiVciR+edJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnsHmp7IlpCivuwNPmt74P3GFSs75oKZkLb8kQZvPrx3HRJ4CGCS5bNn6f5bvJrHa
	 GN3KCk8MFHGmSH1BuYk5uAVO+90FK2pJPVcClaJ3HcEQr3QbWcvzq7KxqWvEwTW+YL
	 Uh5toJhrtpKkhmrjAXyDmWuCNJoDRQn74ADoNYh+P4jiJkroBAfAEIVe5ACRI/gLy0
	 2/vffRDdq+Z3YXwjXmHz/uwHDtNHJXJ6jS0hF+aNwGxrQ/dWOLORUTS9zBkqmvBvAu
	 ujbTeA9CG8Z3+67b8g2e/nbKqW21GDMspBVzvoxLfUjR91rXMHsnRAoG2n4+WFK4tU
	 MpURaLXTa+keg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/8] vsock: simplify error check condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:41 +0000
Message-Id: <20260922134341.5F4B51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> On success, vsock_assign_transport() ensures transport !=3D NULL.
> Drop the redundant check.
>=20
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D2

