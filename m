Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9A391501
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067901; cv=none; b=j6ljfbjEvODlseLhhPtWDjCqkGAd4NBHDHDn8pfIto/RBW2xDJ3HNU6zK9QX2DLDhf14Upcst2+6FLOxnfJ0zHI0wBv3nJ7MZ94NuVNjfkOWXn4ymmVXQEd4vR5oqK2mYNdJHhkCCWIo93gwlm0de7VAuZy6nDlZp/CV+ee9jfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067901; c=relaxed/simple;
	bh=3vSUvNM8rjVuV1yBfgMhBRx+vU6LmbFObnOfOy3lyiQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=LWZiCImCEjtk0QL6yTr1drMY5M+tv+VBywK5CGmshVZtE2j/xlPJJWuNLY/F3UH0VjHGEfflFIRhm6Qv/oEVnq3GS0CxhspTUc2dawblyTT2ehwYyTPfxn+DvG0rcBjayuwOC7MnqBwN2GhyzfNZ1X8wy8S9cLF4eHF2eTXVAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 727ac920920311f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c8ce9d81-8d83-4c51-89bd-8ec67cf8dcf0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b5cb80180b3cb56e03c7503f822530f7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 727ac920920311f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1730433133; Fri, 07 Aug 2026 09:58:12 +0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Brett Creeley <brett.creeley@amd.com>
Cc: Michael S. Tsirkin <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/pds: check virtqueue notify mapping
Date: Fri, 07 Aug 2026 09:58:06 +0800
Message-ID: <178606788689.2139700.16021825706254629026@kylinos.cn>
In-Reply-To: <05ed4e3e-ce2c-4b5c-8bbf-2e1a2e820466@amd.com>
References: <20260804085341.1333303-1-xiongweimin@kylinos.cn> <178597788671.1875248.17519886919048135568@kylinos.cn> <05ed4e3e-ce2c-4b5c-8bbf-2e1a2e820466@amd.com>

VGhhbmtzLCB3aWxsIGRvLiBJJ2xsIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdnBfdmRwYS5j
IGFzIHdlbGwuCgpUaGFua3MsClhpb25nCg==
