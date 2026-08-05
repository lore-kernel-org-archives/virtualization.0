Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9383286415
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893992; cv=none; b=A/6ssYqqWUBUBHb8wzX5IeVZaeiLkhBJHW5bdaB5ZJuoUUV3J3+4J0Op1O84IAdbUf8Tfy1zBtYFsfPeKmoylzNhYxoLo7pRV2/BSLbqJh3gRoQ1GIhoR4jCqWSxS60syVAnIGRYoIy1/cpucSZ6MyIPVKYn/cygSukBp+CmCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893992; c=relaxed/simple;
	bh=2pZWsGsBTAxQpE9IUjP22AtuwnOPbHbpDmuKMQVH8uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4jTqLIOhVcWAHC+JrcaPXeqr1fYbWiKqvcsUd/n9F6cxe7Dlj53nBgzfgQtKTlQKxusO9Rm3h3bL5rrBnc6+EGh3JhfSzWnaTW3mGb5kGcDU4qb5KYRquUyy0jou7CXHH9XVTkh1T9wmqv3acXf6TZLBbjB2iC18IujO+948mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 874fb068906e11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:900e1e44-65b6-46f1-bae7-39506e8e7b67,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d7a13fcab0e2153e1fa3cf8efc421b1d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 874fb068906e11f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1192003168; Wed, 05 Aug 2026 09:39:41 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, Alvaro Karsz <alvaro.karsz@solid-run.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Michael S. Tsirkin <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vdpa: solidrun: Free IRQs after request failure
Date: Wed, 05 Aug 2026 09:39:41 +0800
Message-ID: <178589398132.1551682.1367611575804189849@kylinos.cn>
In-Reply-To: <c592a594-b2cf-46c5-98d0-2935b9a5ebab@web.de>
References: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
 <c592a594-b2cf-46c5-98d0-2935b9a5ebab@web.de>
User-Agent: git-send-email compatible Python smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, Aug 04, 2026 at 06:54:24PM +0200, Markus Elfring wrote:
> How good does a proposed snet_free_irqs(snet) call fit to previous
> devm_request_irq() calls?
>
> I suggest to avoid duplicate exception handling code for affected cases.

The IRQs are requested and freed while the PCI device remains bound, for
example when DRIVER_OK is set and later reset. So the driver cannot rely
only on devres cleanup at device detach time; it already pairs
devm_request_irq() with devm_free_irq() in snet_free_irqs() for reset and
for the snet_write_conf() failure path.

That said, I agree that the error path can be made more precise. I will
send a v2 that keeps the config IRQ request failure as a direct return,
and only calls snet_free_irqs() after at least one IRQ was successfully
requested. I will also add the Fixes/Cc stable tags.

Thanks,
Xiong
