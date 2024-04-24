Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8ED1591E4
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955275; cv=none; b=sxHgN0XyYkU3aXRhfn1v1VK0psppQzwKco7oBFEMB8ZExISaVAEApODBWPuwgx+nOIk1UroU5gkRHDlMFPhyy72oAgB3wD/oCTV0SH0osCetNtKMw0ZQhg7Cw17ZxazuNLkXIJCiGMLX8aBFhNouG9czlx7ZmWUb+XCEGLlPK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955275; c=relaxed/simple;
	bh=WvA9mi8zp8l2a6WFa91lX57zesLhrvAgkOfsOsQeM1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrDQ2befErLlU/2l4rA9+5Pj1LlUGRHpcDvk1poRDlQG0aP12V4cCm24bUzEuTqGpY7jYeeb0KNtqscRmQ+BtuXfmwjQxAhlZeQ5pS4JiW8aMgGX229G6iuuWLqpn1UZW5DHw6xcwnUoWUE21xTq+7d80Un7XPk5rIeCDxbnqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u3qtscCW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u3qtscCW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so8496097a12.3
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955273; x=1714560073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUHI9zilGVXMHsT3cMVzO8EqmG06SAbRC2e4DxW8mYI=;
        b=u3qtscCWDS9p3X/XUGHfUznvVLT9pgpRVKM1zKkG6dKSEefvAuO5sHmNSHkWqxqESM
         26HtY1Jw3rvsqwyNOECVtRrVfnCB5iLP2ihCl6uPJSim7KPCQsnfTnlOquhnS15swqtu
         LnY8RcghyIKa/Hk2I94PRKxVQ1lcRAwkAK4eUpL8gMAuop6QDGVnnejKlcwO8vf1e+cj
         cQhtMu6ydX9jaDo9AftxDYHRwrgLm3ki9Yilofe4+LSwSO0Hqk5mot89FcvlSfDoFIXX
         IAKfKnmP6Fedrfagz0TBfcMoPp67SQtCHHfpSUvY2pqcPLPT8juzm2l97l7AEwB//rKf
         iRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955273; x=1714560073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUHI9zilGVXMHsT3cMVzO8EqmG06SAbRC2e4DxW8mYI=;
        b=V7YHPF31h5ZZKGKgV6Q6D9BVM2EjUd4Q4dFVMAkYCURzEQjv3hEAu+oWvb8UFXPlfw
         4qfujw/lBKOZqXe47415Tn/hiPaaciK7mI8fheyp4t9sKe5sWsHcFtbIwkxHDzWt/mnE
         vMDu32xyCEc+cen1o1oOTOw59nLSa2zczXnoAYuLWbHVXyQ19RZZ5TyDGmSjEaYcqIeg
         2H0yxnvulx/H8GwLrEajr1SFD+cp9WGMZ5dX7CPITkZ9JxSuBaz4P+OA7uM/fUj+fwst
         LHLHFLgJy+S4TG16ePF4Y01AMMfrE6Ca+zMpUX4yb43ZBZzfvDZdorEhrtKsfVucYeQ5
         lmqg==
X-Forwarded-Encrypted: i=1; AJvYcCV5eOL78bZE0bTUg+EgWaAJSnhoEcQX1lxZn5Ad8Ds58mksc8cMGIfmtkobD+/y/UWUwSWfasQqvSAJYLf7tEBXGgFLvP8vIcbSx84HzBs=
X-Gm-Message-State: AOJu0YxjftvQ3grLtfA3Wu7LSVWoul+i2sofn7LMc1VxqoqXy6jGWmyv
	O7uOPDEhwIXFDBW0QVhQLmKcKsRa9wiltMMRQNzr6GU/SrmK1vDLzPJ0p+K406k=
X-Google-Smtp-Source: AGHT+IGE6LlafpU2Qxf9I6d9LJDd/D3TjhCV5n4qDef0tJciUVv5gQJnoUrU9VRAEN9NDhSSUuMJoQ==
X-Received: by 2002:a17:907:6d16:b0:a55:63de:9aa9 with SMTP id sa22-20020a1709076d1600b00a5563de9aa9mr1644449ejc.49.1713955272680;
        Wed, 24 Apr 2024 03:41:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906398200b00a4df061728fsm8181230eje.83.2024.04.24.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:11 -0700 (PDT)
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
Subject: [patch net-next v6 3/5] selftests: forwarding: add check_driver() helper
Date: Wed, 24 Apr 2024 12:40:47 +0200
Message-ID: <20240424104049.3935572-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424104049.3935572-1-jiri@resnulli.us>
References: <20240424104049.3935572-1-jiri@resnulli.us>
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
v5->v6:
- removed the root check removal, that was a rebase mistake
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9d6802c6c023..2d57912d3973 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -283,6 +283,18 @@ if [[ "$(id -u)" -ne 0 ]]; then
 	exit $ksft_skip
 fi
 
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

