Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A517107D
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372363; cv=none; b=WT+peLbKIFh94qEgmMz7YftBTzQnyDOnd73IC7NBXBZBNuH9Qn7BYSe4Eerg5GAP013E+Zn51MZ9T6Q4ewrVq+U17bHlKG9PoD96QIar7rKznZVmne+ksooxYBJVg7+P+6P7js0jhjR24Hpt0WV6nd3BujX+HlbPpL5PKuVo3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372363; c=relaxed/simple;
	bh=PcbDhpd6BnODpMOwqMAwtZG4dOefUKnbanAitXMinJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm+W16gL3WU01ZL4T/i+6FA6RGSuhxrsZVzTYXwO9eYyrxgNIGtlgrblAbkwDgSICdXaLQjB7Z+eVOF5FWMz2nFvzXCnk/WTei+5JYNhY+7ktqjV/ZrsdIxiFTWsL4or/EaIHjNIPQ0VZ5pcnHnbr5wdxwM3nukM33QHTuJn3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nKDryIda; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nKDryIda"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so5950897a12.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372360; x=1713977160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxLxMgGy2MXM/swv+tfB8dexSsgyjH3G44Q6iWAtDNs=;
        b=nKDryIdac7NiocMurYbZh0sMfRBKlrNHSAOaOS/T92F5yUxG/wES996osf1yMBYOnQ
         s1gSyG8aBPr3u6JnuJqwFaYi9V3W4keDMEy/jUMjEdii2dWErAP8g/e0MF21crrLvwYk
         sqJl+1rul+N186wnBbtIgKmLOuU0Y5WYmZ9tARr+ET3mBGxHUiDuXaIKuTs66RQC3PQR
         DIwQULvzxy1r52p9Zw3NBh9jvKEdWdyEaeXfs7tnAVEXfcMA6w7JpA1aoKaW0E4tEStO
         nipGDzoapIAouy5xqBuZqOEo/K8aYGfT3+vIj+rX2gj5xdoCioaUZBlim4TGx/yMdPUO
         BSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372360; x=1713977160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxLxMgGy2MXM/swv+tfB8dexSsgyjH3G44Q6iWAtDNs=;
        b=LBDLMD8Mrp0juT0C65rQqUmHcviTvQV1PzlfPczzkpnBidl6tAt31fXKaa1qvFG7TD
         uHz7P0Y0ONR225/xkvofyX6HuqHeLF9ulLzCUKS0NBCGKUchNdW6BDxWcW66rZZvt9cU
         PEuehV7bnYaVN4rJGIbGpM2sHEBpQr36wRbeWBWPkMzBbu3kyFlyIZmTPHqygimwIyjM
         xOjgjYxxu4FNRavyOjKhUTUj2YMMmYSfhvBmdk9s8srS1e+3N0aPgf7pKU8T+00CPCQ+
         eDofyaGigWiGZpORO9T3OCpyfDehmVURuTkguEFbRc4gyixBTObiLssMD8Dg3joYWVtV
         XFhg==
X-Forwarded-Encrypted: i=1; AJvYcCVZvtEK/yQL5a8Eswm3xx+n7rCGPVPDZom90SmLkvQoQaHf/mv/W5gqT3rGawUi8Z5dF92r6YfY1UAD1T3kuJJ+DXR9z5yj+2+bH+zJLmg=
X-Gm-Message-State: AOJu0YzLZ2SsxAzAzdPyN4Gp7oeTNAVRodBNNBHNkNruRPRZYz6/CTAg
	/QPebfraHckLSyDqLBA0FPjCH3n+X2iXD0QLLg6p1Z1aWOoE8efAc3df0uU4OD4=
X-Google-Smtp-Source: AGHT+IFkVraWXUhT1L9urSkAmtQ2ZYqLl6CkHWvRgjNYeqKxUh5RvxFXQWBk/gVZZhnmdXBrETcE0Q==
X-Received: by 2002:a50:9f43:0:b0:570:5215:d29c with SMTP id b61-20020a509f43000000b005705215d29cmr112439edf.4.1713372359844;
        Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id t6-20020a056402020600b0057030326144sm3381448edv.47.2024.04.17.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
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
Subject: [patch net-next v3 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Wed, 17 Apr 2024 18:45:50 +0200
Message-ID: <20240417164554.3651321-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
 tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7913c6ee418d..2e7695b94b6b 100644
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
@@ -241,11 +251,6 @@ check_port_mab_support()
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

