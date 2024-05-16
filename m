Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF629CE4
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834869; cv=none; b=nuV/e7FYKXrlBAQtYu7lR/mcYUXcUmV7grsmqmFcnjtukF5RfRe6tEF0wbmrcv0L9WfPxg+y5DQVSgrY41PXWt4YOu9AIrmgQTOHi0xJPckKsoh0bw8ZdeAcEbiyTsgNur+CM4XL5tra5g/dVaZrrQI22FiFeHW6Rk54L2JlW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834869; c=relaxed/simple;
	bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkNq1n2FPdczSMTlYqlIODzT7juxiM/uI7dnxl5myCjU1SzP5HBMs38PQoMhzKnEUWKovdVqCQxV0j+61E0sJdHXCUQ5sz80993Muqnpx5E2bNuN4I4A+quW5NSZwDuVZ8UpnR3XT9YGXf6+mgIn02W7aB72pUUb/MzmKkQnDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjGOq4TG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjGOq4TG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715834866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
	b=IjGOq4TGjZ15OUN8HmS+hZhdnfzBOxrUYdZ03YkOr1Gg3D438eqjbBhgDAC8xUiE8swxyO
	C3t8tl5khh4xmUPNjqor9cYAmmLFmAQm+lepS5uO8e/uyUJRL59A03PzmfSBskFNGOdtOl
	PDEoDtmQX9P+uPeIwOUojhnfBUA7q74=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Z73NhQEGOv-RuZPFw9HFrw-1; Thu, 16 May 2024 00:47:45 -0400
X-MC-Unique: Z73NhQEGOv-RuZPFw9HFrw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b9e0939124so1244859a91.0
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 21:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834864; x=1716439664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+hSQ+Eo3s4/YSUffx3V0qw21OLsNhzKiR+hK/TFgUw=;
        b=L35TPBcmDjXW+KY3wiztvfadKQP0Y5O0yViWW3YfnEeLEF97j0zpBy5QFwUD2JKr1N
         qAgaxVwpgURKE5hbaNDXiEh/FX3ClN/P+pAt4HTFZ7Wf6r8o6aXKpeJ/W8tdUkgvHNC/
         b6mc+Ed0mSSgl0BbKi9ZxXJUzC7zAUsyWWTS9QfM6yJMRt72nAed2ZXVPYjKo0uX6p8o
         +GK6JFz+3XybhF/ZhOddMqSqwBq/A6H+osMoJOyV7TJfTIRPWgVxW6ARVDLbrA6UAT5f
         z+skebK+IfjNrI5k4ghfq4vj3q+AibkEHsL4YCGNwAabWLaeDEMccLG2hM0jerRpvWU2
         RG2g==
X-Forwarded-Encrypted: i=1; AJvYcCXDAgWb7aqx8BaVyZdRlpushSQPaLa9EEno1efvXEin99DJV+YO7sPVzqdey1IyTw8elowK4ruCJ4VHVcoT9Go+3Wv3o3kSq0+TdjOZ9D4=
X-Gm-Message-State: AOJu0YyiQquUxk3hErk92j4yT1i56uHjoyIXZTaHXgo90Ykvt9pcuCBA
	SIVspu5tTa5k8Mjo7XoErGctPGuUXbStpJEztHvwftdkeLvM9JOBQ3WcfwaKDEZH4vMuwyt0U1H
	B91WbRihfPONBp4TMK+h16EbCAtzH8H+6zkpVdbWv0AoTvQBYwKwd8KeU7K69ndpabtQO3gR1Lv
	JoiLiQw+0Igp2GifIjtQetufOSGarQlWP1q8Lpt8Y=
X-Received: by 2002:a17:90a:1549:b0:2b9:44f2:eca6 with SMTP id 98e67ed59e1d1-2b944f2ee4amr8182196a91.25.1715834863957;
        Wed, 15 May 2024 21:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE2c51njQXV99PnsZamB8UQqh5DsdrmFenPfs4PgLHNR0d5D/evzbeZaQRgsTeAj0DTXb4g81NcXQohepW61I=
X-Received: by 2002:a17:90a:1549:b0:2b9:44f2:eca6 with SMTP id
 98e67ed59e1d1-2b944f2ee4amr8182182a91.25.1715834863559; Wed, 15 May 2024
 21:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240515163125.569743-1-danielj@nvidia.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 12:47:32 +0800
Message-ID: <CACGkMEs6dcPvgrscYdDyyC7i5qHZ8+BcbGMUhKOtaec_+UMyOw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:32=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com=
> wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

