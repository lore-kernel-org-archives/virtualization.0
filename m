Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171122;
	b=NAQLuzGXNmfYfJfn91xBFr3Q+PK3oG1GJE0FFnJQMbcAAy/AsQyiH45ibiaU+PQrCfdU
	 1kGu2C3im9bNwmCbX2I8ehmfsuh/clkKCruPW+fxj3NVT5TC20VJY1BhYpfMuBw3KHGMb
	 TdWjuqVEHYbxZ5bs886p9GpUBghEI45O7YQvygsJajzTau9ppThRmMStRWGkZ5mpFJ5EA
	 1HtfCFo16OymcgFeHZ4UIVabq0V1y7v/PmeahKVE/MbLZr+XBHfHQDIu/YgcLmHWfpg1x
	 lgNO4oaM9d+FYdzaQ8HCUd2Ri6emyLKjHTm6mIpEY9zph9KVFsXGFLSgNlj9/UHWvdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uvBo8whQM69hOZsneEjVjjkZl1J0uxOhdaznYOQ5Gog=;
	b=5lZ6h/urchy1IxxTehl1OcAzjFccnbmzhhPYiujV2x/lyzt8yVb27JemEtPad/TYzjM7
	 bdxNlHTK2W7V/hw2LbkmPJ4dZtYVSGFt+VE//Nqsv7otK9nGDK522oDonnj8yKxFu2yJr
	 oR+DW4Ja5/R4n9fw4XfNjWhuQGpsiQsEA0XHh+1OJgXhw+8BGIWPtewx/Fh9vA5FN5Bvx
	 Q167qWbwj/7G/aiXDSiK7z1u5wVUVY8g0ZJzWCy0E4FYzpA7+L2XLKAlDTUq6GBfzPMUI
	 4CC2ptFc1YNMeT+9yZGxI3Gd05bZNH8aq7+DvH3AZ084+Uo31BhWDtqzo023kbE+XCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKNaKXEf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E99606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKNaKXEf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110C71F000C6;
	Fri, 20 Nov 2026 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171122;
	bh=uvBo8whQM69hOZsneEjVjjkZl1J0uxOhdaznYOQ5Gog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKNaKXEfnsnxjM426bpMgtnC9z7laMsSVUJFVOVkShlXyalwHG0WKDXKB/bph4git
	 nO0J8uqt6BERqbNlUiXdMnyqz1aghuo+Z528RZAkDZNXs1dxJABLnz4RZwPklFqI2P
	 UTm9yvsdYK31tMi4dTjgHZy8dxM983igc+FZ7Fuv+40WZ28lhKNgJ9BDuQS+cyIDSG
	 /akCnVHjsyNVKJVktEN2hKjfa0L1hOidaQxdTqzn4GYcii1YdLeP6CoCb+HEXe3e1m
	 hhH/wFi8bpIG9l+qNLvMpcJk4L57/Fr0xrJpM6IA+n9/tE1nUCThrTojhQ0lX0SoMo
	 JppPbTj1tjoYQ==
Message-ID: <sashiko-outbox-224949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/balloon: fix NR_BALLOON_PAGES accounting during
 page migration
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-1-d8944b587819@kernel.org>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
 <20261120-b4-balloon_nr_pages-v1-1-d8944b587819@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:38:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> balloon_page_migrate() doesn't update NR_BALLOON_PAGES in two scenarios:
>=20
>  (1) If the new page is on a different node than the old page.
>=20
>  (2) If the old page was deflated but the new page could not be
>      inflated, effectively deflating the balloon.
>=20
> Consequently the "Balloon" values in /proc/meminfo, the per-node meminfo
> etc. will be wrong.
>=20
> Fix it by adjusting the "Balloon" counters accordingly just after
> conditionally adjusting the manage page counts.
>=20
> This has low urgency.
>=20
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES sta=
te")
> Cc: stable@vger.kernel.org
> Reported-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Closes: https://lore.kernel.org/r/20261115004708909xx05JgB9nXnOCG0zL7h_K@=
zte.com.cn
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-b4-balloon=
_nr_pages-v1-0-d8944b587819@kernel.org?part=3D1

