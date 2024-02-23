Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEB7AE47
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689536; cv=none; b=K6VbbXKi5wQMsWO9UTuKkyJ0Jy55MO/wcLrZ/AfTZWcYVr2eMr2ueEk1RooBGtEquen/Io0q+dmALnu6gdZtInvfWeOuqACJuyr9Ep47REXtGngjGDir4CtIjRXm8sgaNtmFTpEkoOAT2pE/yv6CWy81kwt7pFJXnZ3Ptjfm+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689536; c=relaxed/simple;
	bh=o6BO7CXUm9dHSPMMyBG4qtuCBItocp2Cmsd3ImTlUsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfdHtSDXa2Mqc2IwJFcWZJ375/lEijSDmqVAUDkPjcQNVYIZOqtyGM9mY1ol5LSUC8Tggk4fWEF0IT+ypdmnxJtJF0+76Pr0Oq7ABdoYmclEjlrvz6kwGGrpgGT8qoK+qXAKrnzPvOW+2J5zfhN5kfpbJQYExhfB1++gESO0K+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e552eff09so79002666b.3
        for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 03:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689531; x=1709294331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PMOZ8U66vdID9xvLYzabHLRBd9NskjEvwGqh7mLj5M=;
        b=tCFSTF6GPvf0kWuRn5w0czjqaPLQ+IynS+oIqOGTTeFkkXh84Yf47JZcUaZ/MYhIwK
         I4xWRiUFOMDzScCnm++793QauVxuN8EidrpUazcY2huro5W8wZ1BMz7jrLkEh1pdiDFd
         WYqZVPtaHaKS2hrRsF+nE0Hu2Gffd7+JpIZVMKf363EZhb3FQnTp9cbgllfqu9vPJi++
         G27k0XNoUjkdZ4lXVynxvWE3j6y2dGO6GedN1/dikVR9H9izxz8aXYWg9ffSkRKJcw7l
         ZEIanuT4CJiWJdV+ZFg5xcwpRSIlnA6dTpNuhfW8ja3k4gauPYwI0FfxmQnFKEOhkfBp
         tlSA==
X-Forwarded-Encrypted: i=1; AJvYcCXRCXTBEajcaw46cplsSugIWgoVNgqb1gNxDZBL1/lni0F182w477/gihXPGa3wnioPdDzryRVuWR///WaVxvTsc30lRdYhkfgbT19Q4qo=
X-Gm-Message-State: AOJu0Yw10JUUVr6fyadoEMhANcpLGpfMeZzE0+jbHQFFp3f2GRXG6erk
	NAzwvAZzC57x0GJ2OxqYkrKzDE4QAg3ZSbEwMYWb+l3NgieaT0Gd
X-Google-Smtp-Source: AGHT+IGM/TtqREPbVbQFZJLiM0YNydc7nsEwpb3EL+Pefz6h0WM1AlenO0PbKRHUhHPGQWqU9mI5Bw==
X-Received: by 2002:a17:906:f24e:b0:a3e:6036:3e45 with SMTP id gy14-20020a170906f24e00b00a3e60363e45mr1120758ejb.30.1708689530639;
        Fri, 23 Feb 2024 03:58:50 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id pv14-20020a170907208e00b00a3f45b80559sm2346956ejb.139.2024.02.23.03.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:58:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
Subject: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
Date: Fri, 23 Feb 2024 03:58:38 -0800
Message-Id: <20240223115839.3572852-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>
References: <20240223115839.3572852-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not set rtnl_link_stats64 fields to zero, since they are zeroed
before ops->ndo_get_stats64 is called in core dev_get_stats() function.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vsockmon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index a0b4dca36baf..a1ba5169ed5d 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -46,9 +46,6 @@ static void
 vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 {
 	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
-
-	stats->tx_packets = 0;
-	stats->tx_bytes = 0;
 }
 
 static int vsockmon_is_valid_mtu(int new_mtu)
-- 
2.39.3

