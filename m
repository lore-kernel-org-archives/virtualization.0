Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25551DFDA2
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082823; cv=none; b=gDXpYy8Xdv6FgmIe/QTONQjyMumnh9snX4b/3XRZJXv9B6MjsC9KCC+uwRnS/CuUxTXkBa50DVkCAblbP3kIwVSAxXHHGSQQSP4ZzICNxaCxgv6jL2WbsxtJO8UJYgsARaHi9soh7+wvoIAMKvssLNRwSgznhEFKnVAvA7zDBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082823; c=relaxed/simple;
	bh=3Nw6u6TcLstz84UwM+gUpBPEmbRa4zVJY8ONgf+AwsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSodrBO7wUU8MMBnzDDgQ8O5zQcCaxu06VVJmCICdBZJa6tYuvrQokHLGfG4z0qt8rIdX/K5nqdahid0quFQUb45Jrq5ln3vmiAbijzUvS9FLHj+/LIj33wIwTlLwDAgaaoBL3u8vjHPjzyHBhyKBCI/OLo7m0Qfqa3ESfzL288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy6p/Pgv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy6p/Pgv"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so8132105276.2
        for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082821; x=1738687621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=Jy6p/PgvVeCDM+mcW250nO9pPhyX9Ctd7ntvY6CTZjv9ZFgd3Dg2LES/0geDcCNbFf
         szLKD7T6WDPnZUOAFQHd8ayJGz+DgTgtFgF+yIqjcoFiOhicKQyjZhX5trrgjI2iNOJE
         RnsELEiZRy0XRvTupqBLadJtlCvN6SAdk2f/QgZm6nJIAXgy+Zv9kEnlarKMOBmfyFJ3
         Yk5YbVjJw9NQ90fCL8u7Izo9ERLCyzZy/Ug/BLLewIXjMKBTALvuE9igaXedvr1+9Xqu
         V5OgwiL8MgOIk33lKQFqMFrD6g7NJiEuu2LNzdJv/k6CO91yQznPMrkzRjO6AwQDWrEw
         EEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082821; x=1738687621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPo0Qmhd/LgFOJoY/TurPrp2onCgGxY+Z0rc3zytFz4=;
        b=vKbzWoUEB5ST+F8sIt70QtC7Qn5pI1FsG8Urova9d+dGp3KtcSlzsX5IuMHCiY2xh8
         XrI3utjSj16rRtRvkfprXK2CXteIKZWSZQ4LJUHbF36W3DGmsrkKxSdsacyt7xbyo/QS
         qCC4NOQxqCzW2CP0C+ulGAwsCy8LwoYVmNDdYrLSUVpoZzwaLW2R/TdzVNbCbeCGD+ER
         IlXcOIr442z5a5bz4Yc4akF+fWe8t/GO5H464XiUlgVunpUYwaho+xK1gDJlpvtoG8Nh
         eKca+SmW/DgyEZwsirp+chMbF/L2EcQ9yS+DKRaxtrLfyTbLJE1WQ4HXw7mx91nLxBH/
         +1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVVV+1c/sX1P08VNrSayAXnFPZDlqN1rNRO6M/+IcoXksJ0OsaLEnYHB8P/Llbf4sP3/e/HPijMvrN60Tcvjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNCf8reTnUTwWGH8IAO9UJmm3+Yf8L51RJIKRrzZbnhhMWUX4G
	YnSOk9zQl+N8eTK76w3tl/HXkxOUiy9ClaZK8SUfRtrmpFED7Rnx+6O3s6t1SOk=
X-Gm-Gg: ASbGncu5O2ehQt/u5L1gGjOQlDrgNMcoQGC+55zCAuEtbY1puARQSwrXji4iJprQgx3
	uDtf5Xi3tzvD6qjTv6RoSfIruYK+VVuIqBmYzBjE/Vs3B2H/yxPmJr4fB5IghiIjT3da5Fs4xdH
	ArrNzGsHqim66aGsCor70uWGw+L5cefsLCgidgwALZ7liIcWU9MGmQlKwgNtXWrEcIOBQBOoO7S
	+oEOWGbHpYiUmpBL5Pu6tAdeKgTUBLv+TH4ghuVyQq0jgJcxaXaDKpXZJEsMijSGeSApwJtfQyf
	qI5ePPTrdN+wH71Llg2G5D8mAZQTTR5Kgy2kJTL1q+R0OkuUUvE=
X-Google-Smtp-Source: AGHT+IEbCDwztaXs4775wdhVhgVxaydy6EUMlQBUSRYIasXW3lx4ypNqxsjWkznwG36W84zpcNPfgw==
X-Received: by 2002:a05:6902:982:b0:e58:306f:e83a with SMTP id 3f1490d57ef6-e58306fe89cmr14077851276.29.1738082820769;
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e589a2260a9sm196205276.37.2025.01.28.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:47:00 -0800 (PST)
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
Cc: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 06/13] cpumask: re-introduce cpumask_next{,_and}_wrap()
Date: Tue, 28 Jan 2025 11:46:35 -0500
Message-ID: <20250128164646.4009-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_next_wrap_old() has two additional parameters, comparing to its
generic counterpart find_next_bit_wrap(). The reason for that is
historical.

Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
iterator. Now that the iterator is an alias to generic
for_each_set_bit_wrap(), the additional parameters aren't used and may
confuse readers.

All existing users call cpumask_next_wrap() in a way that makes it
possible to turn it to straight and simple alias to find_next_bit_wrap().

In a couple of places kernel users opencode missing cpumask_next_and_wrap().
Add it as well.

CC: Alexander Gordeev <agordeev@linux.ibm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index b267a4f6a917..4f3d8d66e86e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -284,6 +284,44 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
+ *			   @n+1. If nothing found, wrap around and start from
+ *			   the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src1p: the first cpumask pointer
+ * @src2p: the second cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src1p & @src2p is empty.
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
+/**
+ * cpumask_next_wrap - get the next cpu in *src, starting from @n+1. If nothing
+ *		       found, wrap around and start from the beginning
+ * @n: the cpu prior to the place to search (i.e. search starts from @n+1)
+ * @src: cpumask pointer
+ *
+ * Return: next set bit, wrapped if needed, or >= nr_cpu_ids if @src is empty.
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

