Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14924E014
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348600; cv=none; b=p0qP4IGQNq7pShC9h/3wr3863Ay2KZWDhpJc99aM6ShJSpcaaqV/ZMgQmqG/bB4Hz1aoH9Ga4IWckPyiUXnHh1FcKQQG8SmYlNH+sQhNxJJZCF4w0Z6orYgD+86mVK3mLKDFcLXfjt4aKxAJnkCtzIrJ3HWfa2bUeg/oo9fI53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348600; c=relaxed/simple;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSFxkYg+tgUKVt3GUpO+rlKT22haV9cDa9rOyTfO9DLujwhpiJL562X28kXQ1Zi4DUXIcOkKs3RBEce1Nz32PFxpVj5FZygp21jTzuZBoks9fHP6DuJSRUvgozDDfDQuzSmFPqXRcfgjxW93g7RVOhcevTxLpzqqeMSxlg+7wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fX29XGyM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fX29XGyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	b=fX29XGyMPw+STYQNVLF/TjUyTlCXpRjH4KpIX9UwvqraUsgmjrVOnpheTAZodxWQ+2FyMs
	l7OQSbBI6TlmoFDRWfF2/5v2hNJv89FW4tzqKlQFE44S6fm9wdYwfbU75jMepSKWkSjfy4
	BOSYKwQTNZg7gtMVXiTY45gb1ZlzKhw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-zeOS2t67MxO8nhlJpfs4Zg-1; Tue, 18 Mar 2025 21:43:16 -0400
X-MC-Unique: zeOS2t67MxO8nhlJpfs4Zg-1
X-Mimecast-MFC-AGG-ID: zeOS2t67MxO8nhlJpfs4Zg_1742348595
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso10359940a91.2
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 18:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348594; x=1742953394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
        b=TqD6T6aj/424LLdrydgaDmRMljYnwa1SNKoBuILMMLka/L1de0pfcb4O4xcnHZsJI7
         UkvAB/X3xI3dKBesIX5zt5r0QYxlg6eS8HxZpiOPgy3mSmn5u3nwbBt34RUE75NNDNvo
         /Ok0b7FdUNUP5SySu+sw7WLDjluoXPz/uAwwevWVT9P1CyFLl6vhPCogdEIDie/EAyQH
         14yObiH4ZDMrUnGo4UemQpXYVieAgPNte1Hh+71Bk1fe98bsU2vOdQci9sRbDew1TxfO
         BnYblVOJja3+1yfPQ8rlpU8aZowD4jPas+st7kgpYFgYSmocWtBAS/v2SfB0m4CbENhl
         LcDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABDAwTVCY0AQWOG4hqUXLu3G7cvomPOAgWo3olLTPazaPaLbM8iHfdqezffnE0wI5szyD8SA0HeXGWRfh5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1yQVMnBrFrxiNpm0U6P3JdLwrjQ//kwjWJrb7INPR9ILka1Yv
	QTcqtSxTDhGNmC6BgirFWb8xO/pa+er/+vKbpnZnTVjkLZ15+3HWlRVfzlP3lWNWqV3MhyTCdvr
	g/6Bzi7G3oUAq1KQ10mPqD5uycl7Ek2QA8g1z/tOfj0L+JrrMQKbuVcdgOB1NR/Fc7aJ4ldL8OQ
	btv3J+spf2dAiY7rc6v1N7c0Y8KlXlhbOKuaf1TbH++kxovlwTsg==
X-Gm-Gg: ASbGnctX4UClEWyrPeXKzHzC/Ia9uS34zbkdxk9eIV34YwSyWFXCBCnlw7Ygq+xf63p
	N2rs4KXHnsDxuda2/1/PRYYhQovo7vG9J8zJ2EiEULtOGn9XivWtoF9uaQ7YrNyoE5bpW7utJ
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-301bde6cf1fmr1638685a91.11.1742348594703;
        Tue, 18 Mar 2025 18:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFcg4dnJHM1uCFM2u2csupiktItuJlKGJc6MgtbCrZ17gemZAB1I9mrMnZFW3Wp0mx2Q/1cpCGqJkfDvMKT0=
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-301bde6cf1fmr1638665a91.11.1742348594429; Tue, 18 Mar 2025
 18:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-2-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-2-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:02 +0800
X-Gm-Features: AQ5f1JoMSQNYtVIT-ODL08ptBsIoNK10KPby88nDSI2xd14NsoDQzDvBrBl4FY4
Message-ID: <CACGkMEtmzJpWQjAD1FoYwH0HF4+y33Kjf-jUwagnOP3wg15oqw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] virtio_net: Fix endian with virtio_net_ctrl_rss
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xCc20RqQ6ussMwo7yUUR40wlm4LgG7LRNPhzdRzvoI4_1742348595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Mark the fields of struct virtio_net_ctrl_rss as little endian as
> they are in struct virtio_net_rss_config, which it follows.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

