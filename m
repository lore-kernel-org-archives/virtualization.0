Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D2242D70
	for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768114018; cv=none; b=u/e5WoHSbWv7sZqK28U1uzZFXBB9/aGSOKL/0OTyje7k1+i08Kd3vSvbf04e3H08r8ZlgN7mErXjqGpuEpTd/heQ1mVcB9XlyJ0tO7gvMcwbaAiDkdwjc20zhUarVCSQ+TDaxK9EeFzg9X1eXl9/KSxOfpfWp2pCa1pYSxnFBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768114018; c=relaxed/simple;
	bh=oJg0P4BTaPqRMdngCealJvjnKfXREQ/BhzD4UuLebrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lTh8qWaEFLR6qxrIgtEuTLunNT0qHg4Dmb2S6xbzkThhvD6m73FU90cGFrjp5M0Xij+lU1b+MF09ysosc1yYi/jqoV/Dc+Fn7C3mT1FHSqx+b++o7vYjgq1ZzMNfaO4xuEKdbGaR9txycW6Y3NMa9M6pojaj8cnc6tJGkbXMjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH4olwtb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH4olwtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768114015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
	b=FH4olwtbDVkqLlTmiOQY8N+ejqjOeXDcYMPEnh3d+m/Zw2BLexF1MSjrwBdsc54SzGJgKi
	PVUFzPtcPWmp6orE8sWx40eiGUgNIIuB3lJrHZbR0ZrEK9YgW7WW1omNfecrgIvwB2qwKc
	ubk25IHifgNDHBF0a9NbmMdaHByuX3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-49ALBmkgPs2C5-dd88DU5Q-1; Sun, 11 Jan 2026 01:46:52 -0500
X-MC-Unique: 49ALBmkgPs2C5-dd88DU5Q-1
X-Mimecast-MFC-AGG-ID: 49ALBmkgPs2C5-dd88DU5Q_1768114008
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so37051085e9.0
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 22:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768114008; x=1768718808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ7hDBixKgHX7F8NTcaObvBvSlkQPDzeM4vIOMax5Nk=;
        b=rNLXaQFH8RUxAi1DMjIAdnEptANdKpTcD2ATF4KC8uGgk4tAvzsz1+msc7EGiZ/Jmd
         xeNm1yXyFLrSO0pJvVRbcdIpirSPlvxDWADU9T+orCSTQFcCmMoceYnUzBS7YomGbh9Y
         eJeyi4QhWVnpzeMufmnvVnREJeQbXS787gcSM4QpSGOhCFgTbQxYpTyG6N8AT/LLzRpy
         EQWdqUrR/GYY4NAbxfyeVdz5P7E1K3ySkIMmoAKM1LMDWmW9ujahSiTLDFbXCgf7YXx4
         pEsn2UARuA3DflB8IVqAGo3qA0O/iI+wN4OejkDI5sE6X8monJs2HrbWh8uu9ILOplQK
         5NsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW12IkF4b0iXtJ/6bc4FFiqR7S44q8lxtup6u5qsA1I5gVLhntyoHVCv5IBh1sq6EPC5ZcD/F/pXaWAkT355g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcTFWx0o+UviGms2GAjL2c2jn61a7AKAxX/HdR8T/jbQiSC/PG
	bgk0HfkXXAeEXmWIN5DUkPtLESEmsZzeD4yAGdcO/B84R4ybaGU0ZOJ2EzEZTXE6gR4rtH6wNw0
	6scvCHYi5Dn15GX7s7kP+hIPXDY8cIfoSFxkdvp5R+vzala/mydSsS3uCDSXzUVZHQAs/
X-Gm-Gg: AY/fxX5rFDHzUlBYPjb+0bkkvm+Bbr6wCEmVIRgWcBcd4zMVqwlRDygy9UcYm1Sy769
	YiUxbC0I+32Ur/AwCo+FCDfXQBjsvj3Pqa+T/HwAkFMpmkpRpZxsvoLJxtLfLgDtpw52U9p1kXI
	goHDR80oWKsQQnLX/ysvvEeFHSyfjzpt8/+71rzNRk6y1NHdg4lTWnPtmlFyy86ZW2cDmVHSunJ
	DZnAfjZFAaZ8aGSNCZiYa9uOil49DAai0MtLTYJO5tx11ZKbhwQhRQUAPfnQfcm30G7GwFv572X
	HSpztCnglrISqF7Dos/0C78JCLRcCBEdkuQgSPLgZbMi6eoQymtcu1U1HmyH3JHxO+1DbNCEhVG
	RMskXO3dmTkwtxRa7B7ypb0N8+GMXMgk=
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047545e9.3.1768114008085;
        Sat, 10 Jan 2026 22:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2KhXxY5wNvI0FhPEnxgIqYrJLuszMdozjkRjhQaSurG33CO00c2A2r97DP2kFBqnSLT0brQ==
X-Received: by 2002:a05:600c:444c:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d84b0b303mr138047395e9.3.1768114007653;
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm102237315e9.1.2026.01.10.22.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:46:47 -0800 (PST)
Date: Sun, 11 Jan 2026 01:46:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 03/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <20260111014500-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223-vsock-vmtest-v13-3-9d6db8e7c80b@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U1OczgBKU2rGdfGd71cWRgXeONOJsLEZCr_ritCQPLM_1768114008
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 04:28:37PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Associate reply packets with the sending socket. When vsock must reply
> with an RST packet and there exists a sending socket (e.g., for
> loopback), setting the skb owner to the socket correctly handles
> reference counting between the skb and sk (i.e., the sk stays alive
> until the skb is freed).
> 
> This allows the net namespace to be used for socket lookups for the
> duration of the reply skb's lifetime, preventing race conditions between
> the namespace lifecycle and vsock socket search using the namespace
> pointer.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v11:
> - move before adding to netns support (Stefano)

can you explain about the revert please?
I looked at feedback from Stefano and all he said
aparently was not to break bisect.

> Changes in v10:
> - break this out into its own patch for easy revert (Stefano)
> ---
>  net/vmw_vsock/virtio_transport_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index fdb8f5b3fa60..718be9f33274 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  		.op = VIRTIO_VSOCK_OP_RST,
>  		.type = le16_to_cpu(hdr->type),
>  		.reply = true,
> +
> +		/* Set sk owner to socket we are replying to (may be NULL for
> +		 * non-loopback). This keeps a reference to the sock and
> +		 * sock_net(sk) until the reply skb is freed.
> +		 */
> +		.vsk = vsock_sk(skb->sk),
>  	};
>  	struct sk_buff *reply;
>  
> 
> -- 
> 2.47.3

