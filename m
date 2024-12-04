Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67A20C019
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316931; cv=none; b=bsNb6VQNI5SNb9NHh7FSwMCMIyC/qxj+Xw8++LZAYhOlrG1dBsHcexHX7xYQEFK+aXBZx8axQEvuDMoGzNKm+3gMZCNrxR/sZeOkB29mbeqP6OhxmBe+8pqyLHmbW1EBNPn/mcPfT59qk5E4W3hvVGnBypr0ZwpBpA9OFhJyfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316931; c=relaxed/simple;
	bh=uRjaOZTjHUvybJWAv9vGsJi33hCxx6hpGz/B8OQ605Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fR4YR8mHeF1qe2ciRZqeVtwrTT5FBB2mNaPE+hR5yuw0m1Aj1aOYocw0nWcbhdfbf2ZDWuy2tZEKn9CgF28xAsnnOS5Fwu6WgaNVMlnwTLGP/+15z1pSNE53zcQmckQO6RtnMgqRxQbST1gcb462vbZtQCRPyi9JoZEXFTGT/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVHNXWLg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVHNXWLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
	b=HVHNXWLg28CUVSBTgso70CcMvkUKmVgDFMOSKArAG01ljUYnAhe9JG7XQP4nALYWKnekD6
	Ub5p8xdxbV00XAwvioBWZ0PWtkKJSiq9/54mAMtL9x3zLgeyHJRKE2qWaWKWLTE5rElE3U
	hnC47l+FWqfZd2hTVWNZLut369qnWmE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-GRoL1jXzMwuF-nwy3pjE_w-1; Wed, 04 Dec 2024 07:55:25 -0500
X-MC-Unique: GRoL1jXzMwuF-nwy3pjE_w-1
X-Mimecast-MFC-AGG-ID: GRoL1jXzMwuF-nwy3pjE_w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso55382425e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316924; x=1733921724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
        b=Nn8zEwGZjrlHc2+TmeFanzMKqQ7L6zifbDPfBKpXrz6jEHlvklA9QoLMnaawNYEGdD
         JnkRDOsFkIZtvn/74AY55/FzaGa/zElNeYtQf/LM0qAmg1+uU06iLaLZEzxvoiLVuslM
         iv1KlCCgvOUoOwrRS1dYqpEwC3P3N2wMlItsl/wIVgNctMMsKVCZycPmdTeszo5Gid6t
         QkEm8MvJrWJMkdRtuVsf7TqiJ3AgMv9Jb4y2Mg3UMVrRIksuzy//cjAPXCh1ySM37f2l
         3gOR5YluO957sxZeSC4pmaU+K2YyHEx0IOqv/SaHcoUIUpvyvhSntRnRBu9aJmQf6NpW
         g0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNpmBFc7uiHS4WuRCvQE1v3T+PFYvMKnAUo40S8mhzrzu2mMAIC4Y+9AWMyXAirKwhpiF9ZFPFk0qEQQHdgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yywy+mIZ1O6ezb3rSXBh5h5UazUMYCwOxrEP0u+RHcdmMDQQaEF
	fImegW/jYQiLEyIwhNd733lpYUPDIjdSTbN7aI0EY1QqGt5r7ggWjihqUKL3/sfNnxQNSwlJd4d
	8XqHpOjTwWTotzivIhvgpbEqauZbpzzsVIbeyphrTSiKdmkcxJt49EWby8UPPEfKZuF1Cq0OrVe
	o=
X-Gm-Gg: ASbGncsk7Da0cx7dI31RS3otV08XIYqJbiuxqkXFy5f3DgC2tq7ekY5Ep8efV3JEs50
	eVH5Z62CjDxVVxEsR5j4ixUEP4O+rvrXWsmjr2eM/+Cc7VsXonRXvBLD54wvQEb0um9hEhXUyZN
	S2rBS4apHRqYtrZIAJqBLciFyndoIkz/aVBpn5Qoyb+NHhu9HvbdlVGaYVwmNDyEuiq1C0+CkDA
	4qAe2Uu4upq/lbWNpLykIHM9Jw/oydRJYFnWHQ6sE4QTDbNNPIt2MZTRnkqQ4htQ6hyZ2spcuBj
	3gZhol/BJGKExY7a4mGColM6FX88iL1TU+M=
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286445e9.33.1733316924449;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFzA2SYKI5zve6AhLcTcIqYEQR+M/xeFfejA5VMHPdifDyO5ycBtXVIAK8EC4IQe7u0N0Ewg==
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286335e9.33.1733316924087;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23531055e9.35.2024.12.04.04.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 12/12] s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
Date: Wed,  4 Dec 2024 13:54:43 +0100
Message-ID: <20241204125444.1734652-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XI9Pohf8tsGr4PbiGupqSanfvUKFr3ak7Tg76_fvKow_1733316924
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's add support for including virtio-mem device RAM in the crash dump,
setting NEED_PROC_VMCORE_DEVICE_RAM, and implementing
elfcorehdr_fill_device_ram_ptload_elf64().

To avoid code duplication, factor out the code to fill a PT_LOAD entry.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig             |  1 +
 arch/s390/kernel/crash_dump.c | 39 ++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..c230bad7f5cc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -240,6 +240,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..f699df2a2b11 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -508,6 +508,19 @@ static int get_mem_chunk_cnt(void)
 	return cnt;
 }
 
+static void fill_ptload(Elf64_Phdr *phdr, unsigned long paddr,
+		unsigned long vaddr, unsigned long size)
+{
+	phdr->p_type = PT_LOAD;
+	phdr->p_vaddr = vaddr;
+	phdr->p_offset = paddr;
+	phdr->p_paddr = paddr;
+	phdr->p_filesz = size;
+	phdr->p_memsz = size;
+	phdr->p_flags = PF_R | PF_W | PF_X;
+	phdr->p_align = PAGE_SIZE;
+}
+
 /*
  * Initialize ELF loads (new kernel)
  */
@@ -520,14 +533,8 @@ static void loads_init(Elf64_Phdr *phdr, bool os_info_has_vm)
 	if (os_info_has_vm)
 		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
 	for_each_physmem_range(idx, &oldmem_type, &start, &end) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_vaddr = old_identity_base + start;
-		phdr->p_offset = start;
-		phdr->p_paddr = start;
-		phdr->p_filesz = end - start;
-		phdr->p_memsz = end - start;
-		phdr->p_flags = PF_R | PF_W | PF_X;
-		phdr->p_align = PAGE_SIZE;
+		fill_ptload(phdr, start, old_identity_base + start,
+			    end - start);
 		phdr++;
 	}
 }
@@ -537,6 +544,22 @@ static bool os_info_has_vm(void)
 	return os_info_old_value(OS_INFO_KASLR_OFFSET);
 }
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+/*
+ * Fill PT_LOAD for a physical memory range owned by a device and detected by
+ * its device driver.
+ */
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size)
+{
+	unsigned long old_identity_base = 0;
+
+	if (os_info_has_vm())
+		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
+	fill_ptload(phdr, paddr, old_identity_base + paddr, size);
+}
+#endif
+
 /*
  * Prepare PT_LOAD type program header for kernel image region
  */
-- 
2.47.1

