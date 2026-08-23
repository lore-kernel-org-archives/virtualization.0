Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD638DC43
	for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510111; cv=none; b=iKYgu4ngTs0+tBXeRd+8XJ5fBG+QUV29do+F4H8bsNPyXN3yt+Xh+CuGJs2dO/47ViqW7+pHEsn0D5x2DscPrW4Lzy8ts1hmfLuW5tXET6cEAyO0TLy37odkZD/19x80t5XPm9zLjjRf3vnty/SbBO/6Sfbx/A8q5hE9yKkcP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510111; c=relaxed/simple;
	bh=55H5C1Vn6kHJjAVaTokSUMg7w44PdxhSFTQ7W1a0KgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUJAvqpxHAVKqOBQH8C+wLq1MUeVJo2pSdik8cPzJcCsxjwO0RPhTZb97WXbsW4r7HP7I0cC444DWGlw379m1UyWyYUsDSmpaJR709ljgFaLO0buaETxMaTZVBfW3R3cvVw9KSyQj9HXspYGt+JQRAWPyHofQfGWsPofumoACX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eusv8ljC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eusv8ljC"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c167aa9500dso408479366b.3
        for <virtualization@lists.linux.dev>; Sun, 23 Aug 2026 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510108; x=1788114908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1CGqHxj1gYluvAoTnY/OZsvt6mzgTLD3jk4hAmnXP4=;
        b=eusv8ljCSlZDRdwxwLy0euOD21PxTpQx/yIdGgMaz/JGEMou72J7Q6FREmj3ipJu+b
         SiIFsmSCVr2zGBfL/ALHJISqigTF5ojGehuRcrPwKaONSKLM26X5Fr15A80+1MwrhOO1
         ZxWPw/6LC7F7sCAfF6eRcLn4rAdx800Sv7GLbzQkuEQMLakhFtgtDPJyL6S/NbzsB7a4
         a5X6szrCYW6lVtt2VykHXJTzTurpbmkQci+UupButuXhOZIrKNl3hbQKa9A+fWdGomX2
         AMkJ1czTUdMbdD+995X8jFuF7JMvEcRMiRxL8pyK8FJGtg04w1w959jab0a4TttsQLW1
         Zw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510108; x=1788114908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1CGqHxj1gYluvAoTnY/OZsvt6mzgTLD3jk4hAmnXP4=;
        b=Pf8LR2ShA4tUzVFChIotYE9wDAdX2Tg7wl/MXyFod915ma05Y8EHLRt+87QLMe9Rdn
         Yv5d/HPhGJUuydUaV3XEqw4Dkw73PUGfz6bi+DSw+TunNhl9yWAb1za7GcS6OpBVSyS/
         pMsimHZmbDpPzdNzZko2wM15K17NbYNuxEG9JNynFdL/0NY+MawHsRMFaat4c9SguSBf
         FrMby1HKLnBlJo2JDIZ2+mfmIR5uMZsquEfBX7q0osPdV713AM2ml1s0bO6u24aratNF
         ufHeLH2D/ScWBz6b9uvrYXyz40VLJf7YHvjcRt2u7CxCfenw241kMKX+OUiNsjKVxRxs
         uptg==
X-Gm-Message-State: AFuF++m9UBTvoG57On7QuKWaQkiIi+PFFfmZPXvVQnN1wiJ1JwXFg8gi
	d2uXlbxRZ/iAp+1/ZvVGrm53IrJAjyGCNLbHhgZ6VRyPZPHmuGN8lng3
X-Gm-Gg: AR+sD11Nzjv3fewNXAkzNZRcOcPpjcDxMYpKC8Qvqtj/y8tsqyZ96W5EvfVZtJGjCqn
	VUoX3+GY9s0AlYbLGBzTWuvow1+Dj/1zqTpJ6UEVdOErzXRiFEHZPQQJwuCfbMaELMVMkR/aFqC
	9wsnDL2/1QfZ5ELXwxp7ruhhRE2ufmbhG1aoe2OjuN3h3WLQgsCV9R69HZ704uvxGP/mzm3wska
	/D/EMJXChfgoYOQq1Kvjc6E32zYKdTRVyLQoVh2QetsuANeQqBXeR9nafvSoCmI8pXburrinTKM
	2U5a+zsd3eNaQJfImvl1Qf6blQOb/+HTgIlhYvV6W7rioye1bB8Ly8ojRiUIyjA6b7HcGftVNFD
	J6ssY2mVMplCJ9jqnk4amjT27Ek4UxGK1KSWZNH2jts2ocojZLCdbnKTLQNwJChVYJsNOziiE38
	xZIhvUMnqGOP0Kxq/9QuOJPBunwTodmQbdE6h5Wp3pAD194PqfCVQVPRU4Py3fYAxmHKWLJnig+
	REjAfVIXFboyg8ciGdu6iqxPeOC5cc810qdFsO9+MIpvUCE3qH+oywODLoBtYf4RA==
X-Received: by 2002:a17:906:b286:b0:c21:752f:c44e with SMTP id a640c23a62f3a-c246a67492cmr1878483566b.16.1787510108329;
        Sun, 23 Aug 2026 11:35:08 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:07 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 2/3] pciehp: add disconnect_work work_struct
Date: Sun, 23 Aug 2026 18:34:54 +0000
Message-ID: <20260823183458.982699-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260823183458.982699-1-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- This work_struct is used to dispatch disconnect events directly from the pciehp_isr, as we cannot wait in pciehp_isr

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/hotplug/pciehp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..c8ceb9320e2e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -116,6 +116,7 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+	struct work_struct disconnect_work;
 };
 
 /**
-- 
2.51.1

