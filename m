Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E815957D
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955280; cv=none; b=fZBXJsnhW0/LwLROs3VDczEvcRquMKs0XLvHz2sAiP4fX2h3Tp4gJNB4KScmh9omBd82gNo+jC5mgyU+en+43zrmjWU1ecOUfQ3CqiWaR07Ze6mA0xFo7RbH1tGFu+CnyZMjqlboStFrrS0dJ8EtM5MJ/Z/bpoiGwZ79gcDlveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955280; c=relaxed/simple;
	bh=B/zxzQcql6baNzn7gSc3PVV0UgMdGK4IKuqEzi13oS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEWrhLkcz5hdf3c0/yf/Ixv0TWajwr3X5rpJkQolplETFoFWXF3FwkY0e7JTAwdOVvUB1S1vrupVvMWUOkWOYqeKfFsGGSNwkPvisLrq49sLhsT/x8vZikxJlhoumiP2z0UK3AjoolEKkHfP0hw5cP34O93HjfHdBdguRzWSU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EcaXRyKB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EcaXRyKB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so1407638a12.0
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955277; x=1714560077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Z3z4Yi1jKKF2F7DPvPW7KYbmtrDxuE/DmY57trBRo=;
        b=EcaXRyKB+LATaaeNiERys0nerTtnqspwnbbOpxlxkZ3v8iwpU9gSiIYOpiJ4lUxH9V
         fu7V8dY9LVLsAXPAxvBJ+BMCORvL41tkfEEZcKiGMZXgZGBjxhIc+y5gKFGPs1NwrBDc
         JXpKPQ5YwCAaIxudgdVQsgYMPzEMiWE3B2A7Fc3Ll/PfTAfcAlqRy+rB67HZ3643fSI5
         wLNdefQ7f6IutqKopBISDZOvLOJngOBq0gwb/reqtPN7UEatjOW5XposgQnErv4V9FWS
         clYWjSuUkj9MMI+wW6D8tT6Hvq+WGJoDD6OQA+/KE75RCqLSBM9zaTKWUNypQ0A17sr6
         H+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955277; x=1714560077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/Z3z4Yi1jKKF2F7DPvPW7KYbmtrDxuE/DmY57trBRo=;
        b=k7AIjvsCr/ROWJNgZwrfRKzI/SYXuLzQNz5uE1Pgr+z7hIVh4harCQ57LZNhTJxAxz
         oAIk0l9QDNOIfYnmWmgCrhtd2DBNtuhpLIDAXp+Uya7ICXkRUOVLipnXjA0qITyQ6PPJ
         ibsHvcz7ritVZP2AlcWQZaqw2+JFEsuS16ct7+KgqTBikxBckktBUCBM/Xuyhb5P+baw
         Ra9mdeX375hFOVWOIX2EvcUVt0RE+YDINoFDatxxkFdhD0UWm1y+T+W0dmvAoxU3XmlY
         RvzZqnTwnvZ/HY6++R3PfJ+hNPXK1bfH6AO54yjjk+UiwFE5mLneL02Q4rWmrAeDilfU
         oWdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqpDjAlKv8XqCvhz2qVZXmlWKxkfm23Q8/epnaaAfZ21gkLro6QJhTKWdHyZFC9mIiKKkodUZqOhgvsL43GyxM1YQUxpQqlbNwaLiI0M=
X-Gm-Message-State: AOJu0Yx1UeSMhAipt6tkkpJ/pshgpugUomh75slLy7cMg7lJkGQaxwGH
	b21XPcjRaNqJtml0Bj3JYYQJN+x4gQfWxVaU3ur6w2tscJD0hPVl1zZfwohXfZk=
X-Google-Smtp-Source: AGHT+IHZZv1xVt6E3oyEe3yq9SW4nf/htg+PGNeigdjf8TVoO1Gvpm6evcpk2261/trhL4oabGxdmg==
X-Received: by 2002:a05:6402:40cf:b0:572:218e:1676 with SMTP id z15-20020a05640240cf00b00572218e1676mr5950886edb.4.1713955277277;
        Wed, 24 Apr 2024 03:41:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p36-20020a056402502400b0056e064a6d2dsm7872600eda.2.2024.04.24.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:16 -0700 (PDT)
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
Subject: [patch net-next v6 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Wed, 24 Apr 2024 12:40:48 +0200
Message-ID: <20240424104049.3935572-5-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
v3->v4:
- removed "up" from ip link command line
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 2d57912d3973..3353a1745946 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -738,6 +738,19 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+        local dev=$1; shift
+        local timeout=${1:-$WAIT_TIMEOUT}; shift
+
+        slowwait $timeout ip link show dev $dev &> /dev/null
+        if (( $? )); then
+                check_err 1
+                log_test wait_for_dev "Interface $dev did not appear."
+                exit $EXIT_STATUS
+        fi
+}
+
 cmd_jq()
 {
 	local cmd=$1
-- 
2.44.0

