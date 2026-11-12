Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482778;
	b=kD/Id1ALEkPYzb8v3FqnZGkP+gvTPwx6FiDWqkRV45Cg/yA8fgv31O/D9m9/ipwPG021
	 vl34NRw6TSJ3WXTDMriirfapr8yA/aINmiLNiAwv5xum4w8hAJYPkCgksJYFujBJm4kTD
	 LR4EfpOg+1Y1Z0ZTRSlpUGx487IUBcerX2q7+AjJ8V2ebwoJDLfyW03iWAX0yd93y6dJd
	 /qTn+h7QAAdWUROcnODWr5/5UOr3XrY78TKUmVt6qiY3WICp/Y5ZDA5f2smFmOnzwTLCr
	 gfSW7JPMVKJn2+V2Jp12WU+4oaIFouO4u8ZJBLSUXFm2GsEQJV8tVzaxZBG7fruVgmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	b=eD03Rb9w5+7fkT9rJTOJimVx0fTJkR0uaBCYV6SM9v8Mnojd4KsbLDpg+ILF4g5VngaL
	 KFN3e6VfxyBtNRp/j10CQUx34WHYYLyhRkEtOAwLcayU075n9uy4uzmVhQZCPrFOr9qCE
	 e85AO9Suw3WghRyt+/VnlsPFnMGgVm4EiJL9D0IYXFDDQjruZRm2sXef7wZgWZJVAVQUW
	 edFHSFs9O+9NgZ7p/7At+X5C9JwWJ9rRIqORZds6x6l3O4VqKkchAGoFotZ3jPCtrrvKB
	 ahPbsBUopD5941HdEnXCzCanOoFnid0mOXpdFw0SVuOShxidgK8ZG5ItUukO0fjU3dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt7VLZDY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408D606A323;
	Thu, 12 Nov 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lt7VLZDY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93C61F00A06;
	Thu, 12 Nov 2026 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482778;
	bh=sLyZtPTkFdbyABhOZWUDHW8SHa1Rc6mfsRhG3LxmUD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lt7VLZDY+JH64ZwoR4Und5EUcErDQ5ZAuoIJBZ57zEoSgX4witgvEbyPAJhpeM5oZ
	 JO0PaV9p9Y0dHjw9NXaXVs8AjWS8MTBqqBcv6pZvhiPsPtsS2ngIuPr6bbO+OAtCvQ
	 tfEw6egDFG1m5y+5JDbxhD3h/E4w53C4Mpsdd3fcK+kKFiTrsq5O6FwCAEKXtwK0uE
	 t0ob6Emfftx8lIiD7LEK3v/nNhNDAPngQEYGd/jaaY/g/bcFRwHb/PgzZrwtX0zgpw
	 MrJLoDuLg5DydKRHecWduclfUmYZjR9ESwKFcKW5SFf+i6jduRqBirwR+fsAE/lHQO
	 2063kLqMsECzg==
From: netdev-bot+sinfo@kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next v5 0/9] virtio-net: add receive timestamp support
Date: Thu, 12 Nov 2026 11:26:16 +0000
Message-ID: <179448277631.2168702.3589888366892895234@kernel.org>
In-Reply-To:
 <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
References:
 <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
