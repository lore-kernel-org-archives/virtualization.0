Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3814D28F
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934814; cv=none; b=oXBrzoQZ8L/bAlYGMGcMqAmRY2fsD9uOecxtlfS7A5BrozSTwrhKqPLpxzjnhQQfnocFkumqgQaGuotrd4UE05mlBaDdflWg/x67oaQbM+6Q2Gml2ELClP4UYA7sJT+ZGhp8YbtAWwTI6OLm1qu6NdeZJT0wjsRcgEAErEKa0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934814; c=relaxed/simple;
	bh=QbEpVnMQr5FleQ181phGUo98xW1xM6Rbox9biz8EFFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBxdEnoI3YOWP2Qhdy0uu9vwR6a1b+JzU81uEoZWD0xuHQcLzrulI6kuecw7XQ6MeW53nKadlkrcgkcvrGY7a83ftvXyA+Gf1CdIedpTNTsIuOoTa69krCp2ZIrOHk7DsIOK+Pn/Zn04oH5iNQHAKRcTje8Twj3HSAgwJQArDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hHqn9er2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hHqn9er2"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso10254231fa.1
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934810; x=1713539610; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRzBFs7nWe4OmdpxKyecIOsORdsbkwk80rMj+0LzMLM=;
        b=hHqn9er2A5BZ+7I7jtnkxvTNx+0TozSHGPvb3ldQggsV18AfR6+0K4rv3sqtoEG+oZ
         MZKp4uK/U5IzsoKGsQcBUGIBKyvx0maLhhh2AQV2VKcFzmcvoyHWWmIW5opqi/4d9DRM
         z9c2VuTvbhpUkYG+/P1nOxTiQtG3Y2PxpZdeR0OMC06LYRDBwVIikUIso0R8NGImHetn
         VuPZ2+Y9qKOfLVVxoYnTIGC5fLPFN23UNS1TcROZ6J6UE8NnWmJvHTayoQ/iNLG5h/5z
         PCx8zeEeKlcaviOfh11N0JBjTsN6bhj32ULOxu13JuWhFbRK/IVkN6oQDwL4uGuFZlbA
         FVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934810; x=1713539610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRzBFs7nWe4OmdpxKyecIOsORdsbkwk80rMj+0LzMLM=;
        b=su8odcz6HSHHgS7x7YS7q8Zf9Hq3d+UUyyi/rJyWJcH65NFpHvtpQq/bMTPq29Jr1S
         fsVAyVVDtxLAWym2LmtiEK1smomKXNNWbjykYmprfCFRDKOiPDl3bCy792LyzWMSMa7t
         74WilsYOLm5xH0PGpBS7RN9+vLLYIsyFJHbNf46vtOBE34fg5HOsnVfKoY+qf90vLFcG
         TCXZIev/76Bm/3jxbqWARxxoVgUuSTOEJJCJCiRMju2au/aM/N4aNqieECK1Lsqe9eWy
         nXr7MjZ0F1cxlC0TLEVQbOAT11lpZAOtQlafpB3IRvacMSPgkd1/m/bF/6qUi7e2TFtQ
         6uvw==
X-Forwarded-Encrypted: i=1; AJvYcCWsOjrCa0FpXYEWCg4Jil2I5IL2nhvocGzAQSHNdrrYWVCHO5vLnwNRtezpZuMI651X9+qfI+R+8DgkwutsiWibi7HJcMh3u25BUeacMz4=
X-Gm-Message-State: AOJu0YwyB95g/Z67mUd7OnjobTtu/ZAm3GV8xy2N9PDgjm2A4QThHXXn
	welMzfIfSckoKhhvhD8XgP2Mx/jVTJvyhd/jnbfyJsB097dgEQdAUbgcqyiclgo=
X-Google-Smtp-Source: AGHT+IHjo69PdEvYDcnQbXnMCraCmXWHrBnaH7QnmydQNhJdAHZPMhXzQ804UbbE+RnVcalObrgcHA==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr2023490ljp.39.1712934809842;
        Fri, 12 Apr 2024 08:13:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651c0a0800b002d85452f55csm536220ljq.47.2024.04.12.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:29 -0700 (PDT)
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
Subject: [patch net-next 4/6] selftests: forwarding: add check_driver() helper
Date: Fri, 12 Apr 2024 17:13:12 +0200
Message-ID: <20240412151314.3365034-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
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
index 06633518b3aa..959183b516ce 100644
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

