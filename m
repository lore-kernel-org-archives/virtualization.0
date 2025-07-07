Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A229B78F
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895646; cv=none; b=a5NAuyKj/pM0X47H3mZqO+1O1Q1a00+O5FOK7VtMGo0W+VdB0gv8EZsCoPi6hjAWv7gxE64Uf+jRqlbScqqp97o5tertwhajJhKxNHljB47Ak6T2SY2FMqJu3kK1mwuUXBUFOlPMTw6skrS3PhS0vvE44JW4NiZeo8p2jQdm//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895646; c=relaxed/simple;
	bh=ul3tvYiiYuyxmNUs6c6tGf8iXCr1hDf1jpTi6pw0cEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mKHOzBIQY8VKZ08AN3bJ5XAkNGvm432qCbfYukbNlpCNQjTrf/RRRke66uGE1lk63Lp2RIT4wkpirTtBZ0JiPpLZrRuUd7+7cZ2uD/1L29w2uxz3JcWI0j0G6ro+T/C88ws1e9rX/4S0ikGC2sB0eqBDjV66BdAZk7k+whcmhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyOkhIep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyOkhIep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2KJ06Vv9jNgPK/f5x2D67o6F5iefXJHvVBymbKYkgw=;
	b=TyOkhIepXfcr+KziT/ZMJwROkrJCWuUX5xkVBr9K7ClIQfqY3gnfSdEIGTJawIqeVIrdnn
	Hurin1Wi/d5Ib8xw4TaJeMYKTnB2ST8zyk4dXb56EUQWhVAZgvsmYNHz8BjnnMEmfy3RXO
	BhWqeCez4wmLsLNBQC3c6d2mxoSknas=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-caF2HwfTORm4riFwH8BcCw-1; Mon, 07 Jul 2025 09:40:42 -0400
X-MC-Unique: caF2HwfTORm4riFwH8BcCw-1
X-Mimecast-MFC-AGG-ID: caF2HwfTORm4riFwH8BcCw_1751895642
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4536962204aso13149325e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 06:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895641; x=1752500441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2KJ06Vv9jNgPK/f5x2D67o6F5iefXJHvVBymbKYkgw=;
        b=s7P1w+n3yUmroMZeV2/evCndI+X/d9Xe7ldEOQOWxPsF+vd3a14urYF3amzo/6kTH5
         Dpu9B2Tk/Vcv13cRQjY09Byjmj+/XMRvGLRol7pzdYgm3oF9dGXuAF5k0AsabMBuOd5J
         lJ/McXfGFYArnX8W8A+T8t44A2kpjxFUGchnLTWxr6soamcRuGyql3rb9GufDguRcaHH
         tI/74rekVB8DZ9iVVgnUSqf1M69/3OANwIJ0ST/XSi0sFpCF3O4HlhfYtZtHILPAq/t3
         OiHPDKe58ZQ1gfnJjmON1Q2OX7FVZfDlxn9H8G2iQERQCOJjr2LOTA+Fiwd6GizppHOr
         KXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWADrQeSq38OL0/4r0cwvHFusOFkL7CMj+MtP7xIy2mj13kYCI97LbbyfvfiyotzKfanj0hclMzXLMSPzkJng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAi9ag3EkNmxzJ4E8CyNA+/Ka6+o9LJA57CAZVguVzq5mNzXjI
	2YbrtYfJY97DXDSBLkIl4C+AYs9lUxAu9agcpF+nQ5PLEByprQeKXS1r1IgMDySyW4o+VHYmVz/
	k1syxpHClg0L/0KGn/nmbM11dnj7vJsndqDfO1bCx5w77WdDmT6vSX+gqnh+d21IZ8xyM
X-Gm-Gg: ASbGncvQFX1gE4Mnms6g9DWr4rc7jc883NjQA5idD4wvhx9lHJ5OjzsmFxgi4CBxLfe
	//8muqIFhyG32cvanfidBBAYXcVRPMrJPF3V7Zs+ncAas2xaF9HVbePW+RzHM93Y+rmcKr9slaj
	86SujAIRPTHhYasdnlqEZPhzEVP0jlzRyAAzkv+yjF1WjLiBRSksFS7a58ouQk/oAcpyl/YM4ho
	hK7CmHfvaREjrcFwUFzS4I8zX9YHg42cn/rHVt6luv0YBgJv47TLcXZgRWQd7K3SnlCf6gou3ov
	FOH8J83FbAiOfw62CZsTZcH+nxbN
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr117204135e9.14.1751895641294;
        Mon, 07 Jul 2025 06:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ3sl8II9VgNMv0Hs+oc26TdXSoZydYWxbok3SEgKNUWhqxxpymtncK0H5qwe1x6+STsNFHw==
X-Received: by 2002:a05:600c:8214:b0:450:d568:909b with SMTP id 5b1f17b1804b1-454b4e74957mr117203465e9.14.1751895640329;
        Mon, 07 Jul 2025 06:40:40 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c9f9sm10339166f8f.93.2025.07.07.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:40:39 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:40:31 +0200
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
Message-ID: <xhzslzuxrhdoixffmzwprn254ctolimj7giuxj4nfrfg23eesy@ycpe6kma5vih>
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
X-Mimecast-MFC-PROC-ID: Q-Rn2TrtWMHmZpR7lpv8Yc4Gw8ZHYZKVsubSYBcP46I_1751895642
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:

Again, this patch should have `From: Dexuan Cui <decui@microsoft.com>` 
on first line, and this is done automatically by `git format-patch` (or 
others tools) if the author is the right one in your branch.
I'm not sure what is going on on your side, but you should avoid to 
reset the original author.
Applying this patch we will have:

     commit ed36075e04ecbb1dd02a3d8eba5bfac6469d73e4
     Author: Xuewei Niu <niuxuewei97@gmail.com>
     Date:   Sun Jul 6 12:36:29 2025 +0800

         hv_sock: Return the readable bytes in hvs_stream_has_data()

This is not what we want, right?

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
>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Your S-o-b was fine here, I was talking about the author.

Thanks,
Stefano

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

