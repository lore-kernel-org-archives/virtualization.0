Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891671BD4F7
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542274; cv=none; b=EnsuVDJlOjCf2seZPet+ACB17XtOWQ45kQ/cvitfe8RZfpY4IB12+zp1nhTlgwCQgnOixzgVqhqGzRuTHM40PxzOOczsiILn2vYCzcFB50Kruiibd3zZVTDB8/rtK4SE5qO+8xHdWnqBHXguBbpK2U6JE6c4y1ZdjUGTyJFSev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542274; c=relaxed/simple;
	bh=51fwn9UR6sLo33WSntk5b8fVMnu6/RCpawuylEc4EYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBqJZkHiyDm0zFZPkrvzH/ZczDZ9Ujbjnpbdbhkv6aJmdB7mV9UILf9XoshnbdI0LCKUkZt5w4XwicvYn+dOTbvw9IbUSzuvaCUGQq4p0ZAcybIAxiEO1kAHGFzsRh+YTaLWVNIL3Vyj1pq3ED2wPfuWX2Ng3sgIOlaOhwrbLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VaybhV0c; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaybhV0c"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so6395027a91.2
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751542272; x=1752147072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcCs7vej7EmjlOgqSL2DpUmA/zZePV2jjeUjmDVA2Io=;
        b=VaybhV0crHlnmaSNqJjkyuVUUGeTAtxKPVU1YWh4sw1Xh0lml/Cs665R+hB1t4yXBU
         6X2oI2IuDIxmXYRaxWjYBvXTiaCcNjTY9iww+ekwGbQhaA7kTf7r5jPCSbZx6SZovpC0
         bK8164/TPzr2Hn9JBFgwRsxG6/Lw5Tq6oSpVKag7kQ6vZ70YDwzCCV/MlCUnYr9iHC07
         6YWcPLN7S4RFffAABB+QT+sNOD3G90lNG2C3ChG4fqydLiiXZQPnrA65IMCPnB8I/Vjv
         k6rKhmM0l8St2qCxO9dIWt5BN2WzRtgYphAAkFEyH5lBVHHWD+zWZZblFFoPoVYo56Xh
         jKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542272; x=1752147072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcCs7vej7EmjlOgqSL2DpUmA/zZePV2jjeUjmDVA2Io=;
        b=WZUAemgH3T0c3wV6qOg8hbim1GBhVoTcmPmn4RPnRb9dBlDjbLa4s/UULSNen2tj0l
         3L37lu6aUk2ES3tzkx7MF+iLnGNpu7JnwqYD4irxAwB/Wcwb52R2yXlRrDKquc1DBpiL
         mpwZtveh/J8fmf36oqcAYul6rnvFpR3sCArTMohVVK+4aa1O0QkgusGpHVbdMbFfhJRS
         CLy+aimJrKOd8DaYnJONYFc/K87eGDWdxCHA3EZmeByYNys93kYhic06plp/8999KIoq
         Ty52xs7W3cXTGYUg7LvkTMdrnHHIF1PpoqEBV1OMsR3IKH2ZCoFOZ6mc11tHxtZ4TCRh
         yiqA==
X-Forwarded-Encrypted: i=1; AJvYcCWy/SOnLJZ03wAkXb1sfNUBtLlAI0x1EkdokMIcy6gftTuwuV8axC5LgWu0KQWAfOKjNQ3y1MenrTGmiOhJjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7lqF/JDZ5qZMmQs5wLFKyrAtbayEOjl35dNU2Tfe4rw83uwZ+
	WRg9lsztVozhT6iY20uRJr718a5wbT16RGyFrsRsU7SVKrTd8QqP1xtwnagpnyX1tG4=
X-Gm-Gg: ASbGnct8AN3piAEYpqhdMreUJnM2J4WCUgQi9XxJTDzoLqLSKu8xyc09Nh6esBITM7f
	IURHKtD9cbZbYcdV0JgTM/rb/ZpUOa0619ki0O7GQWNnuq8GuoUJBEJ81M93SPWHKseSmhQFmPi
	B5VlW+8CHePYmt4zLpntaErINnvk9xxFyEBftRX2tKxicq4pczF+gPqwV2YZkm712mNA/zmGel1
	EQYI5L1nwtCo0AW83Gx94HoEAfsbVxWi1tg96ZwnbocLD9b1cJ8EIcIwvZk0bZn5Hz31+wo50rW
	xS65gjMorwaGTD7CPLUNHwYYKRjnZszughNi7RB1/LqITVLl79J6jN/ZMfDk4Lw=
X-Google-Smtp-Source: AGHT+IFhAcA3OhH5rYHEhAy0zGIw//i/uHwlpC2u5oxSV4TXYQftB+zfMaEw/b96QQcNkfPz/Z4ybw==
X-Received: by 2002:a17:90b:524d:b0:311:baa0:89ca with SMTP id 98e67ed59e1d1-31a9dfaaff5mr2743821a91.34.1751542271841;
        Thu, 03 Jul 2025 04:31:11 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc65bc3sm2166551a91.14.2025.07.03.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:31:11 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: virtio: Avoid hang by using interruptible completion wait
Date: Thu,  3 Jul 2025 17:01:02 +0530
Message-Id: <b8944e9cab8eb959d888ae80add6f2a686159ba2.1751541962.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses wait_for_completion(), which can cause
the caller to hang indefinitely if the transfer never completes.

Switch to wait_for_completion_interruptible() so that the operation can
be interrupted by signals.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/i2c/busses/i2c-virtio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 2a351f961b89..c8c40ff9765d 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,15 +116,16 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		wait_for_completion(&req->completion);
-
-		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-			failed = true;
+		if (!failed) {
+			if (wait_for_completion_interruptible(&req->completion))
+				failed = true;
+			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+				failed = true;
+			else
+				j++;
+		}
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
-
-		if (!failed)
-			j++;
 	}
 
 	return j;
-- 
2.31.1.272.g89b43f80a514

