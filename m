Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3C35F16C
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351240; cv=none; b=a+13vdnn9kwoxu4+PpwUaNfhgEKG50Q+PQvYjJvcHfZgq+IaKwfIVW/kDyR0tMJbvKN22ZMYD7xhh9qpJlCzdP3JAqOcn+VtHW2THU2RaWB1h+CkZCJw8Y/JwTN6dfZgK9pm2pCRCtXd3nM1LIbY2ooQ9th6TB/q5b2xr16v6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351240; c=relaxed/simple;
	bh=ah8RZnvIv6EG2FUiR40kE0EnXEx8wpu6qvokaRs7nSc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUCh8rfv8VrNYsSZW9EASE5kMP6r+vxXoOyM85lhoe/nLj0dhcPyIKDB+Ih9GxL7mSVeWQC+wvQMYEATKudThrLTodCevDfK2nqBZ7fDVsmwPrdk93vtcNMN0ZSWleGhI3IX05q+MSUTtYQ4Vhyuw2qv94vtrgLeEpaZt8judcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng3DyRR/; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng3DyRR/"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1361784a12.0
        for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787351238; x=1787956038; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=alI6R8OK9bw/lOalZy0/l1DlsPFyxHXm14JHHaHbIQc=;
        b=Ng3DyRR/hYmQ9sUk9NfoWdDkI4cbh00gFp0DBpXwEQR4aWbRP66eoskBB6WJFNLKMO
         cs8vdnYjyAjOymMZV3JGSH+hTHtWdTfZ/Rc1Ct/KdWuOZ8i2NBjuWEJM8ywU1wJd8h4n
         gZEMRSYzjKcQLZtNqt2+ix41pQYAs93I+K5ooySKAZSG/EtMMnmeg0jt94G/mW0zz5IQ
         14AfA5wEWuiYg6ErCEtHnADVWgD7uDD+d0WUSUR0Ggh9XIl6nHUUyMfh47v3/i3Uk6YY
         lLN3u2HyEUROiIOU/MQzYEiA314O2FDMOAfyKWqtDDYlti9YBfT5S0tFP1fv2I53zD9b
         2acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787351238; x=1787956038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=alI6R8OK9bw/lOalZy0/l1DlsPFyxHXm14JHHaHbIQc=;
        b=FQVJY1DMvX2g4gI1MeTMJXJ/ZBD+6GeiG87WJnrbhFbL5X2lRZkdu3cq/hEJbZc5Cx
         G/CGra5GRwMlZVDnHXVsnTVLr/WkmwwykZ3tKOdgvSun8MEKGu6343RzW8mW2UL81gl+
         fqDcvsYv1c1AULeWniToDyvLxH77gT2BiVZZoeu5j5ASYXRxQMGo3ClLx8kWBDbBJXK+
         U4cmRuY9/HmIUin1xRtkWxDV+84EEUJZe3Cp0or9bf+U6xI/eibQP7R+OOmJVVHKPWGX
         JdL6acjSfPXXq5M5Xo7SPpngmayYkQpRGpvJydN5d12MUIalje4mWUJZQxvL0Bmnt4DR
         ATuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp079B3Tuwtytwbb41AExvTu+KO+gPR97XeMmZjmH0wtRvJtx7S4DO7/VPEgBQBPbRaVIB5ubGbAmKmUq2hcA==@lists.linux.dev
X-Gm-Message-State: AFuF++mp6oqMuk4kmGxq5HztG7YtTkbA4AqAWAxAXHAt1XOgztH1iKrk
	1u1Nid/0NlzjOsUWtESqEROAPHIVXNrf88NKU9pLWhMhTl17WU2aV8Wx
X-Gm-Gg: AR+sD139uU203k1VsGw7cumRk9Dec1DMNr2e+PwazMSwrw/k37NTSlVls0MFFmmZlCP
	wDm+zk1AX68mfp5uX2TCtn+SHvjXKtfVKniImiInER7aag4RqL72G9TuzIKSd0yHf+NbBPyRXwV
	GKIjpZfM4P5wf4s/Nyz4sNmnVGskAQrEgoXld+BL2JjVWGIYYndr7CkYMzFJV3mqM8VPJ1TkwQs
	XxyByXIWghjU+hFlMI700ZsdsrMIYHegkBSxuB1CYBeQND8whF8k2OsXpANbi0sJS5ow6G5UnVY
	+cuQmO9Qz8mcEuwlwfARJ8wQ/tVIPvsgHLFaFabuSBNfcEj+Mo5ph0INm2PnHn0bD+J2uNja3Io
	kfaSWvLCZXeG4Wxe2Mo2qAgsxTwCk0F0fI63bxdG/lOIOD/qC9LKVazEllXlMZLHiN4/RL6ImTT
	i/CGLdExgf5CZ0YVoe6uN1usm+V06kLf5Qef8wlkB/Etnb/bILAI0=
X-Received: by 2002:a05:6a21:9103:b0:398:8870:b58f with SMTP id adf61e73a8af0-3cd3011a856mr19868601637.14.1787351237953;
        Fri, 21 Aug 2026 15:27:17 -0700 (PDT)
Received: from localhost ([96.37.2.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1a1de1sm32632049eec.31.2026.08.21.15.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 15:27:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Fri, 21 Aug 2026 18:27:15 -0400
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v10 00/12] sched, steal_governor: Introduce preferred
 CPUs and steal-driven vCPU backoff
Message-ID: <aojOp7KNsVGGb2CX@yury>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>

> ========================================
> Performance Numbers (powerpc, x86, s390)
> ========================================
> 
> PowerPC:
> ===================
> VM1: 60VP/30EC and VM2: 30VP/20EC
> Shared physical CPU pool size: 50 Cores. Each core is SMT8.
> (VP - Virtual Core, EC - Entitles Core) -  PowerVM terminologies of SPLPAR[2]
> 
> Default parameter values: 1000ms, 200 low threshold, 500 high threshold
> Both the VMs are running the same workload. Total throughput/time of VM1+VM2
> is being mentioned in all cases.
> 
> Hackbench
>               baseline    steal_governor        steal_governor
>                              disabled               enabled
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> 10 groups        5.20   |    5.40 (-3.85%)  |     4.65 (+10.58%)
> 20 groups       11.39   |   12.01 (-5.44%)  |     7.09 (+37.75%)
> 40 groups       20.32   |   19.80 (+2.56%)  |    11.31 (+44.34%)
> 10 groups(-p)    2.37   |    2.26 (+4.64%)  |     2.06 (+13.08%)
> 20 groups(-p)    3.34   |    3.28 (+1.80%)  |     3.20 (+4.19%)
> 40 groups(-p)    4.46   |    4.83 (-8.30%)  |     4.26 (+4.48%)
> Remarks: Net improvement with steal_governor specially high load points.
> 
> schbench ( -L -n 0 -r 30 -s 0)
>               baseline    steal_governor          steal_governor
>                              disabled                 enabled
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> -m 1 -t 128     2475162 |    2621246 (+5.90%)  |      2527299 (+2.11%)
> -m 1 -t 256     1467350 |    1470032 (+0.18%)  |      1492372 (+1.71%)
> -m 1 -t 512     1408813 |    1454687 (+3.26%)  |      1437605 (+2.04%)
> Remarks: Effectively means no-improvements or regressions
> 
> kernbench	baseline    steal_governor     steal_governor
> (elapsed time)	               disabled            enabled
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> -j nr_cpus	231      |      235 (-1.7%) |    199 (+14%)
> Remarks: Net improvement in elapsed time.
> 
> Daytrader - A real life work which is a proxy for trading based
> on db2[3]
>               baseline      steal_governor   steal_governor
>                               disabled          enabled
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> Load@30%	1x	|	0.96x	|	 1.53x			
> Load@60%	1x	|	0.94x	|	 1.41x
> Remarks: Good improvement seen at different load points.
> 
> When there is no steal time (such as dedicated LPAR, or only VM2
> is running) throughput was same with steal_governor enabled/disabled
> which indicates minimal overhead of steal_governor. 
> 
> I have run v10 also on a smaller powerpc LPAR system and it shows
> good improvements.
> 
> =======================================================================
> 
> Data from x86,s390 KVM which Ilya Leoshkevich carried out during OSPM26
> time. *This was based on v2*. Idea is still the name, numbers are
> expected to be better in v10 as some of the overhead has been removed.
> Note: Other variations of the benchmark shows no observable
> difference.
> 
> x86:
> ====
> cascade-lake: 32 threads = 16 cores
> Benchmark      #VMs    #CPUs/VM  ΔRPS     (%std)
> ===============================================
> hackbench         8          16  90.73% ± 9.97%
> hackbench         4          24  52.67% ± 7.43%
> hackbench         4          16  37.96% ± 11.19%
> hackbench         4          32  37.82% ± 4.38%
> hackbench        12           8  36.90% ± 4.74%
> hackbench         8           8  35.30% ± 3.61%
> pgbench          16           4  31.77% ± 2.44%
> hackbench         2          24  25.85% ± 8.63%
> hackbench        16           8  24.87% ± 3.46%
> pgbench          16           8  21.83% ± 2.20%
> pgbench          12           8  21.35% ± 2.15%
> pgbench           8           8  18.46% ± 1.01%
> hackbench         2          32  15.56% ± 4.53%
> pgbench          12           4  14.28% ± 2.04%
> hackbench        16           4  14.07% ± 2.90%
> hackbench        12           4  9.60% ± 3.49%
> [...]
> pgbench           4           8  -1.16% ± 3.60%
> hackbench         4           4  -1.80% ± 9.55%
> sysbench         12           4  -2.19% ± 0.78%
> pgbench           4          24  -2.43% ± 4.38%
> pgbench           4          32  -3.21% ± 0.79%
> sysbench         16           4  -3.22% ± 1.09%
> 
> S390:
> =====
> z16: 16 threads = 8 cores (SMT-2)
> Benchmark      #VMs    #CPUs/VM  ΔRPS    (std%)
> ===============================================
> pgbench           2           8  73.50% ± 35.91%
> pgbench          16           4  61.30% ± 4.09%
> hackbench        16           4  54.11% ± 4.38%
> hackbench        12           4  36.34% ± 4.63%
> pgbench          12           4  34.83% ± 2.57%
> hackbench         8           4  29.75% ± 5.86%
> hackbench         8           8  25.98% ± 5.09%
> pgbench           2           4  23.31% ± 33.44%
> pgbench           2          16  19.95% ± 17.12%
> hackbench         4           8  19.43% ± 9.33%
> pgbench           8           4  19.32% ± 4.50%
> [...]
> schbench          8           8  -0.79% ± 0.33%
> sysbench          8           8  -0.81% ± 0.39%
> hackbench         4          16  -1.11% ± 5.82%
> sysbench          8           4  -1.62% ± 0.49%
> sysbench         16           4  -2.70% ± 0.58%
> schbench         16           4  -2.73% ± 0.91%
> sysbench         12           4  -2.91% ± 0.61%
> hackbench         2          24  -4.99% ± 3.31%
> 
> Summary:
> - Many improvement across archs specially with real life workloads.
> - No major regressions observed.
> - Overhead of steal_governor looks minimal when there is no steal time.
> - Overhead when STEAL_GOVERNOR=n is negligible.

OK, I gave it some testing on my laptop.

The results are pretty consistent: the steal ratio is converged to a
number withing the threshold, but the overall performance is 3-5% worse
comparing to baseline. I tried 2-5% and 1.5-15% boundaries.

It's 4 VMs, each running 8 vCPUs on 8 pCPU machine, the payload is
running for 2 minutes.

  Steal governor off:
  VM         THROUGHPUT       AVG STEAL%
  -------- ------------ ----------------
  0               13802            74.59
  1               11929            76.35
  2               13470            74.61
  3               10259            78.67
  -------- ------------ ----------------
  TOTAL           49460                -
  
  Steal governor on:
  VM         THROUGHPUT       AVG STEAL%
  -------- ------------ ----------------
  0               12921             5.72
  1               12762             6.11
  2               10160             5.99
  3               12098             6.00
  -------- ------------ ----------------
  TOTAL           47941                -


The test is attached below. The results are quite differ from the numbers
above, so maybe I misconfigured something? I didn't use hackbench or
similar benchmarks, just a basic math.

Shrikanth, can you please check my test and results? Is there something 
that I have missed?

I think this series should include some testing. The scripts below look
bulky and they depend on virtme, but they allow to build the proper
kernel and run tests with a single command.

Thanks,
Yury

From 27e548d65bbe0ec01308d3329017619e165d0488 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@nvidia.com>
Date: Wed, 19 Aug 2026 16:31:33 -0400
Subject: [PATCH] steal governor: add testing harness based on vng

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 .../virtme-steal-payload.sh                   | 220 ++++++++++++
 .../steal_governor_test/virtme-steal-time.sh  | 321 ++++++++++++++++++
 2 files changed, 541 insertions(+)
 create mode 100755 drivers/virt/steal_governor_test/virtme-steal-payload.sh
 create mode 100755 drivers/virt/steal_governor_test/virtme-steal-time.sh

diff --git a/drivers/virt/steal_governor_test/virtme-steal-payload.sh b/drivers/virt/steal_governor_test/virtme-steal-payload.sh
new file mode 100755
index 000000000000..02a245a900b8
--- /dev/null
+++ b/drivers/virt/steal_governor_test/virtme-steal-payload.sh
@@ -0,0 +1,220 @@
+#!/bin/sh
+# Guest-side measurable workload for the steal governor test.
+
+set -eu
+
+case $# in
+2|3|5) ;;
+*)
+	echo "usage: ${0##*/} VM_ID DURATION_SECONDS [DRIVER [LOW_THRESHOLD HIGH_THRESHOLD]]" >&2
+	exit 2
+	;;
+esac
+
+vm_id=$1
+duration=$2
+driver=${3-}
+low_threshold=${4-}
+high_threshold=${5-}
+
+verify_parameter()
+{
+	parameter=$1
+	expected=$2
+	parameter_file=/sys/module/$driver_sysfs/parameters/$parameter
+
+	if [ ! -r "$parameter_file" ]; then
+		echo "error: driver $driver has no readable $parameter parameter" >&2
+		exit 1
+	fi
+	actual=$(cat "$parameter_file")
+	if [ "$actual" != "$expected" ]; then
+		echo "error: driver $driver $parameter is $actual, expected $expected" >&2
+		exit 1
+	fi
+}
+
+case $vm_id in
+*[!0-9]*|'')
+	echo "error: VM_ID must be a non-negative integer" >&2
+	exit 2
+	;;
+esac
+case $duration in
+*[!0-9]*|'')
+	echo "error: DURATION_SECONDS must be a positive integer" >&2
+	exit 2
+	;;
+esac
+if [ "$duration" -eq 0 ]; then
+	echo "error: DURATION_SECONDS must be greater than zero" >&2
+	exit 2
+fi
+if [ -n "$driver" ]; then
+	case $driver in
+	*[!A-Za-z0-9_.-]*)
+		echo "error: invalid driver module name: $driver" >&2
+		exit 2
+		;;
+	esac
+	if [ -n "$low_threshold" ]; then
+		case $low_threshold:$high_threshold in
+		*[!0-9:]*|:*|*:)
+			echo "error: thresholds must be non-negative integers in percent * 100" >&2
+			exit 2
+			;;
+		esac
+		if [ "$low_threshold" -ge "$high_threshold" ] ||
+		   [ "$high_threshold" -ge 10000 ]; then
+			echo "error: thresholds must satisfy 0 <= LOW < HIGH < 10000" >&2
+			exit 2
+		fi
+	fi
+	if ! command -v modprobe >/dev/null; then
+		echo "error: modprobe is required to load driver $driver" >&2
+		exit 1
+	fi
+	driver_sysfs=$(printf '%s\n' "$driver" | tr '-' '_')
+	if [ ! -d "/sys/module/$driver_sysfs" ]; then
+		if [ -n "$low_threshold" ]; then
+			modprobe "$driver" \
+				low_threshold="$low_threshold" \
+				high_threshold="$high_threshold"
+		else
+			modprobe "$driver"
+		fi
+	fi
+	if [ ! -d "/sys/module/$driver_sysfs" ]; then
+		echo "error: driver $driver has no /sys/module/$driver_sysfs entry after modprobe" >&2
+		exit 1
+	fi
+	if [ -n "$low_threshold" ]; then
+		verify_parameter low_threshold "$low_threshold"
+		verify_parameter high_threshold "$high_threshold"
+	fi
+fi
+
+tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/virtme-steal-payload.XXXXXXXX")
+before=$tmpdir/before
+after=$tmpdir/after
+pids=
+
+stop_workers()
+{
+	for pid in $pids; do
+		kill "$pid" 2>/dev/null || :
+	done
+	for pid in $pids; do
+		wait "$pid" 2>/dev/null || :
+	done
+	pids=
+}
+
+cleanup()
+{
+	stop_workers
+	rm -rf -- "$tmpdir"
+}
+trap cleanup EXIT
+trap 'exit 130' INT
+trap 'exit 143' TERM
+
+awk '$1 ~ /^cpu[0-9]+$/ { print $1, $9 }' /proc/stat >"$before"
+start_time=$(awk '{ print $1 }' /proc/uptime)
+deadline=$(awk -v start="$start_time" -v seconds="$duration" \
+	'BEGIN { printf "%.2f", start + seconds }')
+workers=$(awk '$1 ~ /^cpu[0-9]+$/ { n++ } END { print n }' /proc/stat)
+
+i=0
+while [ "$i" -lt "$workers" ]; do
+	result=$tmpdir/work-$i
+	awk -v deadline="$deadline" -v result="$result" '
+		function uptime(    line, fields) {
+			getline line < "/proc/uptime"
+			close("/proc/uptime")
+			split(line, fields)
+			return fields[1]
+		}
+		BEGIN {
+			batch = 1000
+			units = 0
+			value = 1
+			while (uptime() < deadline) {
+				for (iteration = 0; iteration < batch; iteration++)
+					value = (value * 1103515245 + 12345) % 2147483647
+				units++
+			}
+			printf "%.0f %.0f\n", units, units * batch > result
+		}
+	' </dev/null &
+	pids="$pids $!"
+	i=$((i + 1))
+done
+
+worker_failed=0
+for pid in $pids; do
+	wait "$pid" || worker_failed=1
+done
+pids=
+if [ "$worker_failed" -ne 0 ]; then
+	echo "error: one or more workload processes failed" >&2
+	exit 1
+fi
+
+awk '$1 ~ /^cpu[0-9]+$/ { print $1, $9 }' /proc/stat >"$after"
+end_time=$(awk '{ print $1 }' /proc/uptime)
+elapsed=$(awk -v start="$start_time" -v end="$end_time" \
+	'BEGIN { printf "%.2f", end - start }')
+clk_tck=$(getconf CLK_TCK 2>/dev/null || echo 100)
+
+echo VIRTME_STEAL_REPORT_BEGIN
+driver_status=none
+[ -n "$driver" ] && driver_status=$driver:loaded
+[ -n "$low_threshold" ] && \
+	driver_status="$driver_status,thresholds=$low_threshold..$high_threshold"
+echo "VM $vm_id  kernel=$(uname -r)  vCPUs=$workers  sample=${elapsed}s  driver=$driver_status"
+echo "Workload (unpinned workers)"
+printf '%-10s %12s %16s %16s\n' \
+	WORKER WORK_UNITS ITERATIONS ITERATIONS/s
+printf '%-10s %12s %16s %16s\n' \
+	---------- ------------ ---------------- ----------------
+total_units=0
+total_iterations=0
+i=0
+while [ "$i" -lt "$workers" ]; do
+	read -r units iterations <"$tmpdir/work-$i"
+	rate=$(awk -v iterations="$iterations" -v elapsed="$elapsed" \
+		'BEGIN { printf "%.0f", iterations / elapsed }')
+	printf '%-10s %12s %16s %16s\n' \
+		"worker$i" "$units" "$iterations" "$rate"
+	total_units=$((total_units + units))
+	total_iterations=$((total_iterations + iterations))
+	i=$((i + 1))
+done
+total_rate=$(awk -v iterations="$total_iterations" -v elapsed="$elapsed" \
+	'BEGIN { printf "%.0f", iterations / elapsed }')
+throughput=$(awk -v units="$total_units" -v elapsed="$elapsed" \
+	'BEGIN { printf "%.0f", units / elapsed }')
+printf '%-10s %12s %16s %16s\n' \
+	TOTAL "$total_units" "$total_iterations" "$total_rate"
+
+echo "Steal time by guest CPU"
+printf '%-8s %12s %12s %10s\n' CPU STEAL_TICKS STEAL_s STEAL_%
+printf '%-8s %12s %12s %10s\n' -------- ------------ ------------ ----------
+average_file=$tmpdir/average-steal
+awk -v hz="$clk_tck" -v elapsed="$elapsed" -v cpus="$workers" \
+	-v average_file="$average_file" '
+	NR == FNR { before[$1] = $2; next }
+	{
+		delta = $2 - before[$1]
+		total += delta
+		printf "%-8s %12d %12.2f %10.2f\n", $1, delta,
+		       delta / hz, 100 * delta / hz / elapsed
+	}
+	END {
+		printf "%.2f\n", 100 * total / hz / elapsed / cpus > average_file
+	}
+' "$before" "$after"
+average_steal=$(cat "$average_file")
+echo "VIRTME_STEAL_SUMMARY $vm_id $throughput $average_steal"
+echo VIRTME_STEAL_REPORT_END
diff --git a/drivers/virt/steal_governor_test/virtme-steal-time.sh b/drivers/virt/steal_governor_test/virtme-steal-time.sh
new file mode 100755
index 000000000000..a41d362c7888
--- /dev/null
+++ b/drivers/virt/steal_governor_test/virtme-steal-time.sh
@@ -0,0 +1,321 @@
+#!/usr/bin/env bash
+# Build a minimal KVM guest kernel and measure per-vCPU steal time under load.
+
+set -euo pipefail
+
+script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+kernel_dir=$(CDPATH= cd -- "$script_dir/../../.." && pwd)
+vng=${VNG:-vng}
+build_dir=${BUILD_DIR:-"$kernel_dir/.virtme-steal"}
+payload=${PAYLOAD:-"$script_dir/virtme-steal-payload.sh"}
+vm_count=4
+vcpu_count=$(nproc)
+duration=20
+memory=512M
+driver=
+low_threshold=
+high_threshold=
+verbose=0
+declare -a config_items=()
+
+usage()
+{
+	cat <<EOF
+Usage: ${0##*/} [options] [O=DIR]
+
+Build a virtme-ng minimal kernel with paravirtual steal-time accounting,
+start multiple CPU-bound VMs, and report the steal time of every guest CPU.
+
+Options:
+  -n VMS       number of VMs to run (default: $vm_count)
+  -p VCPUS     vCPUs per VM (default: $vcpu_count)
+  -d SECONDS   workload duration (default: $duration)
+  -m MEMORY    memory per VM (default: $memory)
+  --configitem CONFIG[=VALUE]
+                enable or set a kernel config option (repeatable)
+  --driver MODULE
+                load and verify this module before running the payload
+  -lo VALUE     low steal threshold in percent * 100 (for example, 150 = 1.5%)
+  -hi VALUE     high steal threshold in percent * 100 (for example, 550 = 5.5%)
+  -O DIR       kernel build directory (default: $build_dir)
+  -v, --verbose show per-worker and per-CPU result tables
+  -h            show this help
+
+Environment equivalents: VNG, BUILD_DIR, and PAYLOAD. A custom payload is
+called inside each VM as: PAYLOAD VM_ID DURATION_SECONDS
+[DRIVER [LOW_THRESHOLD HIGH_THRESHOLD]].
+
+Local virtme-ng checkout example:
+  VNG=../virtme-ng/vng ${0##*/}
+
+The positional O=DIR form is equivalent to -O DIR, for example:
+  ${0##*/} -n 4 O=../build-linux-virtme-steal
+
+Config examples:
+  ${0##*/} --configitem CONFIG_SCHEDSTATS --configitem CONFIG_HZ_1000=y
+
+Threshold example:
+  ${0##*/} --driver steal_governor -lo 150 -hi 550
+EOF
+}
+
+while (($#)); do
+	case $1 in
+	-n|-p|-d|-m|-O|-lo|-hi|--configitem|--driver)
+		if (($# < 2)); then
+			echo "error: $1 requires an argument" >&2
+			exit 2
+		fi
+		case $1 in
+		-n) vm_count=$2 ;;
+		-p) vcpu_count=$2 ;;
+		-d) duration=$2 ;;
+		-m) memory=$2 ;;
+		-O) build_dir=$2 ;;
+		-lo) low_threshold=$2 ;;
+		-hi) high_threshold=$2 ;;
+		--configitem) config_items+=("$2") ;;
+		--driver) driver=$2 ;;
+		esac
+		shift 2
+		;;
+	--configitem=?*)
+		config_items+=("${1#*=}")
+		shift
+		;;
+	--driver=?*)
+		driver=${1#*=}
+		shift
+		;;
+	-v|--verbose)
+		verbose=1
+		shift
+		;;
+	-h|--help)
+		usage
+		exit 0
+		;;
+	O=?*)
+		build_dir=${1#O=}
+		shift
+		;;
+	O=|--configitem=|--driver=)
+		echo "error: ${1%%=*}= requires a non-empty argument" >&2
+		exit 2
+		;;
+	*)
+		echo "error: unexpected argument: $1" >&2
+		usage >&2
+		exit 2
+		;;
+	esac
+done
+
+require_positive_integer()
+{
+	local name=$1 value=$2
+
+	if [[ ! $value =~ ^[1-9][0-9]*$ ]]; then
+		echo "error: $name must be a positive integer (got '$value')" >&2
+		exit 2
+	fi
+}
+
+require_positive_integer "VM count" "$vm_count"
+require_positive_integer "vCPU count" "$vcpu_count"
+require_positive_integer "duration" "$duration"
+
+if [[ -n $low_threshold || -n $high_threshold ]]; then
+	if [[ -z $low_threshold || -z $high_threshold ]]; then
+		echo "error: -lo and -hi must be specified together" >&2
+		exit 2
+	fi
+	if [[ ! $low_threshold =~ ^[0-9]+$ || ! $high_threshold =~ ^[0-9]+$ ]]; then
+		echo "error: -lo and -hi must be non-negative integers in percent * 100" >&2
+		exit 2
+	fi
+	low_threshold=$((10#$low_threshold))
+	high_threshold=$((10#$high_threshold))
+	if ((low_threshold >= high_threshold)); then
+		echo "error: -lo must be less than -hi" >&2
+		exit 2
+	fi
+	if ((high_threshold >= 10000)); then
+		echo "error: -hi must be less than 10000 (100%)" >&2
+		exit 2
+	fi
+	if [[ -z $driver ]]; then
+		echo "error: -lo and -hi require --driver MODULE" >&2
+		exit 2
+	fi
+fi
+
+if [[ -n $driver && ! $driver =~ ^[A-Za-z0-9_.-]+$ ]]; then
+	echo "error: invalid driver module name: $driver" >&2
+	exit 2
+fi
+
+for index in "${!config_items[@]}"; do
+	if [[ ! ${config_items[index]} =~ ^CONFIG_[A-Z0-9_]+(=.*)?$ ]]; then
+		echo "error: invalid kernel config item: ${config_items[index]}" >&2
+		exit 2
+	fi
+	if [[ ${config_items[index]} != *=* ]]; then
+		config_items[index]="${config_items[index]}=y"
+	fi
+done
+
+if [[ ! -x $payload ]]; then
+	echo "error: guest payload is not executable: $payload" >&2
+	exit 1
+fi
+if [[ ! -r /dev/kvm || ! -w /dev/kvm ]]; then
+	echo "error: /dev/kvm is not accessible; KVM is required for steal-time accounting" >&2
+	exit 1
+fi
+
+case $build_dir in
+/*) ;;
+*) build_dir=$PWD/$build_dir ;;
+esac
+
+mkdir -p "$build_dir"
+cd "$kernel_dir"
+
+echo "==> Configuring paravirtual kernel in $build_dir"
+if [[ ! -f $build_dir/.config ]]; then
+	config_args=()
+	for config_item in "${config_items[@]}"; do
+		config_args+=(--configitem "$config_item")
+	done
+	"$vng" --kconfig "${config_args[@]}" \
+		--configitem CONFIG_HYPERVISOR_GUEST=y \
+		--configitem CONFIG_PARAVIRT=y \
+		--configitem CONFIG_KVM_GUEST=y \
+		--configitem CONFIG_PARAVIRT_TIME_ACCOUNTING=y \
+		-- "O=$build_dir"
+else
+	# Preserve an existing local minimal config and add the options needed by
+	# this test. olddefconfig resolves their dependencies for the current tree.
+	config_args=(--file "$build_dir/.config")
+	for config_item in "${config_items[@]}"; do
+		config_name=${config_item%%=*}
+		config_value=${config_item#*=}
+		config_args+=(--set-val "$config_name" "$config_value")
+	done
+	"$kernel_dir/scripts/config" "${config_args[@]}" \
+		-e HYPERVISOR_GUEST \
+		-e PARAVIRT \
+		-e KVM_GUEST \
+		-e PARAVIRT_TIME_ACCOUNTING
+	make -s O="$build_dir" olddefconfig
+fi
+
+echo "==> Building kernel"
+declare -a module_args=()
+if [[ -z $driver ]]; then
+	module_args+=(--skip-modules)
+fi
+"$vng" --build "${module_args[@]}" -- "O=$build_dir"
+
+for option in HYPERVISOR_GUEST PARAVIRT KVM_GUEST PARAVIRT_TIME_ACCOUNTING; do
+	if ! grep -qx "CONFIG_${option}=y" "$build_dir/.config"; then
+		echo "error: CONFIG_${option}=y is required but is absent after configuration" >&2
+		exit 1
+	fi
+done
+
+tmpdir=$(mktemp -d "${TMPDIR:-/tmp}/virtme-steal.XXXXXXXX")
+declare -a vm_pids=()
+
+cleanup()
+{
+	local pid
+
+	for pid in "${vm_pids[@]}"; do
+		kill "$pid" 2>/dev/null || true
+	done
+	wait 2>/dev/null || true
+	rm -rf -- "$tmpdir"
+}
+trap cleanup EXIT
+trap 'exit 130' INT
+trap 'exit 143' TERM
+
+echo "==> Starting $vm_count VMs ($vcpu_count vCPUs each)"
+for ((vm = 0; vm < vm_count; vm++)); do
+	printf -v guest_script '%q %q %q' "$payload" "$vm" "$duration"
+	if [[ -n $driver ]]; then
+		printf -v driver_arg ' %q' "$driver"
+		guest_script+=$driver_arg
+		if [[ -n $low_threshold ]]; then
+			printf -v threshold_args ' %q %q' \
+				"$low_threshold" "$high_threshold"
+			guest_script+=$threshold_args
+		fi
+	fi
+
+	log=$tmpdir/vm-$vm.log
+	"$vng" \
+		"${module_args[@]}" \
+		--name "steal-vm-$vm" \
+		--cpus "$vcpu_count" \
+		--memory "$memory" \
+		--exec "$guest_script" \
+		-- "O=$build_dir" >"$log" 2>&1 &
+	vm_pids+=("$!")
+done
+
+status=0
+total_throughput=0
+if (( ! verbose )); then
+	printf '%-8s %12s %16s\n' VM THROUGHPUT 'AVG STEAL%'
+	printf '%-8s %12s %16s\n' -------- ------------ ----------------
+fi
+for ((vm = 0; vm < vm_count; vm++)); do
+	if ! wait "${vm_pids[vm]}"; then
+		echo "error: VM $vm failed; its complete log follows" >&2
+		status=1
+		echo "--- VM $vm log ---"
+		cat "$tmpdir/vm-$vm.log"
+		continue
+	fi
+	if ! grep -qx VIRTME_STEAL_REPORT_BEGIN "$tmpdir/vm-$vm.log" ||
+	   ! grep -qx VIRTME_STEAL_REPORT_END "$tmpdir/vm-$vm.log"; then
+		echo "error: VM $vm exited without a steal-time report; its complete log follows" >&2
+		cat "$tmpdir/vm-$vm.log"
+		status=1
+		continue
+	fi
+
+	summary=$(awk '/^VIRTME_STEAL_SUMMARY / { print $2, $3, $4 }' \
+		"$tmpdir/vm-$vm.log")
+	if [[ -z $summary ]]; then
+		echo "error: VM $vm exited without a summary; its complete log follows" >&2
+		cat "$tmpdir/vm-$vm.log"
+		status=1
+		continue
+	fi
+
+	if (( verbose )); then
+		echo "--- VM $vm results ---"
+		awk '
+			/^VIRTME_STEAL_REPORT_BEGIN$/ { report = 1; next }
+			/^VIRTME_STEAL_REPORT_END$/ { report = 0 }
+			/^VIRTME_STEAL_SUMMARY / { next }
+			report
+		' "$tmpdir/vm-$vm.log"
+	else
+		read -r summary_vm summary_throughput summary_steal <<<"$summary"
+		printf '%-8s %12s %16s\n' \
+			"$summary_vm" "$summary_throughput" "$summary_steal"
+		total_throughput=$((total_throughput + summary_throughput))
+	fi
+done
+
+if (( ! verbose )); then
+	printf '%-8s %12s %16s\n' -------- ------------ ----------------
+	printf '%-8s %12s %16s\n' TOTAL "$total_throughput" -
+fi
+
+exit "$status"
-- 
2.53.0

