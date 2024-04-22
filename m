Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C178153514
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799990; cv=none; b=McyC2qU5PhQxqVMHInlegJhgddOgYqoEkAEDWVpqGTgjocDC/ir3Lda2AyQ4WnIjccz7iRDejjyJyZkpZw5YkqtMJU0zCb+4G2QdH634CZpNu5akhXGYLrPTdUsRVMHt1/fnSS5vvzfUzIyG+ubnbxVclGefF3R5zGkI9hx9o3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799990; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj16WdDZLYsdq70rJ1HYihcj0zWuGDS1UE1kQg0Mxsn9Y4lY0rEdCfle7UC+gJKYkXe9/tEUhR+a1zrBVgXHAMo5npmDipqsqKVRGZKLVJHcjBexxDhRjq7opdT/UqqPePaVqcsRD/tEuO6UEjb8K+hmHG5+m4/MktoTCaEto7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2LFW2leN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2LFW2leN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so7436361fa.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799987; x=1714404787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=2LFW2leNbU8/9FGQp+f6HgbIxzybyKTA8SRdVRc1GHPXzD7jzeV0B9mFR/ZKBgxb6j
         g4bjYteYHfiyvMG7Ey+nP7PokSe0UkXQzwX3HbJvyAUCzI1bo1XoKMHccghRVIWeOshp
         10f+9BKBf3dUalBH/UqcvUK449RGR4HShiXXQFHBN5sOU39CVrKUJbzB2iRoa4jUiI6u
         7sOTtK4TAFCwJzLJgXV4DYZvjdcDAkAhij/FC1lTHcQlGrvBWoSX7lmLyZ+KNueICtc8
         sKmsZcaAAp6Dzcgw1xeJNhuFlc2l58EelLe0TgcDftcWRLApdAvQf7XBIFCGebdhPq/q
         1J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799987; x=1714404787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=X3GbQrbWk/gUsjb/PY8HqAW1rtSvGBqjzHAuVZOFLRU+UVxwhgMFBlBNQtntT4RdCe
         9F+7fzAUMn/QWja/QMzA2UJAR2AU5WKy9qroG92frJPbRXuuJnYzvOPpuaBrDQbXwCfp
         AHY5uVd7mkXdOOlfmM6NHJ4PBZGNVnPl7s9g4OXu6C/7SLKjl0aMuFxe1YFVB4W6qRIx
         MVFIKjmnSJ5JlCrRm1mqayEMyJaHZVtnoSE3nEedRVoMLoW0qtVeJp0M4XU4IS9MRG7V
         pOksqxvO8HdJBALv8J2RBKNzcJ0SzVSc8oO7K1c0h4FY4+UpWk7PwMT4gBqTTH2vbbKY
         TBjw==
X-Forwarded-Encrypted: i=1; AJvYcCU9YanbklyA1Lv4MDNDlgMLSIUuhCqGUK+TeCHvR4RtPPza4GCqSl7dPvnSUOdtC2ZtoHJXFtZCIMfhBztIK9P13fMR+o0GkEVXzpqYFSw=
X-Gm-Message-State: AOJu0Ywckn+PgBThOcEv3HYrzqo1H0/DC8o+R8Ye+UPS9T7OhTAgWRqA
	KM3qEWhw6uo5eou8ll58sLPLo+osUWDwnLDsMoqnS6kIMOMxktAZNQ7+LWdmWN0=
X-Google-Smtp-Source: AGHT+IGlcxXfKgORGsiWYGG7is1cgixCK8Z1Y5WaBaCSGJYErcWa1XDZsrmGBwn5EZpXUNHomnJ1Hw==
X-Received: by 2002:a2e:b607:0:b0:2dc:d2c5:ee9 with SMTP id r7-20020a2eb607000000b002dcd2c50ee9mr5633241ljn.2.1713799987076;
        Mon, 22 Apr 2024 08:33:07 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id p19-20020a05640210d300b00572033ec969sm1836276edu.60.2024.04.22.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:06 -0700 (PDT)
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
Subject: [patch net-next v5 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Mon, 22 Apr 2024 17:32:57 +0200
Message-ID: <20240422153303.3860947-2-jiri@resnulli.us>
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

