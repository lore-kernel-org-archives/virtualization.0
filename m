Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343328F926
	for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340700; cv=none; b=RFTi5+5YL/Qjpbkws119fwIvTy2YOrbY1n/k3FnhE1kxL0JhUJhVopcizEAiszHaRQowcIWt15qt1yx0a8tqtWABrj19tTWFHqFRJgIn8O2NQBD0rtWS/IsnNqyEN4xZrvjwg1F1A9I3QsaVNKd8Jw9TSc3T+2qCG+nkRMEd/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340700; c=relaxed/simple;
	bh=ekx8YSOc7g6jM4/k8aaZwSazUxe/M8O4Al5/LfbvT28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r0kWglnNYBvKrJo+KiSpX4CtPkMS00ymXgp1HZWsn8hoAQVSQgoLDSs/DI5RbKjlNCEuLo+g/Eq/sqnDY54abasN3iTsxzl2I58wLawXRilfy6IlH1/aXTWBt3e0evdjkI1dG2OsZIHMfoh1+ohogpBLS+gCPKO1Av1nxq6s+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFnvw7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFnvw7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755340697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVcBDRwWsttWGK38lVHrVbMK6gqAO5C0KIt3MgVZUK8=;
	b=UIFnvw7NjVftyT0n7odJ2BhaiF0TwR9gI/e5eNeKwb/hPKHc8VavRdh5Rzt6CuQoJdQXFq
	7ze4uNJvPhUTHyYwyb6mJNkeJFJawpkAkpA9JXXrPZX5L7y4mTfjVj14HNdLr8Jzkoq7ZZ
	DtJ4o4Z9ySm+UP0t3XBPf4bMsE9jiKo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-unTsiHi6Ps2L5c9WB2laKA-1; Sat, 16 Aug 2025 06:38:16 -0400
X-MC-Unique: unTsiHi6Ps2L5c9WB2laKA-1
X-Mimecast-MFC-AGG-ID: unTsiHi6Ps2L5c9WB2laKA_1755340695
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so15003195e9.1
        for <virtualization@lists.linux.dev>; Sat, 16 Aug 2025 03:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340695; x=1755945495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVcBDRwWsttWGK38lVHrVbMK6gqAO5C0KIt3MgVZUK8=;
        b=H2ApoMbFM7bnwiIttQM1KUAk45407oIza+agLKQRh1js6S1UlD33lcGkcFsycdSR1R
         9Zi6IylNvVyzF4VQ9ePrk5Wslg3oM6LkjOKmvCyuitqtgllgrlBp9k5ZIBa2ty9KwNZM
         5JcfQ/7BDaftzbzCiVWaOAibVjpczzcvundfjyOubAsd/vICFvcDizD5mtz+l9ZprBs5
         wLUe9ziOPvTWEfmuDLdiDcyiZGtQbQkghSVG300cn5puDkw6xSNenjNMqqNhsb6y0s1W
         +XSVVs81O3RfLG7g481/3N7ThdyXC91CfzFRjc18ea88azhkacgHcKnygn16EWl/pFhS
         8rBg==
X-Forwarded-Encrypted: i=1; AJvYcCWo1RsYPQ+4pF0SmDsnHG+8QXfDHc55RrKaj6rGiJA7BJ+dDu6ZJHcS7IPKYbVzGbkTGWrF8t9kfKPDwUHHTg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7kxZQNZatz47PpgZOTbyo9OeZGOpVImRONbAiv+fc9ZRdyDFU
	fIl6wecmXRVt/9VSO+PEBniW0eZb/EaVqeji8hVYS17vw+hZizGGDaFy9j7snG6seBtFONa6rQP
	HqH7zj/qP7o4l3Twuvv7+emKIcIsQSrLzIvC9+G56U5TCnTRuniCF6o60mK91pcykCbcCeDY8zW
	BB
X-Gm-Gg: ASbGncvFQQz5sFgop/KiJlOXSCJalZk8k8BbJXTOkhoUKSi7ATTsZ9aFBs5H0c3Xnlt
	vmTcjescFsFLBtamykHI3UfZUZScqczydqO4kWSwLyJODwvt2Xpwi6unOPnneXne4JlRqNkiZ71
	UeT09UtDfhYVDxhqVMEJB6Awgme3p2QN9GsnfDvrLOG0zK/J5hx3AcB5xvZMaRaW49RG7E1/ThZ
	nk5FrSfedR56THx9z+q+5Ja9yO1aAzh8qQIUFYhumNg92ncMS2b09n5C7OTGOztB2ejO+0h57dp
	GSm2r/Xbj00aHUOM0J8887Ebg/EVktkQGwE=
X-Received: by 2002:a05:600c:4f53:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45a24220467mr38335015e9.3.1755340694656;
        Sat, 16 Aug 2025 03:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpyVsdecoZjN3XgasLnVr8q4r9q39UzUvK2o47D3rxm95PhfzS+mCEvAW9UWwlVcWzucaPIA==
X-Received: by 2002:a05:600c:4f53:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45a24220467mr38334835e9.3.1755340694248;
        Sat, 16 Aug 2025 03:38:14 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd337sm91741855e9.4.2025.08.16.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 03:38:13 -0700 (PDT)
Date: Sat, 16 Aug 2025 06:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250816063802-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
 <20250813132554.4508-1-hdanton@sina.com>
 <20250815120747.4634-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250815120747.4634-1-hdanton@sina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GUdm05CkchEMsd0SqCzxybuTGDf8XIbvceFfY1DX1Q4_1755340695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 08:07:46PM +0800, Hillf Danton wrote:
> On Fri, 15 Aug 2025 06:22:56 -0400 "Michael S. Tsirkin" wrote:
> > On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> > > On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > > > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > > > transmit data. Unfortunately, these are always linear allocations and
> > > > > can therefore result in significant pressure on kmalloc() considering
> > > > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > > > allocation for each packet.
> > > > > 
> > > > > Rework the vsock SKB allocation so that, for sizes with page order
> > > > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > > > instead with the packet header in the SKB and the transmit data in the
> > > > > fragments. Note that this affects both the vhost and virtio transports.
> > > > > 
> > > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > 
> > > > So this caused a regression, see syzbot report:
> > > > 
> > > > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > > > 
> > > > I'm inclined to revert unless we have a fix quickly.
> > > > 
> > > Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> > > 
> > > [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
> > 
> > I'm not sure I follow that patch though. Do you mind submitting
> > with an explanation in the commit log?
> > 
> It is a simple debug patch to test if Will's work is good at least in the
> syzbot scenario, but stil a couple miles away from a patch with the SOB tag.

Oh that makes sense then.

