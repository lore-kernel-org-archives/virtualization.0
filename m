Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA215E20F
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456530; cv=none; b=mXnEWT9Xz6oyT5WJxMjyyMep7QnNe9bMqOLL0YXzpun7EGQ0esbqw7QLA6vr5diMZ1Sg+7HVIYUH+pp1C0oLyKmyYwvXzns9COo6dCmtiZ6S34GsumM9oFQ1R9xsvlcNGBS4WIszcMB8pRIkPdmMJ7LjVXpVTFSPeeKIRFFYryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456530; c=relaxed/simple;
	bh=ODc2bT3Tgy1hAl/eXH6/NifpgPwvNvOsQzDYDnBF6ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnAFguqbJrgcYejmK61dCL0wFzHAHCwNEjT1Oglib4xIFSI+rtt/93e/hpuShoqS8vDoJJKTzt1GNa2+SPtv6wLBhnu76FQRFX95TVrzy2gjhsUAIYTsGiPQc5R+QxbbCig3+Zq3HDrMtaISmFGx9jaag9p9fv1eSNHB2F/9dpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WEhi9chO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WEhi9chO"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso1389198a12.2
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456527; x=1714061327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3kdsnr+4DRfl3oY8QVhe9j08BHEG8XpCARPL+ULDq0=;
        b=WEhi9chOMVV/iJCcVfo1PGUkwNEZAcgXvDwvxFS8RBOIdfu9J0xqvF9ReJk30A7gmf
         tqSpdvMD3XksveB47iikuFlZvce9Dg2TSk2/y3N4xjtpQzu/p2zlHGrl+jQ70UghauQB
         MDBuYRHbBESROZ+awzVeJ0soonFEGETMW0Zj1a0HW/rPgkg33IJAOMX5N18edw3GhdVg
         6vq1mWECz46jFq99lY74IwHCEvxoH+UsLhLhTtXlRPbcsF+r8zOr/L4++K4TUGTj+64X
         dyXAPEtTv0tglz3GuTY7vKJR06bHMgvsnG/h3Vza7xn6lQfpQ+5DSdLaFLgtrKDBciu4
         bQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456527; x=1714061327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3kdsnr+4DRfl3oY8QVhe9j08BHEG8XpCARPL+ULDq0=;
        b=X9c8ZZ3tRtGPOFA6xyCO4uggbUFCf9oqNCZeU9k2riZaRwvow+88YLXc9Nvr1MZRhW
         pu1+OPWJho/+IQDy/g0bGE8uJKFHaRpcWjhyrsccUXQxjh+vVxS76d6HJuVLzEZIjWO1
         od5d9MzY8OIhC4ggGs8uqpK67NCzQKaClVNuLIdAuc2jM8DRc2QkA32/8mH/Mu3gUAcU
         LW7+gO4NWi3EFkACK7JxYiOT+3AeLDBVk+PYiVixmyjfx0O74pH1diQssPrFghPW/ajf
         2CNgEZLHW7b5/ZoQT13rJI4OJOx+t/Afe23ytpmcU1Joq9jnWt63qVHSKpfOcx4x0eAX
         rIKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfFgNtrcRjkbUFav3t0xkCI7PeZ7S93BYJdN7ZVm8bzT71BqyOKUP5SKA+NDwuTPApgxdJva5kHpj5VA89IJAk2eCP8EQVj0r7LOR+Xuk=
X-Gm-Message-State: AOJu0Yy46br61P2DQtzVDZsXNoAlFh2lecL5OY0XVnmdX1MWhBbM0wAQ
	/N0w5NAePI51Rj6sBooAn3RbSUIXZOWlheLLFyDuRvaMBBBx7yMWm4i4y6jbry0=
X-Google-Smtp-Source: AGHT+IECj0h1cFA9hl40JSPqLgCZoPju1GzoIrhuIDwBt2vpPWd0Qkgb6sqDhRdsWNEcVAVC2+4bzQ==
X-Received: by 2002:a17:906:470c:b0:a52:5a74:13f4 with SMTP id y12-20020a170906470c00b00a525a7413f4mr2185075ejq.12.1713456527053;
        Thu, 18 Apr 2024 09:08:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090616d500b00a51a5c8ea6fsm1081695ejd.193.2024.04.18.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:46 -0700 (PDT)
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
Subject: [patch net-next v4 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Thu, 18 Apr 2024 18:08:27 +0200
Message-ID: <20240418160830.3751846-4-jiri@resnulli.us>
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
---
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
index b63a5866ce97..d49b97edb886 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -89,6 +89,43 @@ if [[ "$(id -u)" -ne 0 ]]; then
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

