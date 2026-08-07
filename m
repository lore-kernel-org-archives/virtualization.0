Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FA37E5DD
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066353; cv=none; b=YTrda7EsQUYJWLCAxYgywdZyimaRRhAgQ/jWapAXIyoP0DjdkOnRQ5ib8KLizZUds/6OL7fAH3A1pQ4sptMnrNCKL00GPxAKOEglX8sZnBdwfEg5zO7qqlzSBnsI6IocZ24ONI905kT0mRkfaism+QEzCbEo9kFyWQqbd9Nu404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066353; c=relaxed/simple;
	bh=0xfhDIIMoHRvodCCtROkDY8Hi5x1FW9/AKerKZsSBwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCOi8hrm/hu38goSAIAo09/yRXCoGHYHBIa1EII6iOHNS9Fn4uwi/GUrrXNz/anShrOEy9NqGHw70jN1rBur24YQ/eC9QiGQoBpwZi69LKMOKlmYEznmBb3183gKF6/aX+cf53YRBsOfnxJoIl+bawE1AyflCa2cRtG8RBOSyVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d54d896a91ff11f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4b41f70d-f22f-47cc-9f9b-05cac0675766,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f7b874d698f64f48f806cef3898a6f7f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d54d896a91ff11f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1413781237; Fri, 07 Aug 2026 09:32:20 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
Date: Fri,  7 Aug 2026 09:32:17 +0800
Message-ID: <20260807013217.2130431-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806160410.2689091-1-kuba@kernel.org>
References: <20260806160410.2689091-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 09:04:10AM -0700, Jakub Kicinski wrote:
> Was an out of range qid actually reachable here?
> ...
> Could the changelog describe this as a defensive reordering rather than
> as preventing an out of range dereference?
> ...
> since the patch touches the enable-side qid test, is the symmetric test
> in virtnet_xsk_pool_disable() safe?

Thanks for the review.

You are right on both counts for this patch: qid is already bounded by
xsk_reg_pool_at_qid(), and the old ordering still rejected the request
before sq/rq were used.  The only visible difference was -EINVAL vs
-ENOENT for qid in [curr_queue_pairs, max_queue_pairs).  I will drop
this reorder (and the overstated changelog).

On the disable path / XDP detach interaction: I agree.  If
curr_queue_pairs shrinks while an AF_XDP pool is still bound,
virtnet_xsk_pool_disable() can return -EINVAL, skip cleanup, and leave
rq/sq->xsk_pool pointing at a pool that xp_clear_dev() then frees.

I will drop this series and post a v2 replacement as a new thread that:
1) lets disable clean up with a max_queue_pairs bounds check, and
2) refuses XDP-driven queue shrink while AF_XDP is still bound.

Thanks,
Xiong Weimin
