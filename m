Received: from 14.mo550.mail-out.ovh.net (14.mo550.mail-out.ovh.net [178.32.97.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9819EED4
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.97.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740022; cv=none; b=VpVdVDgQtHUDs8NDgNSwsbY4KXFsr3jpa0g3++D8pSfS/Z90RdT3/6KlHQRfj3YqiolvbyFQW48VsSCtt5cFQ2H80jfVLCqyF3ZaN4IqZx3+H/8ARVmUNUAnZvjWB+aixBQCJo0wV/aOFsSYkUoB4v9/bFJ70C5rZchog+HWJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740022; c=relaxed/simple;
	bh=GK3R50NkNch+lbRG9vDNLoiia9t8YCkGRD93QMmXbH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub0PBsN75oV9nwi0DD/yTUCMuTLvapnd5Rf/TtHkorR6uC8tbsBhaa3Dtcm3XGFJDDMOE1GuxOfBZQIzd7aY/QAd5fgDB3QbtgG7SJxkzfECTK6mtyZgQTi7b/EkMTnYds8+sBTM0Olt34T2znQ8WM9fDZkeZAemUmJcjWbPM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.32.97.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.17.245])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4WKrL544SCz1Fks
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 23:20:13 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-276s8 (unknown [10.110.96.35])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B92B51FDE0;
	Thu, 11 Jul 2024 23:20:11 +0000 (UTC)
Received: from etezian.org ([37.59.142.102])
	by ghost-submission-6684bf9d7b-276s8 with ESMTPSA
	id d61dKKtokGYCRycAIhEDZw
	(envelope-from <andi@etezian.org>); Thu, 11 Jul 2024 23:20:11 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R004025ef779-b8ef-47a1-8f81-7534dfa48c8c,
                    47FBFB77BDCA57EA66E7955FCDEBFA84A3B4AB1A) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.248.195
From: Andi Shyti <andi.shyti@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] MAINTAINERS: i2c-virtio: Drop Conghui Chen from Maintainers
Date: Fri, 12 Jul 2024 01:19:25 +0200
Message-ID: <20240711231927.3103820-2-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711231927.3103820-1-andi.shyti@kernel.org>
References: <20240711231927.3103820-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7542684953390811759
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeefvddvgefhhfdtffefleehheevfeffhfefudehudejhefhjedtgfffhfekvedvtdenucffohhmrghinhepihhnthgvlhdrtghomhenucfkphepuddvjedrtddrtddruddpudelgedrvdeftddrvdegkedrudelhedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigrdguvghvpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth

E-mails to Conghui Chen have bounced back:

  <conghui.chen@intel.com>: host mgamail.eglb.intel.com[198.175.65.14] said: 550
      #5.1.0 Address rejected. (in reply to RCPT TO command)

Remove him as maintainer of the i2c Virtio driver in the
MAINTAINERS file.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org
Cc: virtualization@lists.linux.dev
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e26555e52bfd..96745f7971100 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23859,7 +23859,6 @@ S:	Maintained
 F:	drivers/vhost/scsi.c
 
 VIRTIO I2C DRIVER
-M:	Conghui Chen <conghui.chen@intel.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-i2c@vger.kernel.org
 L:	virtualization@lists.linux.dev
-- 
2.45.2

