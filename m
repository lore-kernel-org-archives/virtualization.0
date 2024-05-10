Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CE82C6C
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339159; cv=none; b=IkzKD1BA7JSOn346Xyxd6B6OgwbD69oTXfDxTRM0Kf6HwGMbZLlUoug+fxsPSG4b4EFu57nuKQ+6E743d7OyMx0kkmW+2Fp5oNFOUXFg8AcDwoRHiU91PY50C6A6V+loOi8WDKB84x9iQ2AkICYSB800GLWKNL/8EehXSI4DXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339159; c=relaxed/simple;
	bh=DSAxSthP32p4eK9TfHqe0ZuhLGmv0MhvRe392DgN4mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oGYKJArcfh7thxqECHAm72LGivta76ohXZa4Psm7AWq6mO2g9diVc6Z1fjDNml98aTYDM19sxcdkhmYzPPLPsb12aaH1oBD3GJNA5VA/TRc9MjTBZ+9xbcgN/ch6P5nsptTEAa4kzah38zjbRETT50/RARbUZ6yrcPJq0BJ/tpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGOZ4CC5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGOZ4CC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715339156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPRt2Y4AnsfaaiCYqn3j9LRsbSbVPLgFUqtVKabVFYY=;
	b=iGOZ4CC5M0oxp8LrT7Owqfaamse9o9F3AmTTqUml4iZRqJJhsjI3cY314sLN7ACYFMaFET
	2WWAzFzFK+9LZDgyiBCm5zWY/0L74TzLoZf9AIcaWTrXzegTNd0NecZ+N1knkD1liq5FBm
	BDU6qfvjqQQ1WHjFT/+gB9/qrQJNUmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-knUN4hUPO3KPETscY7ZIWA-1; Fri, 10 May 2024 07:05:55 -0400
X-MC-Unique: knUN4hUPO3KPETscY7ZIWA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34f7618a1f2so1459648f8f.1
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339154; x=1715943954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPRt2Y4AnsfaaiCYqn3j9LRsbSbVPLgFUqtVKabVFYY=;
        b=gbzJvOsf6BISIgLJI48JPr1R9aLgcWTXAqT56HHc/mSTiIq+UWtPV3modmwdtNAAbB
         krhXfsCdFoXQRa+M7QNhwNs8A6LRn3kYBCxoG3WxF7VNfmRPfWYryuL3cBT/40prd93J
         9PRgx9xkJSYSPWBv9g7jojo+5KFAospTBIWy5vUvL43d9Ut5pzMHsgFvGJLEaMvepWjL
         6t3gl9ufCGtNvBphv0GjYtHrz+U82sXwj9q7fA7YfiJZsqwVwyeMZICTvTUxGLCmnNLw
         Br/aWO3KMipxMF7iZNPVAbJNqBYEZyXnDqa9Esimxw+sZ0NA1vSnor7pag7t8NKzOKWD
         kgag==
X-Gm-Message-State: AOJu0YzVZnyNtsUQd9pyFUDEA4Tigu8u3ShneynnEl0REHSJn+S2bq94
	VBOyEtDW4L6tNJczNTmfZPn3VRPV2TkdOl9VKIE0heDIR1mH+n7/Vb/tboecmygQuiTrGiFy3vE
	/DuCY4yO8xfk0gvbRz8MfPbMFVBhXByg+NzvmNAD48LCziL6N2dhOb6g07VFySjxu
X-Received: by 2002:adf:f5c6:0:b0:34d:7f59:30b8 with SMTP id ffacd0b85a97d-3504989ebf0mr2386870f8f.12.1715339154073;
        Fri, 10 May 2024 04:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHV5U2/JolpU7vkn8Frhsm4KJ4WflkqN39x8YNjKblG98njNHxXkQGtWMACJSPiKa9T7WHQ==
X-Received: by 2002:adf:f5c6:0:b0:34d:7f59:30b8 with SMTP id ffacd0b85a97d-3504989ebf0mr2386835f8f.12.1715339153527;
        Fri, 10 May 2024 04:05:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502e5e0b0esm4135647f8f.26.2024.05.10.04.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:05:52 -0700 (PDT)
Date: Fri, 10 May 2024 07:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: virtualization@lists.linux.dev, vgoyal@redhat.com, stefanha@redhat.com,
	miklos@szeredi.hu, dgilbert@redhat.com, yorayz@nvidia.comm,
	gurtovoy@nvidia.com
Subject: Re: [PATCH 0/2] virtio-fs: introduce multi-queue support
Message-ID: <20240510070542-mutt-send-email-mst@kernel.org>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240501153817.540855-1-pgootzen@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 05:38:15PM +0200, Peter-Jan Gootzen wrote:
> In this patch set we are adding multi-queue support in the virtio-fs
> driver to enhance performance.
> While multi-queue functionality has been in the virtio-fs specification
> since its inception, the current implementation in the Linux kernel
> creates multiple queues, but only enqueues requests on the first request
> queue.
> 
> The first commit in this patch set limits the number of request queues
> to the number of CPUs in the system, to reduce unnecessary resource
> consumption on the device-side.
> The second commit adds a multi queue mapping to the virtio-fs device
> driver that is created using MSI-X affinity mappings or, in case of no
> existing mappings, by evenly grouping the CPUs and dividing the queues
> over these groups.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Future work in this direction could include:
> - CPU hotplug support
> - In case of no MSI-X, using the created multi-queue mapping to set
>   interrupt affinities
> 
> See the commit message of the second patch for performance results.
> 
> Peter-Jan Gootzen (2):
>   virtio-fs: limit number of request queues
>   virtio-fs: add multi-queue support
> 
>  fs/fuse/virtio_fs.c | 73 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1

