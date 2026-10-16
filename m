Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E93B71C6;
	Fri, 16 Oct 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144167; cv=none; b=RBwVDV9n6iuu/GrR75zO36vflKrG3e7evV4u0sI/qZrYmaRy0EpDfPmZmz0lIYDblnZaLcWTaazNBTIfRKKJstrm5450SsygZ1StEz7RxjAlNYRgquEJoF6Pq6Sx7VsPMRpf9GAlQwrY/Xc9oFCzO9BSXdGg8CzCn/LfC2MPvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144167; c=relaxed/simple;
	bh=gKAEMOgSpCC5WNfMnsDV7LsCcJsKMz8C9HIBbCyHHMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYp+l3MpEW2m5r+yBE7H2Dnhh7UfvJaoCt3OGiLuID9xnuBC/YiVjm82scNrbgsta6C0smS8UHDflevB/Ij0POuaD2X09OWcfjX9q8m/c8vQVgMhh9ZqRwPj7C+LMMUZvJPPEArahIvnKAIpS96iUU5Q5y3BO8oBha2wvIcyrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hxfMOLaM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hxfMOLaM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gKAEMOgSpCC5WNfMnsDV7LsCcJsKMz8C9HIBbCyHHMs=;
	t=1792144165; x=1793353765; b=hxfMOLaMEq1IhbldJgVR3G/pQNvW2BY4lFm7ZCAUaR3cXLm
	ZJ/HNreF9GaKMhnI5sZhf95JskNMSJVQehWt+DkJozky8v7utSHVqb7HlkalcdXU1D09vV67ZRT3P
	ktDyzn2U68pZaP6c+32N0unRPgxHUT+0vO1ka67IebGeo5nNxMdEbgGYlXx0Df6IIX/fWwqGPEJPL
	LLhT9sf9uFCKjLMEjl1tZFlAIbHKpbibXKHiq7yzC1M4fDhLY0Bn7aEuJhZHNFk375dzXOdFb9hC4
	s1nXYqcgR6ApgY6swDM1m7ydmlyn2HgNx5T04AoeQ7yPg+EvGA70G62j9LQCOGSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHeYu-00000005fFz-1IMS;
	Fri, 16 Oct 2026 11:49:16 +0200
Message-ID: <77e9eb61d0e81ead5d5840abb95ffbd695a4e513.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?=	 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,  Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Fri, 16 Oct 2026 11:49:14 +0200
In-Reply-To: <20261016054558-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
	 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
	 <20261016054142-mutt-send-email-mst@kernel.org>
	 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
	 <20261016054558-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2026-10-16 at 05:47 -0400, Michael S. Tsirkin wrote:
> > >=20
> > Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> > and -ERROR on failure?
>=20
> After this patchset, it can, to signal slow path software checksum.
> I'm changing callers first so that changing the function itself
> does not break bisect. I should mention this in the commit log.

Oh, OK, that I clearly missed, but also was only CC'ed on patches 2 and
3 :)

johannes
