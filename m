Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C168316F855
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456539; cv=none; b=DvebRQaPDmEmpiRIivptu+IX3eI41/g4J325LetfPBx0s0l6yS/R72r1L/N4Rle+UKIPdibK3Yj6aXJ/KctS2leimSRvWW/DGpiMWs/tcdRsPnb8zG0pyuh8KtvdOP5crSKnXKy/qzakz4S7AtBZdaQV9ldF604chHT0R50t9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456539; c=relaxed/simple;
	bh=b0IPPzC2gZPsxNRT1JsNB/IxxUT5lL5pQHIYy4fkYB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsiEOyXsQXjtXApGpmrJBV3ikZEknQ1Dq7FP51N42eYRWWPZnF5wPUP+9wFBi2A/p9NiXhdusK0cQwG79Brg9AIOAt8LpnTS9NaPkyhZwek8TPl2veLCoiXckW4D9eWdDcrv13D+aOsVMT5+2dEQFm09iOTVc8jwRyH78D8nFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fda1zuo+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fda1zuo+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5194cebd6caso1276170e87.0
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456536; x=1714061336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iDht4R3VqRW+yPNRz+ghqd2WBxn7y+zWhn1SiVJ1ZI=;
        b=fda1zuo+JuKVLKQAjpfp7tgjsOARhP6oM81rsWSpAO1bOspBrG3wJaoSjDCVl+Gqsk
         UPHMgehsZkC7PziKBQSBHxv8k8s1HyapQ+9qik95LNrKG8iLL8ECbTi8+CWRozo9m7BN
         3F7CROmDA6o97DhRN/CzNKoWmdpYeFa4Aajyan2q/j6MLa3wJmS/hL+LiC99clJ9Cii6
         b0VKDsY/jON7llASNLJ/SARfd5OC0kUMtdk98MWEFhxpVfMehzmUyZRH9EV5nOTZztC4
         ZX4UCypwtaFQeNjlEgH8o9MWOSdy9bM63omy/E8NTdNDn6T3aF+WoYGAelxYFYQILZrv
         xKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456536; x=1714061336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iDht4R3VqRW+yPNRz+ghqd2WBxn7y+zWhn1SiVJ1ZI=;
        b=H2D8MpEhhrzvVh+nc7X8q/Sre8x19HqiMYJYt9PVJ4jO2UzoYB/W1//MYkQfQqWet4
         qud3nFVQuF5cL5lZ0rkE1NzV5p3rfw9rlBnGwsUeeutUIS3/ed1m2W0u7gyXQNKtNRA7
         RhJW/lKTundcwr6C59GuDkLR8qS9ueWZcXSy3C+UAslT5fmn+X4t8HDYsIJjpuUeWYiK
         LQ19Bgw3uxSQsZADUsjnMm8nTLrJKsvKyK8V3YnlOtb50q5RlXiblUR9D1cqwTBoW/37
         dtLCNEZxHgP57dilJWft+b/XQ5cGS6w2hTTe38Lof8ZfA/YIrMQsJ4zd+gaS7YPEspGC
         o4kg==
X-Forwarded-Encrypted: i=1; AJvYcCVrASjUbIDoVtuHByRwoHxK7uImfdqsUq2Ai7vSAfle6Zwtm3ghRq9LvIywexqix2DGkRoupalIjFzDE/UB5qRVaBCJci24h/r/18wiKQQ=
X-Gm-Message-State: AOJu0YwfUwAKo3pivzMkHM9vrcSMNTIybLSI8I+ggDetC/w+PjjzMnKO
	OUOAIPAKILu69hQPxgnatlWyTBb1GlVongZQyk2rz6Seui5/2+DN0xFj0GR9Z44=
X-Google-Smtp-Source: AGHT+IHN1LuBKkkhmIVKUWQfuW1mI3eS+gdV3HtAN4KpyOxEft8HB8VKerh5b0bPC/3GBlEH8c1Y+A==
X-Received: by 2002:a19:7707:0:b0:518:d079:ffd9 with SMTP id s7-20020a197707000000b00518d079ffd9mr1878748lfc.13.1713456535870;
        Thu, 18 Apr 2024 09:08:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l20-20020a170906795400b00a466af74ef2sm1077572ejo.2.2024.04.18.09.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:55 -0700 (PDT)
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
Subject: [patch net-next v4 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Thu, 18 Apr 2024 18:08:29 +0200
Message-ID: <20240418160830.3751846-6-jiri@resnulli.us>
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
---
v3->v4:
- removed "up" from ip link command line
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 17f8b6b9ab9f..e81507686870 100644
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

