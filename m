Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A405186284
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798604; cv=none; b=VDU0/3Mzaw67I/4Xv/5xm4uXEa/dgwcZbKvCgtY+o4qLQ+6AzlJAwHQIpvDEjDQijBlA/djtbDEPoQOc1+L2IB0x24ppoPdWYl3fxVhtTxZyRrqSjfG8NB5V/hbeAAvvDBaHPE0MFpyp0n+UXtAk4WEhSP02s52qkZcgePm34a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798604; c=relaxed/simple;
	bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaPFoxECcrNjzuD7h0NmM9dakdSZMaMo4ttULttRWLI8+r/G8j3xrA9ctG6B0bahMxeDWLZtfx6biKTPN2S2qTU9qV3Wm++nm0ROOhbrXiRe1PzaC02SkGY4LPLJmoaY3UiLdImCPaugt6V3PuBgEPWzWJcpL7LIOqJzRMj4Yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F88PUSWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F88PUSWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730798602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
	b=F88PUSWKHl6vABFRNU5fN5sbiJUJZKB+MV27WK5Vck18WVzutj7xVaQyUWp/H2Zp5iS3ax
	bs5UawyAU04/jWegoYDbnqsnPo5C3GY18zNfuwdffkkFun81Tv2vnH9abEPv5Bfp6lUQUT
	938q6trH/hoQmNk72tMy8NLGMZp++js=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-WAsUQR05Mw-tV0drJfKbVw-1; Tue, 05 Nov 2024 04:23:21 -0500
X-MC-Unique: WAsUQR05Mw-tV0drJfKbVw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e583c7601fso5062447a91.2
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 01:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798600; x=1731403400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqmGDqu3YJTcoPXm3AUjz1Sm1xD34tiZKKiUWhhxzhI=;
        b=dlGYieUjQ7Aiz1A2X8pt6tpZLDKCwq2JgKMYCfgNeKuGxy3Zi9nnr7ddLXhl6JV3td
         LYq+Op8IB6OYRJ9zOR9g4y91PTspX9DH9rMVw8hJxsgOhSgfF/IGXEMjX4FcpSNcpN6w
         uBv6MtCtiDy8VAQeKXor5tSo95C6oKxJBrIMsrSXcgv7ZThH5/KLgLwpjOVmWH2VcFkC
         3OzGzrtbKUQvLOS1AbI4PPWD0WBmTvAhydT24Q9Z8A4IERPMERzi8Xm/Hdu5lL7C1Og2
         xwNrx+DUNLTxvofDNxluFX2gJpzqGczNhRR57gFGs6oV5uL+2yiwMyTuOJdld9gz6jYR
         xA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWs/oZzU8EXhbQEEpbY8hcjICsCSepvi1EhmPVNWaZJ9s1RwC6dlzhs9kadxOeXExnW2AlIsXCCKoHWQ6KBnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiIeCF1gWmQwxPS2h+WZrvPloKQSP1C7O/Eze2ZQ439QW9NexI
	gua1EMTJpaLjGJRgj3TCpAuS6qDA0CNAbcqXckbPvjkYROxUe8Ue7/O9/+Nsz46DeOBTk2VIMzB
	2ef0QW6LpRcC1063ckE8rW3KN+bpU4UpmAY+8+mIaxnN94Y+y+uVLorLKis271NnJkqXBCVS4Yd
	VolRY47HwbDgJGUkJkvccAOnzmRIdJbAsiLmWVmY0=
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id 98e67ed59e1d1-2e94c52a9c3mr23098569a91.37.1730798600307;
        Tue, 05 Nov 2024 01:23:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPtci1uxxNPh759PaVSGbZ7DqP895VpcRzq1C4wn1LN8wRlvHgQnWd4dh6rpTXmWqZ0UunppM8qq1LNUaG4hU=
X-Received: by 2002:a17:90b:1a90:b0:2e2:f044:caaa with SMTP id
 98e67ed59e1d1-2e94c52a9c3mr23098547a91.37.1730798599879; Tue, 05 Nov 2024
 01:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241029084615.91049-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241029084615.91049-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:23:08 +0800
Message-ID: <CACGkMEsDHtT64Gi=BuB0OGoD8EJgpL9=Hb3+L4im_EUxNC-XqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/4] virtio_net: rx remove premapped failover code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, the premapped mode can be enabled unconditionally.
>
> So we can remove the failover code for merge and small mode.
>
> The virtnet_rq_xxx() helper would be only used if the mode is using pre
> mapping. A check is added to prevent misusing of these API.
>
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

