Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E12FD1C7
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253387; cv=none; b=r/8hrsud5hvVE3nhJ4zyjCALIdjln917sSgij39ecwr3utWYgxg/1Pv3KdhbTYBPuwH8KnJCz8Tj21ZMQgQ0vlabIUsgc8fV7/5IHN47zHJ9Kt8xZX3bjqCQrVPEECDXTXuo7dKxLanQ4v83SqaKQRFFaCiT6ToF8eitsJJtjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253387; c=relaxed/simple;
	bh=WE1rN9CQDbCOvNfVAG7gWcd5KU32gMMFHCTSQAiwbWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kr5BJOSkd4reGc4fmkgqYw6yM0zDuyR5ai+gGAgi3XEF4SU3KGvULD7vbH+s9oDLQ+fYsRKq5bqJEeS9SkE6XUlKLXvxRsjFgmQq7jdsLvH2YO3dGtuEWdL0wbF55T3nZxS0Tyg8xY9Ac5WENVyekIEopr240N5qRkJ1ocxRROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6mjFC4Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6mjFC4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755253385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXZQB1LE0AtxSpGbCGCAth6SRq5k5i0cLzQs1mJzr8w=;
	b=J6mjFC4Qa3uP6m6PZpF0K2oGQ2n2GT3W4Hw1Z4c+NzHZ1JL6BWgkT0PKdf/2wjNmJjAPrM
	XzF49iQ0CbOVKW4Dhw1bAYtOTLSy+6rHy5ly6vcD9SaZevKyiv5tmusKdbi1pVqo1QrAqw
	M6sw0WCjdhE8VdHl6HSfjishunruqGo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-xakC7LSjNs208iFzorG_dA-1; Fri, 15 Aug 2025 06:23:01 -0400
X-MC-Unique: xakC7LSjNs208iFzorG_dA-1
X-Mimecast-MFC-AGG-ID: xakC7LSjNs208iFzorG_dA_1755253381
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e418a883so768808f8f.3
        for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 03:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253380; x=1755858180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXZQB1LE0AtxSpGbCGCAth6SRq5k5i0cLzQs1mJzr8w=;
        b=CO6uAmERfsGrdwANDcwhdWY0RMmMpmJK0H/5oU5D/Fty9ucDtkm3OPNxougGuHljmj
         JxdoPDo+tOSygfV8QkoUg2HUDi+AMY4sOaelc4oIeb6+hVNWv3ZpVoK0Hw0U8sFNzKCB
         YoaT8MTpcFieiWv8gGqah2m5kzDUiiZYWe7KUyeGpEQha4/7QsEXzL9rtJxQzPhFSlHN
         VWFLA0Szy0aqaN7E+2k7EJDo4cCZ3y6+VMpCdj+PKsGUXP3P5DAe6Or2EofO9hwxX2+W
         cGhP+AcXCPflllpk2hJTL07i0i8VJux3f+3XuI04nUz4qh0DNItPfTok3kXBYcPVznNx
         Pi1A==
X-Forwarded-Encrypted: i=1; AJvYcCU2vyXFes99KuJUaXGdVVTEJwNE2cxgbnQK1xn0Vd3C37+5qyFPpjcsoImlGaHq+vPRAMAoSLwVIAUefwaORw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzszJ65Udt6JxygKpKuLGxiQfuFacv1avBMesgXH2r7n73fckDT
	Rbna1gHXgi9yWCYp6hbMUeFhiUaRy5HnZ2VBpizEHcWHgJHNWvH7nSn6LumwBiJvR5r3b8qSwYK
	gK6haJSXfsK/T2Rk0XSoNxR5GiRc0v6DRrZ6tOY6asMinuBUld/PQGkRmIc39cyeg3rSz
X-Gm-Gg: ASbGncsk7G3df8bDUt010kUOhlNNIzhAiWxJ9JNNOrB9DjZqQdDEwwBW2ZTdKYOuM8m
	ctm55nJwv0TKWNUaGGKeXX/UEP8g2zlhKqs+7uiLTIn6liAAh74LwCNv07jCGrKqFdJ1xvTmZPy
	ayoeVzj4+M+upTQn6Au81jinJOXOPyLaqxTlkBjm3kCakCIP7hizM/I+wagahljtuzlBBMFdC8p
	V5Yi8CAo5HYLn9R7LXbjJLj4SEE1IB/RSixh0LdSvNH+gjwcyKkjmkRVzl4/5dHFLL6I9tkKC8f
	sfWClfMdYH8NiasdpK+p9FYMvA7IRKZFr2o=
X-Received: by 2002:a05:6000:26c3:b0:3b8:d08c:cde5 with SMTP id ffacd0b85a97d-3bb68fdd70bmr936461f8f.43.1755253380602;
        Fri, 15 Aug 2025 03:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXcWSGeWgeyeaq8Y6Kdy9hPI87jT5jAViHEaJ65V0tcueR2T7DgVvat00CErWZfwSwgGPjEA==
X-Received: by 2002:a05:6000:26c3:b0:3b8:d08c:cde5 with SMTP id ffacd0b85a97d-3bb68fdd70bmr936446f8f.43.1755253380209;
        Fri, 15 Aug 2025 03:23:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223197fbsm14231915e9.8.2025.08.15.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:22:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:22:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250815062222-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
 <20250813132554.4508-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250813132554.4508-1-hdanton@sina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O-TAB7ujB7pH8j8MWKiY3PUGPUTk3af-RVelytz4EMQ_1755253381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > transmit data. Unfortunately, these are always linear allocations and
> > > can therefore result in significant pressure on kmalloc() considering
> > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > allocation for each packet.
> > > 
> > > Rework the vsock SKB allocation so that, for sizes with page order
> > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > instead with the packet header in the SKB and the transmit data in the
> > > fragments. Note that this affects both the vhost and virtio transports.
> > > 
> > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > So this caused a regression, see syzbot report:
> > 
> > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > 
> > I'm inclined to revert unless we have a fix quickly.
> > 
> Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> 
> [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/


I'm not sure I follow that patch though. Do you mind submitting
with an explanation in the commit log?


-- 
MST

