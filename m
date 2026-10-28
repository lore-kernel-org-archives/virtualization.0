Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192745;
	b=ux5C/uGUVxh7B/825bblX17bfpjfUuomIylnkR8z1CR+L0iY2tt3qCD16aH1EDcABHJo
	 +JhSOQTDn45Tx1GNAFXeUSTYHx1IUN7mg67OscPAJNGzoh8sN/7Arlcx/Anb+RWuWd0Wg
	 RZ/1bdZxI3Rm2Eag7rzARohC1bu/zW0yz2XD01oHZXjy+RPE2hMfke5Zs/56YOvIMV1Yq
	 vjkO8LWo2LLuTFvbhR3Cj2imPkjKo+tv0LnkcP48H5KjiatWujhTWaqc0WJYekglFnSGi
	 jUjU2AsrYJ75OVu8bZpfv62n/jDzaWcYHB2tUqdIBj+/evufTaGiEDNQ4836sqBcwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192745;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=HlIvIXJKLVJB/1qR8bgVge7CgWMQDTolT7Waf/npOH8=;
	b=gDclUH3DarSj/2OtL1eY5TeD212EEsjIYtbeuwKfMdlQklDoaXC6uWX9UdFM268p7QBt
	 7YKsSDDE4ls6lcEaLlZU0od6gpWxoGdhJsgivb0R2KdEhQtJk10Z4wp+VqbNZL4PLFlI/
	 u8nJs+Xe2Q7oQvLAZIXD2RnFSg67veBspRd/J1edeIslV6vQ42JW9dWY28yiKWgb8FMQW
	 ZWhTM3HdAuqEhuZvSbEQWcPesZT8QncSw2U0DGk8xAUXbN9eCbhgcf3XzrotcBBZp6vZO
	 ItPbc9DSZP56OvVV93f4XfqNa27QymnWn0f3+nGVRUNTe37b3YbRi/xULLeggA6e3ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PeJBBQ2k;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C28606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 13:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C28606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PeJBBQ2k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793192743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlIvIXJKLVJB/1qR8bgVge7CgWMQDTolT7Waf/npOH8=;
	b=PeJBBQ2kfwuD/7vy58bCmrHpqV8xH7j52/AOtiK9/AwaV9/Wz5GbMRRwnSLwSfG9Mmqinw
	f3yprGGOB1GWS/Qtpbjp8ZYcTQS2iqqRRmpEXbK8qfwspZWqfwSilWVafHekQ23KHcSBin
	WLBdJ82+8UifhDId3sTu2AMZkvNLiaY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-qCBxzQY1Nj6Z-IeOEAZcng-1; Wed, 28 Oct 2026 09:05:42 -0400
X-MC-Unique: qCBxzQY1Nj6Z-IeOEAZcng-1
X-Mimecast-MFC-AGG-ID: qCBxzQY1Nj6Z-IeOEAZcng_1793192741
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so775974f8f.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 06:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793192741; x=1793797541;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlIvIXJKLVJB/1qR8bgVge7CgWMQDTolT7Waf/npOH8=;
        b=eohe4lc7TTRaK94Qk7TOCqM6hwa2gHqQRQYVf+j7e3jj20Kbo1aOrqljwzCACD+QyK
         nP7N5QhEEcwiJi3Ped/7VGrGA4RUY+0UaOSazoXbjD5GbsUWh8OY5guSNupRPbUc6OKB
         c0n8T7BBeLsR1j24GaD44PtviiUT5zzd9TBQJzUgOLLxEtNnTeR8hpZh0nZPwtDlQ4Hf
         bdaPzSdBK4J5yfQdZtrEuHK1mMqkILZWKj/so3kJjynr6Wne0pi4TF/MdvWvHigLDq2H
         xiHph/kmLUL8u1URsBMx2tc/y0Pan5DWdpcptRg91pjotEz3Ha0oAw+rJbDYhnu9LX+E
         aqBw==
X-Forwarded-Encrypted: i=1; AKwUvBztB84/Lz/dkQnowJ7XF1Fvji1BC5KROCk1p/PIbEx61pTQPo8CLUZWTaeMq3o0QLV5DDfdrrZQwG1UshsIdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIL4PWTA1IXBCXMyXaqbCtt2eBxy5SiJn3Lf4sr9Y6BhjrWxG9b
	t/hY+TQ4EnjnzDjq1cXXu6HgLKxXH1tCCjjuS3LCc68vvBR8G3MzoZkGH129Ni5COsrW0mLlb4x
	s8cTNPBY5dd40YgytlOVmcWPHN12cDNVRBxrpnuQHPWRjceBmTWISjGtOdao3OAM+3A2d
X-Gm-Gg: AYBFou1QlGU2nq18bGkDijUV822/MJE614zEnQO4nM227OxwDY6E///ZlNg+Byvu8su
	wfE4rOwEYlbkkHBlq3t198+iweUN5oZZLy10JVJccSOqBdsQCOstUN6BZ9u4G+RE8j8hXWptuBt
	P5d/ozO0UyPkmzK2Es83O2NIfTB5WPq9OtSUPrFftHNgBXLFHcB1QKMm2zV3mv2CCKUqLMzzGiF
	8wm7xC2LMAKLvgpT4ymm5mR5Qu01Tfsr/pi+Pb3OyqzBvT+Prvpg+PPlkmrG5SrgAe4oXrTNAeX
	uhNVLgkt5r/A9CeUAfxUuB2GmQWRCorvJHlJ91Afqpw3xm7V+igrrdgcLmeJkQNJS8m/k3gZZ/Z
	cwHBewRAO9UhWt/rRK3L4JRjdzDrg/TtwMGhFMW1v
X-Received: by 2002:a5d:6d22:0:b0:48e:4f1e:5e24 with SMTP id ffacd0b85a97d-48e5d59097cmr4245313f8f.14.1793192740772;
        Wed, 28 Oct 2026 06:05:40 -0700 (PDT)
X-Received: by 2002:a5d:6d22:0:b0:48e:4f1e:5e24 with SMTP id ffacd0b85a97d-48e5d59097cmr4245242f8f.14.1793192740137;
        Wed, 28 Oct 2026 06:05:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm28484831f8f.34.2026.10.28.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:05:39 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:05:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
	Linfeng Sun <linfeng.sun.dev@gmail.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [REGRESSION] vhost_iotlb: bound map allocation in add_range
 breaks vhost-vdpa on hosts with fragmented memory
Message-ID: <20261028085839-mutt-send-email-mst@kernel.org>
References: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y-tumC5JGqqegX1Kb4BfVqRexazUndVzqLIjw4FLWk0_1793192741
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2026 at 01:44:30PM +0100, Dragos Tatulea wrote:
> Hi,
> 
> We've started seeing regressions for a while in our verification CI for
> vDPA Live Migration tests. Occasionally the FW returns a syndrome
> related to invalid mappings during device reset.
> 
> We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
> allocation in add_range" which limits the iotlbs to 2K by default. On a
> host with fragmented memory you can get easily more than 2K entries.
> This results in truncated/incomplete iotlbs mapped to the device and when
> the rings happen to be outside of the first 2K mappings the FW will complain
> because it got addresses that are not mapped.
> 
> I'm not sure how to fix this though:
> 
> - LLM suggests setting the 2K limit only in VA mode and using 0 as
>   before in PA mode because PA mode is limited anyway. Does this
>   work?

Well no, we do need the limit in PA mode I think.

But we should maybe  bound from what's actually being mapped rather than
a fixed count. e.g. X entries per pinned page? Bounding by bytes instead
of entry count is another option.

Also 0 is now rejected.



> - Can we detect this and reject the device / stop the device at boot time?
>   Probably not as this doesn't cover Live Migration.

Exactly. Besides, failure is not at boot.

> 
> Any thoughts?

Does boosting max_iotlb_entries help?
vhost_vdpa.max_iotlb_entries=65536? Or sized to guest RAM?



> 
> Thanks,
> Dragos

