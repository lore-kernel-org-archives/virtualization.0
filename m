Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAFE2BEC30
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975941; cv=none; b=lD8juf7Op5jdQNnS7Y4wds9TohNShHRXKsUHD7cLyzuITyGG/ERzZSrN7TbcQwSwcRtrluKHxKz6eurxmLvNSA36K+rVufwYskxnnN5HHGeSGCtwNx40hlU8vEt8Otrm6819uHw1K5DMslnXD2AUtj1Sqiy/WXlB5hCsKI96RMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975941; c=relaxed/simple;
	bh=Cz0upPHZk9fGBVcjG//ILHjl/qglp8+Tm6tLew6P7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E/52Q82GN5sNmhSOXl/gMBWFwijbkD9ewZzBFwllZMaaPJMzN8xPo6jt83vwTvJM5cbjvdX6F3NFAvXgC7Drn2kjKBan398amrBJrsuXSilgfUUewq71+ojnTN3KjE8lyckBvljCUDoQYEml4IpXBIE0Yu/qHCrIyV9kMNXha3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ddu8mclA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddu8mclA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so21687515e9.0
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758975938; x=1759580738; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVhumFC8qskWIHg2JamV1kuMQedk4HSzKMYaXz2FDxs=;
        b=ddu8mclAsHvM7qkR/qxCDcbCnVXYkpPBIU8irSA8yDOkGFVtWWNCOsf1wAQyYxsc+w
         Pc70Z1m6tDewhN9m60+bC/a5iAcj3XbcWeVCQ98tiFiW/38rJ29daeh4KKBmCvebHk6t
         OEUmTqF6FULjpWK9lsRMWJu8AxNcV24ZfOmXTsDkWefSPfpcjBSIUWYhqmr0UOgBrpNN
         80BzvNx/1k0LmFYwAs1oMcugg/cW94oloMNwfWW+PaTCmuePbWLA9HVhZfwUM+bIjZ+T
         kT+Oi8/k5NthbIphxoUA8DJpJmp4862TNS/Sv2rRi/QKrHefcltAiZSpDQBzAUyMj1tB
         J6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975938; x=1759580738;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVhumFC8qskWIHg2JamV1kuMQedk4HSzKMYaXz2FDxs=;
        b=DurbjDZFBbAVy+Va2BoM4Q8hY1ezzaf/QyorOIVXgxmELOvcWGPKDGdyrKE6PW/T/k
         ESDT+HMz7Xu7nPTtsTNZX0ySQX8W8ks+E3cmrpNvmTMjJNK75GdJa0bT4qviehi2UDnT
         rhP/P4RG54oskMFMYFnPACpxIcZgU2zPhZAgchwp/h1SwnttT0NhbIq/fPwFxaS5MfqB
         q+bSfeSc9Te4Wx+dYxGo53QFRlxVXsA7r401U+p18P/ZwjAcLbFhVmfvU87si+sjjzDw
         0XSwFTd6DIbP621YTc0zSpWwWppoKb9yPQGqim3lUUJMLFNsjfMu4NOtVmqUb4gpzH+d
         zBcw==
X-Forwarded-Encrypted: i=1; AJvYcCXtW8ReOat41cDUHYnYF60WmLOqeDWDxvs9fACLGAm7v7yqXAI+OIGtBh3fy6GNoPKMIBV20P83JdCtvMOM1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKqwZT9OaR8GEBa8Byoyuv8GrjU1fjb3X32zsEzhYRQKuSD/ri
	fuoTDJOiRyXV2zpOVxiQKVLtNelQfWQKo9hp7QoHpgmeztenqZGNRgySKG3NoU6tTtY=
X-Gm-Gg: ASbGnctqjBS4F5Oqnjf2aOps0rOWFMF2/Nv9Ldtxaq4z5uH9Ujxj8tP19ZfKI2O5cS/
	qHHH6UJTry38tpCT9OJ/VJDyupCUeLGwzfNAyzmx5jKu4Wa4jfgSiBaDQmhuOjphUvsbJZ5WEWG
	4f5qmG3tg2YdtVvszQ5Zb/hPbvc6XfnleD/cK3Qlbsax/w4UpLB0Fz6sNBr1hHinV1nKV62cQW3
	4Tvo1H0NwMimuxPqn4IVWnBx1tbjHPIidmsbhExl2Dxt0chgx2KAZBFyhHh+yPW8GDi4nNSCHfK
	WAqZ5xq10vUyx2SXuf4vhroUm9dnRgVwMFwGam3vZmmttooEUx3yFg1iBV8r64BRo+22DE+8VtI
	Cv90fWf+OLozVtse1qI1FRHQetP+7QgeZOAmAXbo=
X-Google-Smtp-Source: AGHT+IH/fs4tI3yUr2ZaBw2ReWMi5Di+AwUxDHPsiDLmiEELtqX2JAh0B0XFiB/cSRsTRtqy4tVX2A==
X-Received: by 2002:a05:600c:4694:b0:45d:e5ff:e38c with SMTP id 5b1f17b1804b1-46e32a1393cmr95976155e9.32.1758975937784;
        Sat, 27 Sep 2025 05:25:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb72fb017sm10713558f8f.3.2025.09.27.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:25:37 -0700 (PDT)
Date: Sat, 27 Sep 2025 15:25:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
Message-ID: <aNfXvrK5EWIL3avR@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The group is supposed to be copied to the user, but it wasn't assigned
until after the copy_to_user().  Move the "s.num = group;" earlier.

Fixes: ffc3634b6696 ("vduse: add vq group support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This goes through the kvm tree I think.

 drivers/vhost/vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 6305382eacbb..25ab4d06e559 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		group = ops->get_vq_group(vdpa, idx);
 		if (group >= vdpa->ngroups || group > U32_MAX || group < 0)
 			return -EIO;
-		else if (copy_to_user(argp, &s, sizeof(s)))
-			return -EFAULT;
 		s.num = group;
+		if (copy_to_user(argp, &s, sizeof(s)))
+			return -EFAULT;
 		return 0;
 	}
 	case VHOST_VDPA_GET_VRING_DESC_GROUP:
-- 
2.51.0

