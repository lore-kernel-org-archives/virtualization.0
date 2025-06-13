Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74701BFE00
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775351; cv=none; b=D4w/Cciey1lDYYbSfY/qSBqV6bKPvmPUB1oTUOOw0wWoCPAJsQ6ihOMxpOv6p+q29Jsgs2wGK9RnyjW/qkUiUWJ1iwT70MQcSzdMJD9fPSKAm9lBcUX3TLNiizP2Ny26b9dNdQXYoCZtMO1prqbnQOSWIqktzDUZBbXMCPM4Lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775351; c=relaxed/simple;
	bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmDXiVKPvegeCykhc40HfSYjOsa4gd0fch1Htf5PbtN5K8ENsTjKsTUI0NSfD9HXvin4/wJ+os5CmhpAZLHwLNxSs+gnsbACrbGm8y3Pws8VgsdawHdcIfRm3tjUjqwVKB09za0iKbzfH7tlASZiqlnBztqxSvB/FdTHZ2kiFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMFcvSjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMFcvSjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749775348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
	b=RMFcvSjZMZyoBnBCXTyNfeAZ/2Ztg3WaXkS2KnM/M7GRet83s3Yx1rksg/IPPpjbB8Av6y
	hZ9fGQGS8R8BkqsxhBIAaAxXWK4Tm7IkDvArLWW3fApISI2NQDK29AmLItGTmWXZMmNXjW
	Z5kC12o8deNi/h/5Jr8vDHw2OgeVVrE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-8B-_mjiiMr2Wo4-xxtW3cg-1; Thu, 12 Jun 2025 20:42:27 -0400
X-MC-Unique: 8B-_mjiiMr2Wo4-xxtW3cg-1
X-Mimecast-MFC-AGG-ID: 8B-_mjiiMr2Wo4-xxtW3cg_1749775346
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2350804a43eso23528785ad.0
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 17:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749775346; x=1750380146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maylzhN3R1kW/ohhBSyd7HqzpVdN7/AKHxThCz98Pi8=;
        b=qxivB7fOrfrya8t0m9tDHRg4gWZ+Q107DpUUmNI1y7RuZQl3roaFaHmgt9N9wXT0Gm
         8lDIZMraZydO62MRyAhaN5gG8uJySlChkHuOVigdJRxNGzJbZxPKiLJZOuzCVF1bYSU0
         MogqA5kPrlwLHX6haGc3JWDlbteocDI2woE24N7pRwZzQy/tbfBWMdtWUTkRLNc++6a9
         tlJMX7YatO/qvTTqz+KIFqu49cb0Ksqo8hrsaWpxCNf6Q7exv8fMqc9q74e4t3iWTqR1
         Wk3y0bTjF6wlZMtMS+7RPH8DPPXSk9JKrvvSevJ3OhSJ5n8jgw7i1Idf1zYxps871IFY
         KaxA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZAGXiwYfiNaUZVdY6QifHLUnwqqBcRrS9xoX6G2w5JDPV90p57M8DYZslJaVr2Pt9/p2RfDvmU7lwGk5Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZceMftUf3bnUrSe7SM4nJvPXIMva+bMoUOU8ClkLjrBvJEf0B
	DqsCgiVPxkDWmj0hTQ1j3C7eo5u6qOfnUxrFD592QXwQ9mQSmJXExlW24vaqc5HzzgZKzi94CAA
	gAp/ic/vjZGrQDC7wLxGvfV4H1syEcYfqk4b+KvlY3IVowNtpqkctQQWP+p6I1YXow2kyATtZJj
	fYtalAilgGUbvf94DeM1Ef/B8Hoqwzfdlf0e62CXKG9zI=
X-Gm-Gg: ASbGncud/jwar7YMFoJK7ow7Ol0JE0ugPCu4rDrfXdAb5cNLTdP3CYBi2kA+HvpN94v
	ZdLpZG3mOPDhl5Xj43ctj57nBaBUeHIXbrAve9ViGxe9oLGZAuVm3c8kgAh6z0sZQFaQRA6CxX7
	We
X-Received: by 2002:a17:902:ecc1:b0:234:8ec1:4aea with SMTP id d9443c01a7336-2365de3ffebmr15643925ad.52.1749775346547;
        Thu, 12 Jun 2025 17:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyAdb9tOchMbc5VNkQkyQSUnXYNZ2kaRcZWI02WcZBsf9KTCg9tOz9NPCpeq9Fvd5gqgpmYLmy0vfEXIRGarw=
X-Received: by 2002:a17:902:ecc1:b0:234:8ec1:4aea with SMTP id
 d9443c01a7336-2365de3ffebmr15643675ad.52.1749775346178; Thu, 12 Jun 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250611145949.2674086-1-kuba@kernel.org> <20250611145949.2674086-9-kuba@kernel.org>
In-Reply-To: <20250611145949.2674086-9-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Jun 2025 08:42:15 +0800
X-Gm-Features: AX0GCFtduX1ZN2Z9MpNLZYiPSNj2kJDaR7Qwn7qrUaaQEilxwRPmYc-DFKEweUg
Message-ID: <CACGkMEsDmQc-zcSpKSC=ezfTfVQNayZDHC2VTxRvrz7qZ_+kgw@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] net: drv: virtio: migrate to new RXFH callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ecree.xilinx@gmail.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EGwDxKdgeFlcUhIxmljGy5pImHGcTakHOEsYUlIDC_U_1749775346
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Add support for the new rxfh_fields callbacks, instead of de-muxing
> the rxnfc calls. This driver does not support flow filtering so
> the set_rxnfc callback is completely removed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: virtualization@lists.linux.dev
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

