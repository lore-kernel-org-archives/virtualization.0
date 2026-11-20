Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171123;
	b=DH//gTVz5pmydlyqlDDSCnbDKw9s0zMiwaSOQRKXW6E75DozSRcCvjWy4ZjnYApCKmXe
	 WikOynFRsxwzbRBPIESPqDXzmz64/lA9U+xQCa5RjPjQRDByzc+nNBNDdVg7/HrvDpFz5
	 vOK+EgSwev2wNsgmdFawfmezWrq/Ehkrn50nQw82vaMWVkhkYxdQurWTzN1MqLrZQcfBm
	 Nq+UPrarDLTvNUJJ+Gl2KSA6igk1bum0guHomxk3djzCyD8FfPql5JEu7qhsg9cPikGw2
	 HGT0BZpg/10syOYaI1RBApEaS9IjN9C/1Rj88fEm69xyqBdQXQxejtMkEoIhQnc082w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ctf2+5ZhZMZAW1IFKBtE37OOzewOJeRPv9F656tA3DY=;
	b=SQJGcJVnlhgZMgPr4JiNdgOpP8ozLR76K7S/dFv6TSRB/F0+YVyXXuc1KaaR4iXr8i2k
	 5yOAjIxls9ZLHtE7tUAWuCeV/kr6UBbqVO/DhNu+zndiLaJBZpJrphKVs2vB0IBd+G8nk
	 bdNO94K0ImjE/3i9/MdKYlmuYhmOeyW40YuZX0pkHkucgSRGFKeGJ/VGWKll8onECtnve
	 ZPC6d81ZH8+JylVZn85/Ii+SLYY1yx0cYtismI6Q6EoyQ+JoB0jKanEwGRgoLRmXePW8D
	 xUeDOKnvnMkcsA5WO8epgo7cVwRo0d3aLCSi61RtLNunIyQlDSJL+D7hPs4zeRIRLpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEJd0faM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC041606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEJd0faM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BFC1F000C4;
	Fri, 20 Nov 2026 10:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171123;
	bh=ctf2+5ZhZMZAW1IFKBtE37OOzewOJeRPv9F656tA3DY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEJd0faMbL3uHE1wUF0GtAMKyQ4wl2NmzE3CCXJ9v9Auv/JCy6smSkPsgKxu+GjFG
	 TXYE8Xhmm2DKQa30x0gWV02ksCj56y3FS4HbfNV+QVstDLjSCOesymJJ0JK8ufnvLp
	 kHKTLrY8HZRtszgz7p22FTZDNNnf0SEM+qoMpn/e3PT3iO7iw1uZdJUnAmu1EBClva
	 qa8eth7MmJ34g8lv0cgpJ1AhDCS/h8rcteN/auD6CBfP3+NcNfV8Ff2Y0RTUS7++F+
	 eDZLF2SO3+/PHByW3C+upb5ihmdYJ5kTahmRR9fyGLxXD6N0SsQuPLkujjyjhaaMtq
	 jLuho3kBwWYGA==
Message-ID: <sashiko-outbox-224950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in
 NR_BALLOON_PAGES
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
 <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:38:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
> using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
> for base pages.
>=20
> So far we didn't account 2 MiB pages under the "Balloon" counters, so
> /proc/meminfo etc. would not reflect them.
>=20
> Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
> these pages manually.
>=20
> This has low urgency.
>=20
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES sta=
te")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-b4-balloon=
_nr_pages-v1-0-d8944b587819@kernel.org?part=3D2

