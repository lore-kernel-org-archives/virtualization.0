Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D652F692C
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530570; cv=none; b=lKsEWDf038rNxefFDFK2kdkw8FzNpGao3WRXRhch1srtGyO2uObuLvT95eFj4UDkX5G7xm5PUaPEgfJ9CKgvAJLLSS7q2AK+TIlREU4w1h2cVbc+aP85YeJ2MVu8i7L2i6B6iFlRLOvZrdYNleWvEp0F6kvnhfjf6prxdT/tkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530570; c=relaxed/simple;
	bh=8Qe5l67vygPXJazkcPWfkfCqsb/KeWBfBeAs0hHVwfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMIsTqrX2z9dG1ANNTdoMO/6+J1EQ69/09MGku1PAfv818FvQuHdJmW2NrCUPEHvKucDuNdT2Pt75Q84bIrnTvFBqjM6w7xEPyuBFchPqFEi3BWckKmwcOpafunrqGNfFyL0iVzrNRVW2/J4iS6OqMfglMVCLDkgmLlhkqtwM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XrKmXksy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XrKmXksy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710665e7deso4308925e9.1
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530567; x=1763135367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3/wHkVzF7HOlD53dUl3XTlhc18km5IWf6+9u8QQV6U=;
        b=XrKmXksy7sa5nFUYDnPFLbOl4we77ZHFb3iCB5ZCE4LdsVDxcNf6cSe2X4vGP69DoL
         I/D7D7u/PS0uSdhPzEqYTtxU2wyGehskxTzswVNFn9S8Hp1J0Z6AP7MVrA0pyYatd5am
         cAWfvQo63GVWhXT8zyRCB96yxRNx0HcqkDP/UWrKyaP0hLliHnalS5uMO0tpdtQ8WlZ2
         wA7vrqtzbcWSVFeBSxztuW3UTEiVVMejZ3OKkNw7DJT9gg2ur3LqZYhCHcSX3UIrJ8oM
         BA1pSF2+Djh27Qxa5Vs5PnE65e6qnQko2+7fDTbCs6WMmb4QOeTpfogzEIr5zX3Fd7W0
         UZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530567; x=1763135367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3/wHkVzF7HOlD53dUl3XTlhc18km5IWf6+9u8QQV6U=;
        b=t6BG0cDsZlVhexRio/vjyOCMcaLnx8BUWNPP/YGHtZ8/MK8I6PGeHfz3wJeAofOGSq
         iqMnLxG+SnUWFKv+FKM+QJ3zTQCOZcugiuVf/ZAHKM/OAedM2qSLmbCpBbzhzoyG8GN+
         +h+3gwBVezMVJMBquvyJhEtb8VC09uuuTh+UjmxCfhFVITqS6xm4lNaSjkJ2KaEH04xV
         B/UhHYI3v47iBGm9oR2F/wkIWBqfn9j9gyf5W7cvcytf7Vnsy8YcCzkwwrMcWU8Gw959
         pzWSlQyQn0ElIXl4y2Aoi26X4NOkvSpZv4gO9os9dDYu6RDdJOlsk3hv/d0WHeQyHRU6
         /NaQ==
X-Forwarded-Encrypted: i=1; AJvYcCULT1Yn/2rhTUPPdfIG/nilj8T0dE9N1vTca4avlVSQ+kFmleUPT119jcyh2DnJT5dxcySj5RdlYCscAVfBhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfcS2dY4ksRylLIR6zUphk7gFRaRULc9DrcNd9Y4A5ugAcBnWM
	eGbJC8biK4o6lo+IoYL4/BS2QIiG8IBwatSs4mZ3Pn2fIKiK0ncO/18YgcG4IrDh0DA=
X-Gm-Gg: ASbGncsa2y5FzbaIC1s7N9h15T0e0LcgSWxVAUIN92eeDlFX+pOq1UfEt4LwxSdhmb5
	iYGQcb7CCYqabMD24ZOhW71IfnGUcfCbzMYtuH3lhMcF73X6l4jSLr3L2S4tXD6iLLCrTqyXVp3
	S2g0vlpwRJi/Jkl0bmQRCuyI9u+Tx6R8kF+lhW8yPEG8JbJmKlp5rFuxnMJm/3Gx2+6Y5IM9ydw
	T0xmVcZcsYSsQEHiMktP5QJniPe79Hpd9W/QWZoIwNzhzrgE2ydkHMGyNPuxYf8p9eVgXT3FvRj
	Bif04d2eMR4ui7FzWmXI39uhhJCZNmVWM3h9OUCJTwzxNxg4VIAUSXADmZRTLNZ9y2fbvV0DXTC
	QuvaRgQLudkA4onKQ3sfJHbDcuoBD4v/q+jhyrN98IBjX4X6lRoR7YlQ3QCcryJf28kNRknDj/f
	whRDa2K3gVGyVUqLLFJM1UAAdE
X-Google-Smtp-Source: AGHT+IH+t3ILybAlPyFaXUrRQDx8y58mbbGb3fzyHsPfpJT0b7oXiH55FZlJkshBo5S1iuffxBxqQg==
X-Received: by 2002:a05:600c:3515:b0:477:5ccb:e19a with SMTP id 5b1f17b1804b1-4776bcae631mr33761005e9.11.1762530567005;
        Fri, 07 Nov 2025 07:49:27 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:26 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 2/2] vduse: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:49:17 +0100
Message-ID: <20251107154917.313090-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107154917.313090-1-marco.crivellari@suse.com>
References: <20251107154917.313090-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..ae357d014564 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2173,7 +2173,8 @@ static int vduse_init(void)
 	if (!vduse_irq_wq)
 		goto err_wq;
 
-	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound", WQ_HIGHPRI, 0);
+	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound",
+					     WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!vduse_irq_bound_wq)
 		goto err_bound_wq;
 
-- 
2.51.1

