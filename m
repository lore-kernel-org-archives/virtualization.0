Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FE19007D
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526409; cv=none; b=kXpDSI3a/FR2+mlmNiiLtICQcPSP/Mwkgur1kptBy5/O+P+RwegP4S00MgCBKT1wF14TmU5ktf7akinom8lkHJ+EJq1slZ7dTMG6pqgPqMcKgxFDVxkABfNa9QG5zYG5dNzY7N/A2A1J5Hpbm4m1IqasU3jBMGKlmHeXXmFIcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526409; c=relaxed/simple;
	bh=N4VHTOiMr1QEkoUwXNcQJva4+4+xsiihj3nqW8BwZ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV1sLB64FPjEUoDekYZ6QILIVLo+H8aGaJR/JtnIHSA/nn5LxU4diEzLHM+bbUx4loOXMCW5XpFJcOY1lr8UWMpusjZatsa0mmdZaTt/ZGt5v4qbiuwVskTCxkpPFrBiyctawEHa4YEHYl+I5/8xpYvzXE+hUzwhXnecc5uoQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYlgTkIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYlgTkIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02nNA7RsZ956EniYLNy3FanK3JnNwTY1mjUMT95zUi4=;
	b=CYlgTkILmdX1rlfH9y34WQF8QBblpKMSFR5bBe/1GyNkTe+8AKsvDvnUo6rF0jlM4VY+kD
	VhUdCmGNBW9DlQgx0MZLUALIg6JBaI7WftCL5tF7Nnb74S0guQnAUTGolJoPJLQ6KwH8L+
	IRrLpOCeFgwJ2J1cCrGCFSQxkZypKAo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-wHjij2YDMBea6SVVDoEUPw-1; Wed, 22 Jan 2025 01:13:24 -0500
X-MC-Unique: wHjij2YDMBea6SVVDoEUPw-1
X-Mimecast-MFC-AGG-ID: wHjij2YDMBea6SVVDoEUPw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso12254623a91.0
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 22:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526403; x=1738131203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02nNA7RsZ956EniYLNy3FanK3JnNwTY1mjUMT95zUi4=;
        b=nRPil65V4T8sGGhv2KNP3MBw+5eSNB7WtRp/4roVI+3FXnVhr0l773T1u6qQ2PgYK4
         mhsZ6/Zcxu9iTentE/K2HOQgGvHc7hl1NrGcVLdnI2rrL9qIBcDmI5pauKeglEYpZgMR
         1alXmNRtNZdO/meLc5hFzgEgtyeNSJCMrLQLd5tUQNndJmGliHTSyrrzPitAHpmyitpx
         eFYWB7nzWpmHu+n4BCIMFTkVX+S4DHG9nZzSDQFlE0+scJXzUJqYI4TmKvE7qh0X1agY
         LG4bd+msoQ0pTIHt1Mbzzr7r2v7V8mtDK/UcXUF1gP41sMvh0NGs2a+IpDR/2hbUqAPa
         mOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCURIDhBSJAxEIYNztyq7RkLaDFxBwZHfDwPjo7Gk00QsaDlPuDiu52G9Jetr6/zAXvSv8QdpFVuoI4gvQLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvYrR+5yy1aCdz/qrq0jAoFxvfnpe4h0lKlNS6eFMv4vgX17/5
	Xca+KpJIMDZh1lAfEVHr1L2yZqXb5Jn3kBhM8fW/iYSYhzCEP4KX6BfLRD68OQCieKqEKA67kF8
	/Uj1FqLaw88/Kc1kKsWvU1JMbBhAMoEXJdXlfzkpJAArfoghAeYh+ABGKRAlWYhTjNj6Km4qIiE
	K6QT/ZpSr0J4KUxZ8xZnBCfcHHp+iSRuwS55t+4nk=
X-Gm-Gg: ASbGncvzhycugE1pn4DlKGl4hmv0kmcfvaHMfTphtHLwfQtqS3gXNYv4V86gko7UTL0
	Ku9sQx+GF/uquNo40rBQ1dW31TdIU7p4EUCeT0mWQ+G74+JYGustY
X-Received: by 2002:a05:6a00:2448:b0:725:322a:922c with SMTP id d2e1a72fcca58-72daf9abd78mr33122209b3a.3.1737526403539;
        Tue, 21 Jan 2025 22:13:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWZ5jD+lVwVZrfUOdJgzO9VY01R80mkMlLuikBRjnx/qrJv98YZqo4Yk3EacdxygEGirjJku2kd0ZHp3IcPyc=
X-Received: by 2002:a05:6a00:2448:b0:725:322a:922c with SMTP id
 d2e1a72fcca58-72daf9abd78mr33122166b3a.3.1737526403133; Tue, 21 Jan 2025
 22:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-4-jdamato@fastly.com>
In-Reply-To: <20250121191047.269844-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 14:13:12 +0800
X-Gm-Features: AbW1kvas-yRk2J2XFrXmr6vKOy8sE2Th8wv8T5Kmo1zaNBEsKqnxc_Acux4J614
Message-ID: <CACGkMEvLb3o3xe=GVW2ivngYoGt+0KfrWWTN1dsBT7ja-eeiQQ@mail.gmail.com>
Subject: Re: [RFC net-next v3 3/4] virtio_net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b_dQack_ehT-rMOssPFCRZsX3fiAzGF7lwLYCqhFJts_1737526404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

