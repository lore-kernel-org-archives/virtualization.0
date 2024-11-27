Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD81527AC
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696251; cv=none; b=UPIJQtyEsFjJn32L9uIlB3y2+DsEXGx8SXLk1c0BIG8RQoAOlq04hTN3dnUUU7PKMu//6kQgaVrAya3Tp09EUapSI5uzxC5LumiMPj9LYD20ZDUV5J0yj1A3FAHNXHuYzK/sxBBa8hkO4QP7by/8oMiQLc+wxAISvLhX71vPw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696251; c=relaxed/simple;
	bh=Eoz0Q8Mkl/Pr7C3Gb8h9/rvKIVaHswPcRREVkWgCHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iIIk5fpyNX0KGtISvpeBeG8keeerTmJMMF6Tn5wdStzTuK6Jbly8L1VIclV0+nz7lbpyWpeP+z0GXhekzpXsqM4q3o2FZIXi1X8c/VgBd5BaN+x6QQqiSUoYsGYfIqRX1d15CJgejsz8FsI99VMJFwZv0xTYJ+SAic7UGh6YYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IF/06pkh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF/06pkh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BC260706
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 08:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LpWC7ySOI8f for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Nov 2024 08:30:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A67B860707
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A67B860707
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IF/06pkh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A67B860707
	for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732696246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4MUFVXWBRckkMqy36xXoK5Hu73zQLVLWkWdXnXLcAfI=;
	b=IF/06pkh6e8uwno2Nff7uHrkz+VbYdK24xuRMD/SSFuGEQxSQIuWJG8vRUvVzB8Xa6vhGR
	4+mXL+ImxaaojxIFtjpymIouXY+/x6jTJqsrx2QSK7mJuIdj++sKIKES+1eJ6K/OHqFzFs
	ii0ZGRpl2IYjA2IZhnnf4Oxc7VzA4yg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-uoCy_LrROr2rbFLKrV-k1Q-1; Wed, 27 Nov 2024 03:30:45 -0500
X-MC-Unique: uoCy_LrROr2rbFLKrV-k1Q-1
X-Mimecast-MFC-AGG-ID: uoCy_LrROr2rbFLKrV-k1Q
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a6483514so13948245e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 27 Nov 2024 00:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732696244; x=1733301044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MUFVXWBRckkMqy36xXoK5Hu73zQLVLWkWdXnXLcAfI=;
        b=iZlw8YdOJPIl+NKHqWMbn0OHXxzvvJeSHZnV3H2qIcvkUebzOn3uhuNASl10aP0Jo/
         WCsIEt2EINTlY8F1PFKcxcrDvBt++3WB/xJwl/PXxFtfPjNbflNGBdS8n7WPo33aNjb5
         51AXdPcjcoIHG7MFYux8oblZuIbuLXgcQ1AxzxzsbLuGy6vB0BA8JVfgHsTJaCdiqTi9
         mugEVyHkvPkrB/O0gGskvTaoP7NIpdKRu7Uoep+vBRGwIXfe2RIHSpNOBOJH4H1FYBg6
         pJ7B72g7hF+/0lSkH+vJc+XcwOhq7DVqUQPcnhQ+dlM5sbX6gdHU1tImbgEtCHBOZNJo
         CzxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKZMMSTqrYP51BRAm3wR6aGvatEEdt7qOmuELy8uQjTt2WF4Ukn9M5it/VY8iWgi6JTGEDND6uy3zI4qaeCg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YycmOLyqw6XzilMbDY5iH2z0BeEY4vsKOAlPHW5kMADYJ/G7G6M
	z7dd7WDET+TwWQIpWw1jctjMM4LXFgVj12uHYcjzzH9HCXZchv2heOaQSe3ilrYQdEv0XwHmXbV
	J5xQxgO9xR4JkDwR0Zn8m7AwPescHQRHs4TAzfp05kc9iGTGiN0tMrJ/8wkWZW5I265vTSYo82d
	1r+7w=
X-Gm-Gg: ASbGncvflJnUt45vnMKr6b1BTlBd9JDWJaKDw01hT1oJB0Dd/GpsKmNBej9Rl1CyB6A
	8WmI9yx4Curlo1+L7oxzcdGI/jZ3yZmovz3JvZfK1zWwt64j2qzY5DkKWWUqumHtdaspBLGVuM3
	SOWYUas5RcuE713jIDuWHKjJasV4wXPvoWc+HxIQkSdQ/SCvo3fUar7NHVWeGB01250nafVM+qH
	ATuhfbQKxWkV2tbvvHPatOL6bx+CdAIAu3Njc3gWySF
X-Received: by 2002:a05:600c:198c:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434a9db7cf7mr17738185e9.7.1732696244300;
        Wed, 27 Nov 2024 00:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2ADNx1yo7XqVN38+hjrq+uT0dwvOn8CIAZOqDBS7VnrgJbvD/98tIaKuZzdGb8T2i4UE1fg==
X-Received: by 2002:a05:600c:198c:b0:434:a386:6ae with SMTP id 5b1f17b1804b1-434a9db7cf7mr17737925e9.7.1732696243978;
        Wed, 27 Nov 2024 00:30:43 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f6:a902:b9b1:2d24:8c60:30dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74ea95sm13552115e9.5.2024.11.27.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:30:43 -0800 (PST)
Date: Wed, 27 Nov 2024 03:30:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	colin.i.king@gmail.com, dtatulea@nvidia.com, eperezma@redhat.com,
	huangwenyu1998@gmail.com, jasowang@redhat.com, mgurtovoy@nvidia.com,
	philipchen@chromium.org, si-wei.liu@oracle.com
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20241127032948-mutt-send-email-mst@kernel.org>
References: <20241126163144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241126163144-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UVWAshHGjMvD9_3l87fNuqYUhFcXCN0Pe2vzrh2njiI_1732696244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2024 at 04:31:51PM -0500, Michael S. Tsirkin wrote:
> 
> I was hoping to get vhost threading compat fixes in but no luck.
> A very quiet merge cycle - I guess it's a sign we got a lot merged
> last time, and everyone is busy testing. Right, guys?

You will get a merge conflict with net, resolution is here:

https://lore.kernel.org/all/20241118172605.19ee6f25@canb.auug.org.au/


> The following changes since commit 83e445e64f48bdae3f25013e788fcf592f142576:
> 
>   vdpa/mlx5: Fix error path during device add (2024-11-07 16:51:16 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 6a39bb15b3d1c355ab198d41f9590379d734f0bb:
> 
>   virtio_vdpa: remove redundant check on desc (2024-11-12 18:07:46 -0500)
> 
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
> 
> A small number of improvements all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       virtio_vdpa: remove redundant check on desc
> 
> Max Gurtovoy (2):
>       virtio_fs: add informative log for new tag discovery
>       virtio_fs: store actual queue index in mq_map
> 
> Philip Chen (1):
>       virtio_pmem: Add freeze/restore callbacks
> 
> Si-Wei Liu (2):
>       vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
>       vdpa/mlx5: Fix suboptimal range on iotlb iteration
> 
> Wenyu Huang (1):
>       virtio: Make vring_new_virtqueue support packed vring
> 
>  drivers/nvdimm/virtio_pmem.c |  24 +++++
>  drivers/vdpa/mlx5/core/mr.c  |  12 +--
>  drivers/virtio/virtio_ring.c | 227 +++++++++++++++++++++++--------------------
>  drivers/virtio/virtio_vdpa.c |   3 +-
>  fs/fuse/virtio_fs.c          |  13 +--
>  5 files changed, 159 insertions(+), 120 deletions(-)

