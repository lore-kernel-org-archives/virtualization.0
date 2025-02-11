Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2021EF085
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264084; cv=none; b=OhQ8sBhBGChfLyNcceiLz1i4dc3pLWHO0e/PSBt5/uVvkFyw9ZTMHVgw78j6sJWYnPSbwkirBp7K/YPapW8RFhiY5XvxIY/uka5rcg0e4JX1a+5vRxgLDlNJDekIP1fY+6+zhnZyY9mMg9lp/13qSuxq+31v5gAdnmFAceWiqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264084; c=relaxed/simple;
	bh=A9OGoTsHrjtvyBc5Q07ZgbbmAyoBumXm7SUvVbyvJc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u9QmyRm4N4jPo6JwwIqZNBKvu/mar4vP9BqGinRvSDXiuaIz4S3QEagXKA+JAEmk/+PY6fZPBrGrEXPFfezc1cTgRmbhPolK808waGfz7GZabSmRMBu0NfCNdx2R41/AD9Y/0dxuejOm9DtggRUrXHbcvgGbSzgx3ukCk2yfWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZq3/7Bu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZq3/7Bu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739264081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JLq8TzMXCM9fnXbwXAYKIjuUWhuJvIj9pOn4Osk/Hg=;
	b=GZq3/7Buua4e4xWI7jRkfUghkVpbsyf2KBHk/uEQi+KHCIoljcmDDc5URwia7Lu9PQ6SZJ
	BsdOpyrXh5EjxB04vUZ2/9ZSd2KkzXwv2yQstrmQNd1WEVv4+MQrtkavCNOYrU5H5ytqjZ
	QNfLPxm0kKqIWYOi3Vdu2t8j+iyVmZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-LJ-ccKQNM6iaboTFHvaM2A-1; Tue, 11 Feb 2025 03:54:40 -0500
X-MC-Unique: LJ-ccKQNM6iaboTFHvaM2A-1
X-Mimecast-MFC-AGG-ID: LJ-ccKQNM6iaboTFHvaM2A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38de0201961so1248588f8f.2
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 00:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264079; x=1739868879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JLq8TzMXCM9fnXbwXAYKIjuUWhuJvIj9pOn4Osk/Hg=;
        b=oh5OH+XPEMPEljvWvpWGBOUDYjATO+xDJozb+7g7kQsoS25x4x0jSK6fo6rOTnDtRm
         m2dVpzLrJBPx3ousYAh5Lvd8BqR9qkMb0QurZ5PNRPSgmLqpdK2vJuSy+HVkF7Gssu7C
         yM5/QQg/yy1nFBPyUqTJ7MvoOkf9LcPOQmXMsEiPND7XvzgZawfsZQuVH01+nXIEqEpD
         RJny+VMSTE8Ap+CF4KilKxxzVH5vf8DB1OMqh2fcWmoYTjn0ZOcFqJ45x6HPtBqDLm6X
         5L9xOEPVFe5r2ISlcmpQFtQDqo6+2D56QBGbl0bpJeVpGFjUOs76SXxPhgyMk/XOqVZ0
         4Qow==
X-Forwarded-Encrypted: i=1; AJvYcCXA1dqV8MBM1xvnvo5bQ45yIPWQ3VwScfk46+vq/yB7I5nnCywghcNyFbMWeWqiC/iXv2C8ZkRFFQ43U4EN8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKQaGt9n/mFTSkDdtfM8FCoD1lH9Z93ZK6lfMa5+V1KEUb0mjA
	cb12qJ+SVNmPcGIJqB8giK35caJmYFVpL0iUCQT/AnhQJcxrNBuWFU8g3EihVxlwQOGNuPC+KLz
	Suhdo1Y42ZAnnncHtGd8mLif/ikgnc/IlFRGK/RG8zXh0ICe8KrNVHdNwumda+72W
X-Gm-Gg: ASbGncsw+OSl0sF8AAr4jmEvfS1b6MQUHKQCQYIsKEED+9xun+T2HOVNJHK7La7qfKZ
	CTXQMZe4Y1ruph74GlJW96ZctinwfV1Tm6rhTz4/AeynCwY4yTC88eTiBuxZPFEOBs0ikMOQkjE
	piHU03omtVhkrLJIt67u+D//aQ0P7ZCXn+gprFoamrLHmEapTMdw7NHVFH0irB6YD2iAuIkHWL8
	HnCBW0vnkt0O//FHleG3BBtgFv0ZiMUe2ZBoOZtmp5DcE3EZWjjPGdpyHs95wNN+CsSx5sojPV3
	XVv6wvjKYOlL1HWejz5fuoc4H1kAcoNE0T2kW2QEJ15IRn92AxhqVw==
X-Received: by 2002:a05:6000:1a85:b0:38d:d906:dbb0 with SMTP id ffacd0b85a97d-38dd906dcbcmr7731133f8f.7.1739264079244;
        Tue, 11 Feb 2025 00:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+FXQlM4sVQQqQ6bfC1MLrVyaITtJSDcEgeRD57O/EtV7ZEKzfLqyRzc94bzpSoemBGMAbgw==
X-Received: by 2002:a05:6000:1a85:b0:38d:d906:dbb0 with SMTP id ffacd0b85a97d-38dd906dcbcmr7731090f8f.7.1739264078600;
        Tue, 11 Feb 2025 00:54:38 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394df55f51sm12596505e9.0.2025.02.11.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:54:37 -0800 (PST)
Date: Tue, 11 Feb 2025 09:54:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com, 
	lei19.wang@samsung.com
Subject: Re: [Patch net 0/2] vsock suspend/resume fix
Message-ID: <jeqyqnuqklvk4ozyfhi4x4zadb5wxjvnefmk7w4ktvjna4psix@fc244relosif>
References: <CGME20250211071930epcas5p2dbb3a4171fbe04574c0fa7b3a6f1a0c2@epcas5p2.samsung.com>
 <20250211071922.2311873-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250211071922.2311873-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FZVWh0r89Ke1BTmCnX5poXlFyPJe4Dh0HV_AWTxVsgg_1739264079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

For the third time, please READ this link:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

This is a v2, so you should put it in the tags [PATCH net v2 ...]

And also include a changelog and a link to the v1:

v1: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/

On Tue, Feb 11, 2025 at 03:19:20PM +0800, Junnan Wu wrote:
>CC all maintainers and reviews.
>Modify commits accroding to reviewers' comments.
>Re-organize the patches, cover letter, tag, Signed-Off, Co-worker etc.
>
>Junnan Wu (2):
>  vsock/virtio: initialize rx_buf_nr and rx_buf_max_nr when resuming
>  vsock/virtio: Don't reset the created SOCKET during suspend to ram
>
> net/vmw_vsock/virtio_transport.c | 28 +++++++++++++++++++---------
> 1 file changed, 19 insertions(+), 9 deletions(-)
>
>
>base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
>-- 
>2.34.1
>

