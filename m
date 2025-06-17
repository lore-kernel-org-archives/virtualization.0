Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6525B316
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134790; cv=none; b=uz5aoqYsi7pgsqDuICAiJlbfURih1IOGaZZ22Eokgpl4mOyNFgEM+WS/D6w9BmAbR3hLa6Chcc/UcgEdjotu4wJpcK6R2owXTLoiBu/0++cV0ZsevYuSNUshQz/7nwv9DhaWA+WgNcRUTdrGQZE87Hp9615ShPHue8eNBiJEs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134790; c=relaxed/simple;
	bh=SvB3qBm1VTjIjRDl1c4e6i1RbCCzA1EXVBxQVVn1tvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otbI75NFBY9N7hQAPqLIpPZGK0bD87NCUspXjwIYWUXpIwJTzGsuJVer9DSzinIdaJwY6TFSkauInCq/KEMphgNlt874Sfgh7z3rhqTNvbZMMm9xptuv5KnWahnply5Pf9feO7q6UOjeRTO8OfInc8feTI45efOs3+mtIhoHueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0ut2RWz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0ut2RWz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso5977926a91.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134788; x=1750739588; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMpypbPx49C4LhAqP1zWnTq1tGkVcmiL21eIZ1oGdsw=;
        b=c0ut2RWzAnWFJMTp0c6ir3uYTRsPfW18H1fpCb83lXO2W+zkzlcZbFk5HmS5zeFS4/
         7AqilmXWgJfsGmDlSAuO8HsBCyBrcWCxipjpzRd0Tc+QkK7k/VMVbL/eMgXv2Zq9j2qx
         XANWZnzFwjhPGvwB5TQ+vqgsVotfOiecZP/V1RamKOO+QBZBsjv0I15/WhQ+xHu4KiWG
         4eB1ypsErWWNbS46M4FF3PvXuNH3RMuAL7mE/bj2UIL3Fdulgu43A4tF0SBuxALWFAZZ
         Ec0iTIschsGeqD1v24uh8wgQuqfhCnCla6NMPhxF6rIsCVFUnuN9Rg+wvrfM/51bSKKs
         XZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134788; x=1750739588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMpypbPx49C4LhAqP1zWnTq1tGkVcmiL21eIZ1oGdsw=;
        b=EqmnxVOUm0JUYFTcLM7oFAOPSFjwnOm53XZ55PnXypQG95Aipp0b4WF4wJ5b6xgNLx
         XY0A0LyKEF02qvW3EcTzkTrIERDex2tFaq6thWYfJ5ttMOxIs23li0Nc/uOCJCaZSTHB
         mAMmYxwANxXnS0HNZ5jd0d4I9X4oC4w0Fb4RIJdy+5xaXN878Zphux8P7A5D3F+ANyfb
         RVe5R9CncionYtOTsVTsAOiLk7bviFtd4aPJAr+zGJeldBKCCICeQwaseJbyMp9Jn2SL
         Ftub4DZ7nsDyLJ0cCt2f4Hta/wX5YdEQ9ukPCQQkL+ikf7K263ZZOwdO3/2EMGC/pX4L
         Jfpw==
X-Forwarded-Encrypted: i=1; AJvYcCU+vJEJXqxbg4MqBnuF9jhWM4VfiLxz336+DeUtzvCWZ+/YkqptiVgpWH7kT+UopV3udyWb/JSZa8GrpW+YSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLfvDqlI2X3dYalbTftaQsBRlQMeoj2j4rO1AcUIxxJKAdviD1
	50FzNsDqbcvvubMkUNpTCbqsocb3sQiXojhKa5WLUgFmqIwezrNElHYa
X-Gm-Gg: ASbGncve0EVgG7jrZJZKiWwBxxomehLDHZ4fiWKshfBrQ5S1ERg/C1wp4IQS/hnLWM3
	Os6yLEIjENRjw9A6MhbRCr8YYYLM+a0OBtHZ8wfapQAQMY9svZESpnJ62lr+hinNLIg3CWS/S0c
	iri0bajlwKQ2+qEXmtzJ7TlsgHTcKEHUk1ilqNDMyI7dSiND6HdjoxAsnIwSzbZ/4Lq5xO1ISrA
	WGt3sjKtbwt7q5lTUZjiDhwSND7oquT/USlgqDSzV9ECcPT0IviIow1N6cV3Y4cVImAGX0yB44V
	jBW58nD6BBOOZNa9uX7GcGZbQEptmrHjPJWe0zzx7b/HZIembiu/BqYWcK52Hij923iudgY=
X-Google-Smtp-Source: AGHT+IHan/Inn+3hHqs41XckrP55r8fD+/kVg11iHSZaNVdMOIOPZ8mHU4EEhc6WhlTm03MzuZLWCw==
X-Received: by 2002:a17:90b:1e07:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-313f1e2bfa7mr18799476a91.29.1750134788030;
        Mon, 16 Jun 2025 21:33:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782d3sm70339985ad.115.2025.06.16.21.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:33:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:58 -0700
Subject: [PATCH RFC net-next v4 09/11] hv_sock: add netns hooks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-9-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Make NS changes not break hyperv. Guest vsocks still remain in the
global namespace always, so the behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 31342ab502b4..85b22366ef00 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_global_net());
 	if (!sk)
 		return;
 

-- 
2.47.1

