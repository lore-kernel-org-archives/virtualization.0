Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843678;
	b=QYMb6aQDWAqu5ZlC1IyOuY24x5/v2CQkgyouqpOwa1T8UQwJlatyRxBUelRSmibi8C/Y
	 4amAQA3Q9vvSRtfVZ2pZWTGwqSCDLH/gsbKIiZUuL1BJMlikk1AoWe6V2AQDm6xOgOc88
	 f7SPpE36hQmU3hv9JMDAwrwDPUc1PkP+IEm8q8aZ0r/rJkpASHWbjEV93bsURu1Mp/F4s
	 hOQfvM9QSS7F4Ec3twpqoEFdcEACTuXUxNtjtqHNLnmXkG6CvtpdqNUI8jwVC5M16y07S
	 x5IXAIpzY+F165VWKTLKrJRDM6xoXOBF5JLLCBDewUXcJaFxElHnFg/xlvyr1EhsBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/FnXuf0Gh2cmYxj6gIxvZT6iGCsBsgm6n1k4bbX/G+k=;
	b=l86rBnWr/7kcqWd15wyuZH35yQs4cbTAO6QqeoPcTjXe0Vy7uEvCYYHPRSTwfJK9BnSf
	 TbWG90oy3gqbfHoMhabLiZvuRYZeW/LSaQapuUum0f+qdM2cvF6Tox5fkiLyfQB8YFjVI
	 cyDNy0AQ5TDmIu3X8E+LzE24cjUt+P0nH/kc7v524VSNOV2F/61XvspeKVCF1Nx9xn2cH
	 Wu63+7B72YbC+JJiTA0/jbCUVS/SG8kYs3SD7MPztv1nhN4RCG7LRCAsq4z8k+F52akyP
	 80xhA0hRWnmQLSEXNL+CJWujHIqZQcmN25WgkTSTI+rXBN9aePg0U0sVcMr7bGuC4ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cOW/5hQj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20383606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOW/5hQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB7F1F000C1;
	Thu,  5 Nov 2026 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843677;
	bh=/FnXuf0Gh2cmYxj6gIxvZT6iGCsBsgm6n1k4bbX/G+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOW/5hQju3hLaXNKW5f8gIUFHjQjoXcY4bUHmsQRWC+3nAlfIunaZ6+IuIdIokl/c
	 Gh5TywdT5Qp537e9YOWmotrry4C2gSlPOLMPowrolQJSSldBlj/xZTR6kcr74rbFNX
	 YmZKNGhBdK7D+N7+iEYX5Mnw7OSetbcDR9Mde0DwmlXwqNRvmNY6kD+N/62SAQUgA4
	 4Kdm0ZrH1pVA70cEZ8UhAZCCFd4JawhXu61abnKGfTpEeuOtUIPisX+B8K471zX/Oy
	 PTHUfLgUT0Te/t9HRHs0VTNG5QL+/M5vPY/hHZ2ia6ch4QGu5FeI7bKuUN2DbD2e//
	 //wTc/zu6n1pQ==
Message-ID: <sashiko-outbox-198417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-1-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-1-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:36 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D1

