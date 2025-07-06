Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12811ACEDC
	for <virtualization@lists.linux.dev>; Sun,  6 Jul 2025 04:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776637; cv=none; b=Xg8ihA76wNnh+NeCOmnYh2ppx9NBu1C7+OXfK4V5AUXmlwWGy5SOR4Gx1FtqKsBBxesnMd+yZPJE7rwvqlAfQgW/v9//vWK0Cuw9hwsWlRf4lqU/DBShqt4OlKLma+sLgfmVF8I/AzmeKvr/VGvplIxd/70rH5otgMFdF8TbUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776637; c=relaxed/simple;
	bh=lrNsByWI4+JZUOhPSorgBp0TBt5xNkaU5kzScC5uvPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jalav3xev9ou6O6pHN3/mbdE1vqcHB8eEK2qAHCpvusHVLro/ZI4LCZtr4gCdfUIPUoz2kncKUgk3SUb4A6UGVwQEhhayB9laVCfk1o4s8zDwqoqdDrKeTRmvUmcH35W9HW8v3J0v5faC0+Zp8kKO9Kx1KqvsIBsGBDHsUbNYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBKSi1F9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBKSi1F9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74931666cbcso1799488b3a.0
        for <virtualization@lists.linux.dev>; Sat, 05 Jul 2025 21:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776635; x=1752381435; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enAMJL6mb/z9WNfWVziA8KCdR5RF2FfP9GwDXl38f/E=;
        b=cBKSi1F9ubCdEq1781LjLT/bmKq6iEFMC8rvjeIw0kM1q8aFyQBpeIw0AnvPNTyP7Q
         c1cFEw8Ks/CKVhiXq9cAECNT5E93JaXo64yBx1sywqfmjyvi/FXD4CLGGRcVsk+nTnLI
         NF3S+wxgIu5Fwb+xkZcQK5qc0HovnVsJvVHwv6/2af01uVWOaS53C6sN+3GIyEJ6K0KF
         X/w74Iv1RTOpL2rNf7oxl1H2M6kGx32elceXgNVBLNR9zbidALK+fcyua4SRfYbLllWa
         rGNYX7dmMn3+x+RGCIppWjUZmiH1MKP7cEC+PKXxgCLvrQ35jJzR58A9Du9797twjSwU
         Q6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776635; x=1752381435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enAMJL6mb/z9WNfWVziA8KCdR5RF2FfP9GwDXl38f/E=;
        b=dP1t4BY6zIsZvfGrBnmCyx3p9bYe+MrVIx2iC3zGQh5sAMze3xbbNWVCSdEApY5llI
         ojGukTtY3PzL4dw1PljIcuaXaqQNknej0GpKFgnq6nzP3lZZv8AmOYCLb3o+VEdY/5bC
         jG8CgvP1i9yYJvaAlvTWlC55n/oce/YBbQnAQ1t/NMLMzprlGtZXcOwLcLNiYG1Yce6g
         kU3vkmPISaWM11kw9G9S/9IYOlAUT3kzXQEMchnSv10JTK1dJBsPB/cE6xuIzWGXU667
         KXjI6MyU6WeMVSp8nXCI4hiBnpbIvDq4EYsWWRpTjUoNGJcCq4BfCPrw5zN6lJU6WLHi
         KzJA==
X-Forwarded-Encrypted: i=1; AJvYcCWt14nSVINuF2xVt0kPwj8PHbOkVsEji0BCSCiuD416YoPp39mmMt61usq9NTnyrBjAc30x5+VJaOlafzOgBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf/mTj0Yc6BQQmSIyfnYEA8X0S+TuOQCLs9slojQOQlQ/R/IvZ
	O1ubbYxriHaIQgchES9vynYNQ9JZIoKOth7AWzU7+/J7h/RijcWiaYlv
X-Gm-Gg: ASbGnctTSWul6xCNqrhSmgLJafJZF09IRiMDcGtS5FFfCNVdVEfHiej9uoa3a0aSmw1
	doawOQOFsuJW0I97UC8hXQKGtPw3W7W5VLKsTgT0bwn351R9w7pKzEZJrURaqkMId/8jINxO/wA
	NQ7gy43OUMmsx3cM8nCOvDwSmGMHhgk13XK3DD0c6iVkSbWu96BmFXKx/usXLceu2OSiDXzCk7C
	H13E+o20gqrxjMwdlHBUmOI+vTWhTk0Qsd6lsecD/vZLGuCnGoySfLiD4khI00n40f27pi9NfkU
	JeUy9pgDsi58jZzcphq6qwAO8Nav2AO0ltPS5eLwMf1dvD5XmIQvTRXEQ7dnHk4Ylg==
X-Google-Smtp-Source: AGHT+IHQIGrgZb4Ga8DvGclOdGTppLhL3WybIIS3/IKCgYv4g44bAwZQzlV18+HfQ/D8ucanu+qLQQ==
X-Received: by 2002:a05:6a00:4b10:b0:748:f1ba:9aff with SMTP id d2e1a72fcca58-74cf6ef79aemr5032449b3a.5.1751776634875;
        Sat, 05 Jul 2025 21:37:14 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:14 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:30 +0800
Subject: [PATCH net-next v5 2/4] vsock: Add support for SIOCINQ ioctl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-2-8d0b96a87465@antgroup.com>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
X-Mailer: b4 0.14.2

Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
socket. The value is obtained from `vsock_stream_has_data()`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsock_stream_has_data(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 

-- 
2.34.1

