Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628563491C2
	for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735109; cv=none; b=cp85AmEio3x+B/Qv7vXGmd6H6OAK6bKBpr32eaHANM4k5jiYv6vOGeCSrodt9cgOMHszRBJGCHq9xIdq/PLLglbZ/0/GtowZDm8n+uYbWl2Y+eTg2abThVWASYzHYI1p7wySYv/HZxBYJbv9MBqx6relXzt3pfHaRvtcUeWEDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735109; c=relaxed/simple;
	bh=o9M2JHEbNISdyNlluS6kSN7Bd+fpVWxyCYhFzKhFfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t/lgzqHRksd+E0Kp4kzFQ9jvAh3q75uvChvmgCU/5U5d4UE6WQvv6XJ53kLJh4MAe1gY5WbNMa/K55+DdeYLoxEXixIVx5WUJLz3j3MZR6I6ktSkkHIvPTi/zY9Bk9yL/23h+5wsTqIldbPEk51EKeePv1X/b+azwYlDGc4jRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aboBxoC2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aboBxoC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763735106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTtpdEcKnjIG7GqKPBF/r/wV70DsgCEF4sphSKTj1uk=;
	b=aboBxoC2ViscYERQ4Ueye92E8s7AixEBt8q1JIV1/48s/Lz3vHZiEPhKE407hz9BQRA5dh
	CAKKcp1cy7ntg56XGXjOKyElk3ebBLod9mECL9sFQMSgqi/Dhbp5n5fYnflQ/5AwIID42D
	ELVGXC0Q2CsSO4g4F7cgKk8Z0zYJhT8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-PL1tPY7uO5-e8fmQoOGa6Q-1; Fri, 21 Nov 2025 09:25:02 -0500
X-MC-Unique: PL1tPY7uO5-e8fmQoOGa6Q-1
X-Mimecast-MFC-AGG-ID: PL1tPY7uO5-e8fmQoOGa6Q_1763735102
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73586b1195so292896566b.3
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 06:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735101; x=1764339901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTtpdEcKnjIG7GqKPBF/r/wV70DsgCEF4sphSKTj1uk=;
        b=Dy+n7udIwiCMvWbdcYTmF7ifSs93eCw5HRFEFnc98fN+SlzVy9KoTQ8AIVeV0cx6mN
         3++57iug07rzLDZFf02x+BeeAvGnB0a59KNzfxM6UZcn/7fMBbmAh22iKt9KoJAd3F+7
         xYtN/II2K0LusL2600eyEw786ziX+aYtW5+3QTCLWvVZtwYawHFvg4EbUc12Aee0oeaa
         W6/dANt1XC0tb/bvf/GUTA73uVcDARFtiadArbCPCWZy4ye1xj8Ka8JPWK/9VXRHmxse
         Sp1MwsG+tc3A7AAAwj3Gi+b5+XijxtN4R9d3GJ3gF2WfJ8pq1tmjCYTKfwRrdM1mAvXl
         w3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqTshTI8E8gFV8//u4F3sGjnXAxlR4Hi/6HpedRHc0tv0HQadDf6lcCfezLae8DMmCNeTXNCXL/Mtq5dmjWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZIrFLtAbnwP6CtMb2cfz7fPyFYlx1gKOEI2qJ9RMGSaWFbExy
	1zd3ljz3KBeZGw41ASZXi4jyjNZlCv+sjyne0bi6qtlQm0ce3JZ8uXZmh1Kl5ma7A6O3cDzgzfr
	Am3xNhxOkiMZnZOcnUl/TuzWciUxfgPeWT7yT2XegJ7XCy8rK50I506+lajSFrX2IInSK
X-Gm-Gg: ASbGncsqc3ub25rmH3vuqexTLKUtRe7qmWTeo6OTb3grWsJKsByLJI8CtwiAVS05jvk
	VmV3RhGgG0eiC4214GezOCoiWPQuPv4ExIQzYxnc0gS9swUD/J3vPqYLNB8HMRCruh0Xn81NcBP
	l79898TIbxlzEMUTn7CBqxtUkIqd/BeYNhh8rnyloddUxh0BVrG++qufWq0RICtccTAsTQhAQ9s
	Ty/7McS6+hK93xkQPPIHKH/mFnVVkd55UeLKn/6qvbDbacF5cgi84jxBNMp+1VvQYbM1Y5b81t5
	JBEhNRLcgVLHMglYGtRxANUNbH9gSxKf2YzgJU8y+Ob/1ry4zMS5JJXbCGIG04irN+tSPu7i3A2
	+mobOdGMRY6oSHmeS/j6h/LkKeuWmpDaGe9W2kvgJunEWo5TL93yiuDrZTsBPyg==
X-Received: by 2002:a17:907:78a:b0:b73:7a44:b4d5 with SMTP id a640c23a62f3a-b767173160fmr270334366b.41.1763735101316;
        Fri, 21 Nov 2025 06:25:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtSacfGCKQN2XL4Y7amUQs6PWLpmUaZtWzXvHpS37APdsI6uvQyTUfhHU+LqKi/Zo8NS2htQ==
X-Received: by 2002:a17:907:78a:b0:b73:7a44:b4d5 with SMTP id a640c23a62f3a-b767173160fmr270330066b.41.1763735100857;
        Fri, 21 Nov 2025 06:25:00 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d73430sm477526366b.24.2025.11.21.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:25:00 -0800 (PST)
Date: Fri, 21 Nov 2025 15:24:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 04/13] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zxusewvyolqclv247ezr4zflxkjmyo3jvxu2c3xxeggtsbgv5h@ocp6lxkerr6t>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120-vsock-vmtest-v11-4-55cbc80249a7@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RBmKr0JnSOUMrM5RTRwVbDg-wrWQWQUvvpenESxcE28_1763735102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 20, 2025 at 09:44:36PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Associate reply packets with the sending socket. When vsock must reply
>with an RST packet and there exists a sending socket (e.g., for
>loopback), setting the skb owner to the socket correctly handles
>reference counting between the skb and sk (i.e., the sk stays alive
>until the skb is freed).
>
>This allows the net namespace to be used for socket lookups for the
>duration of the reply skb's lifetime, preventing race conditions between
>the namespace lifecycle and vsock socket search using the namespace
>pointer.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- move before adding to netns support (Stefano)
>
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..675eb9d83549 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1165,6 +1165,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
> 	};
> 	struct sk_buff *reply;
>
>
>-- 
>2.47.3
>

