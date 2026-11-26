Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674475;
	b=EKztShtKxuVQ0entZAxOjj9FowkrmJbrywSoDhhNpzvzNcHn1ZipX1p7ur1VyUyY4iYD
	 MgJ1STrOS4zcskF932VLSXmmC4XZ6SqwzdAQYAg24JiXUeshjyYMjK8l4W8ImPZavO7lX
	 fjr7HdvlbEbp53v0pONnrMySTSgGwgeYg9CR8gRE6CILFoAL1/yZheeGnW9F3L/o4B8NO
	 7x5WBXNuoQg2PjvYF4P9FD98GRpVR8qfwuX04h4BaHklbBtGqdf0/aQZQYnZkTsbH3CvA
	 81B+P/wdyNsX8jXDvfmt+FRGmWiC4tJlx3tzrwvYYF/dclUu+RBGVojabnx37FLExtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674475;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=UtfGcVjhbtyMbWnMCWBbJdWulh+LbtmfIOwER82/A9M=;
	b=h09NSNYGU+Ukk+2c6/BmqASZr7M0ruR8Q+aQBOgfoQRqimLcmL2KWAbdKNt3/hC7/PD3
	 KSYymczbSMqEBNp3dbhFmS/rHmt6luXTaLU493qEGnjpqWy2CdGBdHJOnbsTyjCJPITSH
	 M8L6D6lRv4bVOYbJ245T/4StCpGpntGyltk3oJkPpoSHtVRxnhKJCIa4Mq22d7HxTpdt+
	 dK4h4YMWTj1ylO4+Iks9W8CFdPF6gW1Qy2NAK8kieZpHg4LHXtFwcdxuZ8r4/JEe3INgi
	 rDKJdEL80c4kMMvX16V1R2cl8tcJpxjNF+bZGzQAWasjI+PizC3Q9hBkZgfXEJl+Dxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YU3dz5z8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09359606A32A
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09359606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YU3dz5z8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795674474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UtfGcVjhbtyMbWnMCWBbJdWulh+LbtmfIOwER82/A9M=;
	b=YU3dz5z8hxqa3dUPNuSS31CKO9673zsvf0BAhWEZS6/xpIgvzKUklILav7xry+r9tXMq8n
	B0EBl7XwOsPs3/iqi/eOGn+tpJDHUvW/ju5LZhUi5pua8fmBB/5BmrW2FBToVL1S+tQ7Qc
	k5uRmDLolmaFC+50s88hcvRPpWmBrfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Jbx9mJMvMv-9l4lAV6URcw-1; Thu, 26 Nov 2026 06:27:51 +0000
X-MC-Unique: Jbx9mJMvMv-9l4lAV6URcw-1
X-Mimecast-MFC-AGG-ID: Jbx9mJMvMv-9l4lAV6URcw_1795674471
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so46417915e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 22:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674470; x=1796279270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtfGcVjhbtyMbWnMCWBbJdWulh+LbtmfIOwER82/A9M=;
        b=mPTRxnU6jUcLBjjA8HjMUodeJc4Nn5ZWlPITXc9VVwvJyyHwvHT0r2o7sH+frUfSgp
         lXF8vp1jx2KQz1M93T3q9/oP3+wn8hCN9Tcer7x94PZTv7ZcP2DQ6LSTdtsPvhIcukMk
         P8/jSAXoLax0Tn+EamQfXF/ubOzLK+qZakpbsO9ic89i0g7LgPIY11UM35B30CMN0pGU
         4DoLIk3r7WFKffYI8xJRIS7+ibm2SNHsAF+NOBHmfHrsuzfgFzYj9vPIk0kmLbfcf4tL
         ZiZJzWnYCdyYk6Y96TsXxwskFKQGffhmCgYxQktsn/ehchMZ1d8zN+nEREdWQp/nyKqz
         i/Kg==
X-Forwarded-Encrypted: i=1; AL+hErH5yX9gpIk0E3gMavBBQVc7EStYGM7QVBLz97s2PiqLZAfh47JRFB92zuzQRY4MUbHZKhSEw7sP2oZbgmtXng==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RtROAbFrrVUPv+nMZzeVOUdsPWhatfnRwijXp5koVuEnmaNwX
	iwmdH7p+9VxEhgcigMVJQg48aS+XwxBwI91UIftUjKYcZYG1uOIkDjj9iUDoVfXvcsFJgX/13Vm
	IU24g/hRo5J+1tYzj7FfZtB84dIV7GzBXg3G/gqiu3LFTvqjkRlCB0SvxTNnfsT1ndoz1
X-Gm-Gg: AZFdTZcV01J4w55v2h3nTNy1UV8o+IG+k07/dOF5V3LKtQ90YW7lNQ5OizQOqvuIhLu
	BWoAbrfE4a2AZCTLjxDwRhZOpToZ1lPddAQHepGWpOev0oRorUVUOXhSd4awT9BxBX5erjHyKBw
	pKFqCGNIez4VT1SBrHIZYKhiIZS7WXSzvr7B/tP6NJRRxn5Zc3n3JEi2Pet1LRoSoav5ZQ0cwNY
	kZG1qsarg2/6RhVNlTdOVlgadC99keC0WNOV5f7hudg/HewRWcSBXifly9incjaIxnkHBu/ljxq
	ZC4j/0HdYct6ChYj0ltHV3opYx9JIPeYPpFdQvagdjpvNrxfcdKxPB2ZblydSd3f81CPMFFxYXt
	2LyGSiWiW08aXwHuCBI45YMYaje+jv/11iKUD1wKtB1k=
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr405069325e9.4.1795674470481;
        Wed, 25 Nov 2026 22:27:50 -0800 (PST)
X-Received: by 2002:a05:600c:820d:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4bb887c2ca3mr405068955e9.4.1795674470015;
        Wed, 25 Nov 2026 22:27:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm44293956f8f.24.2026.11.25.22.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:27:49 -0800 (PST)
Date: Thu, 26 Nov 2026 01:27:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Flemin Jose <flemin.jose@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] virtio: Add vendor-specific device ID
Message-ID: <20261126012523-mutt-send-email-mst@kernel.org>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-2-7b49bda74916@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-2-7b49bda74916@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kf4n1NsU0sMP4w7csrQevXfUjDpm8Q-PhFrlGjrgtUM_1795674471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2026 at 11:54:00AM +0530, Jayant Shekhar wrote:
> Define VIRTIO_ID_VENDOR with the proposed device ID value 52 for generic
> vendor-specific VirtIO devices. This allows vendor-specific functions to
> share one VirtIO device ID and be distinguished using their vendor ID and
> platform description.
> 
> The value is proposed for VirtIO TC allocation and must not be merged
> until the ID is formally allocated. The DCP function driver should match
> the generic device ID together with Qualcomm vendor identification and
> the DT-described transport.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..9a8b6a6a03a4 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_VENDOR		52 /* virtio vendor-specific device */

I am fine with this. But it has to get virtio tc approval or you risk
conflicting with someone else's id.
Please request a vote in the virtio tc going on this one and resubmit
once it's approved. takes a couple of weeks usually.

>  
>  /*
>   * Virtio Transitional IDs
> 
> -- 
> 2.43.0

