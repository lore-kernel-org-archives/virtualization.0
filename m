Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CB26E71B
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375089; cv=none; b=rA/WAo7pT3BnT3P7qpn0xRkSHJfcXez54FV794jtnGkBLeTg9i/0qrlS5XhmtJ+R7FTz/l8AVxds04+YKx4UlNU8f8ecYYXgUGltM86G5XZ7EDR3Ka7ZbfwGqAwTH5WVAac9MYbSvT+AfJIxEyT9haM1Oudmbzjwc+9SzPYHwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375089; c=relaxed/simple;
	bh=1u6LtBFBZpYRhcRKXCfqg8lwwnGpi9KXfabJfPSkfec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eRyCDwAAjSMBiFRxJgj0atlkVzMJVPvj16TcK7OaJmH1hZyQahVXojr9ZKvYX8/DQohaUzz1IeCTeVMdIvvthRL7XwvgUiIuq3vPkz4vPqUz3yDr/LUNUHAcNu5UyYByvPXWxjZcx48aRB1ZMsHdYST6SgCHhwoMe3Shs0GF4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ep/rOLKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep/rOLKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751375085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
	b=ep/rOLKDcNWGehsgIEYxfmdkGHdRgpPYayV4InvVQMTJEumwv7G7EPRkmPfpHrVdo5iUNk
	PD9l5JNKGEYlmH4NPOcjVf6kw2TclKYffHbCsFlyio7S33ZX+9hS0jv1pV/RS47/hcagxW
	+PCf6AyYo9dDnSh8c2IozperJvjaF8s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-UT1RFTgUOmaZhwPhmGhPTw-1; Tue, 01 Jul 2025 09:04:44 -0400
X-MC-Unique: UT1RFTgUOmaZhwPhmGhPTw-1
X-Mimecast-MFC-AGG-ID: UT1RFTgUOmaZhwPhmGhPTw_1751375083
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so23074675e9.3
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 06:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751375083; x=1751979883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qg+m2/pNVkQnC5aBRNuH+sXdMQvLaC9DgJfu+jNhg0=;
        b=lJxpUN7GyVRV1nm/Zj5f9iUOUlburNdRg4yd7U7CnOcuMuZx0kBAWJEFMvSLrNI+cH
         3+Ywqu3m0mtCGs49Ex4v69Wogxfc5+OHWWKfMwP5kOFrUQJab16cSij6yX5xcyo3ZGnR
         Zdoi0/aFDl28DRIqekyBF3sEvwyDA4oyd3nCNDAhzrADCjSji3dz8jPV+BnwT9fyeyrj
         j1/8PPnbNlyzPwmOeU3nTeVMT7J0F7FOFCmVRzlyGQAiCIe6xUbF0Wdl1toZsqo20/Sl
         2z90G0QqDdzdJz0XLG2ZGN171bmwm0TgwnO8XBOzYjb8sEFcY3aP+MtaWQJkFvKyNMsj
         kwwA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0VT7n96cOEg/cVIBh+1s2ujSW7BdpLudcGlQaYiQbR+g4sO50drCC9o7MtrlkjLokKCIPClnbRPLPDvTaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUfYqwo0129A2VVgEo+OKhz3891PXB64poPLZ13vSCv3raqN8N
	oiNKnSoBPaBr6qEJkWZBgMvcJSoevFf5O6h6vmZkuW+aKndUNeD4IaVhgVb4TxIUdmSRtPHeEzM
	Ngfx0FyQGAdcCJCR9YpOj82mRmiFdOeH3tn3pj1zWaQmOdtlQSbUntzKocp7FilL2z0h6
X-Gm-Gg: ASbGncsd54SrcZm1rO4ZN769oeZXaUCqevvHMPeuIgPY0KejypQkhxN6BCRsXzyxfqN
	WJ9xRorD7Tief1oROg8QR95Mnt9MWrJQD87naZ7z1kxDOp0YI0My/tMPXbTxXDJJQoM5H1A4gj+
	aHH4SAmzB7bfO1ysi1u8+SusPYp44h89sYeXTejNXYwvQyHn8afZeAbo50oYcH7lRBMTnzoOHe6
	oaltHjJCUi+0GUIqce4pEs8pHVAox1Ht+R8PqrP31HmYpHmwBEYx8WvgTTn/bFpXXyxsYKSDlJq
	zrDdskg5sSJ4y623GREkSTIbpABjIScpIDgqq2C6JJ9HBFaz3fdOrItwjmzsas4Gu7oDFw==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207008665e9.10.1751375082788;
        Tue, 01 Jul 2025 06:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9ko9vvQce71TOy0RBCS6sjywmO9bKtkGNw+DoVv+ofxTAO7zJYiibP6bcuGbZwr39XyKgA==
X-Received: by 2002:a05:600c:6218:b0:453:6ca:16a6 with SMTP id 5b1f17b1804b1-4538ee3996cmr207005335e9.10.1751375080189;
        Tue, 01 Jul 2025 06:04:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5b7fsm169229505e9.10.2025.07.01.06.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:04:39 -0700 (PDT)
Message-ID: <346e4b8a-2e62-420b-9816-6a35b8b63da1@redhat.com>
Date: Tue, 1 Jul 2025 15:04:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
To: Dexuan Cui <decui@microsoft.com>, niuxuewei97@gmail.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1751013889-4951-1-git-send-email-decui@microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1751013889-4951-1-git-send-email-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -5-nUHFuE8Zlc_7Q66ka60pdOY-Essvcrvj5IuQE8Rg_1751375083
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:44 AM, Dexuan Cui wrote:
> When hv_sock was originally added, __vsock_stream_recvmsg() and
> vsock_stream_has_data() actually only needed to know whether there
> is any readable data or not, so hvs_stream_has_data() was written to
> return 1 or 0 for simplicity.
> 
> However, now hvs_stream_has_data() should return the readable bytes
> because vsock_data_ready() -> vsock_stream_has_data() needs to know the
> actual bytes rather than a boolean value of 1 or 0.
> 
> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
> the readable bytes.
> 
> Let hvs_stream_has_data() return the readable bytes of the payload in
> the next host-to-guest VMBus hv_sock packet.
> 
> Note: there may be multpile incoming hv_sock packets pending in the
> VMBus channel's ringbuffer, but so far there is not a VMBus API that
> allows us to know all the readable bytes in total without reading and
> caching the payload of the multiple packets, so let's just return the
> readable bytes of the next single packet. In the future, we'll either
> add a VMBus API that allows us to know the total readable bytes without
> touching the data in the ringbuffer, or the hv_sock driver needs to
> understand the VMBus packet format and parse the packets directly.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Hi maintainers, please don't take the patch for now.
> 
> Hi Xuewei Niu, please help to re-post this patch with the next version
> of your patchset "vsock: Introduce SIOCINQ ioctl support". See
> https://lore.kernel.org/virtualization/BL1PR21MB3115F69C544B0FAA145FA4EABF7BA@BL1PR21MB3115.namprd21.prod.outlook.com/#t
> https://lore.kernel.org/virtualization/20250626050219.1847316-1-niuxuewei.nxw@antgroup.com/
> Feel free to add your Signed-off-by, if you need.
> 
>  net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 31342ab502b4..64f1290a9ae7 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
>  static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>  {
>  	struct hvsock *hvs = vsk->trans;
> +	bool need_refill = !hvs->recv_desc;
>  	s64 ret;

Minor nit: when reposting please respect the reverse christmas tree
order above moving 'need_refill' initialization after the following 'if'
statement.

/P

