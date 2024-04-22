Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C26153580
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799994; cv=none; b=GKlKs8dHa3oh8e0OfJqPdClwzdBt9FbjM5u5ndurG6c3/zuFFUMNhtxtrkIN6mUJfN9kpprRiuGA1y4Ad8wrLa7qjphE9KGpEjV/fjTVTbECBOeIK+PiqPAy5rq0kPOdNA+wTrbNpZ+FiGXwaacYTI4oi6Nl3w5K9Wca80z+4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799994; c=relaxed/simple;
	bh=b3s3lonKXCUontl27cidtmw2bRxAlU6LH2RDIq6KhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1gmess15RHrW22JRFeiSFD1ErQnwgW9WjvQEt2GPT1pHxAfbyGkFngMqD6QfGEuotXSg3Cg4bfjNZhM0/rX2IkWpjX7q8pKItYgGrAueatQdi8LK5y03Anx9Lp4NAr7sEgLi2QXUxr8DhogHPDol/+Z2k5cMbPOMbjMhpLc2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Bh1nO3Ly; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Bh1nO3Ly"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5872b74c44so27136366b.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799991; x=1714404791; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=Bh1nO3LynkKBgoGWz8nVPHFCGhXF8qbWJnWSijgm79RSrFLQrvEhaqpLZIvX+GZTeA
         UILOTLDWl0g1r7PcQcBIJxLxWG1TAOTgPklCxs3uPo6kKGWksb0KfOifc1tj4KrkOOLh
         2+PnDXTdpvYFc4RmeKnmR3o/c6CooPZvrkPiWHMv86h2uk003T0IjczuCyiZgrXnsWWx
         sF2AzZwlSo6wmQWade/jbKApR+v/A6tc1puIMWiEGWMjVnmrpcc9k0XbiYIgyno+kVy4
         7OSGTCdkjyzeqtDMlo1uXHoZT1yTYRrAHpZjr8ff1jdylL8WW5m3ypk26az/BPgq04OJ
         CwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799991; x=1714404791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=OEatpMhxmJ/ETtHDi5jc6jtXOoeB34VqrZcqqtlL0elYl+GM0YXq7hOyw2YBR2MOqt
         D6HBkXt7EPCvYrMm61ljmG62z49SYHKPvdUQHMCAInqZ0AYvRBRhwtaf9idLRDlB1uAH
         vm8OV+cBB7xYbcLSxwY+vnvfAnKZdt6MUJnm5QzKnIoRhsQuFMqiJwtq8y/RHumrtDL8
         zD7/bhowf7xoroyJbfxo50P+hME2e85k9ljbfoFenr1dWHFhnwRUkDtTkziRNyQ7Jwof
         ls3BFVsm2NJbZxJWAo9pkpZB/GfF9qsTBOKvqvfq9uLeDYXJWi37YYuz4B5FADvTCVhN
         BCOw==
X-Forwarded-Encrypted: i=1; AJvYcCX+6wsp8t0O1ELMRQeSlN1D2jkSRZ5jPKjKQiWkVY8t8Ewv0YHIsflkHebdXVlR6FnOFvc6s62Shaeh/e8nhMafdtuxk5oSFSW+sIOtJAk=
X-Gm-Message-State: AOJu0YwJ54YSaJdkJduYUAYNszowRwZD0u6vSIpz/1qEqsqZ88Xz5CVD
	2/Y9W6zr7T6ZV07njr+LTiYyHNGr0TCBaRz1GXMBFV54IHQ9sddsPiEFQpDpGBY=
X-Google-Smtp-Source: AGHT+IHIEgOcibr9ucENpjaIIreAlXyqBrgAOhJK7PyeduoRLSEwUOBWPtvHYKh7djNpkMZpKeHA3g==
X-Received: by 2002:a17:907:86a5:b0:a55:ac7d:af14 with SMTP id qa37-20020a17090786a500b00a55ac7daf14mr3872553ejc.40.1713799991109;
        Mon, 22 Apr 2024 08:33:11 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090607d800b00a524216fe78sm5887199ejc.64.2024.04.22.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:10 -0700 (PDT)
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
Subject: [patch net-next v5 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Mon, 22 Apr 2024 17:32:59 +0200
Message-ID: <20240422153303.3860947-4-jiri@resnulli.us>
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
index 00e089dd951d..94751993321c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -733,6 +733,19 @@ setup_wait()
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

