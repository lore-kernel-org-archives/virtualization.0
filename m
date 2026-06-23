Received: from smtp-usa1.onexmail.com (smtp-usa1.onexmail.com [52.205.10.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9912147E5
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.205.10.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184763; cv=none; b=C8tR6sh5BmpXNX9G1Ur55Osd8tzoa8wr7x4V5RVkaO5WUc+22kYcYJM5HC6Bp/TRHLeDiq3GWWG50uQnLVW/IVe7wHyPi0sOullnD901/FD9a/sxZ/rBy4qOlwp/js3pOPIoO9goSjNKhjqyqulleeRhP2+tUqjsUf6Sj5as7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184763; c=relaxed/simple;
	bh=YDGxcWEsv6GWTo5fxcU7l84GVG64V8Z8G8hmd6MIv6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5HuhWRSsLm06twKVrr6r7YXlQdIvnFmXrzjad5AU7omyXDmNYwmGscxQgiPmlHjYxOiJnetWs3GlpuO3ZpvL1e503dhHHGzRWi4AId6rPVjQvfIWewEMYGiefqJp8ddIAz7z8rnbqcjmH0EkZtj8r5stQ/3ACfKJ8t6fs6HQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=L8aXBK9i; arc=none smtp.client-ip=52.205.10.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="L8aXBK9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782184689;
	bh=fF4v7Gi2HQWvot/O3/GlCrpQuRPZDN344XK/HsgaOzM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=L8aXBK9iSZAzPHike38aUQyV6wDsJhp4UcaCqlhW+piS9ycMG7Yq69zPhzQDiRSe0
	 G+fWlkupsEDVIi1TsROOf6DB3nxQHzrJT3mfo/KxEsGUXC24BZnh2+v4KNwo76cYoW
	 WvPTfgqi1qYXxDqR3n1DScTJboUZQj9FK73Y4XJw=
X-QQ-mid: esmtpsz16t1782184668t083372e4
X-QQ-Originating-IP: uVnpzwJiuavW7jgxZIBrMgAVlWqIsdx3EP98DVrMT3M=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 11:17:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16632344768827200221
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com
Cc: akpm@linux-foundation.org,
	chenyichong@uniontech.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	rppt@kernel.org,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 0/2] tools: Fix tools/virtio test build
Date: Tue, 23 Jun 2026 11:17:45 +0800
Message-ID: <AE5DFB4F927277A5+20260623031745.1370871-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618080405-mutt-send-email-mst@kernel.org>
References: <20260618080405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NgEKQrOzHIjOX5bXFYomW3cghJmgsenkaVWLzT7wamsjC5KvAGHSlfAA
	DPayH1Tb3DnRe760JLP/6bApdGa7ZX+fTIEO/B0kTfoTQD2fWfkEywHnXrRXUlB20pHDwUn
	szKABxRbb28SWV0ADDa1b/nZMNNck3M4BKAu7JZi6vd2EnS7jYUTbhYKx8StTatFx5XPih8
	9waSrnqYxPEP3swreUhmYCJPXWX+tOSNkaMtRSOSAXUo62EnQgDYfUeCyPrr86FreRX6T9o
	+xyh9qqbsg0aw/EjtYRLkxkb0429kt6Hx1cRUVUrO5S7qF4FYfzi3Iw5uz6WdYt3gm05DUW
	ESVLmeNbDTq2S3x/Jgs32sbHUdXmXOcpFFAHm9ePZgGkP5vyyw53C6Fsv9DOwZi3RHEza4B
	mCNTbfBXUcAltJMUoViAbs3ooDRDP43OnDupAuA5l9siIMIH5JfNciRH80dpqK1vB0TIW+K
	g6gS/CmZMqkCpxcgK+tptv1be1XeUBQqYjqhwMmthE6pMV9t7mnyGAUeydJwQkwkEovrin5
	PQQzdj4wUacoVBuRy4Kc/TsnueLV0L5ZnD2+iiesUh4leQntDiVvF07npEr95GA4ycdPQYh
	uoA+dfv23O4jEeHJHzlkYwj04euptxevkyDbcYn+W6icRNH7Kv5yl7zwmEeR2lLYH7byuBL
	ejOQX9/hxxIfdIKE37yqQT0515xRCj7afwzEqu0qQZaxXkupFIGc1YUIfcgs8j9ctg8+Kym
	Y/oh8xTAEc1sJPHrpNar9/2z/MKZCC+wYsa85hL1Oa4hdOwglZefd6VAyphtmg0cP37qyYy
	WYTCS4Y+lxXnyNtX8FYM6XStGMSL6b10IJAPTPfdtWh90KpNf7XvYZ+zP9ATnY1MCky/eXX
	D4M83X8pDHPM7pQdLEiEEj1aQpVlFXe8OY64CrYgQUg090TBv9kNMejE0F8ggbdQGDaycKd
	0ZguTIUgRfMA8QmiiYT5dOMBUrjl+R4fE6euoskiJ08heyFtosZ09N6W4wezXoifAGQ7rvz
	Rj1cPX3eAtYx69NGZd3gkkF/k94Uv88dASJTLc8bkvFQkCqFmgNMB0KNYynlOh/elHF29ox
	A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Hi Michael,

I tested the commit you pointed me to:

  8cb2c9285e4c ("can: virtio: Fix comment in UAPI header")

The tools/virtio build failure is still reproducible there with:

  make -C tools/virtio test

The first failure is:

  include/linux/virtio.h:10:10: fatal error:
  linux/mod_devicetable.h: No such file or directory

I also checked my original v7.1-based series, and it does not apply
cleanly on top of this commit due to context changes in
tools/virtio/linux/dma-mapping.h.

Would you like me to respin the series on top of 8cb2c9285e4c?

Thanks,
Yichong
