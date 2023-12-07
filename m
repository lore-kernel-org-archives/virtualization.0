Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C461118E
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou1eulSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701927993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
	b=Ou1eulSyabayFdautSHc5oxVnhnZ57YhHzXu1sFulzqCmqtAh73+Ir7nAbtOeeObuTIilg
	nWIK0hS0Yj0TER8oExh2yQLjLPPp2Y5l685flujCp4dgJDqhu0TOnFP1Bwa7EGG2TmNWJu
	IbMT9mq2z3S0rD01UctOOKEEJJModyo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-BCqVMj_ZMVuo3npGFc0NVg-1; Thu, 07 Dec 2023 00:46:32 -0500
X-MC-Unique: BCqVMj_ZMVuo3npGFc0NVg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28649b11e86so592365a91.0
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 21:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927991; x=1702532791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
        b=nvXqEEpJsr+PPI7FJGPv60EaXIWxECyuEp3ufk4IARCsL78urlBMtnDzPUgXcckbdm
         m1z2CjdFPQTrRFnU7InORLNN9luYGgSFTqzCQKZxFNyKcz438zpnbO6Eo3SoJWZB7Xn3
         rvH8IL1+hnJdCn9e8FKyx2W3ghUkRitX0y16ydaJ36iQGj/dNcae7Mdpi5PChFVtjBII
         d1vonPCOZFxvj9HQxdfy/k4cqFlElLH2fkX/L2USFxB4MNPALyX5ec6bVPE2qObECb52
         +TRCMez97oV/hrJKJrIx+r0wQFYutk7lS6Dc9sdlZMMAqPPoAvtTkW96YQKhjMK8eXiu
         3Dtw==
X-Gm-Message-State: AOJu0YwGGdRH3m4WDu5F1DLkBRo37kZyNpubSqeQl2pbKPF9nOf/onFB
	IyMsSJSE4Su8AO8f500kP0FzNLWHRrgTduFDm9dfVqDgV5N5CWEXmbSMazG7H6c9QPpL7+lvZFn
	MN2Kj2Hhl3Wp5sTZgUpTCHhLdVzymkLZiLrecd9nObl0=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id gc11-20020a17090b310b00b00286bff2c41bmr1876718pjb.23.1701927991075;
        Wed, 06 Dec 2023 21:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfgjoIKpasl0QD67eKC09rD6Vvob1+V2GPMTPFb8/kThT/w3JyyDRtZYtlMl19xjCR/LXa/IPCZwYXFZnNus=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id
 gc11-20020a17090b310b00b00286bff2c41bmr1876711pjb.23.1701927990817; Wed, 06
 Dec 2023 21:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-6-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-6-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:46:19 +0800
Message-ID: <CACGkMEsiDbZcCAKDxK7hQ=pqWM-GHG2UaKRGM264ozqKVwZRPg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

For vhost part:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

