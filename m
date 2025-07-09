Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D3147C9B
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073269; cv=none; b=LG0S3/4yWgTxVLnsnoQVC6rOBkv9r7BE0K3YvYIcCXyoPfaqg0n88kQ6bCyk9ikr+MQYsT9wbEVZm5gjYFb0i3SEkCP/NH5wFUczrH+eZw1PI+YzYmw0izf+KiSWX8Etmes5/Ntwk0m2hgS2fc3ZK/vSXxvqlXDxQYpix7AtmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073269; c=relaxed/simple;
	bh=Y9ykHGirYpNqtGJXkqW0tDJEz7IdqI8cXIVyGrNiyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r40MlFpKcUYSeMkLPUNmSqNxzw07Pj0cfyyFmFs2HudfeVqasENEFvBTZWLltQhV46mjQL6coZ21Phva9v6ABn8KhcXAVc4V0+QGLGWpeQC7WCfe/elXF8Qvo+8W9FZXjYtu4ozFsthZpo1oY3LhpGOBLbH7FwdSKAbXbV5Vo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XB3b0WVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB3b0WVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
	b=XB3b0WVk5QsQOFrfvT25/xBdWBT59dVu3Syc+WMacPX9ZbAZJTYX9K1kyqdM9VQb5TflQM
	9Z963Zz/0Qp2evzWki5f/x7te2/RjqhuLwrGGL4rAVw+Of/Iwkd9EqWN31uV9Leq7O3NWC
	ckfJ82XFY+XYc5axN5PzJHNbrtilH2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Rl2U6Sb9NXqZPFFlJtAi2g-1; Wed, 09 Jul 2025 11:01:05 -0400
X-MC-Unique: Rl2U6Sb9NXqZPFFlJtAi2g-1
X-Mimecast-MFC-AGG-ID: Rl2U6Sb9NXqZPFFlJtAi2g_1752073264
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso95825e9.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 08:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073264; x=1752678064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
        b=K4fQveHLS3VyYkmsc9YHN36tdVuRUdSCelJUzckTWOvOIq5skfhztu3Vdls4r4Oa03
         s0nSoHAfO0KEr8DiAnuwIuQnfXJe/0D7EUJctjWXvJGhY9BPdKyl8K/NUu62xYenlmPe
         L4BIlh4SFBh6G4OON5GILmrX4CwdIrEuBxguECsSqiEVAPp2xv4OUixMZuvpYC2q5cHk
         LGBAms7aEIBLGjc8yJQ8Nw+7edJKtlm/fFImii7cxgpXt3CPK1ge06ZrGJdJfW/cY8Ww
         fVKN0iMfBMupE5NqS5dLt2bB6mikAokax+S6eyKkEi4PMtAIfoJdl6AHA4e1+TVIONOi
         BSDA==
X-Forwarded-Encrypted: i=1; AJvYcCVoIYwPEgQ8N3DqLxsDkxsAb1z3zM9iYENVPOlS0QrGz+S4dlVQ4zHOj91iq6j6hdQrKIpHqq8IYt4aLqwS0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+4NDMz7QHCH1V62iuDYBdQpJY6ScOGRkM/MtJ4n9j8YpRcIJj
	LyVCK70TFnM1JZQQgnhqXVh0BdlruK6i7ocURvMWZ1pCnLmUF7lczbYIK9ua86VfadTxvPMfzP0
	19StgCtfu4OpFtqVZaXpsqA9TMpN6A92TjF19hXheLnEfRXy57Nnu77AeHF6G+3wYX/r/
X-Gm-Gg: ASbGncsZWgY1K1t0vtrsg96g/4RgV0+zK/APpJFA0zW5iWrSuBofUxaeHc471Rb6jId
	YfEQAaC5lQ2AvpkIZE9eDvhUVlFpokTMbn5MoQD6JaR7iNB9khYDhDnS5nz+j7Z1FiORg8F3IDW
	Ui3jyr/fzEdb8n+AeCQSlzFWpYyznlvvx/WJwP+KDpIEQIOVPRR6vyndaeQ67v7ShkkmziapPpj
	GOaIcjvAYNZCqp0ahEOrBKtlkHAaz8kKf+vaShCT5vYfgAYjJUgSuUgXr4mFpTB43ZAkYZ7/e4o
	Vk3IIRaINItpug7LOt1sMxD0aKA=
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72509265e9.8.1752073262629;
        Wed, 09 Jul 2025 08:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxFA3JrFBZwnjsmUsRBbJZ6PJIlFVkCWBmo9J2d0qr9LD4rFkvuvX6RsAssbfW4rug3RVliA==
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72507625e9.8.1752073261100;
        Wed, 09 Jul 2025 08:01:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm26116305e9.36.2025.07.09.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:01:00 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:00:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <h44zrd5qem6vzcmoc45kccx2xaex2lnx6ybf63h5tzc23yfppv@toywbfazwjri>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dLPnYlV39B9wps9fNQF6phRfIPvZs-eO7tvNLPgPRXc_1752073264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:12PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
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
>
>-- 2.34.1
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

