Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B443E4101
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282580; cv=none; b=BAJXudcCIczbRg0MIpihcsjRfh1CCwaM4MINTyucVD6Pb7Vy4bI3Lp3HWqyGDqPZhqHwUhaoo8jlzNioOLCLuWvpGuzf+Ix8grd8mTX1xKj8xfzDJTTHBrB9Yq+ETlh7WZBeHz/h8j38ugDYBrYFxRQ9pCNTeGVqFaEmFTdp/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282580; c=relaxed/simple;
	bh=I6H3bVLfNN9VztBByldnk+pjv8ZpDEQZpW5p4qCK83M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WY0qNfBeXJDieBN0bJuCE108+oFYfbw1WDhAb9ZEBZQJuSvxRioQgkmkbuo5YeGNihf5CLUmGP4VOcY/tNpp6ghet9PG4n0i8vuab0H2fAgy6ku5dbEt+353fqHq1OQMpdBRzp3lylDh2mQMfJhkQ+UFF9uAf3jIdVKubjikvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbpXe9WZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbpXe9WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4364B1F00893;
	Tue,  6 Oct 2026 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791282578;
	bh=I6H3bVLfNN9VztBByldnk+pjv8ZpDEQZpW5p4qCK83M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbpXe9WZQ3IvW9nqerFqb4lGAufr8Q03vnI1qJywnujEKka+me7eRLdUzeDBcpxdr
	 v8LlXApSLSviU1yhe7XskKsNCTVBIbnEC6KEyK9mwuZNun87qIi+rffgk8XYHZwH9/
	 9Vk2dm9ShHV8JZUkHgK8hTBx5bDEu9f24dj4ezO3LrIFs21N2YLnoYHrS3TZIejTNt
	 HSUukCPiorwr5Es3WdsBzArUTQPHgN3wdBV/wI7/F2jsyTABR1/jcTFgwJbrkHUsJ3
	 1So/KuF5Jhs796qPVBHBl7WFfGF4L1NHv08MgiHgiMNa54lY1rSriWqJEvIN5lyTai
	 uOt+Pi7akfcgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_ring: use shadow flags when detaching split
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261006102112.847280-1-tjdqudcks0424@naver.com>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 10:29:36 +0000
Message-Id: <20261006102937.4364B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for s=
plit virtqueue")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006102112.8472=
80-1-tjdqudcks0424@naver.com?part=3D1

