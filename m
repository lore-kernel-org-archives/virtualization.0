Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792728212;
	b=eGAWll2CYZ58Px2QFJe+uRVQ8jhRz2Lst0wjJJqpMbtg5Caau3Q4vWfx88PMdlbpbscI
	 UJReWnWG0zuqLvJInzWk2fH8Npw6aMVjpjVhkUJNSxmUcJxTKW3/tMiQynLpgRAGUpXon
	 GqNcL9JoyLB9uzHOpyAwrb1GT3TbUhWhainljpa5VXzf6jxYgQZ+ymwRp1CFCVTwW/lh5
	 HgLeZ+x2nANKMZx5xjnpjCWfhwm+8+7irBvtdN8ItqZVgkv3WJViqewB38d98u69e2ccv
	 PDjlxSvvWD4PBsetbBuER2aXnsnq2ifCZrvHBmEaE16t/vGDaT3O2DT4xthQsUQkPOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792728212;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QKpbF2NYjurzhEa4kldxHAeNF3pXxzbhF88uq7GLFNY=;
	b=jKp+sHAMdFO/Y/asuGkdv4sCEToWCtDAk7rnPSckqS1RQ99DVyIxz5Du2wCvFpdILnOF
	 +1nLqgby12PzGp7aONbHUAdLyaY82IQlpb+EcPHD+acDaTeahD5o8aflnn3E3Y4jZMvTe
	 0yGov7W9zSrn046JgiHfdKP6tFIiPYsbGVNbpe7D+6y9p0VvxAfn8SkTlrSPQtAmKHiOz
	 0Qjq734BbbDJ5mYn+rc80f51K8gy92++ShTDZYPMFaEtgBXWIfxh0ctRGy1OvV6DgY/UK
	 cII6Rj3LmR4hga8epRihYEWkyrgnA579zBZRzXvOdnfGJ8jcXOC781KgN47U/Ug03NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MWzcxIgp;
	arc=none smtp.remote-ip=115.124.28.197
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885C606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 04:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B885C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MWzcxIgp
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792728202; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QKpbF2NYjurzhEa4kldxHAeNF3pXxzbhF88uq7GLFNY=;
	b=MWzcxIgplb0QYAvlwaFOa2ivBLWXo01f6GNYM23LNPJYPbLBhBbbpo2DxxngP7X1LsxafjByHH34OFlCT7MSYmqJcMwZHR7iaeB799f/4VotJzQPZVz386FPA8zx7QpGlA9uGNb2GFhTGLeI4waxWVEQ4hTGCx0+4rRcNbevjlk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2734637|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0703598-0.00291062-0.92673;FP=8486465230796416835|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jnx.DIq_1792728200;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jnx.DIq_1792728200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 12:03:21 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: xieyongji@bytedance.com,
	xuanzhuo@linux.alibaba.com,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] vringh: fix infinite loop on cyclic top-level indirect descriptor
Date: Fri, 23 Oct 2026 12:03:19 +0800
Message-ID: <20261023040319.48555-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922122955.69433-1-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
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

Hi,

Thanks to Jason for acking patch 2/2.

I wanted to follow up on patch 1/2 and check whether there are any
concerns with the fix or if a different approach would be preferred.

Thanks,
Fang Xieyan
