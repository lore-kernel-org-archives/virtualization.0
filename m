Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4791379981
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977898; cv=none; b=lRDgJEC7/rZWHMxL20pHHvNwDhl0M2hDUBgPWAiJHp35mC8fugLRLc+j6gNgc/92A1Fvu56cScCss7PSkRpUse6wM1eVC6wyQdHvtcUdhvD8oajHAFWGPs+h4I1KfngBYgq7hYC0Q4ZGyGYwv6CV+SarXBXs78gp0fi7qWzMCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977898; c=relaxed/simple;
	bh=XMhC+YKFD+6kEmobHiDgOwZ8kKl63bLzl8HRnMHjNNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYLIfOQau+gUy9xLbtYuBlwrXuJrVoLdyXuwiqjBfAvXOHGxIK4+C8ePMlZeJjkvfGEUPWNUBu4oNJt6/cUAeLGgxJEP9kkay07rGrDkFBr2e4zVJgwcBhzz9NAq8qrgKL9MOA89KDyWxzvU4geufrQli+/w+BlFfBHiEfzskk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e46c8712913111f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9b8afccd-6854-48e9-abe1-32ddbac43da9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:320ca2795b330fd86c2dce17a5b25f62,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e46c8712913111f1aa26b74ffac11d73-20260806
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1676706895; Thu, 06 Aug 2026 08:58:09 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Brett Creeley <brett.creeley@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/pds: check virtqueue notify mapping
Date: Thu, 06 Aug 2026 08:58:06 +0800
Message-ID: <178597788671.1875248.17519886919048135568@kylinos.cn>
In-Reply-To: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
References: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, Aug 04, 2026, Brett Creeley wrote:
> Nit, but why dev_warn() instead of dev_err()? It looks like this was
> copied, but I wonder if the other spot should be a dev_err() instead of
> a dev_warn too?
>
> Other than that, LGTM.
>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Thanks for the review. Agreed — this is a hard failure on the device
add path, and the rest of pds_vdpa_dev_add() already uses dev_err().
I'll send a standalone [PATCH v2] with that change and your
Reviewed-by.

The matching "Fail to map vq notify" in vp_vdpa.c is pre-existing; I
can clean that up in a separate patch if you prefer.

Thanks,
Xiong
