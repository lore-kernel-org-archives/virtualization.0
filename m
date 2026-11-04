Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785882;
	b=xoannoSBYQr9IjfHb8CzgETO2q3NFL4T+26aJXdKr62coVig8chBCt3wtX5/cZ2eydkO
	 9Wn4BUy01WbIx4XGi6a2ZMTKTbJoh9SGGR4KwvkNSSdwcMWpafYyTpMzA1BzTcJ0XxLIU
	 xKXtajn01UV3uiLg6dYIkN//8l8gQG1/V170SAdHTr2y66p8TqXS+sYy3MQepsnKB5amr
	 gFIAEHfFysvNQPjkHsb54GLZgsNavY8q2B3Hr+sLO+hhfpq0iifvpetotm4PTtYkAbfLt
	 VTaRaMDDC575JsztLfzc6XXdrDnyBEokG1iF0qoDZ52LkcT6b2Qor10Xuw98qi9NTAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1KM5Z6kQBBvykBfpyAHbLl3TIRNHLRhAxTwqsskDqtw=;
	b=atDHdL+wsm6BoPTh1kqSpt26Oi/qcdcBLkq22Sp8T7GsnwyMiaK8ZAwObQMjYYbkrWwT
	 40y5Np3+WfpxrW2dK91RkNHjLXWj9/UD4Qh7jEawlXZgRIHS7JFpUh+fLznq62zh6Mb57
	 p4aEwSNfZyoISZSOn9VDDAIIW3crEsL9F+3rV39vxE3GgORyIdKSLQhdZ++84jNqI7s4l
	 2FZWZoSxf3h7GaBaiW+yWlBYLChsyg6TZQ5G5Z9pknrbEeeCkc0lLlYLJyHaqq0i7M7YF
	 dxwvXshmqw6/4UI97ICtI12Cje0wLQHiXNDxpcLaZGyL+yzDYkTadZZN0rqySg66Yrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a8bHn/8Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62333606A32F
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8bHn/8Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77921F00A18;
	Wed,  4 Nov 2026 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785882;
	bh=1KM5Z6kQBBvykBfpyAHbLl3TIRNHLRhAxTwqsskDqtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8bHn/8Z+X54hz3rPSyyJxwke3u7KzF7KfDjP9hAfiTG3YLl0tOEHpHIxzXwbaN5n
	 VYFM8FTwBdac+xxARt0HZnGTEBMeQr8G4EAcg0/U8V8/q/aVUqRI25dwAt6NBWa5ly
	 pqZh+F3GQbg03w6uB+nuYixupgreHFRJDSelC945xE3oC3aj6/PuzH+rvL0iwCfiZY
	 ld9Snjex+gmhmYuXCH4uVBE2MrvIXLMYncH6R+ComQifeuuumWar8ufm5PJiWGKYIL
	 3vmB3XEwHArwA5Z+SyvkuI5qzbVKmEE3ezFz3TqKj0bpclmkDgc+lD4sfPAWDsnYx1
	 hpMtWCIhUB4yA==
Message-ID: <sashiko-outbox-197001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/6] virtio-mem: prepare memory notifier for a
 self-hosted memmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-2-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-2-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> With MHP_MEMMAP_ON_MEMORY, the core excludes the memmap at the start of
> each memory block from the range passed to memory notifiers. The
> virtio-mem notifier does not expect that:
>=20
> * In Sub Block Mode, it rejects any range that is not exactly one
>   aligned memory block with a WARN and NOTIFY_BAD.
>=20
> * It adjusts offline_size by the notified size, while adding and
>   removing memory use the full size. Every onlined memory block would
>   leave its memmap size behind in offline_size, until the offline
>   threshold stops further hotplug.
>=20
> Track the memmap pages per memory block in vm->memmap_pages, expect the
> notified range to start after the memmap in Sub Block Mode, and include
> the memmap when adjusting offline_size.
>=20
> vm->memmap_pages is always 0 for now, so there is no functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D2

