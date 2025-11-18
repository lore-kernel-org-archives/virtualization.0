Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C43074B3
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489566; cv=none; b=fF4uC0dQnwaiWW5jLmBQxOKqBPlr6fSe23MGIEdt5GQC2Smupkfj+2bG+2vDU3NdBRee58/5kQQQdNL2FjkTSRx5Z3YEwrDmLUNCx5XRy7tzmCP7fKjEK1pQgcmlAImLoZA34+FYeQQqv4UHH6w4Xn6nTu0u0UBvEe0iF3PXJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489566; c=relaxed/simple;
	bh=er1J307+KJnRBNUgsTZ17cqFXn2zardiLpzpxp0mLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lpa+pUCGrfazi+eAUW5ctGU3WWKTAIPJjdh0/SeaJL0V20WXmwNiy1gflNi6fZwlg+rfNa4zLA506mH+L8EcGSDHTHJ+6xYsAERIwDDVCVaEazGRJJct8LGsEdMmshJJ1Fl2HMFGKWX0DV4sVZ0OFM1vIOnLIEZxaR+Ke7UYCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+v60MAY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+v60MAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
	b=H+v60MAYYmbFtjm1fCpTfY3J3kxcH8TzOfD4McMBbG9WACu4RGcHwIcj3n7hFZJNEUnnXn
	sLUUw0llynhcttwAHU0luswTSNInMzbzqBcwDKZZ9t7xs/uDIIkyj2Lojlwy0aT6tSX8do
	EUuN93Ok7NkqiDbdQrBxr3qpUtpzQZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-GehIEU9ENDy9sLLy_3M6EA-1; Tue, 18 Nov 2025 13:12:42 -0500
X-MC-Unique: GehIEU9ENDy9sLLy_3M6EA-1
X-Mimecast-MFC-AGG-ID: GehIEU9ENDy9sLLy_3M6EA_1763489561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso71690865e9.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 10:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489561; x=1764094361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=P1W5VMXcmmkHGetfs3udiU9oIBzsEvthkkNGmpGeDm34UymOpaFR7S8+ZGNMuX82U7
         0GlMQtbwGhx0rdvLR5jzObtimUWzEDAfWH2AFplZPLhuRtnWoxuLP68RMJz/owtsEjIe
         o/95pn69U/uJwxrtCSiyRg1VJBmCruv2l6rpjeZJLWWF8OuN21C8z8wpS38O6Mh/7DXP
         Gf79mSxdwkWJTP+F4mnB1/qXXn2m1/aJeWmjXYSADYh4ij2wLxbn7GssdI4K/wNb/cQD
         wbpI+szun9u+htzj5vJK6OhnkpptVCqum+8And5XvOcITi61EVmgdihZwgQKDUoM91ZB
         Vh1g==
X-Forwarded-Encrypted: i=1; AJvYcCXuniE+cyPAgHPwoDko3z6sYDUXgyavsiIIe66GCDKTbsG+zZmTqSzceEuqJAvhTgpx7qz9UZuqYaVOx38uXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywl/30//dpvNmbkVSw6xpqPr8A/TpJn9X06vKJCwILz9RsfAyl9
	NP8c8eSKSvQRd33E4Air2JNUryLh4f+pFMIKFrMdy56GSQaF1NMVC1AQLEvpGqTjnQO/RWDMAWG
	htlrSJvGRMl8GPl/hk3dbs9/ZLoyITpG4/63B5TsEWGg68oDaJXIDUFvBJHE2bO6JtmPy
X-Gm-Gg: ASbGncuuMc7RqR6PJ0QOwwJEyZhmEPOZX9EBWOFVw9flZOgoM+eqTBazkigj+inBfho
	QZhOynXXRS59cFBE+K1+IiX9kziZL4C28Rof6xKUL6mLxKmag4voYL93gDJOIMpcHYMUmjgcZCP
	dUptTVErLjWW9tUEX6EV/4gU8LsQutDjszns30HZDGWXokGp4kRdCgcvkQAqa6y+wxi2X0WqJXk
	7pIigOlg+tyEa16oKSjPrI3QX9J8ilxmfaWAqcc+BUlE2ozsBukMMB0PDU5okNyYk1CEvfLtbn7
	1ycawSdUUmLMB4A/d5B4JbLbhOwoIFgSNYTrX51+xuijHSaMAhoI6yF+sCGd9MtVFr74cEDKfL6
	1mkAED1fc8DDgTdbPUH9ck7jSwgFxaDYRjBWoPHIHdms6VXAwoEsLJuwY91E=
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144928515e9.32.1763489560855;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpTmbeuBuF6OCuotMnf25yLK3sUbAbvYEMuVVlK2CBmGppKS9Ccp0DvA2VuQ7IZI1U9CwzQ==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144927985e9.32.1763489560327;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm4356375e9.5.2025.11.18.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:12:39 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:22 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zwpwgzf6opt2qiqrnpas7bwyphpvrpjmy4pee5w6e3um557x34@wnqbvwofevcs>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WWgFiQDnlHozEdWGLnmnNJNZDrjsmzmiaGx0m1ol3Gw_1763489561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 17, 2025 at 06:00:28PM -0800, Bobby Eshleman wrote:
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
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

IIUC the previous patch only works well whit this one applied, right?

Please pay more attention to the order; we never want to break the 
bisection.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 168e7517a3f0..5bb498caa19e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
>+
> 		/* net or net_mode are not defined here because we pass
> 		 * net and net_mode directly to t->send_pkt(), instead of
> 		 * relying on virtio_transport_send_pkt_info() to pass them to
>
>-- 
>2.47.3
>

