Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283C823BF
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198352; cv=none; b=O+gR92OFbNLu4Sbup9EZLXXnnxrUYP6Y85+2o3wkQyyIiGBlUXBAbK80rz6NzdrMIlqLB3vw/Vc2uPWt9i3UtLoDMBjiVNJsTYWz26N/eQnIese9o82dlDItwPr3txZqNTI978NDMuNKlJqF2htB+pPLbAzvh8IsYM/qz3sY/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198352; c=relaxed/simple;
	bh=6AWPtYIUVkIYogf/lFsvz7tOLfgL9m/gvfqRIzDJe9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8RXQfSH16lcB61A005Y8ZXk6ehIM2DB1Twf60KkEiGxBa9yrXUZZ/NsesFkjxRFLVtPMU+ubV3y0PKcw6AK3HaW22vCbdejKG86adFDAZWgNo+pXJ7e6XpWm8Ubq5ewn3QQhpMEfbF/Z05tN2b/hX/n7QIZD+jejYsXoeKbfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jX6LOSg8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jX6LOSg8"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so48221261fa.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198349; x=1713803149; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VClqDAQzBaKyJ8klxTyXU7hsV/mjaxzL9AK6EWM/QRo=;
        b=jX6LOSg8M4NHIJKtSvc4XDr+F9V2+PPN5Zadca93w44qRuTM2BkRDGwfNZdQ8ofoU7
         FRgUsraAFx2P2NtRLYh6d1TyAQOqxjxBOq5vLzFhT652qnuaCwmYR1bfv1UcqEPzQFdY
         WX2EoIgcM5jeyLQyx5tfm1jd07+dcQvNUOF2r2pQl41muHCmRRBqFoBOc3n6RfxCT9wY
         gHYt8WRlspaYGOzXngLxQcnXl4uOTvOEKuqx0zjJ+9E4HiaiCmbq7NuyXLYDZe3g5aCL
         kRmSA//Xp4fCXN/SnZ87+B7WRWccD/VMEGMOF4BY8JkTDf7AJgr4ULvahC2bwzMKJ4Lg
         b+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198349; x=1713803149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VClqDAQzBaKyJ8klxTyXU7hsV/mjaxzL9AK6EWM/QRo=;
        b=tjha97bRA9HknVCMrj71Wei4t8gDYqT7EnTnyaKQTEoQlWhoq03kHObr2gCUNkxAd6
         QARh910br7N8EjqbRAt5vVnBKlEfcmvjJvnBbo+ChpLynfwLuZgfuLIAR+hHtZu4U7sB
         TG6TGwDORIecMB8yOKPL/vuKnO0Mj0Z2IOkIBS/7Gh48BWnprVtOtKXUxG8pJJ0pNbbS
         soIzHktzLDFYeadHYGPPjl3qIf1RE0HpVl8CS5M78+9QOa+4J5yLSQD96JYqv8wBjH4T
         vFlW2EwHLjeFKpnMWq6m5VukrwANc3yjbCVj9U8pEp0JmZCTwVHk6JfvZxStAGdYGIa/
         tHaw==
X-Forwarded-Encrypted: i=1; AJvYcCWwjqWkqrndx4xPyF5oUp77fmzOZkYZvcLAybrGQWHkAWgvjhu8+04+TDagiACmTdFnxoUKSEOZYvFeHMEP82zCEULiXVUIOyPABk0co5k=
X-Gm-Message-State: AOJu0YyTwvQMh7dXafGrAzprbF2v7hsvVXcRz1b/4j4yOQ7YmOhDgEfG
	zWRJUE+v82XDDaOWoAE9NdC4ndTVHUKIa9Bq10/YXiqGPrm0i0nx/I+fWJbpWaM=
X-Google-Smtp-Source: AGHT+IEuucDhgvoXqySP3PjfT1QnbG5b75B2FPNdroFY03N44M1rruzD375UtJNVfLZzTmoq8qHT1A==
X-Received: by 2002:ac2:520d:0:b0:516:c9a7:82de with SMTP id a13-20020ac2520d000000b00516c9a782demr5949139lfl.38.1713198349145;
        Mon, 15 Apr 2024 09:25:49 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063f8900b00a522e8740ecsm4847924ejj.139.2024.04.15.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v2 4/6] selftests: forwarding: add check_driver() helper
Date: Mon, 15 Apr 2024 18:25:28 +0200
Message-ID: <20240415162530.3594670-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415162530.3594670-1-jiri@resnulli.us>
References: <20240415162530.3594670-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cc94de89bda3..254698c6ba56 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -308,6 +308,18 @@ check_port_mab_support()
 	fi
 }
 
+check_driver()
+{
+	local dev=$1; shift
+	local expected=$1; shift
+	local driver_name=`driver_name_get $dev`
+
+	if [[ $driver_name != $expected ]]; then
+		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
-- 
2.44.0

