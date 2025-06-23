Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642101DE4E6
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661609; cv=none; b=kdFOUVW8R7WDEbTkP8Zi/x97Z+0kJ7xZ7kuCTRvksyPyoaU5ymRO9RZNIWmG4lhI58XNkVaS1MxC+mBApO3b+M7UlGh0IpbPwdlBUo1E//kyUOiwVODBJoCuW7tc14Kf/AdPG6/riDFZniqKY3BTLSp4fSc9knx/446+Zgc9RRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661609; c=relaxed/simple;
	bh=dxcNVwVR6Zx8dDzqw0191eOni0v4TAMtcuUZqOOJYXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHICiPeep+J5yhuIaHwc4cm8oDiqwDgW5qfOc8XCFo3A/vebskmseW7Zcap5DsWAIZaxDtpgfBdn2ApbwaB7FyssUlLbWQBwwWw37yh01q/GYBaJ0Ik9dOa9ahyo7m0jGww72gnU9BSKpajezP9D4mTXd6yybVh59QsT3ZN5n/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GQn21RFN; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GQn21RFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750661578;
	bh=N+KIcwSpqGH09ADYNXYDxVtm3i8+dNv2dHZVtLlc6nQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GQn21RFNWuMIIxXgtzbMkDBjWlEsndqJHXascEA6RO3k2kuYEWCSjY83gxDl23EGm
	 yYcRf+v4etFOdUnOh6MbdkWM0dNDKXZWn4QBkQ6Wg8EDqiSBZ1BI/y6a8NajVnuXbQ
	 4PQYPqqyoypko0zhfPVE3IeGTzR/e9+uEBN1a/3c=
X-QQ-mid: zesmtpip2t1750661534t7ac3a094
X-QQ-Originating-IP: hyjulawz/JNwhhcU+rOyNTg6JWsTXInQ6W1QxfqTaxU=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 14:52:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1313754082888159779
EX-QQ-RecipientCnt: 10
From: WangYuli <wangyuli@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] virtio: virtio_dma_buf: fix missing parameter documentation
Date: Mon, 23 Jun 2025 14:52:10 +0800
Message-ID: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N9ZQ1suYlCRbhmnacNNpHexZYAKF/D+poCgndJbKlS1y9zdpWyNTZ4z+
	gZcPi/GrfEz1+ZCfZdOIhZUmIUuOvEoAdk2lUfUDTZmyc1R06HkDDcN8N2ccYOI7JLTx0Qy
	65SQczWJfpwkgVC1mPFsun2sZYP0STTeR5EeFHX/RbshXgL9gsZ8r3WpxC5je008lJYpkMO
	9JBwux2CQXoJ57zsHqESLBoOtN4PlkNUkkkqHiGGplaScTbMeKEpc//BPwpht44rg+4jwUJ
	E/uC74By5ywMPCgOGt/6PJpwe8jllm5hH8/6b36eZXQvcEBpazTE8laPSlHKXgTi3kNK33O
	0Hn4jKZAsmEE6Bn+MV1QktvNlauaJJzBksypHFEjlPve5mKQxn1oDK0ab2L2Hr55upXK6Ph
	aercUuzM9kEGTQ/+SL9/64lMqV9UgUWPRYU84G5tNOaZn4TFT3nZQjvwKgsHkWngL/rrfp0
	4nig+PMc5dxnDUOx3Y+BQDWvEajR0+GrhO1YHNQF28luUZkadtHFB0Lfit1cxWCQYP8rmzO
	32O0Lef39m38WkBCLizvLPuigiA0FhlUiQr5txX8qhAuvaQuGV6dEY4ssjYpkXdJvfp5oOE
	ulm3FRmha4Ee1hE3L6Uh/btvB2cIy4pvSTEuhZkC83GSPhjVtKTt6tW7wg7QiTIvnk6+vB6
	FqPSP6yhoCS025ls6txOIzCbzFXJK6JR3IimZI3dK/Ms3HN2cFAMkkO0z0nrfzexTemW31d
	zk+FP2xJcSkXkcF0oHy0Zd3tmtic8VnkzxRdRTC1ZWyjMRGBVQLKRxVJ/oqWMAAUyz+1UjV
	g8h1GPV0kcMKgeLJnTv5tZeIDGtyYh9GyiPSw9Q/ZpD6h61E6fWp9n/75FOFK7IsGDgmpwN
	AMBpXIvXiBJPZxSZq2Q0g8xfKOJuWyY+WAq17G7THECR5s2ZUwUTc3abMr+JSceWHt5yZfH
	rvKIixvrVz+1SqFilQZ3iS2M5SrHC/lQhxqUxk/HPCQr3xRqv64OSoU7kY5ReduaaV9+CKL
	j7/MwAjRy6hOrJohI+FSkkC7nacjCv46hr0eqi6w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add missing parameter documentation for virtio_dma_buf_attach()
function to fix kernel-doc warnings:

Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'

The function documentation was missing descriptions for both the
'dma_buf' and 'attach' parameters. Add proper parameter documentation
following kernel-doc format.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/virtio/virtio_dma_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
index 3fe1d03b0645..95c10632f84a 100644
--- a/drivers/virtio/virtio_dma_buf.c
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -36,6 +36,8 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
 
 /**
  * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
+ * @dma_buf: [in] buffer to attach
+ * @attach: [in] attachment structure
  */
 int virtio_dma_buf_attach(struct dma_buf *dma_buf,
 			  struct dma_buf_attachment *attach)
-- 
2.50.0

