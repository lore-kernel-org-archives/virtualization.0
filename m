Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27E371880
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070645; cv=none; b=iRpjFdtWBkGxakutQkIM+r9U8iDl2R9vF09do37np4s1ot73708OxhEl3LdvaSjHrPccmcwIsIoxwnm7k2SLcVRGvLfeXZ6T3SHKBIc082PKVCM+y5vX7LqSuPjcB3C6cby+heAW4w48x1LjTYmZCEMJnThTl7CtkY4JtfiiF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070645; c=relaxed/simple;
	bh=UVi6xsHmlRhuL3EGRPLSqvAma1PqQUv8AwtueJQmpco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yo3QPwkXoTLKjnPaPj7xnviGhpvKwipUh3wkPjLEt4WhdMZdB9sIdwJGWLQv0RKyHAOFkqSwcLX9+z6YmmJCDs33kLgdi0EF8iAHdpsDTjNiMdKZxuI6u52iugrcj29Fe1lZxYz4cniLBRG7E6dk1o9loI92/YturAnym/U5RAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d5a8ba6a920911f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1d75855c-ed8e-41f6-bbcd-13596e2f0056,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:034cdb1e54a2d1f265d9d57def8108d7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5a8ba6a920911f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1493182803; Fri, 07 Aug 2026 10:43:56 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	qemu-devel@nongnu.org,
	Weimin Xiong <xiongwm2026@163.com>
Subject: Re: [PATCH 2/3] hw/virtio: Implement vhost_log_start and vhost_log_stop
Date: Fri,  7 Aug 2026 10:43:53 +0800
Message-ID: <20260807024353.2157846-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724054712-mutt-send-email-mst@kernel.org>
References: <20260724054712-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 24, 2026 at 05:48:26AM -0400, Michael S. Tsirkin wrote:
> Is the implications that in your opinion dirty page logging during live
> migration does not work currently?

No -- that was a bad commit message on my side.

Live migration logging already goes through log_global_start/stop ->
vhost_migration_log().  The log_start/log_stop stubs are a different
path, and my change was incorrect.

I will drop this patch.

Thanks,
Xiong Weimin
