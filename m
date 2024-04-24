Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F8158D79
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955269; cv=none; b=mR9vxwNp+c6zd90qK1xg0KbKq4A05NZALWe5gQH1meKGovLcVDkG66Swe0A4O88x1gfnVPFWobuaZX0NHR6aFBRvDPXDAG9Dk/XWYY4wOTdVx1RjMZz8JCZ/wEMJD+KM9XLo5/qpb00/roJMksjfj7qwh3IJLkGoN7PDNaPq9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955269; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PENzA5loVUTwYDvYsMJqO35wHahtE+DKQH6aPU2SYlWD01y+3B8HK4+e4oOz3e5xOZDvfUUTFWRlLhkb6UcGSixxbTYuYs6K3fcE1QRDI0gay4SgqVud1rYt2oH021zHZMKLKgjrFBAO+ZqxxlJ4mOgTkML1PqnogjhG9z0BGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m+luEOK3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m+luEOK3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so2253732a12.3
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955267; x=1714560067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=m+luEOK37LbJuyE9OG7sETvgNcTzSKVluEjiPwwmkmNprh7R+TXW8jDyRC2YywOHAG
         wZQ3sjYCBseXEhIL1zT8jNg6+wRtQN8EKQ42vY4z9GHSyWe0bAYGNXqi6y4/hIQruIzx
         kxngNCUqUHRdiBHIQwjpuE+dwJ10JUk7kmiwdIAN6/cGulQs8Nd/KpL3b60hNZJNliXn
         pDgRQlYFQw4y/GcTtfC/B6e7wAYQRgamSiX+wi5wtuKuKOip6edf9awyqizHmoeIUR5m
         8EzLzyd/c0YlM9qzgOWDanW3KucyQ9E0/AVGvzwO1yix5dGhc3HpE/8weu2M7oFPM6X2
         s2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955267; x=1714560067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=O5McmJ7kCfdrBSqO7nIj3SY6qiepTNjK2MmBDG2qvoWsgx36y9VJo8FjlUwKHwMkdX
         pARpIwJOemSb9CkXd5dtv+izltj0T88/MpB3gEqcLyWK/5xjPiMco7zv6QmN1oHe1s08
         Boh3egVh0xA8BluL12k6gEeqPGgkUoMMqVlHVfsNBSyM/ZLVYHtS29syRBK03iLguCww
         bNto47GzZymw555BAQ9TSHbuaAa5oZzTJX8UcCHiFF9T8YiVEnNPwAO1fF/7pTWvn0vQ
         WPQkLzPrL6zQYgYXa4ibZfbRsD9k7PNTPDKHbIUBJ5X+tlyxftoMM50dvBYxrghtbgei
         TUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFx6htEy/DnHHuMtPlPWLgTOmbPuCRJpLlRKrcoFdYk1f7txE3hGYblHu0tIW09x/PCgsG96aSnGsynP6pXqMTZnX6D93fbSU2PJnUX7o=
X-Gm-Message-State: AOJu0YyNv7SoHZ9qd8foh7uDEyxEubUtOsBEEM0Ho4T4PsOLQ17+Vy6Q
	rNqhi0gH4/hLDU4M9KEjpZHZDy20yJZs2gxh8YTuwlZxg8yb27DwhF9h6ZsAths=
X-Google-Smtp-Source: AGHT+IEcmmnN/LjVFLpWsyWulmkkwyLqo6DLvHVQYSvdmQmglzk6LQD8NgEQmHuc0kODNIK/8lCHYw==
X-Received: by 2002:a50:8716:0:b0:568:c6a2:f411 with SMTP id i22-20020a508716000000b00568c6a2f411mr1528361edb.32.1713955266379;
        Wed, 24 Apr 2024 03:41:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm7686627eds.45.2024.04.24.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:05 -0700 (PDT)
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
Subject: [patch net-next v6 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Wed, 24 Apr 2024 12:40:46 +0200
Message-ID: <20240424104049.3935572-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424104049.3935572-1-jiri@resnulli.us>
References: <20240424104049.3935572-1-jiri@resnulli.us>
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
v4->v5:
- rebased on top of previous patch removal
v3->v4:
- rebased on top of changes in patch #2
- reworded NETIF_FIND_DRIVER comment to explicitly refer to "importer"
- simplified driver_name_get() avoiding else branch
- s/find_netif/netif_find_driver/
v1->v2:
- removed unnecessary "-p" and "-e" options
- removed unnecessary "! -z" from the check
- moved NETIF_FIND_DRIVER declaration from the config options
---
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7913c6ee418d..9d6802c6c023 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,43 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+##############################################################################
+# Find netifs by test-specified driver name
+
+driver_name_get()
+{
+	local dev=$1; shift
+	local driver_path="/sys/class/net/$dev/device/driver"
+
+	if [[ -L $driver_path ]]; then
+		basename `realpath $driver_path`
+	fi
+}
+
+netif_find_driver()
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
+# Whether to find netdevice according to the driver speficied by the importer
+: "${NETIF_FIND_DRIVER:=}"
+
+if [[ $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	netif_find_driver
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0

