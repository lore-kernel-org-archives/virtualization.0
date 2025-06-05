Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961026AEE
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749091735; cv=none; b=pS0MTkXqQd32TftH/iYP0Bk13yJqvsnUXe4cHVla+RNHHeHpXKddFNqi0G8hoQsnyb6eaw61Vf1vuWckBU4JiB6eSpV5yTA9hK5YMNAbNvISOkoCh5PZy+jF5Js4LnGT5Wuzi7vYu/21tcfSs/HKdZQGqv47osO7+94PabTEKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749091735; c=relaxed/simple;
	bh=t4detorygDiNP94WSkQmK0XSEveHxBQIOKKfwoRS9pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQWW+ojVnBleNQTCsvy8qhArvJW0eYPHeNDrBd9GkE5im2L0OFidewh4SoQD3DiQn0q8VxvIBRQ+ZMD5sRFuo3+xzvlPtWcG4St/xtraVAXhyzN2zT2PBSvLjbNYL9jCERazDs8FNeFIdjJwd55KDsqOqbToJNtyyENOTtRkCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAt+K31H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAt+K31H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749091732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbZIYNIcbcpYGKI7GQpYFy5AAldBczcWZ7gpkadXYag=;
	b=UAt+K31HOZgO+SrpPfVw6mjr46arRo0RW50F1fL2eJmSObr987JHNFddewMlrLuiq4FRoT
	b2oyhgwYEkbMAWdFSLv6EfOP9+pV1mpKgzWLDzioJ8AlbzbRhabivMN8XYFBUZohYA0zu6
	2iGgHCXgEPayE+i4/JetnswPj73+ZRU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-yzIVHUEgOVSkjfMoXPCunA-1; Wed, 04 Jun 2025 22:48:51 -0400
X-MC-Unique: yzIVHUEgOVSkjfMoXPCunA-1
X-Mimecast-MFC-AGG-ID: yzIVHUEgOVSkjfMoXPCunA_1749091730
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7480d44e6f9so495211b3a.2
        for <virtualization@lists.linux.dev>; Wed, 04 Jun 2025 19:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749091730; x=1749696530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbZIYNIcbcpYGKI7GQpYFy5AAldBczcWZ7gpkadXYag=;
        b=Qvowz70/hiCNzow5sdr4Sxtq2GSUkQHo1UedAEc43vSCszSSdLaRkJh2TWFdsPKM7D
         YejvB3H0Xz4Zq8eREa+u0He6855+SKKAn0LLoT3tFsjNZgMD5a3Is9UgqAq2pX8Becvs
         racFToMmXR/1YJjicpIIwfk/Dj6F4dlDL57gdOAR3BTeccxkodbBTMmk+BKlbmA1UHJz
         gz8pMXBvcxIRjomaPY3sTsuyU3Xz+KyA12i94aiigSWIYGykw4/Y+lOjHxKQqo4KpSo/
         YrT+WrzY2Ht8VOY4FC63/3oNq4VNXldb8hbpoUSJ2Z1W10eChnZkpIbLZ3GCbWzeeVco
         gomw==
X-Forwarded-Encrypted: i=1; AJvYcCWfkzLrZhHOvtD9oXnER4Tao33AaRyMusEyYwOJCEoLWQlLdvzOR7SQxMiVZpTygXHM8+r3wRQcei3yRJJGZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzevnMemt8fgOt3Wptf2BsvMwQTO//WGS73rsCmeW7aUmE5U9ga
	J7k/TgdMmFhBPujojR30IntM98SRJYsPnW9QC32mTjr3UU1KQxqyTpTEiIknd3bVxKzZyRuQE1t
	eMbgtDWf/r5pw19JclgSGIHRF9rD82V7KLbTk81bNM23ay5c9AnGFkShYyflnmasfmonj7WLr0c
	Am3sZP5L8hJ1Ov6y4vdUuPdUeA/BnjCESbePufOtOBob0=
X-Gm-Gg: ASbGncuHS3YuYvaUbE0ttjHMXxhcLQuTLUQ2cc/XKl42L0ItM1yaTws1TjQjw1Xjtv0
	kUeSQSn1Pz1oxyT+SYJz8TKFQyqTh+5iwUSjkeuLY5gqBb0XDlfXg8f47cF4fS40cIUvc
X-Received: by 2002:a05:6a00:4fcc:b0:742:a7e3:7c84 with SMTP id d2e1a72fcca58-7480cf89b3emr6468007b3a.13.1749091730134;
        Wed, 04 Jun 2025 19:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrqB3XiBYcW/hYapHNk+jA3BSGhc8isfd6N3AxDbT90mhS46oJzSgVuNFeBEMvpAsTeIqDFb4uw1vsZZZTceU=
X-Received: by 2002:a05:6a00:4fcc:b0:742:a7e3:7c84 with SMTP id
 d2e1a72fcca58-7480cf89b3emr6467980b3a.13.1749091729813; Wed, 04 Jun 2025
 19:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250604184802.2625300-1-dtatulea@nvidia.com>
In-Reply-To: <20250604184802.2625300-1-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 10:48:38 +0800
X-Gm-Features: AX0GCFs_GPLF0gKDUCq970gHNyiw0rWqggwHW7k_1Il5kcuvZ_GXf6UMbbRftgo
Message-ID: <CACGkMEttzcr24-cD5AGSvc_79_OJbZ-coLR-N68dMTqJe6V-TA@mail.gmail.com>
Subject: Re: [PATCH vhost] vdpa/mlx5: Fix needs_teardown flag calculation
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wiu5HsjVHxJj-l6ugLWeqyM-9Em4dqtf21q8Bk36FUg_1749091730
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:48=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> needs_teardown is a device flag that indicates when virtual queues need
> to be recreated. This happens for certain configuration changes: queue
> size and some specific features.
>
> Currently, the needs_teardown state can be incorrectly reset by
> subsequent .set_vq_num() calls. For example, for 1 rx VQ with size 512
> and 1 tx VQ with size 256:
>
> .set_vq_num(0, 512) -> sets needs_teardown to true (rx queue has a
>                        non-default size)
> .set_vq_num(1, 256) -> sets needs_teardown to false (tx queue has a
>                        default size)
>
> This change takes into account the previous value of the needs_teardown
> flag when re-calculating it during VQ size configuration.
>
> Fixes: 0fe963d6fc16 ("vdpa/mlx5: Re-create HW VQs under certain condition=
s")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Tested-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

