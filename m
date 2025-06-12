Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054791F4CA1
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708773; cv=none; b=LEtGBGfHWozDn0KxB1X3miWU8Zzuo2s+xS7apqBx9sY6X+aPMhvU84TVdgFW8cgUWONyuSiPRGqNc1OBv9kesrOFAJWLwUYsfw/EB//oOkK2Gxfsw7qP/uN1IhGrYqkobqvBapybDHyECOq5SlNF9hen2FOusbiYRLb4l52C4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708773; c=relaxed/simple;
	bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nV/kAsgdclGQPuaqDX5TcjZ0fYts2M0rQGmwp51L6v3Ikea5TdqBz2ZHxSCHMgURNvcjUl2W3i6wNK58rfj+CZnp48jcZN4YzMPaCNbCu1DUdg1wBeJyXiwZo8eLLNG9IkqvLXGDAfsUG8/lI8DxmJrzqkxtRGhmehOTz2UwLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFo7PDvY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFo7PDvY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB27080BCE
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsnQlDJXv9aG for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jun 2025 06:12:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1662680BC4
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1662680BC4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFo7PDvY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1662680BC4
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
	b=AFo7PDvYF2NK0MHYckJiofc4sBFl/b9wToNdnDfXkP+f57M57IoIEocSIVYHqkd8lAT3ro
	nS65bv8sQ6iKhWMUGSJl5/1+T0byvB3Wop+cCaJkt9tX+rHgsjxkPWsxeVrCHAo2tpSVa/
	uHIuV071aUA3+VmhuvW3hi8xBjR4jO8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-aWSeGLJPMryMUQV_INfxWQ-1; Thu, 12 Jun 2025 02:12:46 -0400
X-MC-Unique: aWSeGLJPMryMUQV_INfxWQ-1
X-Mimecast-MFC-AGG-ID: aWSeGLJPMryMUQV_INfxWQ_1749708765
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3121cffd7e8so589879a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 23:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708765; x=1750313565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
        b=HWV6Y11wkncav90ptk1twIUD/hdrZBM839cJmdE9o3brbVaEKrTyXZH8GlQ/cNvvl1
         ilSiirLGQpz85Pn0q8p9xVBqAsCfMWu+9+A43GRlI+5o3lSZIBsoVzv6216X8PH4RgwG
         CHwMJBJPDySbUQbb8OuPTkEKMTmylnk8Fr7cuVNj5chWTOE5aSXEJ1rdD9Mi5h94v2I1
         n6kCO3sDzvOr/ttfbKYUJjzTQSvSMZ74eBPot/YPS3c8szKsb/WUY5sU+V+1Ey7a0L3Q
         cwpfgtbA1VCYmhu/u+95oDoOEusb+dWzKj5jDdl9dtdq2XiGAqigGFdralvybvV+yYef
         Jwvg==
X-Forwarded-Encrypted: i=1; AJvYcCVIMEbruvG02SQx9KxS4MZUpmi6eV9MJE8aeDxRTf3KfGJeS5fvYpNPJFeyMyW8u4DLaRSds8cY5L0wSY8Olg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx2/gL0Dl3osYm2W/Q/URg8yNiSKDbOUNBYCfWjt73V8jA0iuLv
	OQK0DpaNNL7lgQWsIJTywkK+/zNo8JjDMiVbR9+wRYA0uSwS/6rG+3/rA+RxWvwh3p7YqhERy6G
	BhKX+pOS570WfggnNv0wj6M582ahIqZQUWKwy7OoUz5+temArprHEfxeU5s5MPYWVhNu2WWVGzp
	T80RN6bRdVS2Q8J4GhldQMG0xMB/qb4ulD+irc0J66dJhSukjFAUnzZTIcXQ==
X-Gm-Gg: ASbGncsoGC4PNhtCA3UMOiplmGN5u9fhuDfx7Ij61SCt7ZT4iJNqGE1o2uU99ofxIJd
	rWZcksL7BIft10m8D9fuKi2sP0HfQOZA7rGYeYMrwBDBP/V3nHjCxojWbrmK5TOV4XVIs5nuZy9
	L19KHp
X-Received: by 2002:a17:90b:5628:b0:311:e4ff:1810 with SMTP id 98e67ed59e1d1-313c0668326mr2584706a91.3.1749708765328;
        Wed, 11 Jun 2025 23:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8nEsPFjSfYppZCrGBwOZj2EXvMsBbci1aiHbuZSbde5qDOX/uaEqUZ1HZNfewkqJpsnTzU7HSRHu/P9/nbYo=
X-Received: by 2002:a17:90b:5628:b0:311:e4ff:1810 with SMTP id
 98e67ed59e1d1-313c0668326mr2584680a91.3.1749708764934; Wed, 11 Jun 2025
 23:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-2-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:12:31 +0800
X-Gm-Features: AX0GCFua3qf1tKF-j83aW6duXknVJEBpOabQNRyFghC9nw8Dh5yPS6CPiPjCd68
Message-ID: <CACGkMEskts7y7bCxRLoZvDbg0YZbdF59b3Jzxkgpg0KCCY+TiA@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: txS9j4ua_3aei0Kkr-KnbYdRHpR2b2agTAF2IXZVoP0_1749708765
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

