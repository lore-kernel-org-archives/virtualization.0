Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7A304976
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414944; cv=none; b=pCLFGHnOIZmOW1lUm1jEnZ6oRoslQBxTPoCDvdbMDqIGWGox+0YlBKkjrBcF5fWIiieOITp+blxW54eQ/HXkrN61jsbinWPZzttDGkyUE65VMYPD5y1JHwnLUmSsIa5JDpeypKIf7/sgHhP8kJR1c3A25wsvgYsGaBojmOAqy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414944; c=relaxed/simple;
	bh=nIGyLbbxUZpHscyIk8BvkSzvjhIy8r/RPT6AGKH+8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoPRvZtmKbn2zg+63UqVMeKCAeUiMjQYaMqUffgeX/XsU1VATOMBpRBL2i1EGbgDo7XQ58RJMDOXmBLCb9MaI3VAsdwFVUiAY6reMImRc06J2+UBoa6gAUDzAG+MXeVHVBHoF5ieABJQgWMCuWkCWOYbEEa7Cn44Jo5CVa+Yo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 783156a6952b11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:080b9568-683e-4ffd-ba1b-ad547c4c5204,IP:0,U
	RL:0,TC:0,Content:100,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:80
X-CID-META: VersionHash:e7bac3a,CLOUDID:fd6c45832c47b1abcd95995fc1d0a882,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|865|898,TC:nil,Content:
	3|15|50,EDM:1|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 783156a6952b11f1aa26b74ffac11d73-20260811
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 674466339; Tue, 11 Aug 2026 10:22:15 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: mst@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Date: Tue, 11 Aug 2026 10:22:13 +0800
Message-ID: <20260811022213.3466325-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811021900.3464410-1-xiongweimin@kylinos.cn>
References: <20260811021900.3464410-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please ignore my previous email
<20260811021900.3464410-1-xiongweimin@kylinos.cn>. The correct
full patch has been resent in a separate email.

Sorry for the noise.
