Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A9171646
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372364; cv=none; b=Lzw4j8kLH3CqpoZ+WWCbPsdj45iefZjp5zHU5ej/hS1b8Z185J8hVchJSieX2YlFvSHTk5MCsRi3ZDdLxj22glrVDY5zXiJiXTcG1va3uuxsJ+CvHuy5I3f99wpAMQ4P0pIXDX87cZllJjTsIc3XN2e72eahYbcDIHa5O7U+hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372364; c=relaxed/simple;
	bh=ywpHm7bmooFCjvprfvVd/Cbc8wvTaPUxL+QMQivo5Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlWI5Rg63RdoBGyPv0UYXOas67/jIOkJPrpQt4kBovdi0U17VA1Lt9T/vC6SsTuFMJJqNQYWdUGvWpRiX5kVjOUo6+bOkjNZf6mkQpCc5tsajfp9hP+u704RmBUlugjwTJKk5U8N9ERsmsgTl0c/zrlv8L9FX22EvSVaAUTFg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Lva70dd6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Lva70dd6"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5700a9caee0so5950931a12.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372361; x=1713977161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwpy2d8VdZTGzMFmGo4R2LG9kH0oGH0sJNWRTRWY9s0=;
        b=Lva70dd6DayFZPCzdHwN29CZ3TSu3sER17lj4l7fUjQXDq8qJScIC85TNnQRUi0YC0
         VRYNG/8xxyOwxFqplFYyz0D+gUMn3OmY12026C4Pmj7wY1WNyImNBLjwXSSNIpLmQM0d
         tyNaOPW8/6bB5bCwZQcrDnbfEUURMD4Nm0Jp2Yiuh/eWHU4vrZg5Y1rw/qfJFqHFyw5N
         JfIk+x2tH/QCbdXCTpJmv5VZO3x2FGuG3EocOP3GjUDOnEhk2pJj1wglZjOnC39nXbWQ
         /NA9DJoaUIwMPnA1MHGvjOdTMyYyGIOwHMuRCsByxdm6OptJU3jegbQWrpnL+TFnAr1I
         zPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372361; x=1713977161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwpy2d8VdZTGzMFmGo4R2LG9kH0oGH0sJNWRTRWY9s0=;
        b=OoNNIC7wvClYv7SozsK0TLiQ310heH9skD+O+YfB1lGQvi1R0VF34tir9R/nMEXQf0
         UFnvCOORTxihm/B1Qdha/QIAuwwudEwksBFvRgl8Q72TQfGUV6HrdSz7ZJhYJsQ9oEKw
         VKLAOakE2J66ITC3BOXvaCk0Y5/4kOdLXkPN19da5oGFOFYyJWjV+Qa+cEF/bUwWDbNE
         1uptknEqSNIs6irLlqDxcCoxrG1ZHjPt4QmiejN4GiZWIdxzhQhpq73w8Hoio0mkzocC
         WixZZ63x7ADARpr9jsmG9mnCOWXzJtXKkGiT1f1dFGUxlSbnPhVSou2kt5Cjuhm1y44X
         R2gw==
X-Forwarded-Encrypted: i=1; AJvYcCXkcFy1ufhK5nQfqsPVidHSwnvyIttgwo31BbIkPD77TcY08jNpXWsDw7h9/DyUov4pl3b8/n+cs2jDIaBJZylGp9TBxiBgXUO/3eblCcc=
X-Gm-Message-State: AOJu0YwM5Gpqap/APbRMrSdOW583ya4G7igiFmdBUoRkw1ZyeBlhIBrd
	v60I1ebNrpt2NijAdROK3zRED21KnPY5H+lJbsjMAKAHw4shdRy72q8C70JqPew=
X-Google-Smtp-Source: AGHT+IG3Me+F0oYiJTCQwHguq194JAhZMF1Uoe5DU2QB6YsaeleSbRyFK+AQwlYwjcC3c8OqOgA3VQ==
X-Received: by 2002:a50:d655:0:b0:56e:64a:2a47 with SMTP id c21-20020a50d655000000b0056e064a2a47mr90004edj.42.1713372361527;
        Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id b73-20020a509f4f000000b005705e7ee65esm876158edf.56.2024.04.17.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
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
Subject: [patch net-next v3 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Wed, 17 Apr 2024 18:45:51 +0200
Message-ID: <20240417164554.3651321-4-jiri@resnulli.us>
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

Allow driver tests to work without specifying the netdevice names.
Introduce a possibility to search for available netdevices according to
set driver name. Allow test to specify the name by setting
NETIF_FIND_DRIVER variable.

Note that user overrides this either by passing netdevice names on the
command line or by declaring NETIFS array in custom forwarding.config
configuration file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- removed unnecessary "-p" and "-e" options
- removed unnecessary "! -z" from the check
- moved NETIF_FIND_DRIVER declaration from the config options
---
 tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 2e7695b94b6b..b3fd0f052d71 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -94,6 +94,45 @@ if [[ ! -v NUM_NETIFS ]]; then
 	exit $ksft_skip
 fi
 
+##############################################################################
+# Find netifs by test-specified driver name
+
+driver_name_get()
+{
+	local dev=$1; shift
+	local driver_path="/sys/class/net/$dev/device/driver"
+
+	if [ ! -L $driver_path ]; then
+		echo ""
+	else
+		basename `realpath $driver_path`
+	fi
+}
+
+find_netif()
+{
+	local ifnames=`ip -j link show | jq -r ".[].ifname"`
+	local count=0
+
+	for ifname in $ifnames
+	do
+		local driver_name=`driver_name_get $ifname`
+		if [[ ! -z $driver_name && $driver_name == $NETIF_FIND_DRIVER ]]; then
+			count=$((count + 1))
+			NETIFS[p$count]="$ifname"
+		fi
+	done
+}
+
+# Whether to find netdevice according to the specified driver.
+: "${NETIF_FIND_DRIVER:=}"
+
+if [[ $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	find_netif
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0

