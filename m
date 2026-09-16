Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17F3BB9F3
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535159; cv=none; b=gx7q/x6K22SaHD+TD3GDhFH8MBCUqRWFFHKE7nuy2tdSabwlKiLzaBnvey7S4b9hvA46CnKPB7UA8IDoBFNrmZPLlZ4B9s2RVFvZcqhY+kA2+tUzidYiaIsXu6bCjxBec8VVYVDTy+lSQwt7wM8FsJ2qX5W+7CZRLLAOPCsTLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535159; c=relaxed/simple;
	bh=LWc2s4qZvBb3TJVfltvRwFaklDcNXyLXGRlUr4C/OwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Olr1/U4wBtucTC0oXFO94d24slBjN9ysehKICq6ly1zNQ+RA35tkxjHKDHrQioU/9dAugpG3SJ0Bx0QHFSFNrMr4iYn5hEpoTMmzYh674yOS39E0b/IJOM654cxo901SInkt3yhLwtSOI2wda59FhBYNkIwqJl5RK3YOyZbsjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dPD93Rny; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dPD93Rny"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5c847eaa0aaso684718e0c.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535156; x=1790139956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=ksBP0IBposg5BgDPPF/rFw9LKbqZNGR4mW4xC65/yWIoZRv60t4x2L4sS5hoenbf4X
         JH44Iw7h1ptjYtwb3HglOun1KRlicDElSu+WatSqayAjjhKlNG6bkjYW6UXEiAXYIDen
         e6C/RWYH2A11ZMmJMwS7m8eGN3qmJqiF/0DKNejDbq0CF5DWg+x3cYTfqmyqVMQ+IlJn
         iHlQdcEqnV1wn1QlyCP9FZ0rsqHEc6Puuk1XFAnHQbpnXyE1jo8B21dnoUjdB4SZB4Gc
         SrxthJXU7h5vvhkWP62e8oCsompTBfmfsTpGr1mMUrVDj4tXdcqv6mc/kUL/4M1YnNv+
         0ToQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmIKglCDKuphxuJXATeBEZtqVN+qTdWehn+IAvVj1JmJnIJPHbF6fq2lDxoqEtsQ4SKt7rCUHj8823SxTi9Q==@lists.linux.dev
X-Gm-Message-State: AFuF++l8W0snyBc0hDR7dsvH0kTMVQ6edNR8MOWXFxVaXq+wWX+FqOX5
	3lpmZiRoeMVcJtdvw+vt4oDbDhiy1MlOZ4OOtC0AHBX3Ae7WqEm0C7+/QCmiVc8+VxNLnsXrKQZ
	1472R0vCMjwfdhetDPkUvkKz6RvPmPvHe6kAi5hW2H66+LFMVLBXQfBXhYEFQZ5fD5Jaknuau+h
	ejvRyj47qTbgxl9Q4DchGF0kGpZEoqrTZWUBKrFjYMpnx6tk5qfzrIwqiYHSLDzJxUHeZ4Z9T3d
	aaEW+mfiGKCRUY1raw=
X-Gm-Gg: AYBFou3P4nFOMsziFkt9jrkGCtLhWWBozXpcik6W6hpT4L+hGNAXMMKsaGH+WgAokrJ
	sg+pAL49nRUrRJ11ndMVMlB4oOT8atLwhg+ebitRo4Pc+jEihGrepXfakZbGKKBRkUhV3rmPLnY
	bx3TBMrHHTrn/AD4wHmaCXHE7/CjVbVRMtTcMjF+SzARoqSPlkXeLtOBAnLLq9Eqi2JwtxJilIh
	K3+w7OTg4ZEm58SLjRgaQsmRH+09QR/S/uzKaf4nQgoHwLSXoBav4HNlTx+vV/+t7W58/9tHvDR
	vKgcv3/FR4B8CS0gdPG+PTVyteziu9d4zLzGRv+1F56Bv5IeIIZw6mN+6oDElGfzr9uljWLgjIH
	vt5ClZ4IM2GYWClZE9yMQwnYfyRQRj0wIt4hZzpNI4wd/83xY0/C9yqicOgiNXgc3e3j/ddEI0/
	VygRba2ujBQ8vKZ3Xyyso0++dSqawAT7qB
X-Received: by 2002:a05:6122:512:b0:5bd:71b1:d5c6 with SMTP id 71dfb90a1353d-5c99ac67d45mr904193e0c.4.1789535156192;
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c9988d09c1sm694783e0c.1.2026.09.15.22.05.54
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so6624476a12.3
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535154; x=1790139954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=dPD93RnyE2TqJFhUlaPOvucotk8/sQ5vvRFmWqez7oSHkJ2/x9Tkoyh78HpSYZTpwu
         zFngGIByfNPrGIaj2/ATrQH+WterfV/6EaPmEX26zN+UglYa9kWqXA5NYf59KWcZmkqA
         cijvmbAgvNBjlAm5YH03c4o2Cif4lDsa1uiY4=
X-Forwarded-Encrypted: i=1; AKwUvBwxOQCjdPlnJE7HftVtTThqfNwrC7XeZFMUeg/DtjajlDY3xT14Vu6YVSi5A87DkN+8LCU1qq9MYwD9euNbSA==@lists.linux.dev
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773502637.17.1789535154002;
        Tue, 15 Sep 2026 22:05:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773437637.17.1789535153567;
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 1/2] percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
Date: Wed, 16 Sep 2026 01:05:39 -0400
Message-ID: <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Decrypted per-CPU data is gated by AMD_MEM_ENCRYPT. With
INTEL_TDX_GUEST=y and AMD_MEM_ENCRYPT=n it falls back to ordinary
per-CPU storage, so converting a variable to shared memory can expose
unrelated data on the same page.

Gate the declarations and linker section on X86_MEM_ENCRYPT, which both
AMD_MEM_ENCRYPT and INTEL_TDX_GUEST select. Existing AMD configurations
are unchanged.

Keep the decrypted subsection page-aligned at both ends. The per-CPU
template and each allocated per-CPU unit are also page-aligned, so page
conversion cannot expose ordinary per-CPU data. TDX-only configurations
may need additional space for this alignment and isolation.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/percpu-defs.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..1448e791773e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1013,7 +1013,7 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..decrypted)					\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..54ce1442d918 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -172,7 +172,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 
-- 
2.53.0

