Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698B634EA
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868888; cv=none; b=HMJzp/tqQOR9hw5631/YCMic33lutwzFKIRVU07LA0y/k7SS5ry//eXpr6mSqsTIFFhUuU2NGQuUulj7yqJ6J+dBYHZpWN87deMrT3qUOSZnrO2JG12SZJzDUl3zu8bQsM5ND5iExJgiHKaN+I7ZmaiDyGF6AbmtyqDSyTCrdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868888; c=relaxed/simple;
	bh=b3s3lonKXCUontl27cidtmw2bRxAlU6LH2RDIq6KhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSwF+I9cf1s8R+LFDZY2i/dD5xn/5bbr2fkk0qG4UkThmbuPqmo5F2yBQ7djGWyAgxXyKk0ctLaAhUErf8og7YhoukjHmPGLPeUM31JRMrxfqOO/fbleleMR4nLKGjRcuzIL688Lq1ktpcXrHmK7hiXE9/Jr6RuGPXij3i9kAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Yav96Vt8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yav96Vt8"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so4950240a12.1
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868885; x=1714473685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=Yav96Vt8Tz8D5hLxvOWyyN8/7YZ9fWWvlPMjMdplrE1yxwfJ1y+yG6PX8l+WlMHLMX
         dq5oBd9Y5syvqlk2UKw44qIBOhhlH6nBRwroWdE6eVdv7Eue5cI1DvezV1me++5edG2Z
         5ZlK+AeHroAzH/Re7bML9wISYqw0cWd83pd32WD3LyVEGMXFTOzDogggGZrRrPjwYvrp
         orwrRb12Jejc6Fm3s5WY3/xaBOdJYTKjDoH22GPlpnlANFt+NLyvP03haah5kONiSlmX
         TKnAhnje7Y63kjsL0Ais/ceVjD/ypHjRKcrFPEU+6tgbmVPgThZ9tpcjSFJdDLacoLyG
         JWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868885; x=1714473685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=LFN2stwR8ZSbmhzvU01x9fVk6PtuEPsVQAc4da3C9XpJWv5C1klt5AwwpaaJUDJjPG
         /G5xUW2YAVaGxs5AKuCdLdy2vh2x0vSns9z6s6fSlcaWgPNFt2rKSu4Acvvhou0G5OLW
         Zq58ABT1an9a7FtOkmAlAWuGiCvPiOl0dLHR92oS/ajXSxtA2yY0vnOOFrufP4lbtzqm
         LPZzIK8RPkklSWso33OTVlReibmfIUk/WNu8AB938hlYa0SDc/GFlt6WKYuGcG05O4S0
         OeMWyCKL8Lczp23TbEI63el+7x1ICMxKyURKSpUEiDeIFqYXte88NG2SjrU7XcwJhf55
         GU4w==
X-Forwarded-Encrypted: i=1; AJvYcCX/O9PyInFPSj5EsnkdRR8cJbqCtJJ0prqc5uDvK6Y9xXFyA53bUmsRH5KWUOM4pXAtXaGXLzpyqt0/Fq9IqXrF4JSBZOTfW20RSF4OnD4=
X-Gm-Message-State: AOJu0Yy3bCkGx6F1XgmYocqfkuCnsE0iGQL2gpBhATASCutD0zPxQ8MK
	GQ6MaXH0LIzGlHc06NPv4AcO3HhTsak1n0cWeIFbgx0FGXdvm60U3QKR3xb23rg=
X-Google-Smtp-Source: AGHT+IF7EqsjRddLl+xv2aOwVOeKqbSfjmJfPOqlEpNdTPkVykzo0NuULllrdLvuLp28jrt9xZ4x3g==
X-Received: by 2002:a50:d682:0:b0:56b:9029:dd48 with SMTP id r2-20020a50d682000000b0056b9029dd48mr9614396edi.5.1713868885302;
        Tue, 23 Apr 2024 03:41:25 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7cc97000000b0056fede24155sm6500516edt.89.2024.04.23.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:24 -0700 (PDT)
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
Subject: [patch net-next v5 repost 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Tue, 23 Apr 2024 12:41:08 +0200
Message-ID: <20240423104109.3880713-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>
References: <20240423104109.3880713-1-jiri@resnulli.us>
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

