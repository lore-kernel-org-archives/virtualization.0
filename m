Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837970;
	b=gx9ilHGqwxaaT7kxL6OKRhOq4mMNn+7QktFo5ETJQNEDTfjaBNUDrMZO3/R8fd/14AeN
	 XmpoV7Mh9wJNfSL30MmNc3Dlmbn+6+Ku8nsIAoD9YSnXle3qVHGV/VLXOF1Nfg1j4c32y
	 sOnzIt+yxuIrKODlHe4aWkoQGD1PeZ1i0hvb7Nx2S/y3SHWYvyOWWst9YCnKXX7v9aLLG
	 UXicEb7MqTYJg8ca8TL/YpAcHeLrMlyluQzsEPLd4MsEwX70DNkwaBc1kBMBaczkBKhea
	 Fq1brQThJtsyp8vftgAYQXQznv/NHpG+1pggsMogydm5jBCy2Fy/zWuzJTTEEvd9WmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837970;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Spam-Status:X-Spam-Checker-Version;
	bh=HN6TW/NKI9aCPvbwatGDME3QAnxBQ1uDv6eHyfYd4YM=;
	b=EPPVzqC4s6oEVGjAoc1GDYT876Hm+aoip2ItJQQqPGGCThEBLYofxVVoQI7s4BfvyY3J
	 y2Dx+gAApTLO+CfPridndO4of4cDn32MaBlh3gBvsL2dRASbgezz2xEaoswJFURNgNTif
	 t+VvgSDdLqojvYF/UwaGKnbG+GvSUqIxxTR/9ZYlpBxEJOzQinyaP2EmP1IDpagxp77tj
	 qDOboyNeGVGimGnOG3scjlgW/RPswJ+l3OqLd7o01nKv9IjkFG6WiMeEMBWvUJeZnGZ0c
	 fHHdOYwdYRfGJieGvKhGHOLJSzsd/9eg/x35WL87XLw+pHofSTRRl0B+G1OcmEtYzTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linuxhacker.ru;
	spf=none smtp.mailfrom=linuxhacker.ru;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A9606A32C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4A9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxhacker.ru
Received: from [10.137.0.31] (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 35268BEE42;
	Thu,  5 Nov 2026 00:19:25 +0000 (UTC)
Message-ID: <b449646e2bc75923e846ee72bee7d72774c48275.camel@linuxhacker.ru>
Subject: Re: [PATCH net 0/3] vsock/virtio: bound what a peer can make the
 host queue
From: Oleg Drokin <green@linuxhacker.ru>
To: netdev-bot+sinfo@kernel.org
Cc: sgarzare@redhat.com, stefanha@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	bobbyeshleman@meta.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, 	virtualization@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 04 Nov 2026 19:19:23 -0500
In-Reply-To: <179383703519.488859.4429490517306926733@kernel.org>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
	 <179383703519.488859.4429490517306926733@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hello!

   This was discovered while working on porting a project from
   xen to kvm hypervisor. One of the llm security reviews
   demonstrated it as valid, so it's not purely a static analysis,
   It was also discovered that a partial patch exists that already
   was included yesterday, by Daehyeon Ko independently posted the same
core fix - Commit: d5e912448cd9 "vhost/vsock: size receive SKBs from
declared payload".

>=20
On Thu, 2026-11-05 at 00:03 +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
> =C2=A0- How the issue was discovered, e.g. hit in production, hit during
> =C2=A0=C2=A0 development, syzbot report, manual code inspection, LLM or s=
tatic
> =C2=A0=C2=A0 analysis tool scan.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
