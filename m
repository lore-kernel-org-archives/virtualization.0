Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1625A2B5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Jul 2025 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859545; cv=none; b=DBjtPQpxFMBlChqZO6s/ysxVA2yoStKJhMQkA9ezPgmGtVDQp28EiKuXdnoFbdneINkrbOBe/Tj9hcYerAmsmgCqJPL9CaTiLOVSbPnrWcYf9X21GrHudvfC2LynV8NhehJy9aZDZ0/Fj5H3Fu9RORuFqJVr1HXTyJHrrLEufFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859545; c=relaxed/simple;
	bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTo9wqUm/ahLvGljUhTmPNwa3l9RGY5V3geL/4w2zZWscwYaDcmQ/TZ6AY7Gp9uPpF7JOZVWu0BStmN+9bHETMvMj6vwjF3034NHIz3qnW90jcYNWd1qgaD6GBdRRqRByMGZbHdwnzwV3jfp3zCERYMc4rjn2lpixsNBQY4Fscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+hz+iNq; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+hz+iNq"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F09F40053
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Jul 2025 03:39:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SCvn7lqxEOxN for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jul 2025 03:39:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 546CE40182
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 546CE40182
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F+hz+iNq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 546CE40182
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Jul 2025 03:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751859541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
	b=F+hz+iNqpFR5zX+hdW73Rq2Gwj3fxSQZJQZJvCrL+isfNclNnQZzXwWy3FNURADIUE+EsY
	UefGbU0+1OJml6CGotDFumULj6ImhDiUapE5VbndRmlwWycbpL7JGth53xhb+NIdAguV7t
	4Kp2YW/xOzKDcoZY/13LpZjbuj9R64c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-ya1cVJ96OLqjb8ixWBHYVw-1; Sun, 06 Jul 2025 23:38:59 -0400
X-MC-Unique: ya1cVJ96OLqjb8ixWBHYVw-1
X-Mimecast-MFC-AGG-ID: ya1cVJ96OLqjb8ixWBHYVw_1751859539
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31c38d4063so1659000a12.3
        for <virtualization@lists.linux-foundation.org>; Sun, 06 Jul 2025 20:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751859539; x=1752464339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cToKybjXtrPshKXsvriTLIFQT34mAn7DrvDWsf8sYmc=;
        b=emtfA1SxhZPy/Cv3JMZI1jEosJX27sdcUjvtDm1lukr/nk2aw1xz2nne9MLbekDBuA
         IEKTq2SwsWUxdyOj2Xjt5BtJH8zGgDzG7aqRUn1IFYHG4x+W1Xqo6x9BjuNtHb/FNJOD
         ulHe5dMcOnM0A1GijXANJC5zfp6D5PQ1gW/QSCFZ3tozbWLIQhL4k9kgC4d/GfdJdlzk
         IkHF+n7UEuR1z3i2By+QjyvykmBDjr9+7DQrTXHwBsIeH/kdZ8Th3B9WPxTdvt20/2iZ
         ObxKr1zwC0iERXm6DKlSSGe11zwiJ8unJsZq/UVn2zaOFXVdQaNknxfMpcnzLRbawkGl
         jHFA==
X-Forwarded-Encrypted: i=1; AJvYcCUc3fq0qwhcFF9m+jOXT0tOsd0ZRQLRZwipkiHo30Kt0zCd1ibS2V6G3P7K6SYV/BfknvJdmAsXV3rsusScoQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxM6ZDVFf6Ss4zr93DXc2YaIVsz0taQAmR47/YEUihY9RCHTDRr
	D28NmHiyOq6fh+eN9Zvjcm7satqVABYOQ1yV3oh3XeiBHBzTxZ2YyxPmjUjI4swQmGEyghNexLv
	Nmtk3K9IYGQuq27lboCpXK+G9zO8YoeW50hCOnYBj2Gfo9BHumni46QIdUZ0fBRUYROzZ277Rq9
	asI3z2RclLzFhAX7qbGjDgG9fPB4blVdJ1/Gjz71V7M2zwRntZvBYgpYOTQg==
X-Gm-Gg: ASbGncvwjcvWDNaNSJzht/kpakGFMSwvbuVmvfwFLssYyCSr8V9mldUgYZfHTQbpLpw
	3Pb6WaBwhszWS0mHpM/aGH627x7CQDWZxAV2EI0PqH0nR177gkgdjF0OFXEtHLpebvP8u2Igr1G
	KzqJZc
X-Received: by 2002:a17:90b:55cb:b0:31c:15da:2175 with SMTP id 98e67ed59e1d1-31c15da23cemr1276675a91.9.1751859538650;
        Sun, 06 Jul 2025 20:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OScOfzxvN6ffL+e+JM/H+J3/JdD4csUZUpOcHgC06UuyYVCjZh3kPiyRl4cX84Tq+BwKAeQqS9ePIWOt/tw=
X-Received: by 2002:a17:90b:55cb:b0:31c:15da:2175 with SMTP id
 98e67ed59e1d1-31c15da23cemr1276643a91.9.1751859538244; Sun, 06 Jul 2025
 20:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250702014139.721-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250702014139.721-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:38:46 +0800
X-Gm-Features: Ac12FXzRSQJDauDNVYKvCZUnjp7a1__tIs86dizLjOKq_h5WbWMweaIbaRJmiis
Message-ID: <CACGkMEuxSsJVkvNnGGZtrK=MOyzc1ajW+SNR-xP_XzO5=R25jA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ujkwsCvfb9F9mhj_YDiT7IVEcE0NjCfHl07gJnhZTjY_1751859539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 9:41=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

