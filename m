Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73A14A4E6
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934810; cv=none; b=WElHW8Beks1vrMm/CTM/hmZ9gqyKspPkX6t7pXQbNZRp1eDJIrjhNjZRJdNPHgUT2+cIEyaAwm2dUIL1t+vWjf3lJfoL5H0Ckhjo4gDe0p0cSJ0Ipv9qo/rXvfqpim0hC/eGNUB7s9USJPjIdJdXsqOD0PdYaQifClpaRMSKrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934810; c=relaxed/simple;
	bh=79Zpumn/yTRAxDTkzsf7dlFSKMtuRYIWNxG+eUi60Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvbajNTFfrTASsFXXsDeGpwIGe226bfJgQMqqvSLMRbuq2VlYRH9JIF2eS7daRQJeNLlELjIYzW3j+hP6yWA0JwBZiFrEN3EJUHCQXirCq7rr3Wna9vTYho1njdCUlyV+1gXmMlkz50uNmfMz/0KdCMdrPQNJoIezgw2UtDfiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gz4rI9sC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gz4rI9sC"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso11865521fa.1
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934807; x=1713539607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSc1knfmuuKWVaRerlL6rWyI43/6CD3p6tfuDkKbsf0=;
        b=gz4rI9sC7QbGD0XjhIlPY7GnuBZJNcmY4wZpY/8G2qGYOUGLxB08Vk2mTUE+MHZqRP
         Yxjz1YQSYPUbyKSjz4LPKyFrouFU4Bm0AYdKJrG0PzyDRJaTcF0nzqnndBf5UnKwTypP
         ei3Simo8vJNgoyGW8fnQ1zUOH98ck64kKRjlftslZ+TMkrXP2d1YOfZzcAzgv6ad0XHD
         9b2pxYbcP96mRDSxjGoorBIQgp/j7EfVPT3IaZIHZduBAENbgAn3mVmE9/F/tOeav5rY
         p0UHTkIp0A2VsmFxaK2nzbhgUiMPIg3qDj21TAvnxEwLRb2q1KWqh1ExrkeN3GEo/UKW
         Aawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934807; x=1713539607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSc1knfmuuKWVaRerlL6rWyI43/6CD3p6tfuDkKbsf0=;
        b=Eht0/Wf4Zixs+oJ3xrN/qsEtI/yeQpwgvG4KYEwkIAxtWO8lAqgRbnShai99R1Vbkm
         lwhoue/m1rz4kWAmYiDtY6o7KaIdgP+EJqcTpxgIBYAhXBq3JlJW86lQKPgpV9RUDMXt
         vUs1YeakM7ezrjPZYOSwySGwaNZfx5Te6RJRs5F6iJbrnyv9jpxPxIjne6lXQJ9DgiNi
         WpsgtCAssdlJQF8qC/8FdEsZ3bl9WC4czd07p5Zlrgfckq3/luG2BHwpfisqcc+RXxSs
         y5zJpX0oSNcxvbmAIEc7iHuOgYMiKCFFMV8SHFg7WLz74av8P9buZETROnoQjAmJLLf5
         Lnqw==
X-Forwarded-Encrypted: i=1; AJvYcCWxkJ5sslT30C9o+rEPOQ7U/vYdDjxfZ8LImTtq/mYhQj7oQs9yArPVKnFqp370TX8tFt4R6/idYd670alOZ8YQclJEvxZbbq3XGt+QzI0=
X-Gm-Message-State: AOJu0Yy9yKYKW1xKkTVLH4X5IZ47A7APU7sOzGxeFk+6g0moGhb2QyGw
	K3O2mSyG7c53dojdEhcwHGGfuLsHU7X+fXz5lAvFU3VHhGUnpG2fRfEVX6ZM+4w=
X-Google-Smtp-Source: AGHT+IG6s9o/5tFXaogDJI5ZYHJzmyIXl+4HeYCIRLyWTTBODB8qVVhF87Iesf1NL4Tbyh0b4rfvPA==
X-Received: by 2002:a05:651c:620:b0:2d9:f68a:d82c with SMTP id k32-20020a05651c062000b002d9f68ad82cmr1699020lje.41.1712934806885;
        Fri, 12 Apr 2024 08:13:26 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651c140f00b002d834cb0400sm546450lje.17.2024.04.12.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:26 -0700 (PDT)
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
Subject: [patch net-next 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Fri, 12 Apr 2024 17:13:11 +0200
Message-ID: <20240412151314.3365034-4-jiri@resnulli.us>
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

Allow driver tests to work without specifying the netdevice names.
Introduce a possibility to search for available netdevices according to
set driver name. Allow test to specify the name by setting
NETIF_FIND_DRIVER variable.

Note that user overrides this either by passing netdevice names on the
command line or by declaring NETIFS array in custom forwarding.config
configuration file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 6f6a0f13465f..06633518b3aa 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -55,6 +55,9 @@ declare -A NETIFS=(
 : "${NETIF_CREATE:=yes}"
 : "${NETIF_TYPE:=veth}"
 
+# Whether to find netdevice according to the specified driver.
+: "${NETIF_FIND_DRIVER:=}"
+
 # Constants for ping tests:
 # How many packets should be sent.
 : "${PING_COUNT:=10}"
@@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
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
+	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`
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
+if [[ ! -z $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	find_netif
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0

