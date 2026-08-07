Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC16347BA9
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 02:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070642; cv=none; b=AtfR4NmMQp3xWx63xjlPSwR8Ja+aams7np8rlTjPG7csGOXe+5tWQLYH/EXA8ZMpKWno+DR4o6JidhkuyvqrxLB0xQacC6s67VLzz+qGxnaLzGFK80xQUxw4QXzWJHWYAgRSLljMLTwmBQ5uYoDUEgHJLW7jYLdQVpARKfu3gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070642; c=relaxed/simple;
	bh=whZNQ7SQKh1qq87vu50ZQLiGgb/HdnH9lUOs6W7psgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHbEX+/U4h4aCcAafKGXFG0BI0HzlcDiR2tViEeCtHPoO4XAQ1iVaEvr/2PzJo9nq6rfK6YXjnI3X+z/vjQLBXn4DLyVSiQ6D0OeiTkGrnjNhmDzbXje/t5COD8xeGvjvMS3+Lx38WIXdsWhJwank4y9qv+L6ksbHCCwvBmCvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d40eaa98920911f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:22f29574-be46-4cfa-addd-64f71ad05ebb,IP:0,U
	RL:0,TC:0,Content:8,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:8
X-CID-META: VersionHash:e7bac3a,CLOUDID:ccac7ddb1b4882427b67e2dd9480b6cb,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d40eaa98920911f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1213189868; Fri, 07 Aug 2026 10:43:53 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	qemu-devel@nongnu.org,
	Weimin Xiong <xiongwm2026@163.com>
Subject: Re: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid N^2 complexity
Date: Fri,  7 Aug 2026 10:43:50 +0800
Message-ID: <20260807024351.2157806-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724055156-mutt-send-email-mst@kernel.org>
References: <20260724055156-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 24, 2026 at 05:56:03AM -0400, Michael S. Tsirkin wrote:
> As any optimization, I expect actual perf measurements
> showing an improvement to be included please.
>
> So it is still O(N^2) right? It just skips calling it for
> some sections.

You are right.  The change only skipped non-overlapping sections and
did not really address the complexity, and I do not have measurements
showing a meaningful win on the only call site (full-range sync in
vhost_log_put).

I will drop this patch.

Thanks,
Xiong Weimin
