Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB9149C6F
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265667; cv=none; b=T+rr9jCKS7kfvP2U5qCBOMnJqg84ZvJH3Wgxqf/ve5Ae+OPOlCB76lfqdtk/EePTPLTJIAUTB889TXTyrunyXivdWatPXcFtvhJfiVNkCWGYmzbrQWdGtllGG4b5nkSwjtReOM2N916byTL2ZiKqFjgtkC28fji4cCWRfK/9ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265667; c=relaxed/simple;
	bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld+M8CuyrtPmr6A7fJHqbPn2s4qDSG1Yfw54MjZf5UVqhNZ3FTAi15h5vPKkRPfGbuMf8cCbqujGI4MSceLkmzywlEvglkb7eDpZVKMZB3kNTwPnpK4u0X4fly1NzE8b24uwRduHDhw5OqiwaTx31M5TUEjTh/jsVS21mX+HhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvPbc32w; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvPbc32w"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ef378069so11243315ad.3
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764265665; x=1764870465; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
        b=MvPbc32w3yvWDI9B8yKTzH5mITacM1BfiZky0OiBep8Afse7pPNSEM59dBNhhXKY+j
         roeZ++VmmMDF3fx9quTbpzlJJ5HWmo2DnJS9wb9EitNxFtCnsTI4lH+OwNORj0K+dsjJ
         KA/6hxv+pzOGyCp4RbOslw4zyG2tPIBHwcoe2vJgxpk6lE9hz/E5lutsdcyIlBfxnmqw
         L6ZvUTNKkbOj1zd6T46veq8EXn4GlNk6Y3CswItVL1FJWiznPqmvLRwu8vJuLa+WiTkE
         OAIkren0O8QQmNYwrASYncvAxm9G1Bgf+x1/Bkw8ObHl5GEcpI5c60UIVTehqS2CGANw
         Txdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764265665; x=1764870465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
        b=oc44+k51A1wjGCtGOGLWMil5SIxMSSjyvSiE/HKwI942hAJQewMw/9XiwwS1PiaHEX
         lGOGoFr8JYe6yYn+/UQlZbTCDlrD/IzxMVneq19OSkkOtyiWXs5l/S3Glvpszuoa0/QP
         bVtZF2O+ef67cTgY5gACo7JMXdp98P793X9Uko6wnBiS6xh9wvjaoIzeo5g8mHjMAJXm
         VhC+LTcUAmUiU0bTXXqUaku6cp7jHS4d1UG2Z3Iu7jUb4FCKfK4J+GFcmsIL8z+WnQgB
         GuVo0EOg8QqfkcBQ/gHrUQS4+fOKRBWq/kr+A8hgkthcbFJeEqN3uu8z19S9wZ3x1hJy
         JxUA==
X-Forwarded-Encrypted: i=1; AJvYcCWTQN/CUYlf1ximjWjZDA8eexTNbblDda730/KzDTtp7c68UDGduyTvyYn8HjptCAqTOaKVCWbtXHWz5BLr3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj7FAWBOLz+e05QEJVk6dSoNNEX1h+5mRq2UGNTx6Ttax4HNez
	LUwHjE2hjmYFZ3OwC4wOhsNzPAq/FiaKK3hlQrzsfysZdvHmmH9tugyN
X-Gm-Gg: ASbGnctbcYM0N2y7qx9rHxQwwT35BRKnVL2COonCOpwHtydcQZnzF/cH8NkkirTUAP9
	lDXy3wtVJPpwGjRD+pwazwYlzlUUp2JwLjULeUDYHCBeur/O6GM/mbG308j7kaQxAmZrshypcoO
	KzJ1UfDSmxJEgEKQFzWE88xV18jG+D/dRi4HdA8pyZgIoj1EFoqf1Z+I3MUbJKaAZAfhG6SmaZx
	aT309Fuul/65wAFAJK8xaqqRB4m1Uux8px5JGVGPOTNqdOxBeRpkq4lEb/rYwmLDlAfBkg4bZT7
	qIKGH9kLodw7mMnvWaz6Sx1TdiJ3Y/pBEUb7MkuPRUceNJ6SlTUz3C9qKLWj1IX4zEwnIcTfgDp
	PRk5Wdb+TCzuGEIipB7PiLspCJa2rKLW3hw6lgD0/RXLIIn5pnLlC3lUQEw7htuxB06LqVdPdi1
	97bDFaJtYJYg7YdwY6/VUBxZPlot24byz0VtqT+qXs/i9RJ7YW7Ftn01hEjK+U8ZyZC4m1dA==
X-Google-Smtp-Source: AGHT+IFQMns4p7mYuQDAf8KkttHI4Vx6NTBg4hreeujJapPT/8zqqg74Cep/q2QlnjNERCvMI0q1AQ==
X-Received: by 2002:a17:903:2ecb:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-29baae4ee0cmr142565705ad.12.1764265665311;
        Thu, 27 Nov 2025 09:47:45 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:de47:e88:2ad3:8735? ([2001:ee0:4f4c:210:de47:e88:2ad3:8735])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40a5ffsm23791225ad.18.2025.11.27.09.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 09:47:44 -0800 (PST)
Message-ID: <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
Date: Fri, 28 Nov 2025 00:47:36 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think the the requeue in refill_work is not the problem here. In
virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
use "even if the work re-queues itself". AFAICS, cancel_work_sync()
will disable work -> flush work -> enable again. So if the work requeue
itself in flush work, the requeue will fail because the work is already
disabled.

I think what triggers the deadlock here is a bug in
virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
__virtnet_rx_resume() which calls napi_enable() and may schedule
refill. It schedules the refill work right after napi_enable the first
receive queue. The correct way must be napi_enable all receive queues
before scheduling refill work.

The fix is like this (there are quite duplicated code, I will clean up
and send patches later if it is correct)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..892aa0805d1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
  static void virtnet_rx_resume_all(struct virtnet_info *vi)
  {
      int i;
+    bool schedule_refill = false;
+
+    for (i = 0; i < vi->max_queue_pairs; i++)
+        __virtnet_rx_resume(vi, &vi->rq[i], false);

      enable_delayed_refill(vi);
-    for (i = 0; i < vi->max_queue_pairs; i++) {
-        if (i < vi->curr_queue_pairs)
-            __virtnet_rx_resume(vi, &vi->rq[i], true);
-        else
-            __virtnet_rx_resume(vi, &vi->rq[i], false);
-    }
+
+    for (i = 0; i < vi->curr_queue_pairs; i++)
+        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+            schedule_refill = true;
+
+    if (schedule_refill)
+        schedule_delayed_work(&vi->refill, 0);
  }

  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
  {
-    enable_delayed_refill(vi);
      __virtnet_rx_resume(vi, rq, true);
+    enable_delayed_refill(vi);
  }

  static int virtnet_rx_resize(struct virtnet_info *vi,

I also move the enable_delayed_refill() after we __virtnet_rx_resume()
to ensure no refill is scheduled before napi_enable().

What do you think?

Thanks,
Quang Minh

