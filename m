Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128684;
	b=t+H2sMV1hGM70EJX1HX46oPjKP/L1ObfnXY23teJqq9wdJiupEjN6qGVsg3oW2BOOB86
	 eKrHZy+SliF4wusmzxT+4jy9qUgNsFZa/Dt9YuBZwr/oR8EkJsP/ioGqVjQkyfWlPwCWe
	 fPnHVV3foE2iRbmZXNNjxdpZkSkdqgvL13tYiytRgA5DnnkY2ST5LN2o3jG8po9JAm4/e
	 Vsa1VBrcHCJyN4A0iNswOuhM0eMP03k0SSnP+yiLMoyZpodPPTPvvYXmzB3K+uCJ43P3E
	 OpKyw/PBbABzOCN2QZKT4Dlwal6E1UILa6qC8Lr7d3J/gjED2KD8SfsdYaoXIDGesEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128684;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=7/No7ycCs2MnT2orES72SqWWMGh3qVK3ShQRxwctkpA=;
	b=vc55Tgr4G4dGwoP7JCQ7LY8U0ba1smDTwFN5rvV6Co5rvwlgRkiplOZ3CHASH2y5+XIW
	 h+stXaWNoWXp1yLHJe63Wg1AynDn48pFe4ql7mvfSOHP8JhWMmLDAEoVmialOqL+Dyxcl
	 ILMfpui/3xUBGTFqdaJXZoTenq2eda8BAIMOMLyDgBrz+7b61C5/lWpEyno0DICoUHM5S
	 sv0xqvsY0U7jE6CS6VAy5kx26gOegCnRFbbMX81Y0YMMS7v0xTimMip9tfvQqMRW9ErtU
	 NN5ayVOL+5VHs6I9YFToCdBV2xFyB42b9xO9vJMncIWyDiOVnj+CTEeQpGBFRmb3RCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ElhbFZtd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C864606A322
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C864606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ElhbFZtd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793128682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/No7ycCs2MnT2orES72SqWWMGh3qVK3ShQRxwctkpA=;
	b=ElhbFZtdZPyj9czhrxl+1rcg2XsB6Ud0RLkw/fRjSPE/5c0qBRZ2xeAzjAU4BGPtnjf2W3
	mmDJBMVjYUrkPiebikfY1OI3lfrF/uPB65lNX7USgKXkhgtInpeZtJXCColmK5mPzEzFr2
	prMq+H3JpWepGT3oWvrfNkYUpg72HMI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-uA8oikN1OKqB5a_uqW4b4A-1; Tue,
 27 Oct 2026 15:18:00 -0400
X-MC-Unique: uA8oikN1OKqB5a_uqW4b4A-1
X-Mimecast-MFC-AGG-ID: uA8oikN1OKqB5a_uqW4b4A_1793128679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910C51800619;
	Tue, 27 Oct 2026 19:17:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 253971803A48;
	Tue, 27 Oct 2026 19:17:57 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:17:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: shao.mingyin@zte.com.cn
Cc: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev,
	pbonzini@redhat.com, eperezma@redhat.com, hch@lst.de,
	dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in batched
 completion
Message-ID: <20261027191756.GB933537@shajnocz.csb>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: I3UYqYggkk8KQ9wBzcckRW-oOJh6qGK6GykDBhdr-9Q_1793128679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2026 at 07:55:19PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
> 
> Move the sector update into a helper and call it from both completion
> paths.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

