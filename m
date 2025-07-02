Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BA1F0E37
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450190; cv=none; b=M6YCjDKy7BbKGsfYbzi5GRI2oT1UlyB9QJLzJWoN66LIjeO9gly3Zuip57jXSyRAXrCUmyIJJLhaVdSYLvi9gADEUMkZ44Klu5N6DgFJdUKTLaTmD5PX4efI1LIfv5bhqx+9ncI0UNBdvBa+tfNInSrFXFs9f5WkuXWAFrjzfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450190; c=relaxed/simple;
	bh=R/vqF8mtqR3Q5cYK/qFuLfD77vbI1Wt5cmIml3gcsWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FYiQpy5fPouOiYgnQAk70+qPUP2B+UzTS07/ZuIk1d0/Vc9U7cehoKWhN90XEOOqEnc8qfj9xhAbTU5qcqllrUmV1MENkBnD+XEP/J3ky8c7SC5v4wK7slbJuDk3M3NgUKLfuRChsKSjYoiPHROAmnYJBjGmaugBe8fk7amoD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXwtQR05; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXwtQR05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751450188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNl7Ngt3KhiRiuYDlu3AWhmnMill6bJNFUWa6YlfZWo=;
	b=GXwtQR05pERJ4pTj5yZLrDcWZiavDIor+yGTECTxi3pCuLteBxgKk21Xhb8/peb6aVDoon
	RHZRTfGVvkCmusc6d7DtYH+mDEUIallmWbzaTU3bFREldZJuPkuhbX3ZOCcSCniFCxM9NE
	03MXgvGq/2xxpw3YVC4CnqywTsAqCPQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-y_ieQub3MYqNFdbmu9jQIQ-1; Wed, 02 Jul 2025 05:56:27 -0400
X-MC-Unique: y_ieQub3MYqNFdbmu9jQIQ-1
X-Mimecast-MFC-AGG-ID: y_ieQub3MYqNFdbmu9jQIQ_1751450186
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2e8f1365181so3625016fac.2
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450186; x=1752054986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNl7Ngt3KhiRiuYDlu3AWhmnMill6bJNFUWa6YlfZWo=;
        b=p8P33013W3QiW9LMIp6hFvYQXWsIMsKaC9Q/XVQDmRbSRPfQteu6XwNxzj3sbGlMGD
         3SMP6tyvZCbnzshttJNjPwqRNOCCz6nACYLGIE6A9I+uNP9rHzaKAIYp2VK1f8S7EN1T
         uRazCCKyKYBMvkz21mKufFFQmfCHDlmPhDDBmEklTgtecfao5oiRZtqgvzvDl6e7yIEk
         K9WED2eQ9eEGZyLtP2Bi+ByeUu2nY7aCdNMzKNEooFqNO5The6pmg5xoKcDQhjvPqkHM
         BDvOsNxMnSjs5fx9jWct4m4QlnTh/imwPhowvmlEb0kPUwvImRNoesKitf4oK9jzT3Mh
         WqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXujiFJsVhI+dckUHd6qx1cBUVpAH962wKL6hc4wfQmBQFohlTmAIL4ZFMwE1Sbpvd/Ph5uopOCVigAObmBFw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2wVpnRrqgm2QLYGXOPVEo1gYMgKoRttzFliMjxmnVO9Lrmdzz
	SbrkhfEJyrAxuwvqf8b6UywByO+t1FAkUSgMZZEE4yZldzsnjrWUzoXX8mBOY475CP4SrMZc/BG
	TTvSnFdgfF7z8srYVpzMzmont2u5rJRwRusZmxSIX2Wd6zAArdmZ44PAma9LLjAXPjeKa
X-Gm-Gg: ASbGncsZfjqBbC+1ctccpVohN8x5YtgNmeIp0bx85C+yOlRaZKpqzNyigK9BftqldT1
	X550VejRdBVlQW1khVSeIyupuIid3k1HDzsVlImreI7R3wqOyWuinT1l6au9T93elMIc1R5vYs3
	NLRS95Aoymr2y0pu7hqoefPvEB4UbUVnqiXikxvi80EvU+bO11ynQZPnTRJzlhz8bjr7PpijqY+
	BgmQOk2fRUNKrn95pKxdsZCwXhZIG9qQkVutelE29HfmfadwEohQHyfjJHU0GYj/VOJOUS2f7pa
	A8nEDNjjjUfcFr3MrG7NZ+4w/Wqp
X-Received: by 2002:a05:6870:ac20:b0:2e9:735:91ba with SMTP id 586e51a60fabf-2f5c7c334d1mr1422481fac.25.1751450186389;
        Wed, 02 Jul 2025 02:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpqQrlTLKRF3KccZ2PdIYCRT6eIHGjwWaj9AB/7CS8NfzugBebe1UFmRYpDGfYy6NDhWabBg==
X-Received: by 2002:a05:6870:ac20:b0:2e9:735:91ba with SMTP id 586e51a60fabf-2f5c7c334d1mr1422456fac.25.1751450185945;
        Wed, 02 Jul 2025 02:56:25 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73b29fd918fsm1247562a34.36.2025.07.02.02.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:56:25 -0700 (PDT)
Date: Wed, 2 Jul 2025 11:56:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RESEND PATCH net-next v4 1/4] vsock: Add support for SIOCINQ
 ioctl
Message-ID: <gqjvhl6rftfygatheyto27kpbqsfc4hixcv7g52nle6grjkrkq@f5ey4iyu7swl>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250630075727.210462-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630075727.210462-2-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: anEBJz1Vl2SJIBqG-KfqEtjT-R9qTUOpPWQzrj9pus8_1751450186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 03:57:24PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..bae6b89bb5fb 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);

This patch should go after we fixed vsock_stream_has_data() for hyper-v.

The rest LGTM!

Thanks,
Stefano

>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-- 
>2.34.1
>

