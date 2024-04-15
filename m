Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90B811EB
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198355; cv=none; b=Zw9a128iKFqrXjGYtkKRk/j8QeDmPIEFcTW9O9vHITcX4qpia8sK9LyWo0IdEtS7R9lpKmJ5cmzsky0B283BJ8VfiPCqf5C7FY3+2KMSgNWbMfPEL63unTEQ+vCn4HwxqSqw9HYh4pwhZxQ3pCnStRYppLX63sy8P7OVH1c3Ukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198355; c=relaxed/simple;
	bh=28bGfo/k1xHZ3BBi63D5YJEOeJXQ0EzebP5KwrPOH6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWlYRtqfzLz9z1rYaRvlosSBUXtryvFshTVwdL4v0CDEnEEFs1e94ucmiY/BCt0YaDNj1k/Dj0kiTQPDC5w80sRKWiYLVcFTFndWyBuZfj/UvCXSOuEFIcIOzxGnVVEkK8AtLLKDDHsDiQwZErLHApAFw7Tg8jUSSA71pZ4nW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WBy4w4q6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WBy4w4q6"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a450bedffdfso424968166b.3
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198352; x=1713803152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hobzl0UFhcxWwRJMKvUjC2bqwhgf84pG3unrWYn5GIY=;
        b=WBy4w4q6BosvAuuOdwLsSyBNy3Agf7xtaaRpF7TwbOnB/qWAPVFeGEqsmb75ILOnX8
         4Y+NIxSknePFFElkHnpdeCDD7024pzNjb6wdz6kh5mPERfe/tkL9wrH6MY/qFU1IekjD
         46DpGRcFxfcJiRXkJS88QptfawGQ2WFvOjevUU7VMPprYjqORnrIbzNKuoG1aH4S9t3J
         jJ1epK0WSIQWiy5Nrv1D0U0fNMuv6Qiv2nqFjOKsqj/YGxZgz8keTUz24CoRANVcGjSm
         Ny1tTk+FK2ZGiE51z9056yp0nd6dZGXQj5uAuzV1hdeJTIrckOWTCAhUPSmM2aocRsfo
         7bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198352; x=1713803152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hobzl0UFhcxWwRJMKvUjC2bqwhgf84pG3unrWYn5GIY=;
        b=Xw3v5MaOoUKBPbn1Gg1qI++VKjTLDQ2+eC6CYiHS24hJweteGdb/5/nXHFOTSFiVUz
         xooSBf2AGb7LjXh8Qo0a//Kx2UA916THwp0PaWNBrOwmxO42/HSs8iFZtWgmbHsvVHGm
         5Cezttsu3HHKNyslHKqxjpoRa5lSRWos2V4i0ny/bFvrO6M1blJ+z48vU+GG+g7z1Dvl
         HXsK0ORxInNbcaRRzdvD0l/zytYLsrTz/BMBxw5An2VekGB8augO8fN9wBfc53B1HTeG
         oUzGpS59WoI/CmWcLJ8vO2IRbGWtdI3con+we4owgSskyUuhPd2PYRwa1RjsgZOn8Puo
         as6g==
X-Forwarded-Encrypted: i=1; AJvYcCW+W0Q+UcPiJcoTRETkiZb0cND8TFgAueqYL2VbKWFhRGcu1nrVnHuwfqdfT7rBaZ+ss42Nfyrf9u/DGGC2uydIcivF8uWAk80A73sCl5Q=
X-Gm-Message-State: AOJu0YxDZv8p90u28zusz9WnEnz8+z3M1SPjgUqXWa4EnKXwdga36dIb
	zrTR3upTaX/u6fIXQXcMFvc+uagwjwv7//uW57lnAuHUSqJJlwRG4Jh3TLHgss8=
X-Google-Smtp-Source: AGHT+IEoJb53bXVvb5Gi0iF9qZqsarg9CG4MfATrcj7oQ02oHBYqjagcwajf+AKPvrZpdhRvj2MvBQ==
X-Received: by 2002:a17:907:360d:b0:a55:201f:75a with SMTP id bk13-20020a170907360d00b00a55201f075amr1301928ejc.33.1713198352533;
        Mon, 15 Apr 2024 09:25:52 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id ci23-20020a170907267700b00a52431b57e4sm3766497ejc.121.2024.04.15.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:51 -0700 (PDT)
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
Subject: [patch net-next v2 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Mon, 15 Apr 2024 18:25:29 +0200
Message-ID: <20240415162530.3594670-6-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 254698c6ba56..e85b361dc85d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -746,6 +746,19 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+        local dev=$1; shift
+        local timeout=${1:-$WAIT_TIMEOUT}; shift
+
+        slowwait $timeout ip link show dev $dev up &> /dev/null
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

