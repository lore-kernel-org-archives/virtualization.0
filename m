Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EF811E6
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198345; cv=none; b=mQwVNOc6s02j+uku3W8eH7PrZfhpT2wuoq8o8G2Jmuvn1e+B6sROKoFWC51lB4yo+KJ4Q/rXLyef2+Of7+WMqsyYMlERh6DFbMbheFjZOuSKxAYFUFBiYO6SmDXD71WN1jVFvcbszmV3Jna2s+46zIQM8Tm9si0QF/L1BAbpq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198345; c=relaxed/simple;
	bh=j2PzpeP++wEtCimj6PizZGaulOFqRwTLU39GbwROnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN3GO4auCy9gS4vl7jInqYyOwZsYvxpjiIgy7UcXsOUskIe21SfpvbjJawaxaCC8L08Mur+k7ygaUMQzJAhilxFUQJUC+fQw30S3GVoT1V0nfLjv0p09rxnHNtfwVUOHKMepzVLrQf/8IGH5Gp256lK0eV3Xdej7lzHOOKa0tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xRFr3X5G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xRFr3X5G"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso3569707a12.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198342; x=1713803142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=xRFr3X5GPixs1Wdp3n/BdgKovl3kh5Da6AaIRCkkMNWoQUOLragp/hkxfCjq6aOQn1
         LUQEfD+z4BKeYCdlzS+3bDr5esKoL4gsYJEm1iVLLWhbcmB4k4K5tCMQw10cFvjcWuha
         dsRryxfM7BYR8wPTwp7W3Sm47bINH7+698sB7DIlihrn5w15R7lEOrOS8XLPkv1qpkbH
         SVQucSBiWqnxy686T58ojFYMqeQ+4BSIBtuFa2emXN+tD+bOnpN+7Gd5DUTdKv0O/dhM
         JkiyIzpxypIYg3SHRmHYiv/dr1JWavPir11CMJq+9q4Db/WubwN3bq3Rz26GpLUVKjTW
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198342; x=1713803142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=KnH3N25sUpLMN8XAkFZSNyugubltXzJ8vr+ksLxjWjyrrIu9rPt7FbyvibSOtAL6nX
         KmsYDG4ckL/c0Ew6gnhT4QKphB5w4s8VYCkyaFwTvZQ5TASCzKWLvs5t+IWgTpOcsxrF
         J4nix7CqfVHUAvYF3bTLocmgYtxURdVrZkShyJ6jGazt0NbIjCRgn1zgLHiebjqQZaI2
         gn+0Y6JC5qkconElU3GYhL5kJfHZDlWkp7MBgML5+LAKqP4bizRLN3cf/9tNLGhqMdOy
         5A/j/SJFL4GjSfvzNKC8PxPMzO+KCc1lk5pv8BrwIiPz3MwEdizZpZ6HLOPxyS8C1l7W
         WDsA==
X-Forwarded-Encrypted: i=1; AJvYcCX2WS+4apletktaULcnqV8KprMEm9rYQgIv7pSD2Vs/YY0LvEvy3gEW7D2ej/7R72YCmXYASM3ziS4FiABANYRP6tt6dJSGh+Le0Ooz6GA=
X-Gm-Message-State: AOJu0YxJtE4Cs0tDO151ioHzF8GIT7bOB2R/hK0fcaXA6oV0D0a1W5RH
	JNyZpunTReJ4l7KrPXkttBFAmBNhrk+zlrhNFHVxsu/MtuSPmwzqO119zHCgluk=
X-Google-Smtp-Source: AGHT+IE3qEYePTUANR+0lWo36Ejjsqj0/fD1LifZooLG26Irc7ZuYxn+NRnblHf3EFxVGbz2a6489Q==
X-Received: by 2002:a50:9506:0:b0:56e:77a8:93d6 with SMTP id u6-20020a509506000000b0056e77a893d6mr6698185eda.3.1713198341676;
        Mon, 15 Apr 2024 09:25:41 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id ck16-20020a0564021c1000b0056ff510c327sm4381535edb.94.2024.04.15.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:41 -0700 (PDT)
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
Subject: [patch net-next v2 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Mon, 15 Apr 2024 18:25:26 +0200
Message-ID: <20240415162530.3594670-3-jiri@resnulli.us>
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

