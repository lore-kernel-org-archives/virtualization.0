Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78197DA73
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548983; cv=none; b=cg/shSzsyOM63oAUaGKN8T4jKbCpqmxPirdADayGxzVlL29lAy3iN9d/X+WTEmqbcvGxzHUBFngfgJUK6ZqmGA3eM7SaqbwvbXLeZlqRb21V9p11c+6mavfoZbBhHd+aSYe5gDRr+5kv1iFrNayuDZbjA3iB/NYqhE2pk0Q3C+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548983; c=relaxed/simple;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txZOt5BD5fv3b0T6XXdBLLdqjeq5xML3ElCssIKXt9ZBBt0S/4coVW3HB8hXm0zMLnNb+oCF0dOP2gz/F9dWcVUc+fY5fwsio+/7vZtPIWTJFZXMMH9oOBZOH/nOyrwGkM+bk6D92TfjyB/7ZFyIaRqhCI4bGw2qp3f8n7+8JtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsrrDmmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrrDmmf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	b=SsrrDmmfTXsIEORcLfhag9L7C3kdEbLDTVh2+AkRR+kShSzyUUOmNLN7xQErKyQw79aRot
	0XAfBeqi2DqwtE902EBkEDqVRMQAiiVUzFIvLHJR9KZh+lrGRWaq8y1LqIj61g3h6qSVvM
	I/J+OBEIFrJ5KyV1mdQAAW7s+Dr4PBA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-nS8ULdRQNU6fuSPmj1Xikw-1; Wed, 26 Feb 2025 00:49:39 -0500
X-MC-Unique: nS8ULdRQNU6fuSPmj1Xikw-1
X-Mimecast-MFC-AGG-ID: nS8ULdRQNU6fuSPmj1Xikw_1740548978
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so18353692a91.1
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 21:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548978; x=1741153778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
        b=bVS0KxDIrMDVI+JXOFxyUiMDKYppprgvorKHVQiQEVBOYky/i2509lQZn3L96M+TdK
         7HxiI2Z4R9wm4RaaEfAWZ7FHEGQUgo7qnn9MsJdVrSNP7a/FvncrIL9n7q3i29NX/xik
         N/zhHjbH3FIWqrUAeWKly3e+Q7lmbYYUEyVTUmFN/YL7pqPiX5EOeDN8k8Vm+eWmdZDD
         9dg4G8Iyl5M42G3KP4PF2AthuiJ1OVfQ6LKnWcp7b+wi8LMbNh2CZTI72A2lF20vwL19
         rgnfPc94u2mxJaZfK93IV+jQz6dpUQlLOiezQC2E/TkCf3p9PUAGDJJz65OOKs0NoE4I
         kurA==
X-Forwarded-Encrypted: i=1; AJvYcCXGmIaYfmly3/2rPRkTrxhl/bDhDmAIslqjXBuzJjUGF5ydR1YA/vAJNmG/Ibe1LkmBimUeLdMNh1AsFAiakg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypf/Q2kuP+TNIumR1oOxgqPJlOYoDbbE46C7hNLhTYao1lB8aN
	hgJYJ6SGVH31KbqBaN4qlTBF9ccUqPvuE0ypLD7MbPj9LzhFgB1hXyR9II6Cdgl0mUEe5Z/SVak
	76w+ybdY+ys0gyGS2M2tQ6W6eCZeDrQ7XtZMBwJPOffQXNkZzQIr2qrIuMOdcipXu4Wpcl6u4Z1
	996kIQ8x0gav+tLXn9kGFEfrPBcDD7Vomn5CuEkxs=
X-Gm-Gg: ASbGncuxlRnEo6FK4AkvVuuqkIg64fsru1CLnjtNBR3Ysze4zPui+1cMdNhmeqcBeY/
	ywLGmn14jmhfNKwimZApwEZrNwdFjeIG00e1chmSvfHdSI8FURusxORsmtJB84P4tEmUQISXIZw
	==
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id 98e67ed59e1d1-2fce8724390mr34443309a91.24.1740548978079;
        Tue, 25 Feb 2025 21:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOC9QXoxJuOHEjlx+qZRYQH6fSlrUiM3+fVaJpf6dIZ4d2WAtWScZFMkzacVSmHtSzRdR+wj6Eo8xT/JNNSFc=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2fce8724390mr34443288a91.24.1740548977777; Tue, 25 Feb 2025
 21:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-3-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-3-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:49:25 +0800
X-Gm-Features: AWEUYZmvhQtj62SIihRDJMGEYtSPUe20LIQv6rcQ21elME2iuLu9IMnansJ-eGg
Message-ID: <CACGkMEsfSqE30m1oq14h_=VNavf+OVHmqW5aptEGBNumf4ALjA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] virtio-net: Refactor napi_disable paths
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q4n4RDFfMnMEBQ_c4sK736DHGKp1t3ZO52pcd1ATRo4_1740548978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
> to take a struct send_queue.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

