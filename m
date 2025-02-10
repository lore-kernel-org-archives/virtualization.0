Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D12580D3
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204177; cv=none; b=FVYTHB9v1ntqNYfrPlFlH6WGhhjXqb+HkY8ev6UIYvp7y8LQ+lwGl3mcIRsM1UfcxSV6i76oSfQJSzkI/Zdd4roPbFUcWjM8VBDNcFAUqyf2dPe+QRPsCWLd1QlbxvPzZ5Trl2RGQ7Kqvub/QKtzKkJpzgKc6w+X1wq6lSbnUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204177; c=relaxed/simple;
	bh=1jcS+7FsjGMJ5ImWaUmKT2uzq8IjSodR7EIZMko9OZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XCnLRwG854LqM+of0SKXUEYZyOiizQmWag7a5mJd6adSOo5REBb17+dw76vjK+KN6oHwHf8Vb6ok5nEgTXZKxw+xdERgvixwZnTZgXF3hLG0hqfW1SejkJJZdyOlxWSidan2adwrUGGGBzz2RldW1JuB7udk4xmhqdaECHS3u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X90NPkgE; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X90NPkgE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9EF680A4F
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09RP3Ta7b-0s for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Feb 2025 16:16:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B4B1C80C78
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4B1C80C78
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X90NPkgE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4B1C80C78
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739204172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNXSpIDMbsYdI6rFjnVldoS4vIPojHfA/xPTtZaSU8I=;
	b=X90NPkgEXVlCIsBD/ayM0MEEAaK0MxSJFiuF92UskLJ+fqyx2BMa4VWhk7XOTMTCeSH34+
	Mngb0JPsEVQ60Ntdb8G/ESGqqs9fLSlZbTvMrwTMGO/8qnLhwW0yIdHiVpoPeQl36QBzwV
	KdWYugcGSi7Z4cw+NDH524sg6mpnXD4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-0tWs_mOYMUeNx4sWmkykng-1; Mon, 10 Feb 2025 11:16:11 -0500
X-MC-Unique: 0tWs_mOYMUeNx4sWmkykng-1
X-Mimecast-MFC-AGG-ID: 0tWs_mOYMUeNx4sWmkykng
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so34753515e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 08:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204170; x=1739808970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNXSpIDMbsYdI6rFjnVldoS4vIPojHfA/xPTtZaSU8I=;
        b=s061PfP5Bqde+v7HX+NS1y6xZv1cStTEmGIV0EtJ6bIFRX7Cmr96OR4Z6m/Xt8R3BV
         j2HdDok2HSqIe/hdrG57QsaG3qSDhG9lSYjkRxCgla3Cl0d+iHBjaiInz1cSnmwgh8+e
         LQ7a4IdGf+6Sk3fNkprB+gFiGUa6G0zKuYMENVBv42jJHd/PoQqF2aQ04XLVh3E+75Yr
         BQbPGDLUOM1ZJMtejVBSooCMmJdlXVx/PW9U+0//lIwvhfQZjLs20CCEFRe+RP2YbUe4
         Vg9YtuXjhaVoTkBI8CZZZwAr6kv//HcM8ps3mcFA+NdHQm5dVkX/LfNsvRvJLpNIuu9K
         3s1w==
X-Forwarded-Encrypted: i=1; AJvYcCWTu/yuE7DuydncisSE87Ro8EgHvSOkDxEJ1m8+EU9wqxRf4WyF4xHyF7ooqUtJF15aDoL5kh+ndtH76eZX4A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyjSHNucaVQkq5dJY5klRfgtAnO/8BXoyqoPD/JVt40lFiAMGo6
	4oTBpljejGxTYTo7rgnpo7ZXU3UK3d+FBuTjWJH3lARoMfn3xxRo9FMkrww7zY1yt4byudJN8CW
	RfMoTFlOfYyc25tu/3BXy3BPIILhAbSeGuLaqk0TDrSZWdd1Qg1x6v+fjqVqIUfvfx0NjOoTQ7c
	8hgyU=
X-Gm-Gg: ASbGncsTKhPM0gggBFMR8TIQvLe59b/8whHgO99C9XOEXBHkOXkWSy+r7UYIFPpxXKk
	UwYBZIjuzleu8K2JcvlQpPPbZPvpsxD6H/4GeKbtZSbU6VMcZ/Kg2HCTz8XEFFwxux8BNTwT6NK
	7UGG/vZMwU1djulhTR8R+FLdMTC8bIlprKSRnwilYPBoWdW1/sKRYCox/NQRXwj5YI5xd+JaBAu
	TO2BtaZhzvKarzZ2JG1AoDRbRFl4TOaED9GTYNRxQMi7irkXnUVsLtpTJwY6kc34LgOgQotkG6F
	DFlsKpKoNfV6/ounn8uLlC6EmU+OkIJF1eHR0E1VBfdGUbbgo5fbkg==
X-Received: by 2002:a05:600c:34c2:b0:439:4a9d:aeaf with SMTP id 5b1f17b1804b1-4394a9db1ebmr15085105e9.25.1739204170031;
        Mon, 10 Feb 2025 08:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4uH/9bRhvTIF3vEIfyT9myGFn94vbG/HM+aXMc6HM0Pb2tHDTL/kGHkjMrZlOrAunNmfsdA==
X-Received: by 2002:a05:600c:34c2:b0:439:4a9d:aeaf with SMTP id 5b1f17b1804b1-4394a9db1ebmr15084685e9.25.1739204169320;
        Mon, 10 Feb 2025 08:16:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43935d4bd5csm77423835e9.6.2025.02.10.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:16:08 -0800 (PST)
Date: Mon, 10 Feb 2025 17:16:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 1/2] vsock/virtio: Move rx_buf_nr and rx_buf_max_nr
 initialization position
Message-ID: <yvdbqfahgu76eczt5c4n76akbhh4h2ofemd46kv6kia4xipeqr@tfucpayw7cqg>
References: <CGME20250207051943epcas5p4b831a4f975232d67f5849c3a2ddbcb59@epcas5p4.samsung.com>
 <20250207052033.2222629-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250207052033.2222629-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2OR1kIvncUfJyWkaN_es0rYfbVPPJ13ElWDJtcZRwo_1739204170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Feb 07, 2025 at 01:20:32PM +0800, Junnan Wu wrote:
>From: Ying Gao <ying01.gao@samsung.com>
>
>In function virtio_vsock_probe, it initializes the variables
>"rx_buf_nr" and "rx_buf_max_nr",
>but in function virtio_vsock_restore it doesn't.
>
>Move the initizalition position into function virtio_vsock_vqs_start.
>
>Once executing s2r twice in a row without

s2r ? suspend 2 ram?

Please define the acronym, it was hard for me to understand (the code 
helped me).

>initializing rx_buf_nr and rx_buf_max_nr,
>the rx_buf_max_nr increased to three times vq->num_free,
>at this time, in function virtio_transport_rx_work,
>the conditions to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) can't be met.
>

Please add a Fixes tag, in this case I think it should be:

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")

but please, double check.

>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

I find the commit title/description a bit hard to understand, please 
take a look at: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

In this case I'd write something like this:

   vsock/virtio: initialize rx_buf_nr and rx_buf_max_nr when resuming

   [Describe the symptom]
   When executing suspend/resume twice in a row, ...

   [Describe the issue]
   `rx_buf_nr` and `rx_buf_max_nr` are initialized only in
   virtio_vsock_probe(), but they should be reset whenever virtqueues
   are recreated, like after a suspend/resume. ...

   [Desribe the fix, what this patch does]
   Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
   virtio_vsock_vqs_init(), so we are sure that they are properly
   initialized, every time we initialize the virtqueues, either when we
   load the driver or after a suspend/resume. ...

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..9eefd0fba92b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -688,6 +688,8 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)

I think it is better to move the initialization of those fields in 
virtio_vsock_vqs_init().

> 	mutex_unlock(&vsock->tx_lock);
>
> 	mutex_lock(&vsock->rx_lock);
>+	vsock->rx_buf_nr = 0;
>+	vsock->rx_buf_max_nr = 0;
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
> 	mutex_unlock(&vsock->rx_lock);
>@@ -779,8 +781,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	vsock->rx_buf_nr = 0;
>-	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);

Should we also move `queued_replies` ?

Thanks,
Stefano

>
> 	mutex_init(&vsock->tx_lock);
>-- 
>2.34.1
>
>

