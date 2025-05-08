Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724221917E3
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667444; cv=none; b=e9G05jheuYMGUwyH5MR3nSEdhzd/1hTS3P+WofQQ5JWBI7B8cHahA06Gq5J0hKHVTfkVToyiHgPV8bFBNpxFhqDMcXaFEm9J7aVti1fF8+1cTiHpB/IUMcKoGpghro2vbvpRwddil5qRlDff98KFwJYnwcUMzV8SZzFX/4Mg5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667444; c=relaxed/simple;
	bh=WeJltu95Tn+DNBEeuRB9CaWU/mev8zVPMStv7LqpUJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WyX0j4HyqSwC3R++fetTj8vccYA3pJkl7EwfRdlpbJ45a9r9bLsyC2o3hv/agMDV4z239KvAa7iXxcpRIG58DbeQMXaFSu+N/0FvWliLH4jrqzBkSm4WW1olyOdcg37uLOHIkhl8vQ/aWvhNj+9o/2vZ+TSMZfZ0MlJwmz/KEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edGe/orE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edGe/orE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so532954b3a.1
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746667441; x=1747272241; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBUy85vWDjKVimljU6VDxoJySzTHA7r6sYi4ZEJbdD8=;
        b=edGe/orEee/2jn42IFyggOo/bWhWHDc0nKhSHPjCkjDvH0YfkAWBpALuoebyFDJwP1
         0cl7ks8LZ9P8oHG7DyNClSyXbv1gmGaxRQDJNdDAQpNfehgJT8SeujvYdxp2d0iGzar7
         b6dJrQKTlIlr7giP94w8dSfa28KrCGWtmU0b45UghJ1FitvMPhgNXo8kI+wZ8EsbeH7S
         DAPyYTHAeXa70/8cfmYesxiTexCTrGZZwjU4mT7IE7YW8ECVrhnDPTzQRSoHaj/HC3P7
         4jrUYlPk+o1QeUuiR0Iol08o49KyEngh45UJNVT+vnC66S6J5Xij4ZVR881bMJO3cVMK
         l6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746667441; x=1747272241;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBUy85vWDjKVimljU6VDxoJySzTHA7r6sYi4ZEJbdD8=;
        b=XXMehsPVUdcf10lgEfB/j/UN7q3eNcGh3IVbWwBWOCPgriMZaTZz1Oe88NUv8NLEv1
         WWgBAZQlbWS+ftKydh+WQdFBMRdorpYPlJ/nOj/Nyr0PXmDx5CWwORpWAh6ytV+n8KkW
         7pOsptEkyuPypxaszURATHFiLsitow4g7PorBoK/QDdneBt3BI6pDl/lxhXmGvBDmVUv
         11OCSkCUgvxvuxaaXXdN0YIExIbziDNHGgsqTJNy4Z85K/9eE6ibJY3CMKHP9HrN45VB
         xPs64AcxsgKgjE7RG+FaF8VA46A5xxZZz42KJQj7LFqkbRU/+8+vPO3lHjUiCQRQ4HI9
         OWbg==
X-Forwarded-Encrypted: i=1; AJvYcCVF9LNRHpwj7JMz+uyX3QW1YP+bIhHm9LyALMkVoqX6xdTNwuK/bjzEJhAdXJL5jT4hDK9AIkFvS7yUBYdmfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz22ZzM1bFXWt3h9vcxKJkT3cTVqyC3ZEAjD5+L40KqtqjMprj7
	+thl730+GGKnDumrFuRcqPOGjYBD9RQrmXQj7H1GAzRGaAKZuGUz
X-Gm-Gg: ASbGnct275eQIUCh8343PDZDZ3yuokUC4i4Kd3Znsaza5A+CZE3D4fvr+LUuK3RHODm
	Xsb3lzaBKDa/8b2abF6hoA4Y7rLfjYy7TH8bK2iXF8TN7gi2b4r2h5YVgiCwNYpv2PhRf8HzUrO
	SBR4tlTRiLbCmifv8wNAWILrN12q0l/S24O0KxC9OWbyr7nwj7ws9KMYLRgrt5OtHysJVJTeW3W
	dbFknot+Jv2Ha/7/e+8I5XA+nf4LYp3K0M5fNoJOV9tcqyqCE6dB4/bLcNEHofW3nBhFr3IMT4c
	1w7SWyQjhYGlFYidDa25dUhz6A3g9YKpDvqBDKcEGVBMBu0=
X-Google-Smtp-Source: AGHT+IGB+A+f/zcJa5K38y123JsWrzyizoCcae60BRiR3wELVPT1shw0q+RoEomHBxSR8UbEFrsp7g==
X-Received: by 2002:a05:6a00:3485:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-7409cfef821mr8301881b3a.24.1746667440469;
        Wed, 07 May 2025 18:24:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740a95f8333sm597274b3a.26.2025.05.07.18.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 18:23:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 07 May 2025 18:23:56 -0700
Subject: [PATCH net-next v4] selftests/vsock: add initial vmtest.sh for
 vsock
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-vsock-vmtest-v4-1-6e2a97262cd6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKsHHGgC/13NQQ6CMBCF4auQrq3pzAAWV97DuChlwEYBQ5tGY
 7i7TVfI8mXy/fMVnhfHXpyLr1g4Ou/mKY3yUAh7N9PA0nVpC1RYKcJKRj/bh4xjYB9kSwahQ1B
 oUSTyWrh375y7iomDnPgdxC1d7s6HefnkPxHyPSdLUP/JCBJkT5XR0Jm20fYyjMY9j3YecyjiF
 p92GBOmRoHBExGw3mPaYNQ7TAmDBtPXUFNPvMXruv4AiP01GCwBAAA=
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.13.0

This commit introduces a new vmtest.sh runner for vsock.

It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
H2G, and loopback. The testing tools from tools/testing/vsock/ are
reused. Currently, only vsock_test is used.

VMCI and hyperv support is automatically built, though not used.

Only tested on x86.

To run:

  $ tools/testing/selftests/vsock/vmtest.sh

or

  $ make -C tools/testing/selftests TARGETS=vsock run_tests

Output (vmtest.sh):
TAP version 13
1..3
not ok 1 vm_server_host_client # exit=1
ok 1 vm_client_host_server
ok 2 vm_loopback
SUMMARY: PASS=2 SKIP=0 FAIL=1
1..3

Future work can include vsock_diag_test.

The tap output style copies mm's run_vmtests.sh.

Because vsock requires a VM to test anything other than loopback, this
patch adds vmtest.sh as a kselftest itself. This is different than other
systems that have a "vmtest.sh", where it is used as a utility script to
spin up a VM to run the selftests as a guest (but isn't hooked into
kselftest).

I've began testing this in one of the NIPA environments Jakub as
graciously provided. I would expect at least one more revision to have
that setup ironed out and fully tested.

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
---
Changes in v4:
- do not use special tab delimiter for help string parsing (Stefano + Paolo)
- fix paths for when installing kselftest and running out-of-tree (Paolo)
- change vng to using running kernel instead of compiled kernel (Paolo)
- use multi-line string for QEMU_OPTS (Stefano)
- change timeout to 300s (Paolo)
- skip if tools are not found and use kselftests status codes (Paolo)
- remove build from vmtest.sh (Paolo)
- change 2222 -> SSH_HOST_PORT (Stefano)
- add tap-format output
- add vmtest.log to gitignore
- check for vsock_test binary and remind user to build it if missing
- create a proper build in makefile
- style fixes
- add ssh, timeout, and pkill to dependency check, just in case
- fix numerical comparison in conditionals
- check qemu pidfile exists before proceeding (avoid wasting time waiting for ssh)
- fix tracking of pass/fail bug
- fix stderr redirection bug
- Link to v3: https://lore.kernel.org/r/20250428-vsock-vmtest-v3-1-181af6163f3e@gmail.com

Changes in v3:
- use common conditional syntax for checking variables
- use return value instead of global rc
- fix typo TEST_HOST_LISTENER_PORT -> TEST_HOST_PORT_LISTENER
- use SIGTERM instead of SIGKILL on cleanup
- use peer-cid=1 for loopback
- change sleep delay times into globals
- fix test_vm_loopback logging
- add test selection in arguments
- make QEMU an argument
- check that vng binary is on path
- use QEMU variable
- change <tab><backslash> to <space><backslash>
- fix hardcoded file paths
- add comment in commit msg about script that vmtest.sh was based off of
- Add tools/testing/selftest/vsock/Makefile for kselftest
- Link to v2: https://lore.kernel.org/r/20250417-vsock-vmtest-v2-1-3901a27331e8@gmail.com

Changes in v2:
- add kernel oops and warnings checker
- change testname variable to use FUNCNAME
- fix spacing in test_vm_server_host_client
- add -s skip build option to vmtest.sh
- add test_vm_loopback
- pass port to vm_wait_for_listener
- fix indentation in vmtest.sh
- add vmci and hyperv to config
- changed whitespace from tabs to spaces in help string
- Link to v1: https://lore.kernel.org/r/20250410-vsock-vmtest-v1-1-f35a81dab98c@gmail.com
---
 MAINTAINERS                              |   1 +
 tools/testing/selftests/vsock/.gitignore |   2 +
 tools/testing/selftests/vsock/Makefile   |  17 ++
 tools/testing/selftests/vsock/config     | 114 +++++++++
 tools/testing/selftests/vsock/settings   |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 423 +++++++++++++++++++++++++++++++
 6 files changed, 558 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 657a67f9031e..3fbdd7bbfce7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25751,6 +25751,7 @@ F:	include/uapi/linux/vm_sockets.h
 F:	include/uapi/linux/vm_sockets_diag.h
 F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
+F:	tools/testing/selftests/vsock/
 F:	tools/testing/vsock/
 
 VMALLOC
diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
new file mode 100644
index 000000000000..9c5bf379480f
--- /dev/null
+++ b/tools/testing/selftests/vsock/.gitignore
@@ -0,0 +1,2 @@
+vmtest.log
+vsock_test
diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
new file mode 100644
index 000000000000..71fca0a2b8da
--- /dev/null
+++ b/tools/testing/selftests/vsock/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ../../..)
+
+$(OUTPUT)/vsock_test: $(TOOLSDIR)/testing/vsock/vsock_test
+	install -m 755 $< $@
+
+$(TOOLSDIR)/testing/vsock/vsock_test:
+	$(MAKE) -C $(TOOLSDIR)/testing/vsock vsock_test
+
+TEST_PROGS += vmtest.sh
+EXTRA_CLEAN += vmtest.log
+TEST_GEN_FILES := vsock_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
new file mode 100644
index 000000000000..3bffaaf98fff
--- /dev/null
+++ b/tools/testing/selftests/vsock/config
@@ -0,0 +1,114 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_HAVE_EBPF_JIT=y
+CONFIG_BPF_EVENTS=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
+CONFIG_ARCH_SUPPORTS_UPROBES=y
+CONFIG_UPROBES=y
+CONFIG_UPROBE_EVENTS=y
+CONFIG_DEBUG_FS=y
+CONFIG_FW_CFG_SYSFS=y
+CONFIG_FW_CFG_SYSFS_CMDLINE=y
+CONFIG_DRM=y
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM_VIRTIO_GPU_KMS=y
+CONFIG_DRM_BOCHS=y
+CONFIG_VIRTIO_IOMMU=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SEQUENCER=y
+CONFIG_SND_PCI=y
+CONFIG_SND_INTEL8X0=y
+CONFIG_SND_HDA_CODEC_REALTEK=y
+CONFIG_SECURITYFS=y
+CONFIG_CGROUP_BPF=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_ZSTD=y
+CONFIG_FUSE_FS=y
+CONFIG_SERIO=y
+CONFIG_PCI=y
+CONFIG_INPUT=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_X86_VERBOSE_BOOTUP=y
+CONFIG_VGA_CONSOLE=y
+CONFIG_FB=y
+CONFIG_FB_VESA=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_DRV_CMOS=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
+CONFIG_VSOCKETS=y
+CONFIG_VSOCKETS_DIAG=y
+CONFIG_VSOCKETS_LOOPBACK=y
+CONFIG_VMWARE_VMCI_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS_COMMON=y
+CONFIG_HYPERV_VSOCKETS=y
+CONFIG_VMWARE_VMCI=y
+CONFIG_VHOST_VSOCK=y
+CONFIG_HYPERV=y
+CONFIG_UEVENT_HELPER=n
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_NET=y
+CONFIG_NET_CORE=y
+CONFIG_NETDEVICES=y
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_INET=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_9P_FS=y
+CONFIG_VIRTIO_NET=y
+CONFIG_CMDLINE_OVERRIDE=n
+CONFIG_BINFMT_SCRIPT=y
+CONFIG_SHMEM=y
+CONFIG_TMPFS=y
+CONFIG_UNIX=y
+CONFIG_MODULE_SIG_FORCE=n
+CONFIG_DEVTMPFS=y
+CONFIG_TTY=y
+CONFIG_VT=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_INOTIFY_USER=y
+CONFIG_BLOCK=y
+CONFIG_SCSI_LOWLEVEL=y
+CONFIG_SCSI=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_CORE=y
+CONFIG_I6300ESB_WDT=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_OVERLAY_FS=y
+CONFIG_DAX=y
+CONFIG_DAX_DRIVER=y
+CONFIG_FS_DAX=y
+CONFIG_MEMORY_HOTPLUG=y
+CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_ZONE_DEVICE=y
+CONFIG_FUSE_FS=y
+CONFIG_VIRTIO_FS=y
+CONFIG_VSOCKETS=y
+CONFIG_VIRTIO_VSOCKETS=y
diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
new file mode 100644
index 000000000000..694d70710ff0
--- /dev/null
+++ b/tools/testing/selftests/vsock/settings
@@ -0,0 +1 @@
+timeout=300
diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
new file mode 100755
index 000000000000..d7e727306175
--- /dev/null
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -0,0 +1,423 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates
+#
+# Dependencies:
+#		* virtme-ng
+#		* busybox-static (used by virtme-ng)
+#		* qemu	(used by virtme-ng)
+
+TAP_PREFIX="# "
+VERBOSE=0
+KSFT_PASS=0
+KSFT_FAIL=1
+KSFT_SKIP=4
+SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+VSOCK_TEST=${SCRIPT_DIR}/vsock_test
+
+TEST_GUEST_PORT=51000
+TEST_HOST_PORT=50000
+TEST_HOST_PORT_LISTENER=50001
+SSH_GUEST_PORT=22
+SSH_HOST_PORT=2222
+VSOCK_CID=1234
+WAIT_PERIOD=3
+WAIT_PERIOD_MAX=20
+WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+
+QEMU_PIDFILE=/tmp/qemu.pid
+
+# virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
+# control port forwarded for vsock_test.  Because virtme-ng doesn't support
+# adding an additional port to forward to the device created from "--ssh" and
+# virtme-init mistakenly sets identical IPs to the ssh device and additional
+# devices, we instead opt out of using --ssh, add the device manually, and also
+# add the kernel cmdline options that virtme-init uses to setup the interface.
+QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
+QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
+QEMU_OPTS="\
+	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+	 -device virtio-net-pci,netdev=n0 \
+	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+	 --pidfile ${QEMU_PIDFILE} \
+"
+KERNEL_CMDLINE="virtme.dhcp net.ifnames=0 biosdevname=0 virtme.ssh virtme_ssh_user=$USER"
+
+LOG=${SCRIPT_DIR}/vmtest.log
+
+TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+TEST_DESCS=(
+	"Run vsock_test in server mode on the VM and in client mode on the host."
+	"Run vsock_test in client mode on the VM and in server mode on the host."
+	"Run vsock_test using the loopback transport in the VM."
+)
+
+usage() {
+	local name
+	local desc
+	local i
+	echo
+	echo "$0 [OPTIONS] [TEST]..."
+	echo "If no TEST argument is given, all tests will be run."
+	echo
+	echo "Options"
+	echo "  -v: verbose output"
+	echo
+	echo "Available tests"
+
+	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
+		name=${TEST_NAMES[${i}]}
+		desc=${TEST_DESCS[${i}]}
+		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+	done
+	echo
+
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit ${KSFT_FAIL}
+}
+
+vm_ssh() {
+	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost $*
+	return $?
+}
+
+cleanup() {
+	if [[ -f "${QEMU_PIDFILE}" ]]; then
+		pkill -SIGTERM -F ${QEMU_PIDFILE} 2>&1 > /dev/null
+	fi
+}
+
+check_args() {
+	local found
+
+	for arg in "$@"; do
+		found=0
+		for name in "${TEST_NAMES[@]}"; do
+			if [[ "${name}" = "${arg}" ]]; then
+				found=1
+				break
+			fi
+		done
+
+		if [[ "${found}" -eq 0 ]]; then
+			echo "${arg} is not an available test" >&2
+			usage
+		fi
+	done
+
+	for arg in "$@"; do
+		if ! command -v > /dev/null "test_${arg}"; then
+			echo "Test ${arg} not found" >&2
+			usage
+		fi
+	done
+}
+
+check_deps() {
+	for dep in vng ${QEMU} busybox timeout pkill ssh; do
+		if [[ ! -x "$(command -v ${dep})" ]]; then
+			echo -e "skip:    dependency ${dep} not found!\n"
+			exit ${KSFT_SKIP}
+		fi
+	done
+
+	if [[ ! -x $(command -v ${VSOCK_TEST}) ]]; then
+		printf "skip:    ${VSOCK_TEST} not found!"
+		printf " Please build the kselftest vsock target.\n"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+vm_setup() {
+	local VNG_OPTS=""
+	local logfile=/dev/null
+
+	if [[ "${VERBOSE}" = 1 ]]; then
+		VNG_OPTS="--verbose"
+		logfile=/dev/stdout
+	fi
+	vng \
+		$VNG_OPTS \
+		--run \
+		--qemu-opts="${QEMU_OPTS}" \
+		--qemu="${QEMU}" \
+		--user root \
+		--append "${KERNEL_CMDLINE}" \
+		--rw  &> ${logfile} &
+
+	timeout ${WAIT_TOTAL} \
+		bash -c 'while [[ ! -e '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'
+	if [[ ! $? -eq 0 ]]; then
+		die "failed to boot VM"
+	fi
+}
+
+vm_wait_for_ssh() {
+	i=0
+	while [[ true ]]; do
+		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
+			die "Timed out waiting for guest ssh"
+		fi
+		vm_ssh -- true
+		if [[ $? -eq 0 ]]; then
+			break
+		fi
+		i=$(( i + 1 ))
+		sleep ${WAIT_PERIOD}
+	done
+}
+
+wait_for_listener() {
+	local port=$1
+	local interval=$2
+	local max_intervals=$3
+	local i=0
+	while ! ss -ltn | grep -q ":${port}"; do
+		if [[ ${i} -gt ${max_intervals} ]]; then
+			die "Timed out waiting for listener on port ${port}"
+		fi
+		i=$(( i + 1 ))
+		sleep ${interval}
+	done
+}
+
+vm_wait_for_listener() {
+	local port=$1
+	vm_ssh <<EOF
+$(declare -f wait_for_listener)
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+EOF
+}
+
+host_wait_for_listener() {
+	wait_for_listener ${TEST_HOST_PORT_LISTENER} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+}
+
+__log_stdin() {
+	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
+}
+
+__log_args() {
+	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
+}
+
+log() {
+	local prefix="$1"
+	shift
+
+	local redirect=
+	if [[ ${VERBOSE} -eq 0 ]]; then
+		redirect=/dev/null
+	else
+		redirect=/dev/stdout
+	fi
+
+	if [[ "$#" -eq 0 ]]; then
+		__log_stdin | tee -a ${LOG} > ${redirect}
+	else
+		__log_args | tee -a ${LOG} > ${redirect}
+	fi
+}
+
+log_setup() {
+	log "setup" "$@"
+}
+
+log_host() {
+	testname=$1
+	shift
+	log "test:${testname}:host" "$@"
+}
+
+log_guest() {
+	testname=$1
+	shift
+	log "test:${testname}:guest" "$@"
+}
+
+tap_prefix() {
+	sed -e "s/^/${TAP_PREFIX}/"
+}
+
+tap_output() {
+	if [[ ! -z "$TAP_PREFIX" ]]; then
+		read str
+		echo $str
+	fi
+}
+
+test_vm_server_host_client() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=server \
+		--control-port="${TEST_GUEST_PORT}" \
+		--peer-cid=2 \
+		2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${TEST_GUEST_PORT}
+
+	${VSOCK_TEST} \
+		--mode=client \
+		--control-host=127.0.0.1 \
+		--peer-cid="${VSOCK_CID}" \
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+
+	return $?
+}
+
+test_vm_client_host_server() {
+	local testname="${FUNCNAME[0]#test_}"
+
+	${VSOCK_TEST} \
+		--mode "server" \
+		--control-port "${TEST_HOST_PORT_LISTENER}" \
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+
+	host_wait_for_listener
+
+	vm_ssh -- "${VSOCK_TEST}" \
+		--mode=client \
+		--control-host=10.0.2.2 \
+		--peer-cid=2 \
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+test_vm_loopback() {
+	local testname="${FUNCNAME[0]#test_}"
+	local port=60000 # non-forwarded local port
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=server \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}" &
+
+	vm_wait_for_listener ${port}
+
+	vm_ssh -- ${VSOCK_TEST} \
+		--mode=client \
+		--control-host="127.0.0.1" \
+		--control-port="${port}" \
+		--peer-cid=1 2>&1 | log_guest "${testname}"
+
+	return $?
+}
+
+run_test() {
+	unset IFS
+	local host_oops_cnt_before
+	local host_warn_cnt_before
+	local vm_oops_cnt_before
+	local vm_warn_cnt_before
+	local host_oops_cnt_after
+	local host_warn_cnt_after
+	local vm_oops_cnt_after
+	local vm_warn_cnt_after
+	local name
+	local rc
+
+	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
+	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+
+	name=$(echo "${1}" | awk '{ print $1 }')
+	eval test_"${name}"
+	rc=$?
+
+	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on host" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on host" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
+		echo "${name}: kernel oops detected on vm" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
+		echo "${name}: kernel warning detected on vm" | log_host ${name}
+		rc=$KSFT_FAIL
+	fi
+
+	return ${rc}
+}
+
+while getopts :hvsq: o
+do
+	case $o in
+	v) VERBOSE=1;;
+	q) QEMU=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+if [[ ${#} -eq 0 ]]; then
+	ARGS=(${TEST_NAMES[@]})
+else
+	ARGS=($@)
+fi
+
+check_args "${ARGS[@]}"
+check_deps
+
+QEMU=$(command -v ${QEMU:-qemu-system-$(uname -m)})
+
+echo "TAP version 13" | tap_output
+echo "1..${#ARGS[@]}" | tap_output
+
+rm -f "${LOG}"
+log_setup "Booting up VM"
+vm_setup
+vm_wait_for_ssh
+log_setup "VM booted up"
+
+cnt_pass=0
+cnt_fail=0
+cnt_skip=0
+cnt_total=0
+exitcode=0
+for arg in "${ARGS[@]}"; do
+	run_test "${arg}"
+	rc=$?
+	if [[ ${rc} == $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "[PASS]" | tap_prefix
+		echo "ok ${cnt_total} ${arg}" | tap_output
+	elif [[ ${rc} == $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "[SKIP]" | tap_prefix
+		echo "ok ${cnt_total} ${arg} # SKIP" | tap_output
+		exitcode=$KSFT_SKIP
+	elif [[ ${rc} == $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "[FAIL]" | tap_prefix
+		echo "not ok ${cnt_fail} ${arg} # exit=$rc" | tap_output
+		exitcode=$KSFT_FAIL
+	fi
+	cnt_total=$(( cnt_total + 1 ))
+done
+
+echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}" | tap_prefix
+echo "1..${cnt_total}" | tap_output
+
+exit ${rc}

---
base-commit: 8066e388be48f1ad62b0449dc1d31a25489fa12a
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@gmail.com>

