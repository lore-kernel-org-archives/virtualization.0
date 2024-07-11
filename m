Received: from 8.mo582.mail-out.ovh.net (8.mo582.mail-out.ovh.net [178.33.42.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346716D9B2
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.42.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720742196; cv=none; b=BRqCyBzMFOdE1WekT4H4WGRr+7OQtT5SrNjtJqyppb+arEnad7r1AHPRF67vURe5VO0DuTj9ySiY6CMgTqmNjtFAkZQtT5s29OEpTOm94bUAvEW/hozVq8lgfuk7P2yvsow3EmLUBEBPxy9B4PyBQ5kv7IiKK4rcuAupwTl9LZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720742196; c=relaxed/simple;
	bh=NZ8T7Ds3iZep5vO1ifYcykqOpLll7nDm1BsynJvV7Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhYxgXDGYeMa+It9Er/qDi3g85PsFKzDify6yXeGKj6EN2u+vjpKL7DpKImFXFGKpi54BtCYHlni6XLewC20/+HYQEAZXoM/v/wsQcjicbA9iLdiQ5No5PoWlAJgPd/VxOO5yM9z2ndaWupk765VF4b3aLt/efmNjOmu6DL8EJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.42.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.139.198])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4WKrL25HKtz1LVn
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 23:20:10 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-8rwxz (unknown [10.108.42.201])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 50E101FDFC;
	Thu, 11 Jul 2024 23:20:07 +0000 (UTC)
Received: from etezian.org ([37.59.142.96])
	by ghost-submission-6684bf9d7b-8rwxz with ESMTPSA
	id PzeKC6dokGZO4gsAyuFlTg
	(envelope-from <andi@etezian.org>); Thu, 11 Jul 2024 23:20:07 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R001e9cb5549-685d-425f-a6a9-8576c3d7597e,
                    47FBFB77BDCA57EA66E7955FCDEBFA84A3B4AB1A) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.248.195
From: Andi Shyti <andi.shyti@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 0/2] Cleanup the MAINTAINER's file
Date: Fri, 12 Jul 2024 01:19:24 +0200
Message-ID: <20240711231927.3103820-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7541840528265644655
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtveeuieehfeetudejhfehleeijedvveetleefhfehuedtleektdevjedujefgvdenucfkphepuddvjedrtddrtddruddpudelgedrvdeftddrvdegkedrudelhedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslhhishhtshdrlhhinhhugidruggvvhdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht

Hi,

while reviewing Wolfram's series, I received some delivery
failure notifications for e-mails that don't exist anymore.

With this series I'm removing:

 - Conghui Chen <conghui.chen@intel.com>
 - Thor Thayer <thor.thayer@linux.intel.com>

unfortunately both from Intel :-(

In the case of Altera's subsystems (except for the i2c), I didn't
really know what to do with them, so that I marked them as
Orphan.

Andi

Cc: Andy Shevchenko <andy@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: virtualization@lists.linux.dev

Andi Shyti (2):
  MAINTAINERS: i2c-virtio: Drop Conghui Chen from Maintainers
  MAINTAINERS: Drop Thor Thayer from maintainers

 MAINTAINERS | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.45.2

