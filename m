Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6CF4F20D
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQTTLj1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703605141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wV/f9f0in7gn4gktkxuOHq7lnBTOjC718N9fK7Gr2Iw=;
	b=XQTTLj1fhrtpcJDoNLryUteJFI8scHXMi9VzDi464QcLTS/vK7i8ylkNS5Wxb1j89F+Wd9
	TVXOr+YT5RafOITEWTW1s6i90f5GLfoNKn1eWLMPwuIFO1drR9x7oyRip8px3tilHU2Hsd
	3cAbrRYGQWpgcM38p7FRLIooRbTsaU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-kNXY3zAXMj67d3aYmwWWtA-1; Tue, 26 Dec 2023 10:38:58 -0500
X-MC-Unique: kNXY3zAXMj67d3aYmwWWtA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d5b7be93aso4218575e9.2
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 07:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703605137; x=1704209937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV/f9f0in7gn4gktkxuOHq7lnBTOjC718N9fK7Gr2Iw=;
        b=Q+hb0+aoQ3r2ikqvH6iNLpMcjCoULeZhA4nkdhyBdyOwDfi6a2WLjGQ5UZ1WupMbhQ
         ZTORR9LTsBbYHRI10FRFx7Rv1sl4ohA6UdYJgphII8eza+RqbuiuXvKKzSIF0X8GWhvU
         K5XyedybMmEO8gQJIcjyI0L416C9YH0ttwdmGv5jmF4BEbBEQ5djop0ohYW0urgxcVHo
         JJ9Yc37IDfVCK5LWgCNRcG+vI+O1WDYaF62Q3Jp+rVPqkzefJbfZ3K8vQaBiz4FmFC/u
         qDPc6TddOe+O/McYAzRLcZsYnYEIUYQgLsWaGBNW+b35RjcatoruKA25K6vA+QFtl3/S
         Yotw==
X-Gm-Message-State: AOJu0Yw4cSlNBqBPULCED8WRCTD28/n7pwf7sORe+3EMBOyeu6NuEYh7
	cvIBKEWLCbD/pRE0ClLpm2d2DhGOcCRUYip1OmOGbEaCX7bO8bKBwhdC2sFMWEsAVW8/pmPaH3t
	EDTXhR3zXkOMd2M76n+ilNmA0NnxO0PXc00U=
X-Received: by 2002:a05:600c:5405:b0:40d:2d25:b8ee with SMTP id he5-20020a05600c540500b0040d2d25b8eemr2051621wmb.171.1703605137303;
        Tue, 26 Dec 2023 07:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF95K6/sVk5zmbFYd7DofTvHL9+lGHyoYvlXR0NoGkiR28DSEG18rrqgMucy+nDqg7Ulg/sXg==
X-Received: by 2002:a05:600c:5405:b0:40d:2d25:b8ee with SMTP id he5-20020a05600c540500b0040d2d25b8eemr2051613wmb.171.1703605136846;
        Tue, 26 Dec 2023 07:38:56 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003feae747ff2sm14254261wmq.35.2023.12.26.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 07:38:56 -0800 (PST)
Date: Tue, 26 Dec 2023 10:38:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231226103743-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> I don't have ideas right now to answer Christoph/Paolo's question.

Paolo did some testing on this thread and posted some concerns.
Do you disagree with his analysis?

-- 
MST

