Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863248;
	b=5OIWFn6iz0vbbbrqFTeFpg2/OJxitbbDyUzH8ZSLpJRrbR1R+bBOuqZl3HWewY76Ln93
	 pIvrAymKrHJ9orzIjeQfXLKxLnz6RItzWkkt322ShHXm5D52SZEb1IMiJCEGvpg4ZJlnZ
	 i6Qi7XTdZKBujQvAMQdCeMDrK3SAomtbtzPPEaKQ/YYA7ePn/VZ62k97eXU+UxMIucwa7
	 nApAu2xx8vmWt9D0bfi6z3WqXxS0JQVuqjraWRj7RL/esMEuTQFJoxWfFkZAPFQlg+vue
	 +Dw8WAR8gXtmG7oj77N+QPVXV2JCI6NZB8Kk8B0vfdKpFVAHzMnsiclfwub3tdUblXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L2KdNduqtkq8AJ1Ow4B4EB27nKRgm9SAcPlDR2n6jks=;
	b=jxZFKAuvJaDPAJ55KKt67KAhl+xlPxyCcLcJp1dlsVREdwAnR85mczT6tBB/eAHCf7jV
	 qYcqtx6qTA6Sea8NO0gDoKcrPTZtOs5bViScBuo0JtWjuh+LD6sfTTZ7d7qvmLlzu6Xly
	 fmsh9RrR0/YJLfrBnx6xPDs+su96OCaqmvibT1cM7L2DWtFZ1Z/PFVP5UWNPa/2CLlTjU
	 8OlIUgBJFTMv+ktW4pKZdm4Par1d/3TZZmrQOxChl46zJ1ziiDtOfk5tfHri3IZoZJcUN
	 N+Nty1WeThx/Fkaaikc0DxEgZIOYjbUt/EEk9e3eVeIjuSrsl4EsS4ekhmuYk87aplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YmFU40/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF1606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmFU40/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D641F000C1;
	Thu,  5 Nov 2026 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863247;
	bh=L2KdNduqtkq8AJ1Ow4B4EB27nKRgm9SAcPlDR2n6jks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YmFU40/PaEl6HAqpEyMnvAwKpF20Bvs90kqbnOcHS8jz9YSsN9ylcU0bs/6Wv5oT7
	 lKgmCz+Cu+cO0I+tf64at+kz4JVIEyB6/W2snyv72y25Pc6NNskFIWBb8P9UijgSgq
	 nn5JyYkoPV6vcbn2RxkDsaocJQnRYsjtk5QRhuHxN3bmFgXLY41Um601Nx1CeryWjf
	 35rVuo1EwfjiU1oWUwcJqbgBcekYr4hA+VcBXT3MrgrB0eCdojp4zF/UtuP2YNAvGo
	 tTczaUPOv3r29j358g5D1KiW3QpjMjdvF0tXp0REqCnPMuloFK63DTlcblvN3CzfPp
	 8kxUWJyG4TxWg==
Message-ID: <sashiko-outbox-198659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-13-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:20:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D12

