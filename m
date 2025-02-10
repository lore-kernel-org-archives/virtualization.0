Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730F1EDA12
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185371; cv=none; b=I2euoOeGbJGoeVP3qypFaEjhx1vtgkNSzuZbUnUakjDo4YBl2/3pJfJ8IpMlAWL2UtKZ+kxk1nT/UfNEKlo2OWrjWsqx3kJtcrU971Z+IeSzfIO4idGHHCtYIvIGgBwAWEeG/0Y4lMc6RPmMp4235fpQJW1Tl8+VHpgFMWocqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185371; c=relaxed/simple;
	bh=LvOQH9ItK5kpkHdcctmHoeElePYbHQ6SeuUkBY4RotA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l031GLANOwvQZLnDMdquCbE1/4kKIaY/5AbGjqqxhbanCRtgkZ4LAyMcb0XYWcNhtHHI2sQgpgWw6ZfjbxWmSVgsYRwWLOzMiTcC342Y3ZizL2mVTNjKsqGCiXRX1UfWi7D/9G+6P8PqYfVom2YBpOjucX+lKMqFx/ZM937CKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxpeVWpS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxpeVWpS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41B77400BB
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhzEFzDspHmJ for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Feb 2025 11:02:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leonardi@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F13944064D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F13944064D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fxpeVWpS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F13944064D
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739185365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swYAcnuiVW6RK8Ul+P0fcMd3U5CHMNqoVkyi4ViV2Rw=;
	b=fxpeVWpS5qxB+o+gZJBtGz4WMrxypHZG3EHezx95xV71VjZxEDgzRfLd846jrTH9sPQQU6
	Z92jXE/UYYNgLg09YeTsV54vT4n2puoxKEbPWrVNx6qjMXrWtUUwPvIqt6Zcv9hSo8XE1L
	tF0B9MUe660O62wcrWpqVQVpSG2YBFo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-wFYB97oDN-uXWMhlEZEzAg-1; Mon, 10 Feb 2025 06:02:44 -0500
X-MC-Unique: wFYB97oDN-uXWMhlEZEzAg-1
X-Mimecast-MFC-AGG-ID: wFYB97oDN-uXWMhlEZEzAg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dc88ed7caso1770589f8f.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Feb 2025 03:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185363; x=1739790163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swYAcnuiVW6RK8Ul+P0fcMd3U5CHMNqoVkyi4ViV2Rw=;
        b=S5u6xyDzvehDeT3bPr6UX4/jKLA7BKEG1BYpZwGgMuDEqCoCkl1HdKoNUeIF/V8DOw
         xq8stkoJmUP2YVJAO5YMmkkMvGZFPeUQADO2E4x0G70oc6pZr9JdPm6R7ueCzt642wzk
         q1TJI3YWwZJ2XrFxBmi+1MuMpe+polWPf1R7kMv7hE9NuWjjWPO0oBNVPKOkoZn5oyS0
         HlIEYOctBRSDfliy/NsvTuRasqsH8S+PC650t9DV2AaqJWXUmAaZa7mo+apeSHJ1sF1k
         gMSSVcXO9gw0R9GoG/eHrEhyzJDrM6T/w5PoLFy5ADAMn2+7sJcd6o8KRTinTexTUXMg
         uzKw==
X-Forwarded-Encrypted: i=1; AJvYcCX86tbTYoUvX1WhfbyBPUxO1tU/Z6MHYjv5r9TgCsWlQleUNpfxIfvEjW4btTB0wKMpg9DYuFsFzCqOmHZ9Zg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw0JWPQySiwK3uLoJucAlOljMzRIbuc7TwQLZsd4CSGFFPacnxZ
	dTj2aI+8MgqZ09WZ43izsaDn4IQxNxWXgJImX7Yt5y+Kgw+fpYxi+yoH06kIONerqWHJ8y9dTV1
	nFBPvQr9+8watCj8/77Pt2q16/XLUASWubx2ZuwFnSsSqJxf/Q4In7Lz0fAI+reUURyTm2zi1ro
	lDyiE=
X-Gm-Gg: ASbGncswPrM4IEFnHVR5WKqfjVnb9eX696kNt3J/T6844b3L6w8OkUNzYzuzvCCpJsd
	jmMphK+bEgToJkpQBXCVz1eYxP1NLTFidZZDbUNcpQyRE4GkUzs2hA5YiDnJSMelT2Pm2AyVbdn
	eMJcJJNPfffnC0JV+B3f5jBIIFKzYB2pBsz3cEBLCjMJj4WkyxQJ0PczOW3ZFbFT/7cGSP73rXE
	1tc6+2WN/wBI4VkaT7mz0yxrJY6wptfRszgy9QPNXEf2JcQesealtFl6+6xWH7kBw0LA1UiFVhW
	2t6MoOeP
X-Received: by 2002:a05:6000:2ac:b0:38d:e02d:5f42 with SMTP id ffacd0b85a97d-38de02d609bmr1377011f8f.6.1739185362711;
        Mon, 10 Feb 2025 03:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVcih5C2q2EoxQo6V3rYfBXB/mX6hEY2CIHU/jm3irE77jPqNtIp7mAAXfge1kKv0X5WGlbw==
X-Received: by 2002:a05:6000:2ac:b0:38d:e02d:5f42 with SMTP id ffacd0b85a97d-38de02d609bmr1376986f8f.6.1739185362281;
        Mon, 10 Feb 2025 03:02:42 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43939db5eeasm31376925e9.0.2025.02.10.03.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:02:41 -0800 (PST)
Date: Mon, 10 Feb 2025 12:02:38 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 1/2] vsock/virtio: Move rx_buf_nr and rx_buf_max_nr
 initialization position
Message-ID: <eebvrzx7zjbc326ycs3coskq5cajaoxcblp3wvcxfqaics2a2z@342wvb6zexs6>
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
X-Mimecast-MFC-PROC-ID: tjbdV12oQGlP_Dik5nZ4YsED-oU0VOq2OB_BmacfpIA_1739185363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Junnan, Ying

Thank you for the contribution!

A few minor comments on the process:

I think this series is missing a cover letter, not all the maintainers 
have been CCd, and you should add the tag net (because it's a fix) to 
the subject. (e.g. [PATCH net 1/2]).
Here you can find some useful information[1].

[1]https://www.kernel.org/doc/html/latest/process/submitting-patches.html

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
I guess "s2r" is "suspend to resume" but is not that clear to me.

>initializing rx_buf_nr and rx_buf_max_nr,
>the rx_buf_max_nr increased to three times vq->num_free,
>at this time, in function virtio_transport_rx_work,
>the conditions to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) can't be met.
>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>

Maybe you need a "Co-Developed-by"?

>---
> net/vmw_vsock/virtio_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..9eefd0fba92b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -688,6 +688,8 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
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
>
> 	mutex_init(&vsock->tx_lock);
>-- 
>2.34.1
>

Code LGTM.

Thank you,
Luigi

