Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691141A8F
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436325; cv=none; b=N5UHljRql8P4qotezWYKUnmp6RZNwqU9XyzIZWMkTBzvRECaSWioa9v0/MWrTwK+Lw0bWQYRNpKdf2TJVN7bJjJclZvDx7mWMUgrCAA0enHaDYWMQsBHlqIyeRzr8CsAtChVhEg38zxBjYjloRndYNEWwIGjDkkH9vJdzqLuN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436325; c=relaxed/simple;
	bh=iJclv+2xy21mZtwsNj1vdH0OSv7xj2YHZZO13lW/xf4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V1jSDuzpFxUIJuU6maZBk9VglR49zXDaBUK9uflg9LHAq0nHkJiyy7ITCLI4+DyGxFFNKoRUEnNvAKKO/S47yw0BnHylpa3cDzh1r8cUg1VzgwQIQeZGuVEmauTFayALs7ngnaZf1G8UsLVhkxJm5HrIu8sVT6qiVAnYA18oDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9GoQ3Ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9GoQ3Ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF31F000FF;
	Thu,  8 Oct 2026 05:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791436324;
	bh=iJclv+2xy21mZtwsNj1vdH0OSv7xj2YHZZO13lW/xf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9GoQ3IaFmxcUMwfvHVomDnECfpEyxiR8ojno26LCzJfyXIRWfTsfcK/Y2EaQYXkm
	 q3lo6PyncYUcQNN08FFwJ6feYQPx94RWhtY58DaI4N/vlWTVF879mfxNdskhYwFePW
	 a8Vig+2t0FWpmz9s7lF6QIaZ04kHJdhFTnevQVFpOIVQnX6uBk1ZLn7BchowABMxRi
	 eKQm9fdMFTphuDHRCl1RIrSyuRn1KOSEmxIVGm+5Hb/ft7UkaU7EE4LJAye76N590l
	 itvSQGbmdp/MGjc7P/UWIz8/HvJR9p3anXxHBHpKTtBC5e9Jd4HW92kPOTAeyktAxT
	 ui3QCF4//R51A==
Message-ID: <sashiko-outbox-163622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio_ring: use shadow flags when detaching split
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "sung byeongchan" <tjdqudcks0424@naver.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261008050423.32221-1-tjdqudcks0424@naver.com>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
 <20261008050423.32221-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 05:12:03 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: sungbyeongchan <tjdqudcks0424@naver.com>
>=20
> Split virtqueues save descriptor flags and next indexes in desc_extra
> before publishing descriptors to the device. The detach path uses the
> shadow next index, but decides whether to continue by rereading the NEXT
> flag from the shared descriptor.
>=20
> Use the shadow flags for the continuation decision as well. This keeps
> all detach metadata in the same driver-owned snapshot and avoids an
> unnecessary shared-ring read.
>=20
> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for s=
plit virtqueue")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008050423.3222=
1-1-tjdqudcks0424@naver.com?part=3D1

