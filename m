Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CB19D07A
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893992; cv=none; b=I5V5KMsiyhm4bv3zqdyGorZ0qv7UdQvcGODHeiajJwS086ySsm9wb9AhPxCyeuSiilFatjJcGLSg1+QsTnsjEuNxzCwrAw3jCyDuDnba04NrkwI6sWnP/M9ssnFkFpgI/EIqjgw1+IAhi5Ds0FhW1n2St9jShxW33NW8WTx8Fo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893992; c=relaxed/simple;
	bh=ZPNBugyZWrwf/gkwaaW7RTX+lR1NT2WkZkvX9Wxq9no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDtqPLIB0ygkZax+jFAceaZCeZHOsjzJROPsa/eYiP0PeaG5Xlxc/ilFN37SqkzZeM9BJcqhbjoLQxBuD3QCtWESLjQ2e1VULlyYj2Gush3rkFVr4kNhNfG6GbFFX1hkDck2o/2bq2ucEdM7OSd2GYo7mHIvl7crMRaVNCs3LfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 871f92c0906e11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1ef9035c-c9c9-4edb-8035-6bc3539d8a41,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:56b2bf02d38db11b8e6a4ee9d99d0422,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 871f92c0906e11f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1770405383; Wed, 05 Aug 2026 09:39:41 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, Zhu Lingshan <lingshan.zhu@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Michael S. Tsirkin <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vdpa: ifcvf: Put device on unsupported feature error
Date: Wed, 05 Aug 2026 09:39:40 +0800
Message-ID: <178589398077.1551682.9339660780572106788@kylinos.cn>
In-Reply-To: <c972f4a9-ed10-45bd-9541-25fa8d7b825a@web.de>
References: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
 <c972f4a9-ed10-45bd-9541-25fa8d7b825a@web.de>
User-Agent: git-send-email compatible Python smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, Aug 04, 2026 at 06:32:04PM +0200, Markus Elfring wrote:
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

Yes, this is a bug fix for the feature provisioning error path, so adding
the tags makes sense.

I will send a v2 with:

Fixes: 46fc0917bbab ("vDPA/ifcvf: implement features provisioning")
Cc: stable@vger.kernel.org # v6.3+

Thanks,
Xiong
