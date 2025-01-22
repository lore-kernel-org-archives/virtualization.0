Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5F175D47
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737526435; cv=none; b=h9nvUZ9CMlzMojY1YtVmoNQ6rNc6Pwo3K6VONbuZr9dAGXjRFkqzRCCLM9v6cxRag3gqGlxL4BloeUSvPhuLRDOzCcc1EqSfSgwnrD/i8bpQhDA8qgg+Y2tscHGxAL6FMJiX1mc0bMRATreKS3T3F0mo4kPmMv0AgMAOEAd72rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737526435; c=relaxed/simple;
	bh=vjKbTn7w8K5WVElatg0aMdnqDfH3VnAXAE40M7XOEgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2PTG5ZlaeX58S9YJrAj6R7viki3ztLSGZ0cgJvBWlAEMI58Ciat1ZV0h0tJlDszVBzHjFSo+RmJ5Gm4EGF1wgVDOu5RICxqMdICbjgL6eI3EJZFBmN3Ruo65ojC+i6EyCl1lBP6XRzWJaIqmmi2qp0oN43X7Rs/JjovBm5468o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9znhGN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9znhGN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737526432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWN0QwZFJgBt79Q9qJ1KqnqceHCKjCN8oGypdv/f+IA=;
	b=U9znhGN/iVX2dgOMirRDUAyrJjJgNOCU0qOitp8dP5lQTHUc1cMQPOPDVAbgFKjeJG0zx3
	NzjqDTZpts8nBVZ/9ALUz2IfBt63o/9VplXkqrHvp8x0PdVNDm0JvoAPFHz0SY0yGMkEGz
	qjPoD7bQ4fW/E5cSO99Rvc+GFzSOeVU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-TaqYli9CPeahPc4uXjlFJA-1; Wed, 22 Jan 2025 01:13:44 -0500
X-MC-Unique: TaqYli9CPeahPc4uXjlFJA-1
X-Mimecast-MFC-AGG-ID: TaqYli9CPeahPc4uXjlFJA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so17978251a91.3
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 22:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737526423; x=1738131223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWN0QwZFJgBt79Q9qJ1KqnqceHCKjCN8oGypdv/f+IA=;
        b=OplgZ9Zx8bIQJjWL+h8GXuEeJ5EFkisVswRvKVLJ0zXo9puxtTvsXdLISOzoGAYrtR
         7HJNmyTDdN5uye07jO0NtvXLf8yP1eUX8xce9eC5t+lOGPVCDAqaKtVAa64jeyhtSA4V
         u3U7GKnDSbeU0KZ0DKMAvAlU0hebL1v0KblTrtBwBD848hWxNEjH7QrjcWOWVl55ALiG
         1OveUzGQIAX5iO/cCfy8Vb0mCdBsCR2T/tY6NUe2G6bDgae1ZivG2/iUr1KSv4ud3GVR
         FGNDRor2FTLUymcOWdHkE3/wmiljgEFl/EWrA0CKxeqsAbG0a/1kGjdras3j+b4LbqG+
         kc3A==
X-Forwarded-Encrypted: i=1; AJvYcCUwmC69weHSQF5S1YrbBXikLY1uvit+CpXM3Au3v+XIDMRcFHei3qWbv+lf/SMPoSqVkzftoPKF5kkKIKyYoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc+WkI2BCes0MFPQkj8DU87m6xDSHqTYNGTn/RtQK8ilIataI+
	jnoVAX/JVOWCQB1iJwpSk0FCi4HxOILJBGv6rvf1t9cTziYHAyS6weRTmBuKRMy3Dhokp40l4j/
	EJkk47l+PANAoJom6M0tPiUj96hqaGofigGDBj3xHD27XtUuf0bbttKdlYTzsCvk2dk3vTlgvfh
	47kHYW54Es+JNlcH2E5Yi1JcusAJpSVvY06xzZu5Y=
X-Gm-Gg: ASbGncsMYekG689PaZy+pos8SjQ7+xoAL4ow8VgHDYFT7dq0I61CeOu3Io2/g2uH00U
	8xTFt2qhTgiUdr1rQgSt9e54LGNA12zJPloNVTV0tjF2jRuzikJqs
X-Received: by 2002:a05:6a00:2d96:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72dafbcdbe4mr26636801b3a.22.1737526423391;
        Tue, 21 Jan 2025 22:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYqZqsM0A60Mj6m99y3nE57/Un0/rci/Atd2ypW5XJwwcIh4GxWsyggmg8FPR7FLg3iPdMlBYcQxtV/egKO2Y=
X-Received: by 2002:a05:6a00:2d96:b0:725:e057:c3dd with SMTP id
 d2e1a72fcca58-72dafbcdbe4mr26636769b3a.22.1737526422974; Tue, 21 Jan 2025
 22:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-5-jdamato@fastly.com>
In-Reply-To: <20250121191047.269844-5-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Jan 2025 14:13:31 +0800
X-Gm-Features: AbW1kvZKHfFCjPQ-bI46vnDnPUQynkrVL4hZbC_qPnyp29-XmFKBRkXp58xT_8o
Message-ID: <CACGkMEsymdUyZZom3KOpyAJA2mP1BNNq0+EN66-42ZAKhx555g@mail.gmail.com>
Subject: Re: [RFC net-next v3 4/4] virtio_net: Use persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R8lUA8smw47S5M9UmQSEcFZVTKy_8QEmNwz28EGa4Wk_1737526423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use persistent NAPI config so that NAPI IDs are not renumbered as queue
> counts change.
>
> $ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
> Current hardware settings:
> Combined:       4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Now adjust the queue count, note that the NAPI IDs are not renumbered:
>
> $ sudo ethtool -L ens4 combined 1
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'}]
>
> $ sudo ethtool -L ens4 combined 8
> $ ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/netdev.yaml \
>     --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
>  {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
>  {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
>  {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
>  [...]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

