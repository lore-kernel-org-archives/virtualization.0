Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973C347BA9
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070645; cv=none; b=MKmVkoiNEdOp/jo3TgajO/dr290tEROzQtwYbMBwEVmpbS6YvNSsRLQA650SYEVrW1yPkLzXAmDPOB5XxI4E8WXHiN1+MizliY4fWTIclKo83ZlkO+0cr4ErrrjLmQW+lAbrGSOMHjN0znjU5Zgl+ldhjB+wApnIP6lIrFj5JWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070645; c=relaxed/simple;
	bh=3mlGr2Uq0r79p40uinxjivM75NG+m6wW8CWqynvIxNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au5h9KtN9c4tcCI9swoIZf42v/BBHXLLvieansmP19k5nMO3iJ+Sl51lkIA8dEflIWHJSzESMNX/5PC5YFIvHoIXnJ0rs30a3VHX29TYFQXgVWrQpsTGRJHwCZocaQf4LzVRBouuxV9YMFliKWk/NqzyeVz4/awkXA2r3lnnHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d73a68b0920911f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c9aa53b3-3798-49f9-a7ca-2622ee2467d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:54beb59992935713d1a2ebc40e642617,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d73a68b0920911f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1117453092; Fri, 07 Aug 2026 10:43:58 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	qemu-devel@nongnu.org,
	Weimin Xiong <xiongwm2026@163.com>
Subject: Re: [PATCH 3/3] hw/virtio: Add error handling for vhost_virtqueue_mask failure
Date: Fri,  7 Aug 2026 10:43:56 +0800
Message-ID: <20260807024356.2157890-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724054836-mutt-send-email-mst@kernel.org>
References: <20260724054836-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 24, 2026 at 05:51:46AM -0400, Michael S. Tsirkin wrote:
> why is this part of this patchset?
>
> and then what happens?

It should not have been part of that series.  I am dropping the other
two patches and will resend this as a standalone change.

Also, the previous version was incomplete: vhost_virtqueue_mask() is
void today, so simply checking its return value was wrong.  The new
patch makes it return the errno from vhost_set_vring_call().  On
failure in vhost_virtqueue_start(), we jump to the existing fail path,
which unmaps the vring and returns the error so device start fails
instead of continuing with a half-configured queue.

Thanks,
Xiong Weimin
