Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8489381EB3
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873371; cv=none; b=hsrY10btpm3uxjBHkjeP+/Sf8bnpmHYCnY8wqSyRBRNmFizYMN6M2ykD4OcW4mkGoAqRcCo25i1baVoDiYU23TEVB+5V4Oilq1mCUa9UhYQj3etNOpJHPGb65xh1bzeTLNTQ+8NhS5wn7GMtB/q7lnknJoPsd3yUl0xi5A2noYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873371; c=relaxed/simple;
	bh=Yv76Uc6eNIRwoHRE5OWMEIz+p5C5RfrnI2mMnfhCH1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnwYtNaBZD4E908yrKqmkMkjJoMHt9K2cJdysjjvY9i9H81cOIU45MDXlB5+2kYXItq1VSmgfjVNFPSuoJieRU8GoPpFg2mtPX6s7NpRpNqcnBtnrJfvgO+SGK4OoQzy7R/Hyg30n7/VRZcL43PjStUonQzSSaScS4Zuc464Jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3pTZazQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3pTZazQ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso45170b3a.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784873369; x=1785478169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SdJQwjXICAfEV1ZszzabJCCVlp1hRyGFUjJs/6dLPw=;
        b=N3pTZazQI3ERwrymlz1uQ60wiLbzkR+TCeeri22tExVoGa2bgY63ckTG03eScbF9yz
         NwzV+exm2jQtu+BlRvZuHfVoA/OQjlW+0mWoafF4DAvz8EUh4vuCH9hH2O1wagDa4jVJ
         ES5ywWaiTlSPDNqXaHZ5tivbbvpMd0zOo4aqyu6S+Xp3Wy27c8snoRTiyhZC2hBleir0
         zDzPzmlbXB0TgkT46yQllvt9/ryvPRRwWEWJVgtHuxh5IT1DIvcXdrhGX9F0Di5E/UOO
         G4oR2H0Ku1PbRLjwtFIXu2i6j93ySmXX9bXh1VKyPTiikIg9VvA1rthl5urHSOMXNlb5
         ihvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784873369; x=1785478169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SdJQwjXICAfEV1ZszzabJCCVlp1hRyGFUjJs/6dLPw=;
        b=YYWTUHj2+qD4GuJqQFJcOb97z4xPg5BlB7aG4Ah3Z76VeOIpillgrUK8A4yiqclhLp
         ukkBKsEHXQuJQPaq0xgv9VTFED9d8RKo5CE/Yx/F3UdhJ/DMNs2mAweMUjls/x8EAi4e
         6NcLCrP+2EozvGIgtMPBnuOU0SWtOK2UBD0BbWMJKFRfKBIKU7KPLLfJzhlxrP19T13z
         qYVYtNn0PNc8Piimry4PyQkOi7ICBnyuHvl3GXjCuHua37n1qOLuEydj51kiVkC6FSav
         iwBKxVs3GSpw5/LFWEUXiNlFUlgFxDi830VF9Dld8QOA4QV4xzIfaTMmaA4Un67MoYVj
         SW9w==
X-Forwarded-Encrypted: i=1; AHgh+Rq9By7Fvubd2lfMgn4tgaeUThk4CYndWtyT+fOcF53DA1jFYaJQMLWCcMMvHOe11VP5++XzhxzV7iHs9e8dqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG6qMDgK1g2unaKHBL/1IWLCh4IXeDagAdoClbJhK/7ijnrjLZ
	3tFRyRpTg/jeWkh4BBenVnavK6fAgqAKUZXUKZLF4PWUqe6QA9BP812r
X-Gm-Gg: AR+sD10N8BSkPmOVHktZgvuyx+aLfFetVG+r/F/GHnBUivw1+oRZKM5a25mMqkeUgWJ
	gpePAjCvZj3nYZfgw6LNiZCgN+xRjWBsY9sd5HuiNyjQxZ3uu+2LNQl3GFzpXYbeOnQYf8oIbOo
	kUqTmIhBpgNOqCA0JbyBDifak1Y5P6Y8IIKMWf3hUNBm1O7GQzuEbdxTX+Rk+/amoXNkv9DgZ78
	kf4IMDC9bzDEhO7jf+bKO+2sldPKHNnRudhSI7/uDLaC78+Lwmn3oDkypuVO4LLkOiRG4YNLoUn
	hxmlAd5nUypppmc5VwJbu6WEqZkGru5LWJ6+kcf4o2QvMohNehyfGXS0VYBYOMo9ljkfC2VEqGu
	N7nsqbgJ/Fs0+Er0DPi2biw/qP2KpMFP7Lh9nAW89KQGXb2M5V/j7HPi8MInRwmpK3ojXHN0s9L
	kIYKwA
X-Received: by 2002:a05:6a00:2d2a:b0:848:63fb:fda5 with SMTP id d2e1a72fcca58-84e2c1b9f89mr6544139b3a.41.1784873368593;
        Thu, 23 Jul 2026 23:09:28 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm4133451b3a.27.2026.07.23.23.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:09:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Fri, 24 Jul 2026 14:09:19 +0800
Message-Id: <20260724060919.1569170-1-physicalmtea@gmail.com>
In-Reply-To: <20260721073639.1532488-1-physicalmtea@gmail.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi translates guest response descriptors into userspace iovecs
when commands are submitted.  Target-core completes those commands
asynchronously, so VHOST_SET_MEM_TABLE can replace the memory table while
an in-flight command still retains response iovecs translated through the
old table.

If the old mapping is reused after VHOST_SET_MEM_TABLE returns, command
completion can write the response to an unrelated userspace object.

Flush the vhost-scsi backend after vhost_dev_ioctl() handles a device
ioctl.  This waits for in-flight commands that can still use the old
response iovecs before the ioctl returns.

Changes in v2:
- Shorten the changelog and remove investigation details.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..c3e8f1a0b2d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		/* TODO: flush backend after dev ioctl. */
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
+		else
+			vhost_scsi_flush(vs);
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}
 }
-- 
2.43.0

