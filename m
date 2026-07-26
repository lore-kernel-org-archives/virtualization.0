Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603C12FF69
	for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785046211; cv=none; b=IMAYd8JLA5eSE6jbYT+nWfWBkuNDI7K3cp4BX2cL2UnCEWhyH44JjKugPx2A1xAZPdJxLK/s6Yyd9fynrH4D+lPpEYlAoGvPnBLqfxP7WwOb2zPv7W9qfyfS47DraUuqcxwz1eqV1EarPk1797dWDllNM9HgXMt6haMyshfZxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785046211; c=relaxed/simple;
	bh=nVZPEwB7VqcMF2ACQNmeveKB1/mfZNWkykkM16dsJmc=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=HKjuGj46DZ1by5M/w0yBGembfJfrEsyEzqOYmjL796hjFiYV5bTwHBG0lc32w2JnbsB5a8zV94BqK85kqEhtQsYP/k0lBn3Mv6BQlXrH2hcYeytrqJCS9QZ4M/AMcHqbcYWbjX9TVhDS3EUGdl//slHaRmzYqz1Sek0ns2ULE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn; spf=pass smtp.mailfrom=hdu.edu.cn; dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b=VbcplwY2; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hdu.edu.cn header.i=@hdu.edu.cn header.b="VbcplwY2"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AF6AMgBrKs8-sIiDVdE6JaqJ.3.1785045889051.Hmail.241270009@hdu.edu.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linfeng Sun <slf@hdu.edu.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIIHYyXSB2ZHBhX3NpbTogZml4IGNsZWFudXAgYWZ0ZXIgd29ya2VyIGNyZWF0aW9uIGZhaWx1cmU=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
In-Reply-To: <20260620100959.2070316-1-slf@hdu.edu.cn>
References: <20260620100959.2070316-1-slf@hdu.edu.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from 241270009@hdu.edu.cn( [117.147.100.113] ) by ajax-webmail ( [127.0.0.1] ) ; Sun, 26 Jul 2026 14:04:49 +0800 (GMT+08:00)
From: Linfeng Sun <slf@hdu.edu.cn>
Date: Sun, 26 Jul 2026 14:04:49 +0800 (GMT+08:00)
X-HM-Tid: 0a9f9d050031d45akusy10d0397d283c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSEMdVklJTEIdTUsfTkxLTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSkxVSk9MVUpLS1VKSkhZV1kWGg8SFR0UWUFZS1VLVU
	tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=VbcplwY2IzQiyPDhIX7nRgqVxRT8imHfFINSNhnaSl8AXyhp148Oc/L0v0VVTDyb3S4IRiWCxX7Iv8wIsr6xmz6XPUhjHVgU/SJgUUAd8pgDqmUDr9zOEN/jB194zZJehLCp0s7lFx1MEMlFoqUzodAkuZ+L9d1ef53w48dsjJo=; s=default; c=relaxed/relaxed; d=hdu.edu.cn; v=1;
	bh=nVZPEwB7VqcMF2ACQNmeveKB1/mfZNWkykkM16dsJmc=;
	h=date:mime-version:subject:message-id:from;

SGksCgpJdCdzIGJlZW4gYSBtb250aCB3aXRoIG5vIHJlc3BvbnNlLCBhbmQgSSBkb24ndCBzZWUg
aXQgaW4gbGludXgtbmV4dC4KCkFsc28sIG15IEVEVSBlbWFpbCB3aWxsIGV4cGlyZSBhZnRlciBn
cmFkdWF0aW9uLCBzbyBJJ2QgbGlrZSB0byB1cGRhdGUgdG86CkxpbmZlbmcgU3VuwqA8bGluZmVu
Zy5zdW4uZGV2QGdhbWlsLmNvbT4KClNob3VsZCBJIHJlc2VuZCB3aXRoIG5ldyBhZGRyZXNzLCBv
ciB3YWl0PwoKVGhhbmtzLApMaW5mZW5nIFN1bg==
