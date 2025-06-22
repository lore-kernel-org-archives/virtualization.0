Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECE5CDF1
	for <virtualization@lists.linux.dev>; Sun, 22 Jun 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750600765; cv=none; b=MAhWEWQ/Rshh8dByeOh5VD8nKYmIS4nS4RYiSXevDvy+K1e1SjkrR/4fWzg0aF9K2QFF5YRATeH45sJRXkRGHZn9T3Q3FqSTTFVRyryUUz19uHIEs8e5jc3fJ0A96u5JrwkZKMTfzOS0aLT6KG5xGgRQAqa/AO7tg8p6ltaXDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750600765; c=relaxed/simple;
	bh=UxKMEiEskUPW9t0F65Rgb1ZCmJRY9zGpr+eirXMl1cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrXEThxb+JFmD0ZwAfWaHYg2qgS567xI+LmQ8gOef/jso4uwI/AIVHstpRZyMlfjeDkciCE/QrOSkfZ8/4e0bgZoYEjXmICV7B2WKN8iTWRag4clsAEDEygRCVeqJsWnkN5ijqm7j90XjoyA6wA6VQGsl0pyZGNvKT/E2yai+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2IKs60B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2IKs60B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748fe69a7baso2926228b3a.3
        for <virtualization@lists.linux.dev>; Sun, 22 Jun 2025 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750600763; x=1751205563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CctixpwR27qpFLNeLtbKOjrAbCl9MvTJF19ZD0qLuo=;
        b=B2IKs60BO4tJdoDRu0tf9lMMoevbQu6GLj58278fFGZEjZcg+M0/bmLcULdv6tJeSf
         vEqbZQBZLkQy7nRT+73jizlYb0hu8R6/2tA1FviswaDexqTht7k4mtJ5mPBZoW73jmg2
         AqyE4bJTOUzAzL+C0CXKzt0w3BXnlr5Du4eF5xmtxMh2U3T87+7IR73TFFjyllBIyfFT
         1+Oh0D/TKRsVI2S7P51uNzL8EvfY0ano3NV28/uxVDcHiMVmSNDEYK9y+/gYGizR2TuB
         xAJl5V+/7GdwChOgotPxBr/Kd0HWSpGXiB6Pgy+KCsplCpeavvGXbu4sfXvtQobdPP0y
         +XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750600763; x=1751205563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CctixpwR27qpFLNeLtbKOjrAbCl9MvTJF19ZD0qLuo=;
        b=uoMFuu8JceujoaaJiOrtaER6Gx6DYKqvLPIZwNnSlDbr9ilUVFKVOvnF5psDhBj5Mb
         MJxL9nxo1b0lyXm+MpJ/Ii7mGbl9vCAmTUZ+UAE00VA9vkMmvb5Kup0Lm+sH1UCCQd94
         ORwneFNLxWeOosROxFVjrdClMyyviVSPhrStBpajpzAIm4g5/qUTKxq1vqozAVkHjdGq
         XOteq8d8v80sKsMtxYA+ASBd0fXHnFkTqh9KYXvbEvXzap8/uIFS13HX2Ga52PnBM6ZT
         /kNu2lAMcZiERX1tDTvN7DnxGYAJxvDQRMiK6QciYjCU4L1tLP7NIDFwvkSRKohUoroh
         cGnA==
X-Forwarded-Encrypted: i=1; AJvYcCW0lLaaLsNF7y/uUxjpYFBg1SK3fVQMltd/DFLxBwVOPYx8GJxJTDlteFLA+xr+vfeNVY7KKyLKXi6pURoOeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6/SKw6ea4g9qUkrHQjcwCy1i2U/S+19wNphjyQwVqM11TVQhs
	uSXXRb0Xi7pyfkUSPa8srxs3kKZSHurDPNhTrwSREIGvTF44O7zUT1W+
X-Gm-Gg: ASbGncujKERJmMrV/StQWNEwmNpwbC2V8rDIZflBdPFMOBJnZARaw/WPrB6W/47xx3I
	vzpbm6VrNW9DPaMBTaeKu9kHmBRGtGVfFxkUUBhTTczeKLGHOpDBz5mj9EqvdIm06pRa4Ch+yRl
	M1zASFXMkNr/Y3mTJCSK3G2uF9Hs9/robMsmM7xyPT6Sf5JP2dhsfsxGdvLZVI7quDe+nhSnnuM
	JJ7z4flTYzuOv1bBbnv4u4+pTnztLeE1UGL+n3C4CEdhr2jtMbf0DG2KfzKeUoeR3HK48av344G
	CWB7SJROv6O+bb1V4LeFPayUdrOfN29UTGn2klQQXVQWdLlYGUWTx+L3uuvmpCiSNxJE5/7czaU
	Lw9XG0mQ4
X-Google-Smtp-Source: AGHT+IGGPVZOhGf33+4x/8I48rOosb9DE+Jlj5P0FJFQOP/wdva4gvlvzXjTkAkxs7+rDh5CXvmoLQ==
X-Received: by 2002:a05:6a20:9187:b0:21f:5598:4c2c with SMTP id adf61e73a8af0-22026d8d928mr13077235637.13.1750600762962;
        Sun, 22 Jun 2025 06:59:22 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46b497sm6004931b3a.6.2025.06.22.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 06:59:22 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	decui@microsoft.com,
	fupan.lfp@antgroup.com,
	haiyangz@microsoft.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	kys@microsoft.com,
	leonardi@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	wei.liu@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Date: Sun, 22 Jun 2025 21:59:10 +0800
Message-Id: <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
References: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ACCin hyper-v maintainers and list since I have a question about hyperv 
> transport.
> 
> On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
> >Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
> >socket. The value is obtained from `vsock_stream_has_data()`.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> > 1 file changed, 22 insertions(+)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 2e7a3034e965..bae6b89bb5fb 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> > 	vsk = vsock_sk(sk);
> >
> > 	switch (cmd) {
> >+	case SIOCINQ: {
> >+		ssize_t n_bytes;
> >+
> >+		if (!vsk->transport) {
> >+			ret = -EOPNOTSUPP;
> >+			break;
> >+		}
> >+
> >+		if (sock_type_connectible(sk->sk_type) &&
> >+		    sk->sk_state == TCP_LISTEN) {
> >+			ret = -EINVAL;
> >+			break;
> >+		}
> >+
> >+		n_bytes = vsock_stream_has_data(vsk);
> 
> Now looks better to me, I just checked transports: vmci and virtio/vhost 
> returns what we want, but for hyperv we have:
> 
> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 	{
> 		struct hvsock *hvs = vsk->trans;
> 		s64 ret;
> 
> 		if (hvs->recv_data_len > 0)
> 			return 1;
> 
> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
> Do you think we can do that to support this new feature?

Hi Hyper-v maintainers, could you please take a look at this?

Hi Stefano, if no response, can I fix this issue in the next version?

Thanks,
Xuewei
 
> Thanks,
> Stefano
> 
> >+		if (n_bytes < 0) {
> >+			ret = n_bytes;
> >+			break;
> >+		}
> >+		ret = put_user(n_bytes, arg);
> >+		break;
> >+	}
> > 	case SIOCOUTQ: {
> > 		ssize_t n_bytes;
> >
> >-- 
> >2.34.1
> >
