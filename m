Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759D2BD5BB
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895778; cv=none; b=Ekd47jfr7a4YigSTLyNVQcqq3cWIObq1Oahgl/11BvNEwKNFqBH3GKVNAbs8kd5tMU66xGyQj6hSe8s8sImcPPdtD7SvJVKJij2LrGSnFDj3iBeF0gRbE11O08qVNZbD8m41OCRM/50WlCFUGf6jBdhE8XgRkbYYTPhfTWCi/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895778; c=relaxed/simple;
	bh=xltTqBYmsiirVvBdNqG5/Fyy6AbHsBrBr+WSXMtuttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=flulFbpQXBiokAqTVkcwZb4tXksyfQydiiyde2jObroDZAqvnFOX0xq2Hzphn7+C7Idcz1594zSO55zkalOKajCAAyCy35ZiI4vbp6ltHcE6O/gK1R/uk+LzPUSvVmovNyycnefm4eBmMY23EaPlTdD1yVpC+yM08QCAvmOCwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfWPSwXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfWPSwXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
	b=EfWPSwXp05NXrm2v/aYMfa1IuuwV1PXaIoxucJqf6VrhpnkC/4Qic/Kra0y7szowIhsKUS
	NHOXG8fTtFo6IgjYg0KAEJLW7Ig85doQZYQCgleHFkAnrodB5wFzYNTTZvnAHFsTUkvsYL
	4ba2LUUV8G8aYL5Qqnr2JZ4RgS8Q05k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-UClvJlm_MpC852MJShSiIw-1; Mon, 07 Jul 2025 09:42:54 -0400
X-MC-Unique: UClvJlm_MpC852MJShSiIw-1
X-Mimecast-MFC-AGG-ID: UClvJlm_MpC852MJShSiIw_1751895774
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1436350f8f.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 06:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895773; x=1752500573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
        b=NW7mVYoIik05o7xXKM5NzywiLKZsV1tIS9Pvnz9k0RpU4JVWJEQhFBaPB1H1FFlw1D
         0rTNX39cvhIuBYslXOvri/rsBvwV0x6SiUFjewgYQJga/8BuPTHSG/RGpGyNjl8mY3Hh
         zvvm+z74CBLdJSMAz7G7eWQ2I5jLoVFKpUErzXOAa+2LU/+2Gr5OY8voUKVFZecF4wls
         wezu//b2/PZXFe3ayE0TsCK0sh3EU7ZuyLb/JLOcYZopYfX8zBRYss/toxluhu3LVxpt
         NORgoZQGuQ6NQ5PzGrURInXbaG2wKSju7DcYHzVgG2n1225X/gJKz8eN4+OIepbVVcWt
         IQXg==
X-Forwarded-Encrypted: i=1; AJvYcCUtLsH1dCVM2lWToywjVxBhbr0X0n9E42w8/1XN/qJgdyhwj4IjJIoloUcO1ix5kuj1z18pfg/9J4bRwstGpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz10EiuqCfamFvMwz70uuFiBzhdC1Zp14ls8+10F++XiGj9LLPM
	Hc94Zfh/rjmAZIRftaHGEWk0r3ZQJrp8DeLW+FhQ3oZZDsr0//sTevTwR5XM65JdpHN0ewsDpLB
	6c3527baiRcdmWFxdyfDdbcG4gl1QNxjCOZY2EeuZ6hJ/4wtFanARZoAQJh6n4SYKacMt
X-Gm-Gg: ASbGncu2sZbz2sVYFrZOXdpbWPsGkLbASdnOvuiWmP3Hw7YBjmB6pE1BfrlGMqpD094
	4O9ctCxNRT1kXkL5PLx95YJC3xKOKKm9uqCsRCUpQhQ4y/Sg3UDQFVboOUvIlJGXHhHo5pZcj8o
	zw3j/wvKyrw3ISowQRP9Aq8n0zhh7IfIQPkUAbODg0HNnJjFiSQvZD9uek9CBqXgE2rW/YZFYAE
	ioqIX7hNrMfRRj0LxPIfES2MWOx/9kyD29sJhF+3YXPawI1jMyjbp4TxFwjPOv65pDXeu1HO4os
	nk+pa6z09nfks8q+akMYVZX/u9IM
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564060f8f.42.1751895773414;
        Mon, 07 Jul 2025 06:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY8SiQF+6f5+bf4//S2AtBghoAdxNERSqvvMXKZJvwoNLtCvWhRhxkkv/MOEbunhybnSwajg==
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564020f8f.42.1751895772808;
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b492sm140318785e9.13.2025.07.07.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:42:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
Subject: Re: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <xphwpqqi42w5b3jug3vfooybrlft3z5ewravl7jvzci7ogs3nh@5i7yi66dg7fa>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
 <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3-7Yt4LJHV77DqN1MImc3jaFRNR4IX5Kv4qIbXdyffo_1751895774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:
>When hv_sock was originally added, __vsock_stream_recvmsg() and
>vsock_stream_has_data() actually only needed to know whether there
>is any readable data or not, so hvs_stream_has_data() was written to
>return 1 or 0 for simplicity.
>
>However, now hvs_stream_has_data() should return the readable bytes
>because vsock_data_ready() -> vsock_stream_has_data() needs to know the
>actual bytes rather than a boolean value of 1 or 0.
>
>The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
>the readable bytes.
>
>Let hvs_stream_has_data() return the readable bytes of the payload in
>the next host-to-guest VMBus hv_sock packet.
>
>Note: there may be multpile incoming hv_sock packets pending in the

s/multpile/multiple

>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
> 	struct hvsock *hvs = vsk->trans;
>+	bool need_refill;
> 	s64 ret;
>
> 	if (hvs->recv_data_len > 0)
>-		return 1;
>+		return hvs->recv_data_len;
>
> 	switch (hvs_channel_readable_payload(hvs->chan)) {
> 	case 1:
>-		ret = 1;
>-		break;
>+		need_refill = !hvs->recv_desc;
>+		if (!need_refill)
>+			return -EIO;
>+
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
>+
>+		ret = hvs_update_recv_data(hvs);
>+		if (ret)
>+			return ret;
>+		return hvs->recv_data_len;
> 	case 0:
> 		vsk->peer_shutdown |= SEND_SHUTDOWN;
> 		ret = 0;
>
>-- 
>2.34.1
>

