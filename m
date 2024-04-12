Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28A14D710
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934820; cv=none; b=Jocgp+KE7ZSlLWltFZ/vN+VudfSRoEeDhw6Hm+oTib7nsQQudEARucvslNn/mIUuT/l4rLZOXWHPvdqIUxlV59Ofs2vX0GtAgEEyd2o8rqHR2LypGSzJ1Vr6Eq1lnvHgsnUAohzUKDktKLDyjeIOZ+ETat2CUYXMY1O0Zj/UK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934820; c=relaxed/simple;
	bh=vG/dFpiKplr0KjS27Xya8aAHKc92Q9+PvZTQfbvlf6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtqnWVqPZEoMp9r3eNbE++ujQVCwwWHfIW52pXHhuZDubfg7hSD/8ckTXCDxwT5VZ2GMg9zO9TMM6rvQtbj1HmPb/DwK4LxNolGyElc3qw4RvASRELSsF4g2Vbe2SEyVKLPsDNaW7/XDohrH8wi1fPVLPa8aCVF+ROJ1iGnwaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0imDprmL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0imDprmL"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518872fcb89so762350e87.3
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934815; x=1713539615; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTunXC6x4034AG0WHitd+4hipFdLCF+F+A/dgWvIp8o=;
        b=0imDprmLU1EcQb9F3ct0sdBPZBhHCu9OnTpL7AIjEOz/XJCVMVb214Hr9Rjp7goaLO
         0sfMwcJD1oZ3Cp12XkahU+6zlmSGEh4fKGx7FJyjxedz6+lC9fdZdskBARR5KXPwDaQC
         Vz3JGNdrFqNeseUCmchlWe2CjI+qZfWVKZ4hDTeBsPNQGAbocX8Fh5PgnDExlhnwbIOs
         RfSHEj94QnXEcZztEd+2Ou/RAoOStLUscmUDOTmldLxhElsk5BAE0tEmmDfGsB7IbTuU
         SQ4YFc7jjseIzzmjcoz3nmCYaLVG7VeyF1Tp3kKdWstoNWrAI+fhEOi79vFmZd76+YVS
         wwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934815; x=1713539615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTunXC6x4034AG0WHitd+4hipFdLCF+F+A/dgWvIp8o=;
        b=egE7eOcdD+Kep8jW77JuA+oXeUZqdgaiEE4RTspeRFu/lNk5l0VizHoHDQNglXSKXH
         kX7h1K3yQsfIRALdmUIG4Jg5Z22GvegAzWDPAC7fV05+wiCwl6C3GyGvRHaOh8c6Cwoj
         UxiqbY2EyrQHlWf7vaYtAIlycnCR8yXWo+R09hAZqKQMBuLVDt9Flcqr+tq2mELWFXU9
         Ct8Df1ewFg2BKp8gJAihrB8+nbud6GwVBey0obGSstwYKhK63LZV3eywr1UtGNwrbwrd
         8MXcVDIhkVdcPQ5ZgxjXcWpDxy7QWFUQK4PmOArjp3A4xhV2rIygExkv29FE9UiBpbec
         rpTg==
X-Forwarded-Encrypted: i=1; AJvYcCV179fAUQETG4diGFhLRdQ4tjUKypGUcEOM0y+RH9GVJENQmLRblgZ6IEox10Qdh6CqDloukf6+LsqdNN1XX635u9UlgztfcA6v8KyohY0=
X-Gm-Message-State: AOJu0YxDjEINh4/ekhnEbc+4juD9hcuIOnm+wgPuA7AVogUZ9iB5fVAU
	bgNnzq9feaJganCL2ajrq1DS6fRrYIpx7aR37J0+FwQxBKQtScGrjZwFRG1cNsA=
X-Google-Smtp-Source: AGHT+IEFA5gkQ0ib7+hUmRwuS1fmSH2StHxV6OdCj4Zff4iXBk/jIHEX9eBmv8UKr6k22h+0gOtUDA==
X-Received: by 2002:a19:f80a:0:b0:513:d3c0:f66 with SMTP id a10-20020a19f80a000000b00513d3c00f66mr1903270lff.51.1712934815395;
        Fri, 12 Apr 2024 08:13:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f30-20020a19381e000000b00517aaa8670csm544114lfa.276.2024.04.12.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:34 -0700 (PDT)
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
Subject: [patch net-next 6/6] selftests: virtio_net: add initial tests
Date: Fri, 12 Apr 2024 17:13:14 +0200
Message-ID: <20240412151314.3365034-7-jiri@resnulli.us>
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

Introduce initial tests for virtio_net driver. Focus on feature testing
leveraging previously introduced debugfs feature filtering
infrastructure. Add very basic ping and F_MAC feature tests.

To run this, do:
$ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

Run it on a system with 2 virtio_net devices connected back-to-back
on the hypervisor.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |   5 +
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6dab886d6f7a..a8e40599c65f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
+TARGETS += drivers/net/virtio
 TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
new file mode 100644
index 000000000000..c6edf5ddb0e4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = basic_features.sh
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
new file mode 100755
index 000000000000..b9047299b510
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -0,0 +1,127 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# See virtio_net_common.sh comments for more details about assumed setup
+
+ALL_TESTS="
+	initial_ping_test
+	f_mac_test
+"
+
+source virtio_net_common.sh
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+h1=${NETIFS[p1]}
+h2=${NETIFS[p2]}
+
+h1_create()
+{
+	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+initial_ping_test()
+{
+	cleanup
+	setup_prepare
+	ping_test $h1 $H2_IPV4 " simple"
+}
+
+f_mac_test()
+{
+	RET=0
+	local test_name="mac feature filtered"
+
+	virtio_feature_present $h1 $VIRTIO_NET_F_MAC
+	if [ $? -ne 0 ]; then
+		log_test_skip "$test_name" "Device $h1 is missing feature $VIRTIO_NET_F_MAC."
+		return 0
+	fi
+	virtio_feature_present $h1 $VIRTIO_NET_F_MAC
+	if [ $? -ne 0 ]; then
+		log_test_skip "$test_name" "Device $h2 is missing feature $VIRTIO_NET_F_MAC."
+		return 0
+	fi
+
+	cleanup
+	setup_prepare
+
+	grep -q 0 /sys/class/net/$h1/addr_assign_type
+	check_err $? "Permanent address assign type for $h1 is not set"
+	grep -q 0 /sys/class/net/$h2/addr_assign_type
+	check_err $? "Permanent address assign type for $h2 is not set"
+
+	cleanup
+	virtio_filter_feature_add $h1 $VIRTIO_NET_F_MAC
+	virtio_filter_feature_add $h2 $VIRTIO_NET_F_MAC
+	setup_prepare
+
+	grep -q 0 /sys/class/net/$h1/addr_assign_type
+	check_fail $? "Permanent address assign type for $h1 is set when F_MAC feature is filtered"
+	grep -q 0 /sys/class/net/$h2/addr_assign_type
+	check_fail $? "Permanent address assign type for $h2 is set when F_MAC feature is filtered"
+
+	ping_do $h1 $H2_IPV4
+	check_err $? "Ping failed"
+
+	log_test "$test_name"
+}
+
+setup_prepare()
+{
+	virtio_device_rebind $h1
+	virtio_device_rebind $h2
+	wait_for_dev $h1
+	wait_for_dev $h2
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+
+	virtio_filter_features_clear $h1
+	virtio_filter_features_clear $h2
+	virtio_device_rebind $h1
+	virtio_device_rebind $h2
+	wait_for_dev $h1
+	wait_for_dev $h2
+}
+
+check_driver $h1 "virtio_net"
+check_driver $h2 "virtio_net"
+check_virtio_debugfs $h1
+check_virtio_debugfs $h2
+
+trap cleanup EXIT
+
+setup_prepare
+
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh b/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
new file mode 100644
index 000000000000..57bd8055e2e5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This assumes running on a host with two virtio interfaces connected
+# back to back. Example script to do such wire-up of tap devices would
+# look like this:
+#
+# =======================================================================================================
+# #!/bin/bash
+#
+# DEV1="$1"
+# DEV2="$2"
+#
+# sudo tc qdisc add dev $DEV1 clsact
+# sudo tc qdisc add dev $DEV2 clsact
+# sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
+# sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
+# sudo ip link set $DEV1 up
+# sudo ip link set $DEV2 up
+# =======================================================================================================
+
+REQUIRE_MZ="no"
+NETIF_CREATE="no"
+NETIF_FIND_DRIVER="virtio_net"
+NUM_NETIFS=2
+
+H1_IPV4="192.0.2.1"
+H2_IPV4="192.0.2.2"
+H1_IPV6="2001:db8:1::1"
+H2_IPV6="2001:db8:1::2"
+
+VIRTIO_NET_F_MAC=5
+
+virtio_device_get()
+{
+	local dev=$1; shift
+	local device_path="/sys/class/net/$dev/device/"
+
+	basename `realpath $device_path`
+}
+
+virtio_device_rebind()
+{
+	local dev=$1; shift
+	local device=`virtio_device_get $dev`
+
+	echo "$device" > /sys/bus/virtio/drivers/virtio_net/unbind
+	echo "$device" > /sys/bus/virtio/drivers/virtio_net/bind
+}
+
+virtio_debugfs_get()
+{
+	local dev=$1; shift
+	local device=`virtio_device_get $dev`
+
+	echo /sys/kernel/debug/virtio/$device/
+}
+
+check_virtio_debugfs()
+{
+	local dev=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	if [ ! -f "$debugfs/device_features" ] ||
+	   [ ! -f "$debugfs/filter_feature_add"  ] ||
+	   [ ! -f "$debugfs/filter_feature_del"  ] ||
+	   [ ! -f "$debugfs/filter_features"  ] ||
+	   [ ! -f "$debugfs/filter_features_clear"  ]; then
+		echo "SKIP: not possible to access debugfs for $dev"
+		exit $ksft_skip
+	fi
+}
+
+virtio_feature_present()
+{
+	local dev=$1; shift
+	local feature=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	cat $debugfs/device_features |grep "^$feature$" &> /dev/null
+	return $?
+}
+
+virtio_filter_features_clear()
+{
+	local dev=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	echo "1" > $debugfs/filter_features_clear
+}
+
+virtio_filter_feature_add()
+{
+	local dev=$1; shift
+	local feature=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	echo "$feature" > $debugfs/filter_feature_add
+}
-- 
2.44.0

