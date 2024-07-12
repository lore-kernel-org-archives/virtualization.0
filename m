Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3509171075
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793177; cv=none; b=rfIBNv132FPFYb1QSC2e7PwAeylJzlJ6holMqBkv2hpSx0wlM0+kfCGXfI6Q4tFr5NmOe5mlzyxbZhvQ79WxfW+Ooc4IoOuQJ5VKL/yr08uzgQzSuwtQxqKMV2eJ+4H12FV3cZ3Qnsnx6zx6maxRZmO6f2NKcCccZoW1yg1N67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793177; c=relaxed/simple;
	bh=N06X/eoY1Uebyo+0qwaEwr0aawks/J5+fGM4g2wyaBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUDpBfarOUGKUh49Bmudp/yQzB2Io6255VbGb3eiJq+dytVL7gXowK7W/r2S04/4QJNaSbPoF2TcXZEZy/3J+MAH8hve7+zaiRRBVnszrIa0dN0w/NCo+B9r7g3k43/ITHMVnlbj1O3uRhK+zPmP2HsDVL5nPrw7IeReaOqid9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t92oBtBl; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t92oBtBl"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e04a7d9f1so995724fac.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793175; x=1721397975; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvGeMLuAwhrzJn9gtgYIG8cYNqHlo6tU2+mQF6lF0yw=;
        b=t92oBtBlADQEm92DlygTX4DqoJlTc9fUc2d1U9xMh+bltWCF6kLnhV82IgWS6qkazZ
         YrhstGN57/1StcwS0qlcPtl+N2A5NzFWORuu+go/nAMh1XwPGki06e443ZQ7AQ1QR41r
         SZzZGr0HEapwLXskXZ7cgltznJlNeT1N7me+/n4hOUU77hW9eWlWXwg4wRZ/kftMbNGJ
         sd0DR5WDvSsEWFF8xUSWMJNyr8yymVCmGSujSv8TwiryYQlzWeLDKuReGUPFcu741YyQ
         zRA0vC/JBkQY1CuWYgleBVAFNc2n5Vh9H8Ge4iz4c3d6OzMDiH4hJGdhM4S2gu0W+2Ow
         jVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793175; x=1721397975;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvGeMLuAwhrzJn9gtgYIG8cYNqHlo6tU2+mQF6lF0yw=;
        b=CbHCSsqE3WLFihOv77cd6HjimQMH5DU/PbYxoTM8n5HpqfbkqgZv6xD+oWQn1VbHhp
         GWrLDzz0uikVBjPPAqVFPrfv1EkhXCwUOV/0AjZ9rW6y2JaMPkys9iIkoVcecCpQw97U
         b/80Ievo9hT4UUAprzr4GwAzgXCaHxrUBnWIdb+Ga4iM4Z8uyoNFezQ/kgs1SFNcn2aH
         0kAaeBrOmKroDlvU5qBbDjcyfy0jAxYdUXUtRaibTGJG3uVFF3qhmGyMLdw35bpk7btM
         BViX4aVjLtgFtnLVCMWaSETd+4OYxMGVbM6O1CMQTQ2oV3aigUKlgp6cSV+PoaslPRWE
         9hfA==
X-Forwarded-Encrypted: i=1; AJvYcCVALK8qQ2vFwfm9IqyZx7McSQjYrojQWDGjrqXaPOWQLWM3F6/4Sf0WFvjSoKTA/hkqzZvly+wO7gIgx1V6MaR201AHlvmtXI8C7UXiBS8=
X-Gm-Message-State: AOJu0YzZBpLWqgs7cuf4wvzR7hLEW+8AtFaDpj9uvNTUKJhWfmBaYH89
	AUHVrEetq7EKLNO5PbRAu9+BYS6KgO6lH9tXVtTH+xs9reBpsJLBoPJpO2afnEY=
X-Google-Smtp-Source: AGHT+IHtlDnTv4HuxsnriRgYqH4/N/EK8AvwLk/fKhC8ywuVcO8avOC/Y0CnrzNEReTN5UcGHI/41w==
X-Received: by 2002:a05:6870:a353:b0:25e:2923:a373 with SMTP id 586e51a60fabf-25eae7a3377mr9210983fac.15.1720793174935;
        Fri, 12 Jul 2024 07:06:14 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa5afa68sm2180190fac.28.2024.07.12.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:06:14 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:06:12 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srujana Challa <schalla@marvell.com>
Cc: vattunuru@marvell.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] vdpa/octeon_ep: Fix error code in octep_process_mbox()
Message-ID: <623e885b-1a05-479e-ab97-01bcf10bf5b8@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -EINVAL for invalid signatures.  Don't return success.

Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Nag mode: When we add a new driver, then could we use the patch prefix for the
driver not for the subsystem only.

 BAD: net: add driver for abc123
GOOD: net/abc123: add driver for abc123

 drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index 7fa0491bb201..11bd76ae18cf 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -140,7 +140,7 @@ static int octep_process_mbox(struct octep_hw *oct_hw, u16 id, u16 qid, void *bu
 	val = octep_read_sig(mbox);
 	if ((val & 0xFFFF) != MBOX_RSP_SIG) {
 		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d response\n", id);
-		return ret;
+		return -EINVAL;
 	}
 
 	val = octep_read_sts(mbox);
-- 
2.43.0

