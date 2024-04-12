Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C814D28F
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934817; cv=none; b=JeFEdHKujrKDL29OaujBIHnWqFF/5uMbUmeo299xUXOx+r1Y6tHZWteJO+SZuaEd3RdW5v8r4dsHZsr7LpB9pC9AUrJLCxOnm29r693055CEWDqQEY6a4IiXgtWMdfC2v9HrLxrBQikZ3qZOkzU2wUrICedOERMF2FQxgS33YuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934817; c=relaxed/simple;
	bh=y4OsWKbOLTtBRExU+Hq2EPu4xoFPTa3O/91wuGNyqUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne7QIU/FnEjrNTHLua1Vvg789b711zk1MVO7PMryPA4bZGBCeyFebUq1jgPB3onpib7To6hMjfEr4OGDFLVBUlgtPjtnFV6G/NqIjxCd3FeN3It9MT7lfpbMn0t/rv66NxMBIRKq8TXMaUh47c8YPRc36so3qz9POSctaBLNw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MXNIg1Id; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MXNIg1Id"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516dbc36918so1336534e87.0
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934812; x=1713539612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sErkhIGmhf5usWez5Xl4XZ9oQzpvBj57cN4AShWReY=;
        b=MXNIg1IdZ0BD7LDQELQc60nCzgJUME9NuCUIuyhWrTNwafQBxHdIauCQy2yqX+veXe
         /cebBKIvTolqAP8ZygYFWX1LlX7gzKTRvMcJcGclqsuCCn0HsD9ODc/DPVFzBd1MxRfs
         bv9tlBTX0/ZETxmk7dS+T/zn4f/5CG2fLZrqD/Cw98584x9fc2SKKsDQOK94/59KwcWK
         YsFFky+zxGx8vyrpOWmQZatuEAnzXSVmDzdV7H7f2HXZWspfplnVZ5DnFGik1CSzkWBk
         AC7LspJtHCpOn6lVLvMosUyM1heyYSfRyO5fHVdkLFJ6r+p6mRnpZCME3tvL7SzYrSlt
         2p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934812; x=1713539612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sErkhIGmhf5usWez5Xl4XZ9oQzpvBj57cN4AShWReY=;
        b=i2SCYlEIYG0ouPNGf+8Uou4Gwp9vaAmkO/6csI7JH9vE2/mp5tyxZB9/AVmAvYYeq2
         job0zfMUu2pwYwfd/+4DHLMm0U6VtPcRRYBqhDXSKk1l4ZhYuRs0EeZ7gguEjmUNUTdQ
         pnf0IWP5ljxLTvHqUllF62ZAMVYEVtQ3WWm9J+cgyfeKvd4NcZ+MNc3EnlxH5ik3VSMc
         ddUN5A/wYZ0w/1wLlKEmGck/5I41xMWXcZfwc+ZGQoXAR21BupFdnegwrt5h3+P7MtsI
         vuBhcukRQwTKiA1TRXrf+IxNvvy5foUYuzTINpqV26wkdKCtjrS3EUZuEhGhb0UppeXR
         RIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxziASostlwf3tWLjz2DnhOOdpjVV2XGloMF82FYw+booqCLPUq6JHaajgbDl9/Q6o9IcW7T+DW1qU3zy909POCTcowy9IMwGLBWa8OKg=
X-Gm-Message-State: AOJu0YzsQbocHmE2Inz64UedjW7lrz0jptDO693DHL4lFCRJpU8Kjwsx
	7yQWiuR17rFes/Gs/AUNBGd7SNUukoLNbXKwVLrCF4mE5qVXcMKeW9AEy20t1Lg=
X-Google-Smtp-Source: AGHT+IHwWGW3bNG9GA57M2WThwmdHi3AxEYStvc4TMRAgXH1eI+v60ijR149hFgbWIu61VtE9NGtsA==
X-Received: by 2002:ac2:5502:0:b0:515:bf51:a533 with SMTP id j2-20020ac25502000000b00515bf51a533mr1829013lfk.23.1712934812639;
        Fri, 12 Apr 2024 08:13:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u5-20020a056512094500b00516dabfa3ffsm532393lft.145.2024.04.12.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:32 -0700 (PDT)
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
Subject: [patch net-next 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Fri, 12 Apr 2024 17:13:13 +0200
Message-ID: <20240412151314.3365034-6-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 959183b516ce..74859f969997 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -746,6 +746,25 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+	local dev=$1; shift
+	local timeout=${1:-$WAIT_TIMEOUT}; shift
+	local max_iterations=$(($timeout * 10))
+
+	for ((i = 1; i <= $max_iterations; ++i)); do
+		ip link show dev $dev up &> /dev/null
+		if [[ $? -ne 0 ]]; then
+			sleep 0.1
+		else
+			return 0
+		fi
+	done
+
+	log_test wait_for_dev ": Interface $dev did not appear."
+	exit 1
+}
+
 cmd_jq()
 {
 	local cmd=$1
-- 
2.44.0

