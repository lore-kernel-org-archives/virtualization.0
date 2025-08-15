Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9D28C2BC
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236321; cv=none; b=iERNTg0EUC6x1vpwAKKcp/D3YBxxR/l/6o7IQ5zhi+Hb3b/5SHf2VHONksg7hg3WX6sI0Iev+1tQuLGI1iIMAZ6o4FLhsTVCC/i+Kt7yusnWYPciKelqXoA3vo3ZlYfxmjIuzIjse6kMivNLSdlxX2hbuga6nY1LO1/0mr0uKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236321; c=relaxed/simple;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAmkiTZg3bAB5WEkj8BOljTEc7T1vhiukDDLb9lAnQWRoQY0BAB/E/na1vohVR93EfkUwnGbP2g1Epfxn2gv6t0AZUA9AM9GX3dXDoOZOVKu04Xo4yR5z11H1uJoqx575J+Y0slUGiafeXtwCoQfYgzeLsye0Um2/O46kyqZkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg4oYuM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg4oYuM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755236318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
	b=bg4oYuM03qICeF/ha5yrS0bMYx3Ses0UT6ZH2+KmgNx47k+FA7wjZx4T4CxhfCy0BN5mD/
	A4menhSjMBrgE/0INVAeRrcgrO2O+IX+7RBN79PiNXZhgTlWyf7AuD2aOLNvgUsyHbBK8q
	cK0b7Z1KB7iEOY9HlmmxjV0LpZnOhj0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-0Z7fMUb1OYWXDehOaJVyzg-1; Fri, 15 Aug 2025 01:38:35 -0400
X-MC-Unique: 0Z7fMUb1OYWXDehOaJVyzg-1
X-Mimecast-MFC-AGG-ID: 0Z7fMUb1OYWXDehOaJVyzg_1755236314
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458067fdeso18163565ad.1
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 22:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236314; x=1755841114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+R2H99bfh+BH8niSXXyRR5xbh5Ki0lvO06FVlwDvVA=;
        b=adpnWbuN74vjV4gH1QUI2HanCPHVQyU1Sm1ebMYPOJ0pswlBRK/Y/+16abV8VNTloo
         CFnq1SU3XMI4/81/bNLROVC3HI2ucFduP/izGwhNg97dW+ynYwkXk51Z6T3KMhkVilqa
         nHqvJ42wpEZGS361Znl9eSClXvaKU0iOCOwby6FDN573CMgl7TONL+/He6K7dekf9tc7
         xT8LnSpOJwCs19FNOHZCaVyCMv4mWlfAd0wkBpMCp0yXIOR9ppioUC//OBVaMM1R+UjO
         EQiOIU5krojNnPZ/jAqPdh6VYCn32OC++k1qUefDAzN6yfqZMWCWf/+ImVfkVbGZTCnm
         Jh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP8a1JbLBGt3NW/pl65qeFgqXnsQCx/Qox9yc7vGz0b9k/+wy1oJkmqIHKds+hhAVazYEOt5bDvUB7f7Fsjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgM760KVwcRxY5crsWu3knSUjGoQM+YPj/NtAcn5VqdV/VNe4L
	phOCIMEujdLGtcKZPSfg7oC0oXuAn7FuJ84HcCuXma7NESLHIiIHGDocKV9PXmSQ570k79U8dPz
	zdmGNJi0VYniVQ3OOZmyWbsRkJDOeopMUL+0dOhGt20bP2R4Th0u1j/LH+IBIgdadVLZhydQ8js
	v48ckzlizB8vWjDdTN6msGFbTLqbakrUtfZaDdI0HAPgo=
X-Gm-Gg: ASbGnctls1/13jw7IFTHdcY4/hRf9z+tKblb5nhhVq/vgbRH9HJWaSEqpSpIcJDvLp0
	npqJ6neOSleiFlezvMbFlzxMTZ1n08h+o4t8EMbJT4BEOJYTzNqVtYfizfMJ4dsUX5ZHMt0Ef5e
	u/dKdwHL7AcmIk52eGbB/YBQ==
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id d9443c01a7336-2446d8ef2dcmr14827985ad.46.1755236313892;
        Thu, 14 Aug 2025 22:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNF8ixWW+K/UQ+wsBh6Kk+3CTYVr9Miz4ZwB26y/XjbpOCpnb8qBRzSIZa7K8FyWNx9BMFUAKlBAn4MxP1R4w=
X-Received: by 2002:a17:902:ce84:b0:240:5549:708e with SMTP id
 d9443c01a7336-2446d8ef2dcmr14827585ad.46.1755236313492; Thu, 14 Aug 2025
 22:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e@epcas5p3.samsung.com>
 <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com> <20250815022308.2783786-1-junnan01.wu@samsung.com>
In-Reply-To: <20250815022308.2783786-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 13:38:21 +0800
X-Gm-Features: Ac12FXx0bLK4_QgLg7PMFy71tElM2n26_1WoRrHpv6PfQj0ttolriEFKlqdwaoQ
Message-ID: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3kdbxSyrXgn-zffqfgGNnPkfKbM1CfESvTAeBJT6wZs_1755236314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:24=E2=80=AFAM Junnan Wu <junnan01.wu@samsung.com=
> wrote:
>
> Sorry, I basically mean that the tx napi which caused by userspace will n=
ot be scheduled during suspend,
> others can not be guaranteed, such as unfinished packets already in tx vq=
 etc.
>
> But after this patch, once `virtnet_close` completes,
> both tx and rq napi will be disabled which guarantee their napi will not =
be scheduled in future.
> And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `ne=
tif_device_detach`.

Ok, so the commit mentioned by fix tag is incorrect.

Thanks

>
> Thanks.
>

