Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640281990BD
	for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411807; cv=none; b=CnOaEcHqokx8m3RsZa178rFtwUJ/YPDzJUa1LkYY9HyXGyELsePKJYtsBhQ3mCV+T/Tqv6gbprOOuKhv1HOk/KM+5WTPzIn3rX6PjWnYQ+E7YfkcqmHpJQ+BlWrJ+S4Ln3xTR6+mDZZCcKT48N58NMeBN9EyZeA2AvDE6cnUNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411807; c=relaxed/simple;
	bh=hMJtabK1vX54uoCs62Uh1uKXB0G3C1rvDyjRxtrbzJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0bk2hnL81C547Hi+cDTdvsSfrLCv55oABgH+or/G6b2lbJ18ohMPCn+QzBz8b2ZG3B6LxzVTyqL7x3HcjmjTWASuaD057Z/+IG5zz2qI1hbMob1H48gUyAzSKnerqeXzID11EGqUwCR6ojprvB66aQObLzCn6f8SfxYGY405hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlZEGLVK; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlZEGLVK"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3990bbe22cso8902420276.1
        for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411804; x=1736016604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=BlZEGLVKjltdzsX/KWoK5Bfs1KxRUd26PTU6eveBkc0eMw9i/tAnTsbw6EQWbZ9a7S
         Dnoqal7XtTVTxDrEyac7EZvUUrqYo5qrGtUzyLiY3pQpTommBqmbnrG9cXG5/KtOV5ja
         yRVn58LBVWHBQHWD/Y+ckp/d5DRgFUvxZXbZHOsUgIRHAYrQWBBpJJo8CV77v92dvgMd
         NPDF0anmch1CVahx26DFatPFjikww6oX8hQBQvE3r0MLbEB+3Om3XXILV96aeXD/55nr
         UianhCDGSdgSgTLtRTPkHtClZ0kQi5hfcfT4uVVT3zwR+XAO3NPKHIpRX9Wnn769x69i
         5J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411804; x=1736016604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9g5yzfm32qCCSZ9hYX8RFrDFECwqUd1W8h8dBnaZOA=;
        b=UMH6au7eMqe0qir0a3hYWB4xGkS/Dv0QVzZ6cn2lqshrKkB09P+jS/Ks96lTbmwGPE
         /kYheFAadeh5ndggTWSZVAdsipS9vUD0H1CdAtCIfr2R31gEhBRMG1at3DkiZM1Sounf
         olC4svzddMKQpra4jwXlnyw159Zr8tzUYnBjQdym6t57RIb9o22IKLTMZiLTBcqmIr5y
         GDRhh/DdgmM7X7E3alVfQY0BrYZ0bKl6jSpdY0RZ6bKPxosikulg47LTAaJ3ytC657mD
         yravWSRdBLnCaQ1O43m4vQx8mdC9I4viMZ9xXkTOgTBd07fRfpMgAEaE2Ef+O9Itinus
         tFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvpaz1ILgjUn2rvNiU78zIzS/B7PhTPf7c8Qk/oIuhPp4fj/cIGzvBxaJIOeJoK9xZggc2Brw9HNIelw3jfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNP+xJdNhkDKRmbk7y6nTXlctwNdR2Xly4ohTggiA2hWtX10aV
	+My87uJAW2WNTpyWfF1a+DT8QkNPw+BQ9H4Zyv5KZWEJLbcBj4iC
X-Gm-Gg: ASbGncuZabJegxP5xkHlU9U5jtppjtsLdudSIf3Ntw8UatAlyiGKhszQu8SGzfA8r0u
	+Fy1cfchCcijx1rFdS58slaXiXhLWPCrbOjj6U/kgs5H/otyNjlVkOOGkXQ4OtgpKI2tRGRQ52f
	Q+5s7I8uTIkYexmSAOJYGPN15v5xUgt/iPQSKi8AkKxuZpFa7E9q8sCOfpv1UGqJZPjEEwZmtUJ
	VkBNfT17WDFiC8rwUAfnO1PX7KHjf+7EIwyoCGXSSo37X7aXJbo652ElxtSW9FrA+byk2sZmMBs
	XNJaMdyZWXiNjtWh
X-Google-Smtp-Source: AGHT+IFRAv4ES1nGe5GZzQSCr0JvuQEh3E1vBTb1UadMisfKYeWtlE6qWVQlRiPBMv3C59QKs6b8rQ==
X-Received: by 2002:a25:cc1:0:b0:e53:4d98:7459 with SMTP id 3f1490d57ef6-e538c3cfd9dmr14310782276.40.1735411804331;
        Sat, 28 Dec 2024 10:50:04 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cf73675sm5102193276.51.2024.12.28.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:50:03 -0800 (PST)
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
Subject: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Sat, 28 Dec 2024 10:49:38 -0800
Message-ID: <20241228184949.31582-7-yury.norov@gmail.com>
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

cpumask_next_wrap_old() has two additional parameters, comparing to it's
analogue in linux/find.h find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..18c9908d50c4 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search (i.e. return will be > @n)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
+			      const struct cpumask *src2p)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
+		small_cpumask_bits, n + 1);
+}
+
+/*
+ * cpumask_next_wrap - get the next cpu in *src, starting from
+ *			   @n and wrapping around, if needed
+ * @n: the cpu prior to the place to search
+ * @src: cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if no further cpus set in both.
+ */
+static __always_inline
+unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
+}
+
 /**
  * for_each_cpu - iterate over every cpu in a mask
  * @cpu: the (optionally unsigned) integer iterator
-- 
2.43.0

