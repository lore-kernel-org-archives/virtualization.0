Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440816F8EB
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456534; cv=none; b=BdIBKgTYS9mxmkafpKtAlGvAJVzXTHQzszxISoeadmUmzXoB/8H4NMH5/bgzqdrxqp+VKwrZOWymPaIuCiZywzvYifhu6Ku56iGIvRWE/d3ctXkG+/3bUWc+jIPI16Uu7+RGf4I6rYgu/sA9ZmeXkisHeI+5GSTQNkZhpeU2iU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456534; c=relaxed/simple;
	bh=2jQPPr9mkTqJV56LvL7E1XGifU9BFqf1rQjL05mNI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvtLk0DbjqmdExobHneYQ3NlW1RonUchyC1ypElHm5moR5UGmGqwXcJQlySxkoZf6VApoioYvcwpEYZLrJmrdOYE7euIXqzxeekoa7jb82zINUhIljEQjziK+LnZmdfFBbb9RIqDGkQhBPKvKrBfjBAdVlnXF6FKwQ8oTiOY2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HQOZ5VF4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HQOZ5VF4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a524ecaf215so120214366b.2
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456531; x=1714061331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSQx0/+CrkjLLqkpLado9VHrrZwCAyIq3CNsBoHFJwI=;
        b=HQOZ5VF4tVtl5hfuLTQs+LPr9piK7vAk2H6LqGMtqK0AbOTbJjBdS0SAQO3/Gltr5h
         m13xYEbhkTwuw7XZ0cEkqGLI5XIvr7IFEc/icxz9yWxZaICL1SMT+wCCMQWdvIG7Kbge
         DTkANZR/eDC0yZ//B9pNw2EkGvTkY6r83yNLMo/CQleWkcjvNd5N3LeZg21MeWe5LNiF
         gCK7PiEOo6SEf3KUsBDlxJXIQVDBd7ztgKf+t+qgROs/9etQs9YeMnhr1FqLNuTe9O53
         Hp0Df/Kx6lnawttMJm91djlbTMPkN5xDf3APoo3WvqXpl7fSJ6081I/0OHZN70S4eTJ9
         nY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456531; x=1714061331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSQx0/+CrkjLLqkpLado9VHrrZwCAyIq3CNsBoHFJwI=;
        b=Q7JOBiVCkWGbwqvPsAjp1kxCCM2Q8EP/0lyqaTBTSer8ieCdHD7ZfPZc1pbtiP6C/b
         P285WbEMEqPfX0Qmmzmbi01p0byVRBDDEQ4gPSulfgcztmet7LCDzDF4KIlfMVHwPiFu
         2TctzMJ20YY4PFSJnak3U1NtKoKwDbUo1rnPPqcfL9/XkyZsFhxPaTJ7R2LL+jKUU0mf
         yGxOkjnEn1tjunvKUxjgj693+dbIBR9yAl3Na2MkTs/F4g1HLpcfy3PM7VnAFsulGQis
         f2/fuRZtarBxUb+BPk3bsw/1T3LMyTgZoqwaSo7MWWCzio8OYLxaVxT3tSRpEFvIerUS
         Gmzw==
X-Forwarded-Encrypted: i=1; AJvYcCX8+PMOmuqX5Yr6W30ShXEjaFSQ5452m0gsxyZwiy0NRpV4rETCkznaspTuRxOUfDR9H/azCmEINxh863VbyLJy/Fa664pMWvaslAbBGUU=
X-Gm-Message-State: AOJu0Yz6g0gxQa+bBgMl9TjWtmg6U91PehI1JT64eSKrpepiijGcJkxv
	MGToeTLo2TWKOc9cC2R9dAmT3+hjuerqYvk60nglAw2jiWARpxH0VKbD2Dbv+Co=
X-Google-Smtp-Source: AGHT+IHiaBm2LKsHV2qQHTiD3aikXdD7pxY2WNALoqBcP1UifeUoqdQS7+b2n5gVV7we9OrzlrQ6pA==
X-Received: by 2002:a17:907:9724:b0:a55:766f:ce59 with SMTP id jg36-20020a170907972400b00a55766fce59mr1826260ejc.75.1713456531339;
        Thu, 18 Apr 2024 09:08:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm1079280ejp.171.2024.04.18.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:50 -0700 (PDT)
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
Subject: [patch net-next v4 4/6] selftests: forwarding: add check_driver() helper
Date: Thu, 18 Apr 2024 18:08:28 +0200
Message-ID: <20240418160830.3751846-5-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d49b97edb886..17f8b6b9ab9f 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -283,6 +283,18 @@ check_port_mab_support()
 	fi
 }
 
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

