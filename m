Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC916F8F4
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456527; cv=none; b=YQx8/KrDcLka1mZ1jMKCZJrDSStxESJijCUxILchqmIEkKGm1G/ASRKd24JbmPlNk0lQ0GJRCL5ZUPnYIDWC0csTZY7onoFem1M03RckVZTZgFFK28vA9lpZe5d86Xb0taVNNey+dwXiD9bkapKrc8MEESRJR/vntuGZfogC3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456527; c=relaxed/simple;
	bh=O2CXlE7WbZEsGwfjpXKOeRNmpABi1eqbjqUq5VnToZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bges28tXnhIgas5cY4wcSMFvMlkllK58lH06uYH+3/t8tZI2btmbzxyv7x0vsuAwqqvXDjNGjr/2PT9VPGhdzBj4xkga+mRoUGvCc7RZpm1SskbkX8qyFSvHFYW8CSpB9YitC8jTAIWddA8SJP+mim09SxEnqkFBpIUDR0RSh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QFtSD82F; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QFtSD82F"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so1197677a12.3
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456523; x=1714061323; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spywciv4H/4k+WYAUPcD4YDC9twSB1M/aeoXVh94Uao=;
        b=QFtSD82FwoEEgtjRGWi2hydx0DpQe7WMXUbwQObXlfiEM1iSn6ilza71yyXTSd+1bM
         fy3lFZ47IDUEStlJo86WcO7cS8B767F1I7NbyAzTsizbQad3VUUUNyWvYfJsITpb4z+6
         Tcf3z0QnFOlXdka1lhsE7yPE9MZF+xq3DNHugxXO0Kr4y0sK8PIHAnNE30xOr1ryMcoI
         iBGndH5YDKo9bY7CBXDlBY/mGSrL3RZDZ1r0se/cyzlgZE8pIwJ1ocOuAJZT8DDuvr+r
         hgTKYcOcLgip+qO7Ziiw2DiSNf0AXOVN0cJN26RV7Dg26yV9hjvmp8A0YUIT4wq4EsD3
         G5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456523; x=1714061323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spywciv4H/4k+WYAUPcD4YDC9twSB1M/aeoXVh94Uao=;
        b=jCDxS38qIujVvx3wPhB3WoKVPiJp503VbyYKdAPFK2LUxqiHf4B+PuNa38beJOs2Gx
         8KcK4l4bCAgmkD/EL7chBM5LclNlKebpN2JiyaChrrGXLVAZtA3BOqSwkPDis14LAuw5
         s3M8WhQdOhBOlz1QWkVJJatYBiCwUpG+GM+EI0ssqGvCVmeEMKrQfoGsjxPgZWnMEnXH
         w7kLDnWztos8Hfdo4i+yCBYiDdU/aIzlUQjxrsY0uztCGe2oRpFkPG63x+r/HpF4crlt
         38eRUAtrbtpRlfCqY0o0glxBvJTxk46l+KTty0mooqLXy8jFFUKI5EhpwX6YSRcvcKLe
         teag==
X-Forwarded-Encrypted: i=1; AJvYcCVow56Q/sGeXH96m50kZdWTCm5/kVGfFyUV70j25j5u038Q77KC97WkxRHivuw5KMBcfVl2q2fdIorjMTd9vbZU6FZVVhoKKvAdNIi1IEQ=
X-Gm-Message-State: AOJu0YzOgyV6FGk4oGPyyoNrRSnYd6MxkpYCVeIJ9LaP+Pe39Dg5aoxn
	WuxNl4eigzfprUk7ZVbz4AAkfrB5OS5HAFVBYCrn9jeKCcRIrl/+tREm37nj8GQ=
X-Google-Smtp-Source: AGHT+IHqXWzlT9OXQCwTPdM0t4BTG9sgRzPtxKjEdbuLI/IWPbpqLaWrsM82W6TAJ+ud4ZdH7G7QDg==
X-Received: by 2002:a50:8a90:0:b0:56e:2d93:3f84 with SMTP id j16-20020a508a90000000b0056e2d933f84mr2027411edj.4.1713456522576;
        Thu, 18 Apr 2024 09:08:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c2cf000000b00571c2712539sm424083edp.81.2024.04.18.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:41 -0700 (PDT)
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
Subject: [patch net-next v4 2/6] selftests: forwarding: move initial root check to the beginning
Date: Thu, 18 Apr 2024 18:08:26 +0200
Message-ID: <20240418160830.3751846-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
References: <20240418160830.3751846-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This check can be done at the very beginning of the script.
As the follow up patch needs to add early code that needs to be executed
after the check, move it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- removed NUM_NETIFS mode, rephrased the patch subject and description
  accordingly
---
 tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7913c6ee418d..b63a5866ce97 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,11 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: need root privileges"
+	exit $ksft_skip
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -241,11 +246,6 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
-
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
-- 
2.44.0

