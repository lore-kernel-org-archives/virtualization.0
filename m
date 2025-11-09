Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6C263C8C
	for <virtualization@lists.linux.dev>; Sun,  9 Nov 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724283; cv=none; b=RuFSpulRwY8X09XDqVx7QPVxYJkkyHQ6O5wc811wMVhUSqvnz2TbejVncjHKdj4xL8Un+Xlto1iY9SQ00ai5eEIcBzen+uZcK5Y6wuy3i6yYtnT6rTRe0eRfF5EZNv1FB/y18J2ovFmW4Li9od0es6wyyPvm6jziRcsT4AUysiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724283; c=relaxed/simple;
	bh=DIzUN1s4DEuSCXVSJ04xr/mRIfhhQkl1RR8veyzoBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uwUI6mQxN3qfj3dKzUG1MMLQQSfE4aY14zhZ/JafX/uc3BcGy3QSj/3fY0tZGrs850725Rj3Mb1QJGIH4TrPNIQ60J8pcCcyVT1G24mCSxwa9bOp53+xekzxGS0EAIxqUQ2dwOAz2W+Yyq1hfgJQ51t5RXxedI8mAOC6TMuzENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ2VMG7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ2VMG7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xvyjmhDZgnpP4TOu14SeMoSyT/sv3kAnEbdVl0JxBi4=;
	b=KJ2VMG7jvVaG5uc7AwaR7HZZUw+bwCTsDuhSM59Nsb9kLNG/o3UjzOjItLTtznXXF2Gokm
	mRnLeMyKHEMxzZIEm/9ObQo9CFBSJmgf/bhddlMhv0/QBEVJ/iDcbfoGPSXOMysuKL84cp
	P2DvuQQFiXa5e2Fl/PEITlcpbpuKstI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-udk2gfzjMP-0QDj0iAR5vQ-1; Sun, 09 Nov 2025 16:37:56 -0500
X-MC-Unique: udk2gfzjMP-0QDj0iAR5vQ-1
X-Mimecast-MFC-AGG-ID: udk2gfzjMP-0QDj0iAR5vQ_1762724275
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47778daa4d2so5744345e9.2
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 13:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724275; x=1763329075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvyjmhDZgnpP4TOu14SeMoSyT/sv3kAnEbdVl0JxBi4=;
        b=wlOVyozhjFv395CP+NkLL3hRgcj67p6oXSPg/1237kdKJscCTeSdtWXcp+wLZCW+ZN
         L1P8oT4DddS3yMWXcYWc/WIu4mtnuf7z4VL3rY/R7wTBHPD42jsyY8Ejurw8gCvJALEd
         Al01p1DuzjodyPRWsoQE3gTxVvph2HpRMB0RzlvipCSCSPW+G2s8d/rm3aB0NT6ajJmo
         JDZwAPk1EFg1cg2bGOLlq8M+JX3bEjw/a60RTJwTTNbaUSbgIYYCtbPNtO5pMXgsOUH+
         tKKnkTiqy66Hp3a+A780jdWuEjDERKYcxWwvP7nEH7lfqZtFvoAp2+d+f6WQXjIjCGYv
         TBGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMUs25iYuAzK1fSeC+Gx6vhGUT8CDAV/txkowel/XzTcrIhzN8QaE4lJa5JJIqCiPFMJJJoT6dVfcnfEz+3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwNB7mZxCOOWHwJIFT88hrrIMAO8sDobP0ultj2QtcFeUaNwQX
	j4qBMJNW64nfC8IUvAx3iMNj7Q2CzgQX0GJx4ymkF2tuRAL6BndMMTL2kiY53bI/YB+9tnhTUjH
	9JJYkQatLzAavqBqep8lJ4+8SVXECGQfNXJmsRqc1lJTozXtBI7qQO/UmAZ95u/dhe20t
X-Gm-Gg: ASbGncudMa6QNx23ytK7D4Iok8pyR2Vu8Hj5n+vrKtTU0oxux4cid1atym2BU+UgSrM
	1O0jpqtd58Bp7eJKurP7vh9MIMEyNLPkuv057V2eFFHK8SyrVCuPCgCFVBI2oye3vSkKyu2Ve/M
	4eS/dzA4ZL1MaGipQ8jcT9H+GAETdXInWaLEHvhG4xXEcwQJ2auTDCWQvVb6QHBwvJ/UQIbTmDB
	HREDVnTWR+W5q8Qmuxq6DC5pqw3VTMKeCvJXwqlj6nGKMINpWlfVXU/kBXv66rPbT3OONA5PIZ3
	DtFE/NsARPxBtV+yzHGV9YSr/+paGUmJK6cRuBlO24We4LAr+OI7i5u8X8tR51zUJAs=
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-47773297851mr52784285e9.38.1762724275294;
        Sun, 09 Nov 2025 13:37:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0U/SG3m1x4dqg/u2TGOQBny95vM3jKF8Mmr9odg5lF81Z80qmr88J50kweLcG41uASeevvA==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-47773297851mr52784095e9.38.1762724274820;
        Sun, 09 Nov 2025 13:37:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm282270195e9.10.2025.11.09.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:37:53 -0800 (PST)
Date: Sun, 9 Nov 2025 16:37:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 2/4] virtio-net: Ensure hdr_len is not set unless
 the header is forwarded to the device.
Message-ID: <20251109163644-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pCxQDREauUigMBf37yWBGvPWhSFr62LZI7DrfAONqEo_1762724275
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 11:09:11AM +0800, Xuan Zhuo wrote:
> Although `virtio_net_hdr_from_skb` is used in several places outside of
> `virtio-net.c`, the `hdr_len` field is only utilized by the device
> according to the specification. Therefore, we do not need to set
> `hdr_len` unless the header is actually passed to the device.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

maybe ...  but what is this patch trying to achieve?
it does not seem harmful to set it ...


> ---
>  include/linux/virtio_net.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..710ae0d2d336 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -218,9 +218,14 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
> +		/* In certain code paths (such as the af_packet.c receive path),
> +		 * this function may be called without a transport header.
> +		 * In this case, we do not need to set the hdr_len.
> +		 */
> +		if (skb_transport_header_was_set(skb))
> +			hdr->hdr_len = __cpu_to_virtio16(little_endian,
> +							 skb_headlen(skb));
> +
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> -- 
> 2.32.0.3.g01195cf9f

