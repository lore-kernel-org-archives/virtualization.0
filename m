Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745A3DEAC8
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654594; cv=none; b=CS6lPwbselwW5XeYlK8RJyYv1vQk8m4NefLJGRvKFZdmVFfoiSgy3NNSloogMp5IkTLiPscskpSa3UUSulUpmZjUV6QbH61sWI5KsZyb+TSVsPq0ibDWlBfNquxGzPpJruch/odHzaNinLX9UKMkJVjtwINqMGUAJuIqD9DdjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654594; c=relaxed/simple;
	bh=wfxZIiWhDP3+oFPqhctMkZvaOYbsAemH2FvdQjYIm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycd3YDnVxHGcGhO9DEGm0ZCHZ3FsZMgv+aXcKQVpCfu7YmGyI22qg2nhre4Qq2HlbzkOnohdiQp9PpXhHbRpWBjTTOq53cBPwfA9Ym1zFsqimtxgtrrZtqnwQ957OvOjHGHhyvuAiAleTc/L+vcjUw4UZyIbh1282PUM+AWQuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ePXsX/MG; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ePXsX/MG"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8819c83a8ecso519115b3a.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654591; x=1791259391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=bw9HHKMKd+J+kzVonBKBdT/ny/vr+xtwIkyZ6kdbcOZEg4mWyxKA0HjqttRL4H7iRu
         ivRNCvEg0J0AoIqw57VX1dNXuCPwxr7YzIJDfhS9y17eq7BUxJzKTg6BcnU/KEAt4bBa
         UWK7dXBfBGiGhKw6/OQOa6bb8hZq2P3zIITJNoOCU8SfRUp/IHxZxM8PE4eTdYWhiZde
         0ytjPpH+A3ge1FM+CwYPdhn5xV4owLDNvWqaiLJm81UC9C/mv1E6Q5dtZufjDnjQeS0g
         N16BXrJsBNmBD4gSK12+TmtDMnfAbn8CBsGvMeixev9vu6i3w7RHlQ4HAXcyG0pG5ve3
         ATvw==
X-Forwarded-Encrypted: i=1; AKwUvByV6mxFBwqiMcgcFXcdz0L0cJLiNHOuKHH/tX99GDu5SieswriG8WIY+rpiBTknsg6NsffjSmJdpZH9me0odA==@lists.linux.dev
X-Gm-Message-State: AFuF++kjNyUEakSZHTybHK8XiOqE6oeEUnY9YJTHJgZWHJx8LeC/GDjX
	b6yteos47/B/hqdjLroS0IqBhXWAGNncckbLWOlkCE/bI40j+x4eocHWbitmxgQ4vIkqQBaEdXs
	93LtEoCpjNzEy5og+t3ZL0wILHg4tUoNpI7T3wUp7v7tXCVnPlvUxlb/9dYWo37YeS8SnHMBvtb
	m+omQ1Yic2y/U+5SFeJaYXVmsgk7rLJs+ZuwyYcH8LPWGMgZ7TtY/KY80E3w99ohmrmN27Jt0SN
	pmaENbI51ph1NMstb0=
X-Gm-Gg: AYBFou3qXV8eNQobO3Enou/WBFXdvj2qgpxlwMT52yFeD6UiwGwP2gRmxEgopTMlrlQ
	U+boyKLd2LtCMIAJW84AaiLg+bxwkUOxkxw8jPJAfsgLwJHlO0VXQr8AFghF5totEi/lZXG/OEb
	QRFqbtVh6MqP/dE75OaNVbJ3n3KzqwKhCbKzU50w4wcN26BN0uC2tVi7Twsgfs0KyIHsPcj15Y6
	omhpf8jI/yzGVQxga9FD0/qmcSs8KzgRz97TTpKJ8D2QxLSgUp1nD+3SHeI2CfaZUVKvmkHE0pe
	iJYE4eavFpu9mP/FylHrAtUyR5ZNY/+TcyOLmHfk2ifMVKWsmA18w+RHrmVQnDmoqrF7cxMZIpm
	XO+bNe+yBd8TEfDya/q1d2enm0xNhVm4pNLN2dXMPd66gJ6g4DIthwHQ4/n94dZZXkczfHEO9/e
	+F0wZzhYKldGMLMQDoIIj4gk1DzJPa2IJL
X-Received: by 2002:a05:6a00:a228:b0:87d:dc3c:1b5e with SMTP id d2e1a72fcca58-87e9956d39amr12106845b3a.26.1790654591495;
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-885e183152csm75977b3a.3.2026.09.28.21.03.10
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33baaba6371so14196418eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654590; x=1791259390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=ePXsX/MGPztuO/POlhG3Nf6HZXmqPvMH6dFLOETOOepWuENl0jOO5ko9iiA/GMLIsm
         S77W4GVQP8KJc5g/G2DtXVsISlne8op86cN6Xxbd8njpOENDj8qHzmPfjN05I0nGjQkF
         NNUijL7HD6enfV5xtyUEBuig2DbKthPf44zAw=
X-Forwarded-Encrypted: i=1; AKwUvBxKK/mxMqbHMSlfaYXfEC4Ulcy8FnwYYHfXANBzNaaZuOIVmyTcSHVDzQEj9waCUaxFi05RnINNmHClByo+1w==@lists.linux.dev
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715259eec.14.1790654589504;
        Mon, 28 Sep 2026 21:03:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715216eec.14.1790654588762;
        Mon, 28 Sep 2026 21:03:08 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 1/6] percpu: Page-align decrypted data in UP kernels
Date: Tue, 29 Sep 2026 00:02:50 -0400
Message-ID: <20260929040256.543767-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Without SMP, DEFINE_PER_CPU_DECRYPTED() places variables in
.data..decrypted. Align both ends of that section so that changing a
variable's encryption attribute cannot expose unrelated kernel data.
Keep the section in permanent data, where UP variables are instantiated.

Fixes: 000f8870a47b ("vmlinux.lds.h: Fix placement of '.data..decrypted' section")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..64bc2bfdd2ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,10 +368,19 @@
 /*
  * .data section
  */
+#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#define DATA_DECRYPTED							\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..decrypted)						\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define DATA_DECRYPTED	*(.data..decrypted)
+#endif
+
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
-	*(.data..decrypted)						\
+	DATA_DECRYPTED							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
-- 
2.53.0

