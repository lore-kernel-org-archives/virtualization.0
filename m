Received: from mail-m6076.netease.com (mail-m6076.netease.com [210.79.60.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8112FF69
	for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785046164; cv=none; b=UA8K2YFXchNDquDR80ct/ZhPjdrIojpsUm44iN3/4ALV/XVSzxqHGeJaV/N9ZDEGL/mj6jXlZu54HvnQq0uzWvrZK+gsQxnEfGgFI8XtE3a+jJW9M7pxmQHJgTUYamx3IKByU+ybRkvSOdWejeJg2vz6tFJIdGQZlkZWt9uQqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785046164; c=relaxed/simple;
	bh=bgQDX0MWGlXrik6fAVgaPIZWg+N5IzPGoOt+SRG+Q3Q=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=WNTJmlbpSaNrwQmOMfA+FQsZW/ul8KU/JufmLw2em4/EwTjF42UjFa2rKy1hI1kl+tz+gVwVtWJqhdSSsTkUaVxDVlLlXynvJDk99hXPQoEVSHJexka+vAobH/r9oT8bzI2BDCEdT+FCRFc0lHyko1sH6zAyu0/ReJfQzvABFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=JAU8cNp3; arc=none smtp.client-ip=210.79.60.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="JAU8cNp3"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AKgAnwB5Kga-4YhMVX3Wvao*.3.1785046156497.Hmail.241270009@hdu.edu.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linfeng Sun <slf@hdu.edu.cn>
Subject: =?UTF-8?B?UmU6UmU6W1BBVENIIHYyXSB2ZHBhX3NpbTogZml4IGNsZWFudXAgYWZ0ZXIgd29ya2VyIGNyZWF0aW9uIGZhaWx1cmU=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <AF6AMgBrKs8-sIiDVdE6JaqJ.3.1785045889051.Hmail.241270009@hdu.edu.cn>
References: <20260620100959.2070316-1-slf@hdu.edu.cn> <AF6AMgBrKs8-sIiDVdE6JaqJ.3.1785045889051.Hmail.241270009@hdu.edu.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from 241270009@hdu.edu.cn( [117.147.100.113] ) by ajax-webmail ( [127.0.0.1] ) ; Sun, 26 Jul 2026 14:09:16 +0800 (GMT+08:00)
From: Linfeng Sun <slf@hdu.edu.cn>
Date: Sun, 26 Jul 2026 14:09:16 +0800 (GMT+08:00)
X-HM-Tid: 0a9f9d097087d45akusy181ce0e62841
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh0aVkoZQx1ISE4aTU0ZTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkxVSk9MVUpLS1VKSkhZV1kWGg8SFR0UWUFZT0tIVU
	pLSUJDQ0xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=JAU8cNp3LodMJysqAFru/o4eqeHy2bG0IPfowxppq1b/3Dh1NF2WN5qgeFbIQYpadXJy4Jex8gK3pAMQbRArMaTEEULtcVuUXYKj66mI6IWXT75V1j7M5AJFAuOkKBjWIgSaFoS8zHz/ZU8X+fZy3GDMLvXoKf6JdNLumpilwwc=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=bgQDX0MWGlXrik6fAVgaPIZWg+N5IzPGoOt+SRG+Q3Q=;
	h=date:mime-version:subject:message-id:from;

PkxpbmZlbmcgU3VuwqA8bGluZmVuZy5zdW4uZGV2QGdhbWlsLmNvbT4KClNvcnJ5LCBJIG1pc3Nw
ZWxsZWQgdGhlIGRvbWFpbiwgaXQgc2hvdWxkIGJlOgpMaW5mZW5nIFN1bsKgPGxpbmZlbmcuc3Vu
LmRldkBnbWFpbC5jb20+Cgo=
