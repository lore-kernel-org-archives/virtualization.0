Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3080623
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198348; cv=none; b=IcyYsNRBNAS1++nIS2cJ3RA+be44+Rh1UgrRXoTVr105Wk+RZER1e+lGrwWYOGWo8eEBVxR3Yc42pHmChc/ko1SGrb0ZzlmBa3R3r5Y9zbuzR9QxYV/znSCkVEu1XplIlOdvhFDOt1JEt2gsUR3EAHVMPNdyaI4dvvzaGO4dwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198348; c=relaxed/simple;
	bh=wxFoEQXGXgP9lAoXIJl4FH/A6/EA6g2XPjytbEI7kbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aY85ZVB953uKweywG2hzAowZEashGUx2noRSJh08Q2eUBG8KyNj/o2JSU+nJb2EOELFz4quhvvYYE7JFrHln5vZ+uxf8q4L7dww9Upj/7wth1nOaue5zrTOCUxAo+sxnvez6MxtObpFexRPmUH5XvM0oJZA4faHlDoUmoZDe8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F+kZLzpP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F+kZLzpP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so2867792a12.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198345; x=1713803145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOjc7RskPi7a/HeDwvwVOXTy5sL+YjkDPnBm1m5pAYk=;
        b=F+kZLzpPwsUL4GJkpFyFyplDafMhOeEBm/Jlm7WOEcuLf+W1PSLx8R9k1DP/5PWdO4
         VWiUGK4KdoY2jjH7+/HlKpd1R3EaAAJGPVz09bl/1MQRY7eoxbF+dXZ6+f83Y0GKRnVR
         RIVLVjQoTjA8a9FsGK5/YsAqeJ1hoaRdnj5He0PW6c7mIm/rWy7AAghx/DwDTDZUn6ge
         ch2ttNlJfwORBKBFyjIMfvqFIwKUJ1OGcIQMRKRT5ZPYp/+MtvHlhI4wjTZqEQB3DdNA
         u4eR4PKzGJKQBRXbHp8ZMlVo0erkER8A/7YtCj9GKaMB0xyqIhrnVbyz5vNbzqYvC0Ch
         JAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198345; x=1713803145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOjc7RskPi7a/HeDwvwVOXTy5sL+YjkDPnBm1m5pAYk=;
        b=YWR5MVs5Wk9OBivcf6nfbi7eiFi12bbPSzZoZY9fKvt1amvLJJKDNeQ94wObYW+B98
         GO0A+/AhuXCc3fPke8TEgak/894YY5zdMc72PjAOe5y56QDiFjD5qSH+yyei4CGuyiIw
         w1pUttIi2f096G3omPpxuQqunCGR3oJWN2m1ps2YeQkFWDztnm7vYfw1gnhDIoBHC21m
         SHpwa9ltzQOQLqlaXX8zN6Q3pT5wYoLKKtTzJSde1KQY74at+rJ/KVvdRClLoQdMASan
         vUEzq1rya8HW4TcPhtnGaVa9TFt8QQiPPxLslQxMBpo9f5noTmrGMHWNlN3Gw58lCzua
         3Xwg==
X-Forwarded-Encrypted: i=1; AJvYcCV1uxV07niJiwC/m5oW89daFYfI3KkfpzbfAAWSwtRYs34oua2c/DALq3543ASEAC3PDWygfFh/ewHWhWsyPoindUrC9RhTc3P0++3N30k=
X-Gm-Message-State: AOJu0YzXpQg7kti+GGAL/1fuTx7G4y0dHiqVwvR1HGLavNIbAHGed7qq
	A94UBATEJ7eM1jb/qeE8iZ0U5ue4BBCoJBkWl7feR10JncJx582/zACyqYua6zQ=
X-Google-Smtp-Source: AGHT+IGsktiI0fRNTkM866z5w/QeMx2+qxChxXe2b1H+SAiQI3oyutgFmZXAflo3H33P1t2i05fsmA==
X-Received: by 2002:a50:9543:0:b0:56e:2b1c:d013 with SMTP id v3-20020a509543000000b0056e2b1cd013mr7749568eda.21.1713198345074;
        Mon, 15 Apr 2024 09:25:45 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id i8-20020a05640200c800b00562d908daf4sm5016938edu.84.2024.04.15.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:44 -0700 (PDT)
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
Subject: [patch net-next v2 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Mon, 15 Apr 2024 18:25:27 +0200
Message-ID: <20240415162530.3594670-4-jiri@resnulli.us>
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
index 6f6a0f13465f..cc94de89bda3 100644
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

