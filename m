Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC14078F9;
	Tue, 15 Sep 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442770; cv=none; b=hB4chTrWDBow6IbgD/XJht7cV2cNCjqflDZUvNlt0HT6l4mSi2ePZAxVuFvHtOOSb4qqyiXZomP+XgXRHxEKEMOa/eU/7pS4TgZMPR4Z8HtWB8FvS/E0lJysh1MgDyDS2a3P/enqlh7W7cnlWYDuyh8mnJIMBIAY6MkLyWZ8Ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442770; c=relaxed/simple;
	bh=GcspyUu6yxD43Q4qIfDDpvn6AgdLU0M9g5Ba2Pt/Ud4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dsn+ngEVRoHPCYqk3tvXUQwoR+PnPs1863EN26wZ4wKy6XnGLGSwpQWiDoz0zP8i5LtG9KS6aL9PrXQEyOLrPBYmrfx9300c+3wFt384ESq7AAz76pO2vEbWh01BblTH3kaGzSOwMC81t56KdwwMRq/ge9kT2wYjlQfW7luz7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSaEU3i4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSaEU3i4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE51F0089F;
	Tue, 15 Sep 2026 03:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789442767;
	bh=GcspyUu6yxD43Q4qIfDDpvn6AgdLU0M9g5Ba2Pt/Ud4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSaEU3i44KTuTmuzbU3EJpUbCUd6UDN1wa37EKJTtQqMkKencRaWHY8YBLFEvMfcO
	 VXBrh8e1YvqqcrjC48wwz160MXja54QGrwnRp3GeikpEA25dFLXAchRzjTX8EMTDto
	 dG/1K9cTPuPkNPl7nQGZ9/bfPsELIHb2Vpprv2wg0ui9tG7eKdl2OwbLi/ygh1KlbI
	 MJlE0FMqYvHw6EOBBHX2j1Se7A8Jhc7ZLNqGPDgxo+Mz8B+9MUgGpGnDlY1o4fh40P
	 2bO1zQ18qxQwteyoeyyNEabnHcQeOiTW5GKl39MD2A38X8I12ceIM/+xb7a73YKcwg
	 UCUMUUpnpfWhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/17] rcu: assert static storage for RCU sync and SRCU
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260915031334.1194975-11-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-11-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:26:06 +0000
Message-Id: <20260915032606.DEDE51F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> DEFINE_RCU_SYNC() contains a statically initialized wait queue. SRCU
> static definitions similarly rely on persistent lockdep keys and, in
> Tiny SRCU, a statically initialized work item.
>=20
> Add ASSERT_STATIC_STORAGE() to DEFINE_RCU_SYNC(), both Tree SRCU
> __DEFINE_SRCU() variants and Tiny SRCU's common DEFINE_SRCU() declaration.
> This covers the non-static FAST and FAST_UPDOWN wrappers too. Tiny SRCU's
> explicitly static declarations already enforce the required duration.
> The existing per-CPU restrictions on Tree SRCU declarations still apply.
>=20
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915030336.1192=
299-1-ynorov@nvidia.com?part=3D16

