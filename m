Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8051E32C3
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Jul 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479711; cv=none; b=aSUBo7LDzzDEBqtEN7GKtIzgAxFx3lKhAbCeJd+25TqthlxzvIL2zowikZs2OHk2CsC+tKQ24TQoFfyKP+pGjzhI1+1sSZ6sOSn+l4jRBCYGc84LGVMS9nN9k6UySwU9de6Igh2fVKRScVuyvYcjKeaecxi9ePFfpDi+9zDR5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479711; c=relaxed/simple;
	bh=tiu2nK+C56Y4UTXeDLT+Tfbmtgme13MZm7oIc8lWWM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfaZ+Dm5PXpK6JzdBEAH2msVxgJNbqIpESPRT4E/+KXEZ5LcCRG7wcfKQDNBz9/qPITn3Y4O3Gd07atyo3LKhEBn4kzd+pgy2xltppDNwLEruEqTziYbol/6moLcuiA1EMSlFrUfsbrYAiGQtscN5AyoPNxcqy7tDy103Dboouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itboC17W; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itboC17W"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5ADF840053
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Jul 2025 07:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zeXhHQjQy-qV for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jul 2025 07:55:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB6514031D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB6514031D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=itboC17W
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB6514031D
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Jul 2025 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752479707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
	b=itboC17WAaWE6a+4LblQ7Y7SqWyyiWoC2N8cjcimILDqMG94KbNmaupwAl0AOLkJXM1EBl
	9qaoeYTzVeqWDwkjHvwTXaYUZ+qS3MJTw++BlnI5ilF3IDOABA+ukCP/qhXIdV2+qD6I6J
	WrecUucX/MDlCxHiwJVCIR6yAcwv2RU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-C8XL5mMzObK2ZDilduauJA-1; Mon, 14 Jul 2025 03:55:05 -0400
X-MC-Unique: C8XL5mMzObK2ZDilduauJA-1
X-Mimecast-MFC-AGG-ID: C8XL5mMzObK2ZDilduauJA_1752479704
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so7454933a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 14 Jul 2025 00:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479704; x=1753084504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
        b=IPZKnwLiFOAwJJGjxmnTwSfqEsjCqmu0K99YYC0hKRfWVRNcGhDNgfsIhpffgbquqP
         75IAUMQ2E9f4gImC5B54p2Kbm39fgx7fSB1/ujJ8m+6UpacxVK23hFHVpZ6NQsNIy86V
         G1X3Oo6k3a/PTsrzA4jDoKMV40D8L6a2/OFO+9flCGmISLWQvYWjlh91+5YT4Fe5+jYy
         ECqMEUhawBYUPLOWrwmXO/WEtPkrt3BX0YeA8UaKHlVMaj64UAmbPtLnRv/w5XKVLPbv
         d9WQOw8kImqZJdKrO/7vfzI8gEUfkZLmAwc0qpgIXWTzn90zysN4ZBy2FIeDIg0vvtXB
         jQaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjcmcj98sKfF7xoR96LPh2ygwNXsL5ggruVmLZ6dB5nXqAHwell3bun/yfIIkEJGU7crDFt7637aoXy3XuTQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyHCoMeg+oUgmWO5nwUwuKVacl5RUeplwgUZ6BfG8G9Jcqi++l9
	LzlDSxl3Nbn5qMV1bE8i6LnSZ9uD9LYJVI01btuaX0fidvAcWOHM6A3uTYEdfYRNQxpjbg39Og/
	3QOKCEvKDbzemujQtxX2G61k5CJNPalbaW9gXML7u5+KxWFRJ5TkKXxw/9EzAUFDe1MQqMEPVLn
	mXXsFGgtZLoGJgpTxumHkyjDKSmqmLEFxYHTjS7qKOzYH+hZCkqlH4A2ueIw==
X-Gm-Gg: ASbGncssbYcZ5bcUYKDZdF0iVsyvnExeJpnhbmt/ilalRyENA/42UjDAq4kBYAKEBDm
	v9xxIe8TNmpK2DsOxs2TnSqJ7GyG2xvyhRFjfRZ/mAK+LW9hG7fhbFL4Sl8o1nByyWqT+hcRY/8
	+ltjZfCo7db9ZCNFhPucLh
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-31c4ca8484dmr19569352a91.14.1752479704464;
        Mon, 14 Jul 2025 00:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnet4rC1xgcXEZ20xYgQVBr3JRR5R4FOhA8hV2O705o81pURROYmMQvBTkz/PEie7bN+76RHxpnjO5by0g3h0=
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-31c4ca8484dmr19569328a91.14.1752479704074; Mon, 14 Jul 2025
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com> <20250714071333.59794-2-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jul 2025 15:54:50 +0800
X-Gm-Features: Ac12FXwOxi5XmIWDjVBorqVT78hYR2jMNPSkm1W_ckD1RqpdpvGkBqoo8WdhIzE
Message-ID: <CACGkMEvZthxg3x=SLQMj5t_dunnuutFm_8ZZiO1MiQdWGqx9Cw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2fC2DGBIY0-T8cIuTVMH8k1hxvSpM3CKqepv3YdDquk_1752479704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
>
> - Add 'fork_owner' parameter to vhost_dev to let users select kthread
>   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
>
> - Reintroduce kthread mode support:
>   * Bring back the original vhost_worker() implementation,
>     and renamed to vhost_run_work_kthread_list().
>   * Add cgroup support for the kthread
>   * Introduce struct vhost_worker_ops:
>     - Encapsulates create / stop / wake=E2=80=91up callbacks.
>     - vhost_worker_create() selects the proper ops according to
>       inherit_owner.
>
> - Userspace configuration interface:
>   * New IOCTLs:
>       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
>         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD=
)
>       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
>   * Expose module parameter 'fork_from_owner_default' to allow system
>     administrators to configure the default mode for vhost workers
>   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whethe=
r
>     these IOCTLs and the parameter are available
>
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
>
> This partially reverts or improves upon:
>   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
)
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

