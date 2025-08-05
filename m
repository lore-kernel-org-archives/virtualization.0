Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323A2063FD
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377265; cv=none; b=Sx8wwTH/46doVKtqGZ7C5Ppw+5rAc7QGqtmqf39Yv/hI23UIxQLhk3IJum7WtAGRyg8BVIxXrVxLSs/DTJT/OZQLKkL3TxPqDiAcDNB+7sqflyxHDziEfal3xO0NmBgR37P/7OiUDtmF+3PfP6nDAQSb7j/kPaHYNwLriOhNPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377265; c=relaxed/simple;
	bh=ygCeSeAh0m+wHTDyfFMhYQdNXoKy++DrVVWSwBZlVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FXQ8HvfVU2r41o1cZa7RExfptDSET84cE51C6vllTJ0fbT9xQ3Jo50YWF0G8IyKjY1yuYJyTarl8Ud2PjY8ntDhNvIXdI/FsIB9KNVgecQ+qpq4gr6TCOKJcePKYqB7YOKXYQt/8i9NBhTB7KFEp4jUB6Lcv2pmH4RLNLzCuyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=em3MNbut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em3MNbut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754377262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSIbGepWdDgc96njCuHhSUJPUf+KzluXS7gRDoPBvAM=;
	b=em3MNbutoTNo2BAB8nE22QYAhUJu62kIfUkskfAvxFKKlwX/U+3SaWZALTdTw+bJFlIvYD
	CAwknnc7fUOUj/0X9jjUZSArob3MDnqiV6LkhCUt4tDne+sqfkMsDH1rthxAaktwZxGe+O
	FkduSuHiovqFi38YMx5gylNrr+suaWQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-59H7PgI3OOm8m8-j9Lcw9w-1; Tue, 05 Aug 2025 03:01:01 -0400
X-MC-Unique: 59H7PgI3OOm8m8-j9Lcw9w-1
X-Mimecast-MFC-AGG-ID: 59H7PgI3OOm8m8-j9Lcw9w_1754377261
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c7c30d8986so1232686185a.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 00:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377261; x=1754982061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSIbGepWdDgc96njCuHhSUJPUf+KzluXS7gRDoPBvAM=;
        b=Ph0bjChHBNYl13iqGNIw3/aItrGrb+RJQgtWTNL0cP4GvGmOBwZSo8I0Ra+upuHyhm
         u2ebCAV4uXTVg5xaJwSwG5Ey+pHT5TiqEmJvDVvge7IWztcCAUl2nyOXJAFm8VuL8qgJ
         dnFZ5n5H1O13dLRaJkFaj1nyv9nFQniBLPHeoK6seFsBCkwjoUj/nZ7jcFUW2nLqw2i3
         lersQvt1edy9s6K7kvD1vaK283ovyGs5QQQwZwoacRyfpj0L9XIv2dnrEtS6ZiqEW2ze
         c/Tspwg46xczxZZm+a7KmKFALkQ+t7lkUf+2uJTBgx2ctQHF4fe2nQEg3QSpn1rgZPHQ
         O2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCX49iHbdYo67zSnBKIT6/Wt2TWmW1HmuqE6+XXDijd/Jp2HQWV3D1+IbZnqPHyC2ua8pVkeFQZiRt+UPpbXyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHSoM6gIgOvLAzG7SjLc5/lTar5sFDysU2sA4LFXqHvkBDjTNE
	rDbl7O4LyPw220yT8YWt6BrGY/bgu+x3anX+2f4EJQfTGZ1EZOuxadW80BXyfAx9ABoReVSoTzc
	LzJJHoSec7iWsrhOswZObWp7BD3w/oObaBb0usky3jyKC/WDY0cYeJBS6YcJnl0EMQ3bp
X-Gm-Gg: ASbGncuzG7+X3LVL7b2b5jp0K8a4Yz76IkutxGuTTQZM5gfLIgWMPYqmqmnns2J57ui
	WSnvheVsU6dNmPpDFBR1DaLfwROg6LR3PjCgpNOYFE72OaNB+Uj1DdiWPWi3XmdGr/xDDMgjut1
	AAI/vvyQKq5Q5ro5eBcKOMdZqdFOYT59lNKp3gK6hMwAG0LSejgBrJRhblbglVFAwX+0NdG2oxF
	vUCkP+JajoGKqN1oOHC87K3oZrgzJsGrmBPwg+qqq50M5RcsZEdg6j4oMCaDtEl8oGP1jj8NJMV
	StwayZ0as3KkXdlhSJGHF3w82/gwJDFAu8pU2NLaq+j/V067TqNmMB1uYodXxJ3528VqDFiFGMR
	NJGlHn2x6IgvVA6U=
X-Received: by 2002:a05:620a:916:b0:7e6:856d:bcb with SMTP id af79cd13be357-7e69625cd59mr1302046785a.6.1754377260567;
        Tue, 05 Aug 2025 00:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbo+rLta4n3tR1EMLfUV+fq1PsfLHsTA6oRYI7oXpPQbjgFFKmF+wjy0WLjzOdJ4+LHAbjcg==
X-Received: by 2002:a05:620a:916:b0:7e6:856d:bcb with SMTP id af79cd13be357-7e69625cd59mr1302041885a.6.1754377260042;
        Tue, 05 Aug 2025 00:01:00 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5b528bsm637184485a.21.2025.08.05.00.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:00:59 -0700 (PDT)
Date: Tue, 5 Aug 2025 09:00:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: bsdhenrymartin@gmail.com
Cc: huntazhang@tencent.com, jitxie@tencent.com, landonsun@tencent.com, 
	stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Henry Martin <bsdhenryma@tencent.com>, TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v1] VSOCK: fix Information Leak in
 virtio_transport_shutdown()
Message-ID: <4sbamls46k3dxlqgreifhhhd66iaosbeoxgbpyvwaipwlnwiba@dep4mseknust>
References: <20250805051009.1766587-1-tcs_kernel@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250805051009.1766587-1-tcs_kernel@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kzDp8gunyYm1Azow6aXsQlOcxISwZGooWNWz5hcc9XE_1754377261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 05, 2025 at 01:10:09PM +0800, bsdhenrymartin@gmail.com wrote:
>From: Henry Martin <bsdhenryma@tencent.com>
>
>The `struct virtio_vsock_pkt_info` is declared on the stack but only
>partially initialized (only `op`, `flags`, and `vsk` are set)
>
>The uninitialized fields (including `pkt_len`, `remote_cid`,
>`remote_port`, etc.) contain residual kernel stack data. This structure
>is passed to `virtio_transport_send_pkt_info()`, which uses the
>uninitialized fields.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: TCS Robot <tcs_robot@tencent.com>
>Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 15 +++++++--------
> 1 file changed, 7 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index fe92e5fa95b4..cb391a98d025 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1073,14 +1073,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_connect);
>
> int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
>-	struct virtio_vsock_pkt_info info = {
>-		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.flags = (mode & RCV_SHUTDOWN ?
>-			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
>-			 (mode & SEND_SHUTDOWN ?
>-			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
>-		.vsk = vsk,
>-	};

The compiler sets all other fields to 0, so I don't understand what this 
patch solves.
Can you give an example of the problem you found?

Furthermore, even if this fix were valid, why do it for just one 
function?

Stefano

>+	struct virtio_vsock_pkt_info info = {0};
>+
>+	info.op = VIRTIO_VSOCK_OP_SHUTDOWN;
>+	info.flags = (mode & RCV_SHUTDOWN ?
>+			VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
>+			(mode & SEND_SHUTDOWN ?
>+			VIRTIO_VSOCK_SHUTDOWN_SEND : 0);
>+	info.vsk = vsk;
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
> }
>-- 
>2.41.3
>

