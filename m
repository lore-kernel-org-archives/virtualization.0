Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923F77A1E
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868882; cv=none; b=XlG/jovGhwigCZEnlEyOJhJ+X/R8w2OooYm25fnZIYee4xjhIJLbyjXWRG4vaIEzfpAa0drDiqe3pNjkMPWhyOj6xanWVSEE8jrKOGaUXjrEd/y67BdFOLxR3VZwmD1ZHwwqzKryAoRGlFJ2v1msCigTy+ruQY/013diV3ZEVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868882; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYAQhusrLt1xwpqp3lEcVzCYyfcveKL4pJY7dEl59/6pONyScGpHIXrcJeLomqs5L14HyW3eUWn+hSxo/N2DAX2HkiCc3FjDIaRb6zaucDTh+4e4jnXy+ytZyxegbh2MSSGGkNZYXD+rBYB5yQVTaAO17eDMF80TwUEENJXLJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ssDofgWT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ssDofgWT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55911bff66so431961166b.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868879; x=1714473679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=ssDofgWTK1SxCUWMwiAM/km1eW6FeMkq++oKENrvC0P36ji71H8OyiYGBYlujwbNN5
         if37FR2oJseXp/3mQ4aEve+EnQUIlSdoY6juaSZ2GA/lmReKzjC1b6MfpVB6bT840roF
         gm9+bljg8TlQLYIO+RzP66+GK51oMTjojrGc0XNQwVqxx9cT8S73DQqsfnUfwc3UGHeX
         94/vUuCZKLev7HTUBnoEHmNlZug4ryoEup/HMNRfcGmr7A8R86ltslKuF9bOUyLj9JUn
         ZvyBNwXuJ4JzGjlfp++talba9pEqXw1bjZy2yzob7DT/iJYOuuOxBL80eKTvObLmkbNb
         4oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868879; x=1714473679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=v8rqUsz3o7dWFd0PR5PX5mzdD23ov8q0IzFZeF2EoJouZ/4HZJg17R44MHZVN7OZHK
         HGkRNYkpYk1J12psoQCIXSKpwleA48bfx1FEWnSP1TtUyCShm7Zg78+pcn1fPeb9nA1k
         Hd71wqVx4SdOUbMlieOsHHNQAizTGj4RyleYNc1Agn0lLVuVB79i88xGBw2xWZV7ppGD
         8f0KSP72c9TkncmB2C2Xfa+Wdhx/PEB7iKIAlbUYpgu6AFG+z9VT4ygVkiE5iVh7Pg8c
         lGyDprpHDlvzzw7VDAAnPTHwo2v1OOlcxTjcO6xp18GXXOcqNZ9oa21LmCowgki1XLtY
         iAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgM29QD53ahsb120Xt4DqdLV6q7zb2Fv7ye9qWJhDJAlGOKWolFst7eKV3Ri0kX/ReET1QShV1G4KLmLa8JShDrXm8ECNN5VC8qCZI+Hg=
X-Gm-Message-State: AOJu0YyrEwUuhkCG/YtPnefGiJCnP2jiz0Ma/jiwVtcMcPbZc8voLZn+
	K0m0n/h44xXUdYKDgQUML45AUZcktxXQqfKSvvklBodIiB55QSqI8joyR8NDy7I=
X-Google-Smtp-Source: AGHT+IG+hOv6ETUr4XWph6lySqZB5qDDYJRKGSSrZIIlVz00gQt3waHz4MI2qIsvPg0J/EZVG/jMqQ==
X-Received: by 2002:a17:906:b105:b0:a55:75f6:ce0f with SMTP id u5-20020a170906b10500b00a5575f6ce0fmr7297845ejy.13.1713868879171;
        Tue, 23 Apr 2024 03:41:19 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id v16-20020a170906b01000b00a522c69f28asm6879534ejy.216.2024.04.23.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:18 -0700 (PDT)
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
Subject: [patch net-next v5 repost 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Tue, 23 Apr 2024 12:41:06 +0200
Message-ID: <20240423104109.3880713-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>
References: <20240423104109.3880713-1-jiri@resnulli.us>
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

