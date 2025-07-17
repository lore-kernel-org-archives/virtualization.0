Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC331BC58
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717759; cv=none; b=Ihzd8IbaNcFCx/O5GA+LVxvJRqY6xPx6JWKCaPFedhjvZOm8MA/yRNlhp316FT/QWxdVnRfuzRQ3QV5KuVuHTYNCfHPhMZjJekGOc+ciBaMzkUrfBoWpy5p/kmEASmi/7PP7h6IMzaoAmRDNLFN18goz/AUeFcMpWLh0tCyPHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717759; c=relaxed/simple;
	bh=0GZHNVlrO+mmKMgTeSzkW0wKBWAd9//7yTO7Ox115SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3AVNFPSv8i3JVNnq0ff728oAQBzmqYdivL37mGFbEX4oIHdbH9mmOuM7W4A6b6LQwGplpUE5A/7kA9WzKLs0j+pocY5s9/YtgM+vwHV5wozw0hFY7Prj0R+2cu+cQaTJhZ/T9NqdoqGnOkaNDXENC5jWLaQA88lv4GFyvT3b88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0PsZeN4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0PsZeN4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
	b=E0PsZeN4qysR/ByaMUD/e3h5JYWnjsnnlgBKShG7C77lvnhbQ+ca6ZVJ23Sx+7se2h27vt
	jcvffnDesWVOogz5MIkQUc1cvtss8Ao5Rj8aBUHBLj0r4ZxWNC3RGguBP0gOXkr5ko+Kvn
	81vPi219tBmpcBVKYAvDEENfSoJ0QBg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-WOqPSFDmPbyI6qXR7oVTHQ-1; Wed, 16 Jul 2025 22:02:35 -0400
X-MC-Unique: WOqPSFDmPbyI6qXR7oVTHQ-1
X-Mimecast-MFC-AGG-ID: WOqPSFDmPbyI6qXR7oVTHQ_1752717754
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313f702d37fso623731a91.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 19:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717754; x=1753322554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M14DsGiQtqzXQpY818urP9W5ujH4yY77Exoy3IyUIdA=;
        b=XZxVfI1pLG2StzlWOH9Q2p/Z17x2XFM8y6Paj3WVKz4nzMVZtJgdONuIUOX0JH2HXZ
         +aAeWim9woRz2GUwaMdDQKmTVC5org+PTE3gfih14Vq8RK7EcXNonfhfzIiYNx5Rrii7
         6LAz4ghEVUIATuEP2aGda41Bkp0Ka7ikvPviZvC4Ipf2le+bzr3QYHvR3Es2VP1k50tZ
         XIW920IgwdTPW6N96W22xKHG8C//nEJsbiHjTSTE86N5wc8MSpj50J1zQjTfutBHMw7x
         BtzanGfF0/heUR8iyEoZ1lb0ilhV4nmzO5Oyvqdw44IIxSPNxZIi0qH7gRTfxw6VG3HS
         MeIw==
X-Forwarded-Encrypted: i=1; AJvYcCVzHhrRvZ7b6azJOdYOWs2hwTHyCiISkm/fQdwYSnR7ggkOaUlvNjsLHv4nC6f6bt6VodrA/jIR1KGexbrGPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFpD3B9ZPt5DY2JZGxlwTqMl/Awb66W0nSIeUOM5GXDcjtoBOp
	nTfRtsyoc7t/2Lu0tYhT9nhqd0g5yIF9KbjDfe836emvTJbzNLGIjAwx+ccPuykpwBnUTPYc1tl
	bojtJowQtIG70Kk/MJpxE+EJSflLBOMd+ZKbpPaCyK1O30xFse9zsS0hxyRtE3gibAYwx7WbH4q
	2geQ0K+gB0YWteDZitjbt7JcFlBZRgmE/tfbLxXebojKs=
X-Gm-Gg: ASbGncvfeozkRk392mjuvY4/SykvpuxgtD32uFAZuf75PJCX2PLm++j+1tX6cwAeQrF
	h71VlHN8KPwyv1M/KJmxPX/FAUvQO9dsy2sAdWuf6+50pY4WAlsNiRjcr/DEsTnMHubXj6rvnrF
	LFpaNDiH09HGZhFsoOumsz
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id 98e67ed59e1d1-31c9f44bc2dmr7521580a91.10.1752717754216;
        Wed, 16 Jul 2025 19:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5iPUiqqpQyBmPLZCPtjid1ls/tJqR3WHYd9f5uSW/9kS6qJ/9PczlVKVSg/orVJ4W9fRrd/6H4sTsVPc7n5k=
X-Received: by 2002:a17:90b:1fc3:b0:30c:540b:9ba with SMTP id
 98e67ed59e1d1-31c9f44bc2dmr7521534a91.10.1752717753774; Wed, 16 Jul 2025
 19:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 10:02:22 +0800
X-Gm-Features: Ac12FXxK3fHuuCF0pftokODGN7tkaUVBIGycjF0F-57Uypg4whIM51FXe-X2b_o
Message-ID: <CACGkMEsSD_r0akWpsP+Xa4_CvCAEVbF2cQ9GrE6VYhZ7m2C9hA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during probe()
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vUx2y90bcrhm0k4b7oAFf89L_eDxLY-80HJbllIwzdM_1752717754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:57=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> =
wrote:
>
> The deadlock appears in a stack trace like:
>
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
>
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
>
> The config_work in probe() will get scheduled until virtnet_open() enable=
s
> the config change notification via virtio_config_driver_enable().
>
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state =
on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

