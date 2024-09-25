Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0E2AD11
	for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727238150; cv=none; b=ZYno4Ot72cahgvmGiB53W7W+pnc7bE1ssLWAjP3/117fNGqUZM8CHHzdKq0Vj5DHfG8V4uw0CwGgnZEWtXT6qc26uvs4IrHR4p0fszUTX+wy5Bo+tk7REYlyq8NBDe5oxz4mtshWio1mqM2BtHChAoqlGi/p/YBtl+Q+15X+2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727238150; c=relaxed/simple;
	bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVIfiII3SGcNsOEb2P0DUWbFdegtm8IphQtzwJvsXcydRtH9an5wJxp+PyIlUPxCVtskMh76Mv5eEChhKJv+U7/FPWhkdF2QMWzRq1KYrnxTY3VHmvfdKn3Q/ZWyrCHB3cpI6h6LCuvMdTsLpTK6MSv29rczD8L3pMe9WLvwzt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftZszEdv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftZszEdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727238147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
	b=ftZszEdvMGKK75p/F10QzqQPbB8WBXUedG5ofREmiQHK136QSb8d6TEcNc7AeXmeWTxv/q
	rqawRIyKQQr5BXh7225MDjwmoBxogZzet3e7dKBn5Exe9F8jOo7cxALzuQAR/HFqofDJWN
	DxaOZXXzzRhL2NGIipBCXalQxsn5u6U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-fS3Xg-E9On-8HRASX9EdnQ-1; Wed, 25 Sep 2024 00:22:25 -0400
X-MC-Unique: fS3Xg-E9On-8HRASX9EdnQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d86e9da90cso5792302a91.2
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 21:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727238145; x=1727842945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9LN97hlTJQQcAvajkRRjEdhLeC7uRAKnig/6jQvM+o=;
        b=RA5SbmlWAFdDfg8+MQcShK8KGdkqXCyJSkd0YPRY1tCUHBcsAhkg6OvGYPchXwjSrK
         au/8tE2j163g+ODcGt+tly7Hj8beRQCQBXacFQOW4x8lvsMVCeVhqKAPdZinz8VZfok8
         qvvqr5b/ngBPqMPnwoIQk/6aqFiYgH+J29xlafcLCQHjhA5y7CZXDpiowHnEzPgJlWMn
         UJaBBa//QRLx911l2xM0bNjmqm3883RVDKR8Uq4aDM5rBDrW8giDEBw+FNyVi4IrKdPk
         /xKv9TxVx9vDb3wUBKRVitEkhMU7obGkrIcHKPMPwf+CU/JDjyS376+QOr4vbgY3Zw58
         P5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVlwrLGdh9+vuEq68ix7e73iIqPqIIDBf7CHefYp5IC7pXq/owufo2qLo4g/42nICiOwpk2lzQ1t37mh1B7kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnA0N1wPfT/dnoUaL2hk4m1YQMI1+NPjoA6QmcxA0cTZ82qsqb
	j0x6C9y/wT9EEpajEtlgxrmQ9fJ8MtNPBifOJIQJ8bBW8khIbS5Cxd06y8sAPvjdAP9s1mOxkPQ
	b7ubPNzykBVYhKRxckSqyIDdVfAQOiUELcuevuLQK8Xq9s8L4aLFUVtrgncrQHNnbB+uxVacnrG
	3OPvVbBU9j4yDYiwrPkd/mW7AyNtGGW59oH2P+cto=
X-Received: by 2002:a17:90b:2811:b0:2da:d766:1925 with SMTP id 98e67ed59e1d1-2e06aff73b7mr1767990a91.37.1727238144853;
        Tue, 24 Sep 2024 21:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyQ0SI/V6qMBFQePIJmblPb1NZncnX8sNbsV7txh504HJjJLI6AZkFNT+9jhFdudDINdqTAi1UZYIWZxKdAIE=
X-Received: by 2002:a17:90b:2811:b0:2da:d766:1925 with SMTP id
 98e67ed59e1d1-2e06aff73b7mr1767966a91.37.1727238144426; Tue, 24 Sep 2024
 21:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240920202141.89446-1-huangwenyuu@outlook.com>
In-Reply-To: <20240920202141.89446-1-huangwenyuu@outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Sep 2024 12:22:13 +0800
Message-ID: <CACGkMEvieuDTp-DfhQ58EGbeFCvNmn4fUNmUdPHzex6pOetbdw@mail.gmail.com>
Subject: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
To: Wenyu Huang <huangwenyu1998@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 4:21=E2=80=AFAM Wenyu Huang <huangwenyu1998@gmail.c=
om> wrote:
>
> From: Wenyu Huang <huangwenyu1998@gmail.com>
>
> It's also available for packed ring now.
>
> Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
> ---

Patch seems to be fine at a first glance. Is this used for testing or
transport like remoteproc?

Thanks

