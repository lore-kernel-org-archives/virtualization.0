Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EAD2BF003
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084120; cv=none; b=EEJX7BsAwGJcrKwI+zMr6YAeZMQENfwc0cGcCUVG47pjSWPJs3PDlV9mrz3aIj8MQyNizjxfJ9Z9QGELPPhqTtHnLUMPetJa+0lLfSbgigDIOIS2SMyM/nBoTYyDoEldSYE5Kh1kdkjUhX6njSxNRbV8vGXkTNkzFNzoRsDmwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084120; c=relaxed/simple;
	bh=D51oDNoeO5PvOntYeAXdoXiXYLEN+Mk2DDfBb1UO+3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upTP0A1/0jnG9E2poechN3lktwHzvvP1jI0HvVpQSEzhvjwvcwviLTGyTKX3UzeDdpLd6J8cW0ENOX646f/4oVYCYSa2taqO1RTTQPhgUH0NJ5Hr+rQZisV+yycF0oEaA+yX4CLhPT/YHgssyrodHAFG6uLLYZhiPIzu4NrRNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bapJ9cQh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bapJ9cQh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2363616a1a6so34829355ad.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084119; x=1750688919; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX+bi5Hgmn9NrTEaY/oPghRXm3i2VfhEfvJkderRFkA=;
        b=bapJ9cQhZ27qOccw6o4RH5uJJ6vLr1p/SjVilGogA7tK8ttHBr3GVgelDn/3kfHleC
         oS2v2IODt38ZoUWcS/UCKstVw93fKeTfo+E9mTcNKThkq+6e1+1aGlTvIExtox7zB87j
         UDcOE7Pd4sYSM9BQLHXi/IRz6ENGP1ac3Cq3duQydlsOwvbceVVCWd6Zr/QeCxAk6jeu
         fyeu3R1lZ8+clFaITZxd0OSncX5bFztb/w426rxlMF3dnhC6ujaIm0grMPlOLnoLTaII
         52lPGgoL6inz2HqbdF1V8aEsGa2O+5xQnM9o17b4d6v4kXcWXS3Ho5SC4oe1ZjU3yinq
         30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084119; x=1750688919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX+bi5Hgmn9NrTEaY/oPghRXm3i2VfhEfvJkderRFkA=;
        b=Jmn9xBoq+KYXAkBVTrmgZxQp8dHBfAQtExHQ3Q30lQVeEZKA/BDLh9mn0asOlCPkkL
         UY4NFKRo+Qn1KLNL2B0YMH/Ll5d055urMLXi/ZLE9BqZhciL1N9mnXRWCwyB/sWLwnHF
         YdvhARa2sENSP46xTD1iTkfi600B3wuzIKsvzkMeahgx8cbZJpwiLwchlv4iy6IppxrS
         NU5J0N8KMC3AaCM9dQ4oMxAHI9l6sCdgWOnqwNdRebyFinUBCWkWfVb8ClkR0vCS67QV
         uUFyCBT0ma7m1Gi2gJe19UfW09WYzUwcTp85iFMhTY/npSzogwYEHeVtITB7lSAfk8yU
         mgdw==
X-Forwarded-Encrypted: i=1; AJvYcCW/N5Tutgz3zk9ApNKNtdjRzQZsipn7JjP1JWMkc2nN5v6ojL9P/DuMdCnJrX2IqNpxgy6754SHuYLuRodZlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaMhSU0HzPgeWwbj/E83O+94hJxkAoGnbi98PociYDtk9xwMBo
	PWSCQJFuWzAi9S7e61vHn30C78wBXokOahsfzDK/oTNMrStz5xjr7H32
X-Gm-Gg: ASbGncsJFaviCIEhjdb7SlrI5qnBdpxHd7bXjWrP815qkTMpT8q8ubsfSYRcZ0QAVX1
	qRm7+8EJSLrtvM9l8BXP/CAyB3OJKZ8SiS1BDttPoH0xSVboQ8Wp8KrqEPDVorckVkWE4z5JE2Z
	wAveQTh30zFO5+JcMO8kh8FyjJmB2XP7ST1Jo1jInKSly9+TarCfKxGOgvovDQ2pXppcDpIcnqj
	BEH97QO2AZAs/8Laq57zMLQZ/k/S/NkWyhUXH79IQ1pS66UPvk7iY+k37v9WWhtEmhRhdJCI8ly
	FeDLdUtCgfka2ACCO+wLRsn7ttZ97kRtSPhamNu8YiumPSyRO83ZslTnBjceJkM3J3ZSk+owXiz
	PTJCtlQt3
X-Google-Smtp-Source: AGHT+IEiUlcugSM6imRNfKRXtWTfhUz3HfPDFOqCZEki+4pDVZ1e5ScBdgWJBhYp+4nuJn/5v4VLWg==
X-Received: by 2002:a17:903:32c5:b0:234:adce:3ece with SMTP id d9443c01a7336-2366afe9924mr140921925ad.11.1750084118202;
        Mon, 16 Jun 2025 07:28:38 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaa9f7sm61494905ad.168.2025.06.16.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:28:37 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Date: Mon, 16 Jun 2025 22:28:22 +0800
Message-Id: <20250616142822.1183736-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <xshb6hrotqilacvkemcraz3xdqcdhuxp3co6u3jz3heea3sxfi@eeys5zdpcfxb>
References: <xshb6hrotqilacvkemcraz3xdqcdhuxp3co6u3jz3heea3sxfi@eeys5zdpcfxb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
> >This patch adds support for SIOCINQ ioctl, which returns the number of
> >bytes unread in the socket.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > include/net/af_vsock.h   |  2 ++
> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> > 2 files changed, 24 insertions(+)
> >
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index d56e6e135158..723a886253ba 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -171,6 +171,8 @@ struct vsock_transport {
> >
> > 	/* SIOCOUTQ ioctl */
> > 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
> >+	/* SIOCINQ ioctl */
> >+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
> 
> Instead of adding a new callback, can we just use 
> `vsock_stream_has_data()` ?
>
> Maybe adjusting it or changing something in the transports, but for 
> virtio-vsock, it seems to me it does exactly what the new 
> `virtio_transport_unread_bytes()` does, right?

Sorry, I forgot to update this.

I am curious that is there a plan to implement dgram support in
virtio-vsock? If yes, adding a new callback is the right way to go. I
deadly hope to see that feature. If no, will do in the next.

Thanks,
Xuewei

> Thanks,
> Stefano
> 
> >
> > 	/* Shutdown. */
> > 	int (*shutdown)(struct vsock_sock *, int);
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 2e7a3034e965..466b1ebadbbc 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> > 	vsk = vsock_sk(sk);
> >
> > 	switch (cmd) {
> >+	case SIOCINQ: {
> >+		ssize_t n_bytes;
> >+
> >+		if (!vsk->transport || !vsk->transport->unread_bytes) {
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
> >+		n_bytes = vsk->transport->unread_bytes(vsk);
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
