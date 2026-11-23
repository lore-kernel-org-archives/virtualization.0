Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429440;
	b=NIOh5W0mG+tYZluXNrzsvSveIRceM+0YFirZh1uf9rLn3aXfGcz4symUmaiSRQ43/H+q
	 Squ/gsT5gtrmfHlWAdmmXR0VWAG/fMam27G+pOiP0Faz2pDH+PHk9XS8U2OmEhaneKw6q
	 yS4dYN9MqXXl2DT5BHNYixy826OXZEwWXlSI4oFncROqEKjDpfwLP6AeJwKJGuzrk20lT
	 R3/4nidBlJ9dInnIP7P6oTlWzNsekicfjdGWFR5X8BeudxdLyaRrTdFqWjk02DHWmAg35
	 7w7446J1VWIirSDX+I050V8GAi1FDPUa+i+DGQ+BAbUXBoOmSsKcDQ6gs4rxjrqTbtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429440;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=DM8Z2kkd5DMvAM3LbwImu0YAsjyghgKUS0c1QBqKji4=;
	b=GFFDTKCYLAWNKT97/zAnrwrDPXizZwUccOCKm/YcFY/0tTdZl5Nm1JdE16fvqiBD0ZaX
	 O1swOzQ7JjzSZfXMGwHg5MhkhmM3Yr7QhGhw6HUa9VR9L00+aYJ4AzDHIoSyfgXJeTZuW
	 KMPYTmKWfDDPheRG1vCTgEBfKiQCiLTNDqQrzG/hc5urm/4H9vOKtyXGFjsiXwPGeWb7y
	 XWU2VGMAUGplFa4O8vo3Z1uqRQZ6dN7ywss+WcgpIIA75GMOiuXk5wLDKWe6QIKFN5Ht1
	 tc35N4/A/sEN5u5otMskCy2dX6BNj7X9wp5OC7XkfVHbfoOMjP0x0gPm2nuK1xwEnTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Wr6Thzmg;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75815606A331
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 10:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75815606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Wr6Thzmg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DM
	8Z2kkd5DMvAM3LbwImu0YAsjyghgKUS0c1QBqKji4=; b=Wr6ThzmgCtYuIO+LZa
	v9x9o0A/NiTJeEbNjJV731shWDzIuXXJTfrwPE9oojEum82BJg5WUCMHf+D1bj5d
	TKou8N4yw1904yBs4CVDDKSF1JrhOFk25TKOz/trzZxi+0pEeAD7kJSXFZJBNbyt
	pJSHIkJflZ4mD24jDnheJBrxs=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3f3UZFARri_WlJg--.18020S2;
	Mon, 23 Nov 2026 18:23:22 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_console: drop device reference when DMA allocation fails
Date: Mon, 23 Nov 2026 18:23:21 +0800
Message-ID: <20261123102321.8605-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3UZFARri_WlJg--.18020S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4fZFW8Ar4kGrW5uF48WFg_yoWkJFg_C3
	48Zry7ZrykAF48Zw4UtF1SvrWI9a4fZrykZF15tFWfA34agFsxX3WxZr9YgF13Jw4DAryj
	ya98Aa13Aw17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUecyCJUUUUU==
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RrmN2sEFBrbkQAA3N

alloc_buf() takes a device reference before dma_alloc_coherent(), but its
failure label only frees the buffer:

  get_device() -> dma_alloc_coherent() fails -> kfree(buf)
                -> device reference is permanently leaked

Release the reference on the failure path as free_buf() does on success.

Found by LLM-assisted static analysis. Build tested with allmodconfig;
no runtime fault-injection test.

Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 drivers/char/virtio_console.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b1b1aaf43..ef942c0df 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -464,6 +464,8 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	return buf;
 
 free_buf:
+	if (buf->dev)
+		put_device(buf->dev);
 	kfree(buf);
 fail:
 	return NULL;

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

