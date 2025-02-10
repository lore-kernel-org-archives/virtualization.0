Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991631F561D
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188096; cv=none; b=F8pMlMVDIBkxigoCbBOurg55MWqQwDrAaS1fuOPFaDj8N2nfyhQmXZBwpixGQSZ1VR0w47Jx88Frph/De1P44CgW0HrgMDgnunuSp+KPJBATgSKpY33Y/WJY3Hm+tWU+0D6wzkxPOtqSLbquAcge92H2KI73qQn+OuehuQq5mJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188096; c=relaxed/simple;
	bh=d/DnoVtSkV/Nkf8oyOpZiRm12klhEJ7Wo4KRtp9gtVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cXhlWBVe7o604s/yI6h/rRiC4efulx1lzojfrK9aS1031MLlyup+M6nd84mfHW6T6OuU+ksf7yH4qieoQOwCFbUoKUSdGarzrY0YB2Vp6XHxlksYnixoT3F0JZjq8+NhMoWKjQL9a40FmSr3DAiZgfNDh4vGyywFfvHmKq9FcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhJqXdHi; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhJqXdHi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16DFE40024
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksl1jEfs-0uB for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Feb 2025 11:48:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leonardi@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 04C03400BB
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04C03400BB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WhJqXdHi
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04C03400BB
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739188091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V96jX69C9DLp/pa7eUqKAsyCn0HykOC/OsS7VPjv/yE=;
	b=WhJqXdHi36Ck1TN5gzR9v593pF1foJh9Ty0FgCTgb8MgMZs7Ovskp6SzHR4F5aB5kPv6SO
	cRAFuZsYHiyFPgyoiFm//F+cgGxxFuPeEib9hpxYmnYWi8F6V6QVKtBdZugmyioYBJAoyL
	Kd9VlljLTue9vFAg2ddXluoHJWSViAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-omABHtOfNAaczdBFtv4gTg-1; Mon, 10 Feb 2025 06:48:08 -0500
X-MC-Unique: omABHtOfNAaczdBFtv4gTg-1
X-Mimecast-MFC-AGG-ID: omABHtOfNAaczdBFtv4gTg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso1483965e9.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 03:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188087; x=1739792887;
        h=in-reply-to:content-disposition:mime-version:references:ifrom
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V96jX69C9DLp/pa7eUqKAsyCn0HykOC/OsS7VPjv/yE=;
        b=XUo236nXRrRm3dgSnal/NP8NHtl1epki4LN2RxtE7ULp/xp2wCCg6HCbV2ZFrnGS/v
         E5IXnLpyFia8dCmLCWJNSn30sGTiCkuNuLa/PfAfeuNWaQ0wPifU1HZSPxx8NA0Th7bU
         ROaeqwHyibs3WoVUSwPIxXFo7/kipjY7dV8U3upUiJSX2jq3S3h6kwlSNJzrw0OIRriq
         xgvCtJ7VXE517HO8AlL2m1AQK0gTt7LS9Xlk28PsoOVFlUwyAYAMWFUphlaaSCUEAv51
         14p1bKUF90gNnRlYO1mPEVBmvfFUgS9ZMo+SyfCNeqlBEole8I+GofiWLDRANUJIKqGE
         L7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKSoSXXcBd+4N6LXBs12cGxXFs4jEiFKnf0dbEd19Ea6ootdggvnnk06EeDSsNnR7d6jBp/YWaFdhaO3tfsw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwfHvOZ6renbx3IjLMWUrlUB7w4UTCyVo+pJEPtXzOlsSa1kYkR
	rDwBZmMZecTrGV9yEDZnlGhcG4Z4iO5/MQIhoOF7g+ILN8o990Y+KjwnQAUIQxdU49uxpVJp6Ij
	qiQG4Gf9G+JqoBlAmhafO+cQsgc/p1I+zWtqucjcZjESRPflbzsW+cIkC+wN1eO+bWzgZIEd96r
	iCgUU=
X-Gm-Gg: ASbGncuuTycRWR85Nxbq38le5qxdDC5MrTtaCXuPrN/t8U0LhjP6gdNlTgTOMlh9rmd
	QwAhPQ17oySXfv28iJLC5BL2rjKVHFDLI/sIMh5nmm254VjGNrijyNpI4Yga/AVfnyuXM0MYocc
	T26nKCLth5+GxvZo1dx8aaChi30p4W3uAm4UeivUdzwXDmoUNMQ+k0/y65T2mjEePi7M0pnx0vK
	lz2ja+4QVXKQhanw4SThszKfcQ+rTWgwtP0ohUEsZ/eGSqCHBehmsuG0qlL3NjdfrWXAsOSEKdZ
	/y6O58r2
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr67131395e9.12.1739188086692;
        Mon, 10 Feb 2025 03:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGN3KR5R07uNE78CVdV7zyw1euIY35SEs9+TXB0gKXhyKCy8SuRwCQFSKXWIpDT0SeS4gsMg==
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr67131065e9.12.1739188086265;
        Mon, 10 Feb 2025 03:48:06 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4392fc0856csm76891455e9.34.2025.02.10.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:48:05 -0800 (PST)
Date: Mon, 10 Feb 2025 12:48:03 +0100
From: leonardi@redhat.com
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
iFrom: Luigi Leonardi <leonardi@redhat.com>
References: <20250207052033.2222629-1-junnan01.wu@samsung.com>
 <CGME20250207051946epcas5p295a3f6455ad1dbd9658ed1bcf131ced5@epcas5p2.samsung.com>
 <20250207052033.2222629-2-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250207052033.2222629-2-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y6o9SeU9Ntg-ActeqWnhX3FHVkPpkR9Ber4rQPtlk7c_1739188087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Like for the other patch, some maintainers have not been CCd.

On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>From: Ying Gao <ying01.gao@samsung.com>
>
>If suspend is executed during vsock communication and the
>socket is reset, the original socket will be unusable after resume.
>
>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>only when the function is invoked by virtio_vsock_remove,
>all vsock connections will be reset.
>
The second part of the commit message is not that clear, do you mind 
rephrasing it?

>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
Missing Co-developed-by?
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>


>---
> net/vmw_vsock/virtio_transport.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 9eefd0fba92b..9df609581755 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 	struct sk_buff *skb;
>
> 	/* Reset all connected sockets when the VQs disappear */
>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>-					virtio_vsock_reset_sock);
I would add a comment explaining why you are adding this check.
>+	if (!vdev->priv) {
>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>+						virtio_vsock_reset_sock);
>+	}
>
> 	/* Stop all work handlers to make sure no one is accessing the device,
> 	 * so we can safely call virtio_reset_device().
>-- 
>2.34.1
>

I am not familiar with freeze/resume, but I don't see any problems with 
this patch.

Thank you,
Luigi

