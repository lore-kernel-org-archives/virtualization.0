Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB244C76
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345454; cv=none; b=mqR2hQIj8/0TP0vUDEpeid7oHmoybXywkm7UzIyP+S7WRTQUNAo0UogofNv7JGgMVuSWPdJNmZoLTkTYzFdus9Z0F6Mcc3cpf9LeNRuTGAv3nvsVnOD/Gi/GqP4mU52+intASX02api/ad2eI6W+F8K/7qGAggkacWSbuUei3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345454; c=relaxed/simple;
	bh=ko3uVA6VJm1NSJB8YRJHTV6RnbG8NXS2brijGf7c8Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPT0G9IcELCl0B86XRCmmUDG1apYVh0cBFGGDAzk0EcMOYN6LI5Uv//U2rsnjFvXv2KI3fkxW4omww9kgXOXZPLZANNabnI+8w0FHoiN0Q9vzgoJUHlhAQjq3DKRW6pAGocWi1umEVLoEyGA/o1SZzJnl2blRHfqP9PdhLIG5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cox5c6Ac; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cox5c6Ac"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a1192c664so526393566b.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345451; x=1715950251; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LM/odI6j/fMx3udtCezmjdbmQwQqNuohmtxS/7GVXYY=;
        b=Cox5c6AcnDlZI+9zc0zmfaJTCLVQ/YxKFlGwKccSBeUbKkU/178XtVMYTeEjTuOOxm
         eLc7pRBupaw2mp218oYi1WhSj5A8OgG4yeUpvAukwl+cx7tfs+C28ONKIMdgWqgX3B5R
         pbK45oopDVCTWfT3+AQiBaSMfpcduMBr5qhqQ/uQd4at3xgz9Hpo4fHuHpoMxspRXl9C
         pda/fnH67F+g7RTCDpHxQ/uCYOyCVvoSJsqjKBXnmAD7seL8ndOxBzHskWN6Of3gFSV0
         L83ekf9G/mxpdm5T2RahJRM6BeWffS2zLEy//gAYq3LdGmLt08nyWol3VlvpgusrH3ph
         0eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345451; x=1715950251;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM/odI6j/fMx3udtCezmjdbmQwQqNuohmtxS/7GVXYY=;
        b=LUdleN0gcFAj6Mdv4K6qhEE868KeZxFcaqqFv9rR0h1Vg+8nHugDKq7QMfEPXEPyxT
         Rmc8Tu1eahMtYXEvka6h1t1ujTh05BbBOTaft02RpIf3/e4XYlZwZRJH50slP20nnoMK
         JUt1x0XPPNQMHBZfoHUUlU93QK8rGc9nnHfZvpVDJrQeUC2VDPAFC9OxZXyRSDTJ0aEJ
         1c0QOdC7qaItEHCZnlIYU8eO97zlENVU7n4MsCgzRelQNvbFXbLzWAK9tfnUZzzTI3gx
         ifMfvgpIVCJVSVzfA22Uyxf385VSCIPrdgnDD4qpOooBSSepdoulhViDLsQz1iueAdp/
         GG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbwNs0O0QfhOqcArt3zyprgV5sZUYft4iyL/BRfMV/zSuqR1Hahv6e2A8a2Ol0nfVweAToddumszckfHGsEMT0YmEIN39X7cbQObTg5Qo=
X-Gm-Message-State: AOJu0YxxRLGRiW91pWyr6Dx+iQrZ8ndKtH/TCL+Oj26ULvdztxqkw2GC
	Bz5Yv+M6QpSfIyCsXwWnHCz8fQTsZZBezHcZaPmncq8Bl7otd3GVLoSa3NFEg8A=
X-Google-Smtp-Source: AGHT+IEp74LXPMOrN4jcdcnJvpP4z0aouu/s0LV8Wdwfhk/MAZjj1kgHFHoHWXY/x0HaMZmy3440fg==
X-Received: by 2002:a17:906:80a:b0:a59:b784:ced3 with SMTP id a640c23a62f3a-a5a2d676b2emr194516266b.77.1715345450478;
        Fri, 10 May 2024 05:50:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c814dsm180050666b.118.2024.05.10.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:50:50 -0700 (PDT)
Date: Fri, 10 May 2024 15:50:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The virtnet_send_command_reply() function returns true on success or
false on failure.  The "ok" variable is true/false depending on whether
it succeeds or not.  It's up to the caller to translate the true/false
into -EINVAL on failure or zero for success.

The bug is that __virtnet_get_hw_stats() returns false for both
errors and success.  It's not a bug, but it is confusing that the caller
virtnet_get_hw_stats() uses an "ok" variable to store negative error
codes.

Fix the bug and clean things up so that it's clear that
__virtnet_get_hw_stats() returns zero on success or negative error codes
on failure.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..4fc0fcdad259 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4016,7 +4016,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 					&sgs_out, &sgs_in);
 
 	if (!ok)
-		return ok;
+		return -EINVAL;
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
@@ -4053,7 +4053,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct virtio_net_ctrl_queue_stats *req;
 	bool enable_cvq;
 	void *reply;
-	int ok;
+	int err;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
 		return 0;
@@ -4100,12 +4100,12 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (enable_cvq)
 		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
 
-	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
+	err = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
 
 	kfree(req);
 	kfree(reply);
 
-	return ok;
+	return err;
 }
 
 static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)

