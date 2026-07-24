Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F5286D5E
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862702; cv=none; b=bpbQQ23S51aNL/QTGzHniltfDLOmGFKTkSpqg+8vZ0BeEV9w7N88n81wdt6flQIIuIB3rep7xLhU1FPYfi+2mrdv3H53TLZt3waR/QKPnsGudrCNYyHzHdSCAfr2c+h+3ROYDpZFwQn15IOBh61n0HQ8P+lTDNGH70cokkUE+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862702; c=relaxed/simple;
	bh=XZ5/m91mCKFWBUm41FXN6jdoeDBSlCrXG6RIqmllwTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aq0YD1F7QZP5Iv2yMDuF2cuXUAciGj76FiteqxAqsZBmPm/zfKnuHwHmzeqpi1vE6d3jmVek3kIQtmxByzfI1iOBfhjg2uGwJ12bWlNskJj+nzKA4JVCGQ3Re7N1k61x0SQH7FKD5RmYokMWacaZp4TgPca3nQTDvNO4FzJPZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFGl72Be; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFGl72Be"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso16096255ad.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784862700; x=1785467500; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XZ5/m91mCKFWBUm41FXN6jdoeDBSlCrXG6RIqmllwTs=;
        b=tFGl72BeyYV8Ata39OOoRYi4Ah10vklok3kooevCNOLvuk/h1+n+MpXTolnKMoLGff
         DQlgAnQGYkJJuq1zZEC97xyPOnNxjIrQgsnN3uBCZ0x4i9PEqBC7bxZ4e2Py9jhqTpIe
         ec6NdBj7KnKXTi/pwaZwAppM/BqSWT9bhmkTGqUCWD6KxdEiEpxonq7zvVV5BfwR/6s4
         Pull4YdtWYCBTFoGt+5m6LsCFC7CgdOvo60IsK65mBTHJEklP+0RzVt6NgP7VQumrtAr
         /UpYqfHUQ7+4YydR3NCmcVGhnXG7VqzcoASsTGDnXkQwSn+D75xUkBX9JnNY3i7EfndE
         z9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862700; x=1785467500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XZ5/m91mCKFWBUm41FXN6jdoeDBSlCrXG6RIqmllwTs=;
        b=HA4jOQeZkNNim67eQiFZVHfsOKFsbmV7ciikAtDwGIQ95pZJTcNlMvtGoOngkOl0Kk
         1JV/mQtGa0IBdXN73NgqSKOdddhz9wWkDmhDGKx9iXa2W69/vRmcTajLPvsN2nVkeIwY
         +ESM5S+PcHc1Q8qc784cyRV11NU7M5WBLLtlLC6dARDcCnUc+0bk9zu7UqOd/ROvzJTC
         ETXyITCvzQem6RY0pBf0x926yTeMm6iwsS0gGGQ8KJodAxEt08WFa7bZNrsi2tWjFp9e
         1fCKKgKqx3TbVNLo44M1Lcf54a9ERbioyaIgsHXKjrB8mh/fmb4wrr07/fxJPRX059A8
         92hg==
X-Forwarded-Encrypted: i=1; AHgh+RqqtofBj4ho5reFGoGGdDGozoTtW+Rt/r1ulMWHt06nGhtCf0cSrCoGhbtArOrvzbkDzLr7T48z7IkaygLwag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCSLp81szi8PFIVaN0z8/aqpO2g04eL3QEQzDEyXnHc2lksCtn
	tW7eFgsXZvoO2CrB8vAwVp9mCQJo8eXYY5ZjOXsvb+kd3djnjYRa0J2k
X-Gm-Gg: AR+sD13tttfw9faepAKFoFf0JhEyPbW+JsTaKtal0o0LkfExezw1cbCfFGkCczx29uA
	4Gj4vFopZi5upUBU6TQlUTYNU3tnhJvYxVSf7kR9nJvEsLUZ80UOt7xre+poaXx2OG2HJlMBgV9
	yB7yz+2bUY1GVoeDZcpYW3UqLnfJ3jy9ZoUSjOJic41nUBeh/MjXAOGxSlhYMVFLxWnmFTBFnFa
	G6Ae+TwbjLd23BSF39S84o9Mm2Bc4I1H+DxhD0vOH9+u/uXQKP3DC7IAMOW3c1JirUPCnUauqrp
	94cv18l3xIPszX0sG2WVwLdco97YvoqiU7i+ZEjUaY0Q7MEA61qVDvbbzM9mzLH3UPz66Qzc9v1
	VMNMpZ7G4mvEKQDjgvj4wLLqVyY0ci+qweVTXX/TtjtN12c/8IxChLdAWQvWnkCDGIAqlNI/vpi
	e8ffyn
X-Received: by 2002:a05:6a20:6a06:b0:3c3:c71d:9030 with SMTP id adf61e73a8af0-3c44b245a11mr6442727637.65.1784862699928;
        Thu, 23 Jul 2026 20:11:39 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a9967sm3537895a12.25.2026.07.23.20.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:11:39 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@gmail.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: fix T10-PI lifecycle hard BUG after endpoint
Date: Fri, 24 Jul 2026 11:11:29 +0800
Message-Id: <20260724031129.1567664-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
References: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the guidance. I understand now that the fix should follow the
virtio specification rather than use VHOST_F_LOG_ALL as the model. I will
update v2 accordingly.

Following your suggestion, I also checked the other vhost devices. For the
specific T10-PI lifecycle issue, vhost-vdpa already rejects feature changes
after FEATURES_OK. vhost-net and vhost-vsock still accept runtime feature
changes, but I have not yet confirmed a corresponding runtime failure in
those paths. I will treat them as separate audit items.

