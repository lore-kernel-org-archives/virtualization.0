Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335E149013
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934807; cv=none; b=f4Yc2lDCo2lB4DpL2bW20CxSlnJJ9mkwi9VWDNagxUGbzX7KtnYZ5J5+pOL9RMVtUqsmvkX2JGaKc1kADLX8EAtOCIfEb5Pm8Twf/vnby8r7smne6+5SnrRz6y6V/ylBdwQJPXgSyOO+sHNYNgSfEsgXDZU+kToNZlZZ1rlI3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934807; c=relaxed/simple;
	bh=j2PzpeP++wEtCimj6PizZGaulOFqRwTLU39GbwROnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOCnrkWR9vOuIzMNXJs+ngsGjFFqpUg3LiFzyxweWToUYxO1OpjBihkxzxn4cGmBqqR2yrs9f3sd/vIyOb2bXx028wMvyE1QaAjoS19N/1fcJAL1raeD8f8stI4Nr+zWUvc0maWPqBHq8bRAieeS8x+AzQSxTS9m/QbdIWvI2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d/sr+o/T; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d/sr+o/T"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so10480661fa.2
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934804; x=1713539604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=d/sr+o/Tt8FdbiH+tXbSAj7CGUhDIlB3cryf1oiK7/xQ/zH7UDCqyek+rcJeebd20l
         BkfIcHRq8jD3g5MMCj4ISCEzi48jbnM4HWMqGXQvrNDI2TlYgQKmDgFF21eBsaJdXGh8
         n3kOIkGMsnbKOvG3Bhnkd1SEi3z3hs0qV6iDYwmr/HWSRdFeLg4LSO74K+c2Z1bjOjcR
         vFUp1FT0DdDfSM7VUAF2+vkIxb54JnkjXEhGD9AaaYvAzBvF2TYoNUG9GgoP377RDQf4
         3EdsIMTA8wgkZ30nOiV706rqZo8fB+59jI8uEGBFDJOQ1cCWlQy/0Dlj/B2SR9Jail0/
         tg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934804; x=1713539604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=p3gXZqlTf8Q1fydZ3fuzx64Uup9sYzxxUtcXc6AColiVyGyh+oL4IAitVJkSLO4VZC
         rJBIeUH5A4+AbUI6HZ8vdFvIvwcDFYxsIohNCxk19TYk6yve70aZ80TUBaFM4kcVAh8c
         qGNZuIoy3+0PDBCLtN3L2zcdnYRztO5OO03Ywv3SrdUVBQ7yxexqvuxj2xFt48nYX+Wp
         mHTGVHd6290yylkNcN156jDjlB+nmNhB5webTRTKUzNZUCRcgqGVgakny7U9nMRG/4gK
         ACTxV+f6G8tm+KGfdfka98Y7Y3x8X0QAOSNS3jwRXf2pR6gl11XkwNbYt/XdvcstRkYA
         afEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL74h6L3FtGl43UZPg5/kcO2pOvfY49SmCA3Eh8oJkw7Vqm3Jma7xIL+llWuNSWvMOTF8dRI+SZ77FMiORn/8/NQIVyEQ0hpLjN69HUCM=
X-Gm-Message-State: AOJu0YzweTPwzWCKx8tqQU9zELb5K1u9Dl9XPDAAIu5oZohIdMT0N84x
	Kvx+5YKlBxlSpZlZhIYgqCAYO9IS6D6AiE6aF0+Wtmw3dI7TLuFLq133eS1VRwE=
X-Google-Smtp-Source: AGHT+IHFdKzw5NH68XHyEiCdbiwMKDRkLvCxllBdJm1UClw0RzjlT/6YxQPbu8l9bViiRw+3UWrtAg==
X-Received: by 2002:a05:651c:2124:b0:2d8:3a46:8ab6 with SMTP id a36-20020a05651c212400b002d83a468ab6mr1894565ljq.17.1712934803774;
        Fri, 12 Apr 2024 08:13:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b43-20020a05651c0b2b00b002d82bbf7862sm528050ljr.25.2024.04.12.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:23 -0700 (PDT)
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
Subject: [patch net-next 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Fri, 12 Apr 2024 17:13:10 +0200
Message-ID: <20240412151314.3365034-3-jiri@resnulli.us>
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

These two check can be done at he very beginning of the script.
As the follow up patch needs to add early code that needs to be executed
after the checks, move them.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 4103ed7afcde..6f6a0f13465f 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,16 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: need root privileges"
+	exit $ksft_skip
+fi
+
+if [[ ! -v NUM_NETIFS ]]; then
+	echo "SKIP: importer does not define \"NUM_NETIFS\""
+	exit $ksft_skip
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -259,11 +269,6 @@ check_port_mab_support()
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
@@ -291,11 +296,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	require_command mreceive
 fi
 
-if [[ ! -v NUM_NETIFS ]]; then
-	echo "SKIP: importer does not define \"NUM_NETIFS\""
-	exit $ksft_skip
-fi
-
 ##############################################################################
 # Command line options handling
 
-- 
2.44.0

