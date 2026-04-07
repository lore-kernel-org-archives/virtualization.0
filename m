Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C93B38A1
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578985; cv=none; b=GzEtcTsAoYCUTmW1TCFpMk8bniCSVNfYkw0H1IOXL815BqUQAUpQI4U15pVJgT8k7auGuaSCVChg6bPBKGAkho3Lrl6QTne7wIb/GvSif2Va1jJTE1gSkX/ODL4w7i6lVLZeNYwLJfMncXN67esyjdae/cB0+jvw+WNVIT4XptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578985; c=relaxed/simple;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FWC6pjY+oITnSz1q1VUSnLrSnyO1dm9FW+s8I+0au+sQKp7qFPbrowLZraVMtQKisC8mqSl3JNUWXF+DFB1NxU5E778ux2e/2TulvV6wmijwmCTEdKmMOfWDO7AP0o43/Czkm0HrofAjyLtGDshE6RtA4PTn4gpTjbmRc1JdPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAAIRVkZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAAIRVkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
	b=IAAIRVkZ9KRCN+WREJaDU0SdEV73KpV/fzZ82XvRxXSLWkusULW4zKcIdbmwHYiQSB8Zf1
	2oNFxzIsb4d5lCrtsDdPMFU9E2FHhaMQexa7uvs2wiy6mK2Qub3qdkqgtQH1y2kIt3CtY3
	lNrLVLMruQSP4rFAo48V6wP6/mUlAgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-jfxdi5f0Of-HT2ljS_gpbg-1; Tue, 07 Apr 2026 12:23:02 -0400
X-MC-Unique: jfxdi5f0Of-HT2ljS_gpbg-1
X-Mimecast-MFC-AGG-ID: jfxdi5f0Of-HT2ljS_gpbg_1775578981
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so6960845e9.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578981; x=1776183781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npcNeRLpBOM6AzePvk8du8CWXMtHoBqLRVHefaNpStI=;
        b=Ajm5a4jOYAQJpJsIhoe3JW03XTwb6LhNJIxGsBNZ5wUyzTHN54dGdR3adYLf0Xu4iQ
         p9Ehy2dObYQ2myPeoJcBZEXZoXg34vNPUn/bFxAe1/MviuOnOSBOhSe6kf/kXIGGrE6M
         Wr/UEchPoW6QT7fF97tQ89uoVDyM+uVNKuGpL+o5G2i9syH2XUZQIyetK8Vr9z5HGPuq
         8GtCjvaZ1vPshcVKsvbEeyhsewBJFg27mYSxa+LvKqShy8MNbYxO0QTpVXbrqlgyjfHe
         EeFANYMGbQLShG1EUzugStHxNbdU+FtcC/4As/NG7bT0l+/avl8qqHyGhC5LeMu+EOxr
         TS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCSzytrsWL55cGV4WHAQje8vOMQUlazK2MSJHL8yaJ3MV5j2E3tMeKx2G138dpqivKo8kmKTs3Mg0Sgr9BdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgDV/QwnXqhaTINrnCpPo/E73VWeiai/baYx8Ze82299Kot4HR
	cAT364zLUwhDtxpKRdBQ5iSiTpZpcgfIR/GxoNdRR7KRXb3lWvoUwVDZ/nNoGPy/Wqw+XfhsZ9h
	fLgaKS3XoqFBiIoB4OgG0P5lBbR8qaBXb6Pks2O13Z06v2NnF21f9zhrTgqH5W/jmFKlN
X-Gm-Gg: AeBDieueB6Q0Ov5/iWFd7D7aRMhHo0AxgwckiLkSQouPCnP685NDaXaSUFusCzGG/v1
	QzrA474APWKr0v76SumIWosYqnpvPOkB2mjPTCb87BhHzAt+JWq21AHI4cHC7UD0DPnTdkmabn1
	Hsmcy/rNUset3lL0D9qsQD2LiXP6z5nug8e51Gy3Ds53KeEanbeUa+IerL5hWuPiY2tAyzFW1pD
	ER8I1SNzsHkAUW3790H2MTeHl1xnk1V1aCqy8SJj49ZAyyfRfP3VZ/QI+l8aLeQzSl4rzClz1ys
	HiVysqcg10xMPCZZipbMCQfsHLdhUE9YfbxTpJUQVLflBg6mCgfT0QEdzGKIqVluq7XP28LwXka
	FiPwwwmlqd19QQyep6LWDWUID2jY=
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226451115e9.2.1775578980906;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr226450755e9.2.1775578980501;
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm60518000f8f.11.2026.04.07.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:23:00 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:22:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvRegULccN0hiL@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <20260407121515-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407121515-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WLwOVGYEQILPd40yyWA7kFr8gz82nPmokeQMG7yRyVg_1775578981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 07, 2026 at 12:16:27PM -0400, Michael S. Tsirkin wrote:
>On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>>
>> Remove it.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>but I think we should drop the Fixes tag.

ok, should I send a v2 without the tag?

Thanks,
Luigi

