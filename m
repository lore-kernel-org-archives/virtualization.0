Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CA19AD48
	for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411805; cv=none; b=ch8IM8wO39ka43pC7vs5ieRF/2bFQdeeGhviZO9HVRbuLa5gnZWgAGIaMjprNavTNJO4uj7a1ZgzJNRa0v4mXrtssgx4BX+k6f1PoWLeD9rhW2/sh1wPjWDBnK1nBhj0/uRcmY7M6tGH6mAqCW6sCGu+bG8MG8G1gubTE67ujSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411805; c=relaxed/simple;
	bh=00KAaZiElDeuSwSawiskbWLQDjpCB7R5sWeWi2JBcew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xox75NfqjfdF5LDcjjgGe0gudl4DNihB51X26kIzUeBxtjoOZJfLIGc9cYE10A710jzFLLCSuHCkn9OEmG2ErxiVlj5ey8guNxJES6asYJc9Z1tcCFUSbjYfHrTcgk9ejFFcbofG4HaXdgJNaVGw+1Z4b1SsBhwK0aWeC74MSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR/BW0ya; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR/BW0ya"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3a26de697fso8956709276.3
        for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411803; x=1736016603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=HR/BW0yaLX6aZRFeIynGY+DkfYzJpzcqvrLTPtDUi3HEwQ7nMpLL2NQjO294r/doZM
         ZtIgjLMwRs7eEf/gpFgk4sAi+QznKoTqoJlNbNGVOKkXlQCKVCWuubRESUJ/ISTPVmwz
         Ndrpp99xT/yfJYmnjqhPdHdyYt52y+ggM5n6wnEFIgUvaqevXVfQU4Q0PDVPX0xjYIS0
         HUbjgkYpJm4h2oSD64bg20vZCe+HimpRyPohZCwiuyQg1A1ivRseDqSeCYT+gx49AcQF
         ZHaHpsThmjI79CHHVE/Y3sIeHZiIR3s2ske72iNKmdr86dJT73PiTgTXHYhpYCiNMzum
         T8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411803; x=1736016603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bA6qa5mRtLx/JNJepZMf5RGZWm5ti1ameVb2qE56fE=;
        b=TMtCo+7y8YC6K1QQTn9FB0IGNuMC4/xTPkqGqP1nuPbQci9HTjuZUYpDoHVVupom5+
         2nHV7TYnCwQrum7U2cK9TZEuRnMUd5c4dhbgmImjqJuoeiEk5deLhfB/UZ5KdzUykk7I
         L9YIpNtQ1j43UrAjf9Bbjgu0Jy4WH6swxbm3PbeU0TZo6vtq/PY6M/ejahfYDqIvAlR+
         ooi2L7QfuX6XtqTF7EtZJOHCgUE3kA0E5wYt1Bpw7KBgqaBOHxawHphcWinh/vacutKG
         jjKeBHFdcPWY7QwDfMUACaQo0pmr187gO0EC0sQeWUeYy0pMvDVyAPkDdLcwIaZnpcOJ
         +gNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLoQiiaVw1JMt6IcrnIko46BAbHGRAMgGOmcRZnGRAFCv6kJLw6UftavZeaTlud//oW+WOK8CQU+U4fEFdig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFhx2UkpV71z7NjpF1PkYqwLP2AJRiXkVL9jCGroPy48Ah5yyp
	RMt8dXBXCrHNvEEdrtA9RpFDkerSyAzUKb4LSEBmqqBMYtIkevLC
X-Gm-Gg: ASbGncv3QWqWWwLTkTmZ5Y0kWk15MuQPmmH4LmYgY0dQjEs1NIyHGVGR4xeocNBpBXo
	Fh1ti8tp/k+dWaxa0HwzCt0GylNMCCO5TnXU0vMAK8lGl911zhxv7XM+YRezW5/lr37clzqGfOk
	cw+YEPaAjFdKNUrIE6tBSVQXUVXnGUDcCA1rQ+Ov32FJ+LoLKbrjMtMHZDHsctBUGrewCCwhSpQ
	5Tfxcb9nQKgJg516c4MK0gGSRSE3zt9bCcTweyOCguT1MCDUAqvVwDYJALnmPxDb7sdsTLtzRNc
	fOKYdGr5U9LxHgmo
X-Google-Smtp-Source: AGHT+IEdltlfo7VoM/K9Hx3CK/leMoimfCHWr7pfYR9wsJX7DjblcCmfKrexz0jlZQgTcU9bnrqr/g==
X-Received: by 2002:a05:6902:1a48:b0:e49:5f2d:e71d with SMTP id 3f1490d57ef6-e538c267d16mr23706682276.21.1735411803005;
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeba44sm5051923276.7.2024.12.28.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:02 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>,
	Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH 05/14] cpumask: deprecate cpumask_next_wrap()
Date: Sat, 28 Dec 2024 10:49:37 -0800
Message-ID: <20241228184949.31582-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patche aligns implementation of cpumask_next_wrap() with the
generic version in find.h which changes function signature.

To make the transition smooth, this patch deprecates current
implementation by adding an _old suffix. The following patches switch
current users to the new implementation one by one.

No functional changes were intended.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/s390/kernel/processor.c        | 2 +-
 drivers/nvme/host/tcp.c             | 2 +-
 drivers/pci/controller/pci-hyperv.c | 2 +-
 drivers/scsi/lpfc/lpfc_init.c       | 2 +-
 include/linux/cpumask.h             | 4 ++--
 kernel/padata.c                     | 2 +-
 lib/cpumask.c                       | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5ce9a795a0fe..42ca61909030 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
 	this_cpu = smp_processor_id();
 	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
 		__this_cpu_write(cpu_relax_retry, 0);
-		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
+		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
 		if (cpu >= nr_cpu_ids)
 			return;
 		if (arch_vcpu_is_preempted(cpu))
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..054904376c3c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
 	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cdd5be16021d..86d1c2be8eb5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1757,7 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
 
 	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
 
-	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
+	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
 				     false);
 	cpu = cpu_next;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7f57397d91a9..31622fb0614a 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12876,7 +12876,7 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
 
 	if (offline) {
 		/* Find next online CPU on original mask */
-		cpu_next = cpumask_next_wrap(cpu, orig_mask, cpu, true);
+		cpu_next = cpumask_next_wrap_old(cpu, orig_mask, cpu, true);
 		cpu_select = lpfc_next_online_cpu(orig_mask, cpu_next);
 
 		/* Found a valid CPU */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 30042351f15f..b267a4f6a917 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -296,7 +296,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 
 #if NR_CPUS == 1
 static __always_inline
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	cpumask_check(start);
 	if (n != -1)
@@ -312,7 +312,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 	return cpumask_first(mask);
 }
 #else
-unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
+unsigned int __pure cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap);
 #endif
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index d51bbc76b227..454ff2fca40b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -274,7 +274,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		pd->cpu = cpumask_next_wrap_old(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index e77ee9d46f71..c9a9b451772a 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -8,7 +8,7 @@
 #include <linux/numa.h>
 
 /**
- * cpumask_next_wrap - helper to implement for_each_cpu_wrap
+ * cpumask_next_wrap_old - helper to implement for_each_cpu_wrap
  * @n: the cpu prior to the place to search
  * @mask: the cpumask pointer
  * @start: the start point of the iteration
@@ -19,7 +19,7 @@
  * Note: the @wrap argument is required for the start condition when
  * we cannot assume @start is set in @mask.
  */
-unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
 {
 	unsigned int next;
 
@@ -37,7 +37,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
 
 	return next;
 }
-EXPORT_SYMBOL(cpumask_next_wrap);
+EXPORT_SYMBOL(cpumask_next_wrap_old);
 
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
-- 
2.43.0

