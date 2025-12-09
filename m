Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE612E1DC
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246993; cv=none; b=RtcmR1xVOeGFTEmfXdIseOBEw+6U4gQsLWurBaug2xDBsOmdIkDw2K10e4QxDzKXJ1/snhgYCGwcO4YFdkGB88CWjFSuAIgOTxx3K/C3mmtBRNw2GyMk3AQEWiIbTAL6KPBQNdkyvaG9di7HI2kezeYjnJOqqUjgoF16DKo13HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246993; c=relaxed/simple;
	bh=7uEZlY08pApLqncxFus98l7GN5XvIf15qCw1fmPb8g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Us8KKhiahNXGbGpRr4w0YFcqeX1NW1M6mP7rzFRZwh2v1zDQMUM1nkSQkI5EfYjaNmXHc6FFegp/t+B4LGx1HFuzAjwcB1Q8s6zhuGnsjeGTL3W7G/YZkopzKYvChJjEia4KkaBTdEXAInXxIokmMxDBYIR7nWU/Mc54ciTeRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxF9EMiDdpvIIsAA--.30497S3;
	Tue, 09 Dec 2025 10:23:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxdOQDiDdpykFHAQ--.59037S5;
	Tue, 09 Dec 2025 10:23:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Gonglei <arei.gonglei@huawei.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] crypto: virtio: Replace package id with numa node id
Date: Tue,  9 Dec 2025 10:22:51 +0800
Message-Id: <20251209022258.4183415-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251209022258.4183415-1-maobibo@loongson.cn>
References: <20251209022258.4183415-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQDiDdpykFHAQ--.59037S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With multiple virtio crypto devices supported with different NUMA
nodes, when crypto session is created, it will search virtio crypto
device with the same numa node of current CPU.

Here API topology_physical_package_id() is replaced with cpu_to_node()
since package id is physical concept, and one package id have multiple
memory numa id.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 19c934af3df6..e559bdadf4f9 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -135,7 +135,7 @@ static inline int virtio_crypto_get_current_node(void)
 	int cpu, node;
 
 	cpu = get_cpu();
-	node = topology_physical_package_id(cpu);
+	node = cpu_to_node(cpu);
 	put_cpu();
 
 	return node;
-- 
2.39.3

