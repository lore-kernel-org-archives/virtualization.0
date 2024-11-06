Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DA1DA2F6
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885772; cv=none; b=pPRe1wVWv+8YKscPk7voyRNaWAOmJQ4I8VubnLCVaxURv/7NElHz0Y18FqX82E4TyjdWo8dri7/IO1oDGKbu7ulBWKESvKH+ZKmYPz8T4FVtTx++YU5DyKdrliiD5lLK9BvpEsg7lwlO3GOZvrGjW8SClGBo+D0Sljm8bJ3PZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885772; c=relaxed/simple;
	bh=3vOUKvnOfreuFAxHGPUcHTCrhg6SWNX1a08DlVUzJGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pb2I1sX39HNqLEwA/gas2QUImdam+6u2W8lmEEbmiIQeHgNQwuhfceljjS5CDPYiJWHzvepNOJEscpcOsGxwjFh4b/XyVIwHEAHKJwiRaEqVS89PBqEtGvjxcNaK5UDsty4NfuFHI1Ex2hulJWjMBDzu7sd+4kOERJUBj8r61E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=R03o8jku; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="R03o8jku"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e6048bc23cso3598144b6e.3
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1730885770; x=1731490570; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/l5vH8OJnrqRXgkQA/vYQVnL0JscbhG9csXji1nC/4=;
        b=R03o8jkuYSgPSDf56gItqjxQxlPG9G95w8WcP4LUTxD9Y3dj983+QV5+erMwl0EhRy
         VwRLZtBXCcJ+6gm1t+wx75D46Bq4tjzVVZBgfXdAGHbrYivY2TVoneeIttQK0IWGQq5M
         k6JfP7Z/uYdDWzsoBGoKWML2lyalf1u3L9XnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885770; x=1731490570;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/l5vH8OJnrqRXgkQA/vYQVnL0JscbhG9csXji1nC/4=;
        b=G3q5GBHfRQ4QXAws053SSxTITNHCvW4k4+UL9NNmcjBjfeO/8413y2X35I6BN918nm
         551OSsMHSo/tueaNnKrFyZDx/9+UrHlohdDHHPcmCdWmn272zyiOzqS7SdxW4ttYziSb
         N9gJH2MfgzFlo2LACRUzHDzaqIclNDsu7b4c2h8ePMNeLLwdFvnc5EUzDrHfiji4Y1iL
         0Fs2A7XlX4bw07CojHQmybf9koUqUIEyVz0jQjYR2v5oydr7G2ls3MhXi0Mk952rFyj4
         Xdk6EfLweM5HgN8oZl5pmQmXk7om+jbC0L+um/E0VHuibl1O/J19GDZYa/7mpafQIKaG
         vOYw==
X-Forwarded-Encrypted: i=1; AJvYcCUcpOO//+HRx9w37p5USLvGOW9cs+JsotIimUUN2enzaBHCoVP1yE8WeNAWd6rRbFdEPy04+FvRKb5RhuyhIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBKOujk4qr1WY7T0eVfwu3Z2/q0bkdrXu+dGLfBf/S2YraN46m
	gQkPFEMEKX54b+k6V4rw8hbtAH1Y///oSufEHoRYinkXjEHqikdMzzmf7N03Rg8=
X-Google-Smtp-Source: AGHT+IGnZVoXgrwerKZgrBNt1b4IWnW5Xukz4laU24ynvt1xYZWptXEc1nUA2wrR6Tk6AjrbeFK86A==
X-Received: by 2002:a05:6808:10d0:b0:3e6:25df:2604 with SMTP id 5614622812f47-3e6384432c6mr34382974b6e.14.1730885769706;
        Wed, 06 Nov 2024 01:36:09 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f9050sm10850494a12.74.2024.11.06.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:36:09 -0800 (PST)
Date: Wed, 6 Nov 2024 04:36:04 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com,
	jasowang@redhat.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When hvs is released, there is a possibility that vsk->trans may not
be initialized to NULL, which could lead to a dangling pointer.
This issue is resolved by initializing vsk->trans to NULL.

Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Add fixes and cc tags
---
 net/vmw_vsock/hyperv_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index e2157e387217..56c232cf5b0f 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
 		vmbus_hvsock_device_unregister(chan);
 
 	kfree(hvs);
+	vsk->trans = NULL;
 }
 
 static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
-- 
2.34.1

