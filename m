Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50722441625
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136771; cv=none; b=k7I+mIIjPqp7KTBjDJMc4Jgnw60qtSL7hvsMSQ8xBK1NcZQqwoi/adyUsb5/kNqrGQFoqXJFLAc0Fig8XHsh0ZNE5Q2ldTYKQrOxJmSdz+zicFiI3+ccHQgAQN4/bMHeHAPewbzMdK190mSzfxNezbcrJYcNria1/IbtgGKVSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136771; c=relaxed/simple;
	bh=0va3WFlSC6WHbkfOdYWUCNkm6pgNY44JTkg3gjhyJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ROW2ambuo+P3L7rwvupXfR5z+LosXSkqXXAS4S7uWTKKI8DDRTxpD6qCqoyEaw6bkYqwQnhSND6Cpt6BgpjSB7C+V5tlcwgLT0CV4BYhG+xnlDjBbNtoBL6pBJOytlkrmlFQ7CaTRMrwgCtQg9EpCEyU9C4owQHChSGTNo/ESzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+SG/022; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+SG/022"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f96c5b722so485966f8f.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 03:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787136768; x=1787741568; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bdVdt7FL/tihS7EYxxhgHwIGgHm7ch/dQjPbge2b/w=;
        b=j+SG/022Aqclo4E37uMQ3kg9Omwenn75n2gb3RCH2Fl3GxlZGkWNdp1CvYDLHBg+L6
         +j8A4ZiZGVTiyOUR5HkcTET/x7mBlYqBbnmXHYrRqjwlp0ssgRpogrHFprsNTXzmeHCO
         SUazZX4ZsxalBLoOAuwNct19ywhYsE4AeGSoNrihgMiNNFp5UP6zrZAIA7dwfphuhFJb
         PSkABb30hS0he4UFx2xWB5IDI/zAds5u+EOuwy0RKecFz4HX1JhxIkPXmhDUkBUkxTee
         3N6g231C/MlxwYvwauv4B1FZptj7eX+nEAZYOzOs9D5Co/0LnvAVCKo/ctJjR8fYkLe/
         tE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787136768; x=1787741568;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bdVdt7FL/tihS7EYxxhgHwIGgHm7ch/dQjPbge2b/w=;
        b=GzOvDyG+4RDLqapaliJnkZLRdsSrqkPyis8D8sAFdcOt5QBbQY/WeBMn1Fr6v8sFlb
         QqXrMaHpQGIJ9rOaNS+FegthjN+DraQM82nKmqCdo/lVeJB0ezLVCf05W98/4fZ/0hZz
         r8HSaeRt37TjBKObI+yM7DxAPFKHnt3DHbDRBgu/ZGc/aK0vEvZFmlprli4p1XA96QXi
         lwBYJY0tqLaVFgvWQqkuXT37edM9MJtSactH+B0fDHzn/S1QRsZ+Hk1TdGkK1c9jqR7f
         t0ujJfO4Kq5LVDWHf6rj29GyrqaqvTSR4zvnukdt7l1y0HmA1Q/hcgv7zSlLh6rKXhxe
         kvsQ==
X-Gm-Message-State: AFuF++nJVMrmTp3pFI7o7hKeQdnKlTkzacbq9Fh830Etc0wjWinpYym6
	x1zAcjVBD7eE8b40L7NHa7cJffrIM8vaX4JqQCuKQK42jAZA9kMPxxxw
X-Gm-Gg: AR+sD10CcqUJEIf+Rzr8VkZ3qJzr+lSgDW5OqPBuMRkVsBCHT/jyiOu6ZuJQ0WuL9Uq
	iaI0SYHYRIZ8TxO2iPKdtlb0mYq7hu2UDFFk3ybCeDQmQStZT5hL3JHNv8xlFW5uI5OfOXLrFI+
	G9DhnuavV1jyEcXjvFG+Q72Tsy+RcuEa20ID2tOU7I7kOhYSQ1+yyFucUmZckpzG5aLh1C6r5RM
	q1+jj1rwuXCIuu1TcynPSPdH75Y4tn85GnAFM+aFh1q1Pfe3BXWHDE6MrQISb2Pq+7Ka9OXRTGU
	4XCBOaaMr2KsTaUibqnGNz/sobr8jeJXL/gQesZxr5lz8qp5LDehna350tV3DQ91+va7SPJ4hBI
	yM5wI+TY2QbeBuwcCmFjZnEhefNywwx2suQM7MUIkP3s29O+kK/0A99cLzDc9OSIsr9kSAzM2tw
	VZea7d5PjuQxJPNi8AwL5Gv3FM+IostIsQ5/RqUIfjarretLPblj6VGq8bkk5M7zlQJmi1yADEy
	NbiIuZy1/FBDCGKgEIASVeV/AlSzCixu0uFSfsPyjh0lX7J
X-Received: by 2002:adf:e19c:0:b0:47f:9ac6:ca60 with SMTP id ffacd0b85a97d-482b1e1bc3dmr6597802f8f.0.1787136768341;
        Wed, 19 Aug 2026 03:52:48 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c46f2sm6091273f8f.29.2026.08.19.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:52:47 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:52:46 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_console: Put device on failure
Message-ID: <aoWK_qpSBeO6Bw0M@michalis-linux>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If dma_alloc_coherent() fails, the buffer is freed but not the
reference which is acquired before calling dma_alloc_coherent().
Fix by calling put_device in the error path.

Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")
Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 62eecfa61646..de83a8a61a8f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -451,18 +451,22 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
 		buf->buf = dma_alloc_coherent(buf->dev, buf_size, &buf->dma, gfp);
+		if (!buf->buf)
+			goto free_buf_and_put_dev;
 	} else {
 		buf->dev = NULL;
 		buf->buf = kmalloc(buf_size, gfp);
+		if (!buf->buf)
+			goto free_buf;
 	}
 
-	if (!buf->buf)
-		goto free_buf;
 	buf->len = 0;
 	buf->offset = 0;
 	buf->size = buf_size;
 	return buf;
 
+free_buf_and_put_dev:
+	put_device(buf->dev);
 free_buf:
 	kfree(buf);
 fail:
-- 
2.43.0

