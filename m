Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CD2C3769
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971790; cv=none; b=fObuYBZQ1EUArMCVOwy8Xh6vZuXwlKsJ6G1OZ2ntTdU/mXipLTVOQRMm0XXcNj9BEcSkB/2SMuEQ873Kd3ttEW8EScN8PQ7CAKJLGhECwrc3Y8TkE88CS3bMUEXbdRQcHNyDw5ZLNwynWD+ExpU5EFjciYWL1QdXKBHAvAYp8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971790; c=relaxed/simple;
	bh=O7wwD7eSFM539CC00ixDKAsR7sbvVfXkvwV0BcTBHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iNxyBPk/ABJgKp1Gn9S5I0idlPTMSD7WgT6lIJFyCmLXIRGU/3vSC1y6vpNN2iwy81IYi0bQMucs0t8JeFotDeL6DRMZ/B2Q0ZxL+mbADjp0ztkBG5BQu6Mv/yJdBoNJizZDPuSjhWdHxkK0ptd3LoXyCkKX3HQqow/OHSopvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWg6xLdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWg6xLdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
	b=BWg6xLdoRbxP4T3tJhhEp46STTZMqBYI/kuPElw5vu1e5Q8f45HcRfffvVXmJxo7GJ+6tE
	wyOfMHdGsdOFn+ru36ViKjE2qzXYeBnZEFSg2IXuRXT36x19r2rgt77VGE/DgJlV9wAtJ0
	YfO1reIm7XQciw4/CU+pSCPbrOQL3Vw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-S3GL9xFhOkKBjufaFkifXA-1; Tue, 08 Jul 2025 06:49:46 -0400
X-MC-Unique: S3GL9xFhOkKBjufaFkifXA-1
X-Mimecast-MFC-AGG-ID: S3GL9xFhOkKBjufaFkifXA_1751971786
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6faf265c3c5so67298536d6.2
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 03:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971786; x=1752576586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
        b=byNESEtfdLoX7we++0etBg71/IEdlVsSMVcQoGVz6aVqin6+qr3dbvlgWraKyFVhhe
         tele158aIjQ2kywszsZgLfXHHJZroIGF3SRwXkLKA8VxFMaHcH7qHCy5Hvs0FbUpmc2x
         6kxxNIIvKJSbzFeRGAg+wMA5qgu1Agri2iXei5DZCpT3DBQ6U8XNVsK62Bqa5VfBaKGM
         3FulvUmkAHrDbiDuJSEXjeWsueiLefvpZIavjq4fwEJ/wbpvixmYbr1RSQot67PICy7Q
         11ysnEKjIyB1YyVP2M1cnIJe2+i/N6aBcJDLpbh1n29esGEUHqWqFjF/+94wr1SdbkfW
         pysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTRyE+qS2lHFPtDxDrr0k2LFuK1nOURG+Fj7XR9dB1A6Yy51mFLAjMdD20huVdj37NGYPolFIxIDtGuMSWtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ZyE/llbe6U+AjsoayHEHBBXSMs3tT7UywW81OmFFNwArtt7a
	nczXvxHQZVtnNzObQQ4MZZXRTuaeaUON9xC0eEtcOgOVl714gi40RaOhiuF8w1cA/IlQgYCL44R
	slCE3TyiZr/6+Rd616rR8fz1SUPQXVFPUN/VMoYFiZSfTZjrjEPaaZaK3ZZfL6JZo4RFa
X-Gm-Gg: ASbGncux9xResAEmMFsExI51k6Jq7CKwcNepB+b/HwpOqgzHQU6itkPP1hLWS4y/Vnq
	eHh13sCSA4CwDPY+cx0XrBI7+sUGpnoCm6QLQdhjYcWumwqLAgtbkWcw7BAzwOq8NwKGFLE80Yn
	toUGwAxPkACNyt87D5P3gFSxniHVtzHSrmy/CJ4+l0zlHIY4Wn5sUYoSxwRKPNoElseL4P6tpHk
	52WcUZCRelRdGtndSEUmnSM/njKAJNr9PP2TClpJCJuWy08eH+QQ4Ugi0L8C0eh1iFknJ7Oi7Lf
	2roH0eyjynLrOchFq9ZSbiSqsbay
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40374181cf.19.1751971785762;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYlU0uqUvfcleoNVAAhyRWfQZX9q6ookm+/i8X2MtWsxRCFgVRxkOKlEb0p2JpI6O3Qdagg==
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40373621cf.19.1751971785234;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e527sm78690641cf.67.2025.07.08.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:49:44 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:49:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <o2u6lj6m7ro73vmza4zlrwwlvonjzkgdtd4xxrjn57xpa2lmpb@yik2rrzp2sos>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G2GQiBMViJzEjR7er8u56zINdw96lo356ujhUcquaXU_1751971786
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:11PM +0800, Xuewei Niu wrote:
>From: Dexuan Cui <decui@microsoft.com>
>
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
>Note: there may be multiple incoming hv_sock packets pending in the
>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

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

