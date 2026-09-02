Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0562409620
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356508; cv=none; b=OhZ44TLPkaiJWGCLhS/NAb/PuvyXeNVWhX+UPMgrSBfP+89ErhbYI+lOaXTUz8HmOm3T6SqWJFEt34Y437F/8AsQYXn+fZ2P6QX8iuMKujDF+R6o9qAWvcTQ+xGiFtIeMwPbKidPWd7Boc4GsSbf2oUOzyN5qrE5bdVKGe/TWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356508; c=relaxed/simple;
	bh=r6mRzQhhJ88iS45AXaAovqfXVJ5jLdC6yvmI5FzNa2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kKXqDfecJKKCWIWRVkAXCQ/ya8oLFupd5ywvo3lKC4dMqPLGulzYUER5zGsXXc/L3u/fFxX5L050pVLjZwctimfubPQjO2fTeq0vSFuJwA6xF+UDTMpTveRuLamuQdPrGV4kDJ1Vt78TPrQcPZKvSV6hdMt5v+iDCV0q0Cy92qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxR7/TYq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxR7/TYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788356504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRhy8W81mqy36OEvhVyBzZ3Evc0oZiCvH7zL9mD3AoU=;
	b=DxR7/TYqf/Evufv8kDJcewe18KLZdia1UyWqXLmifl9/aQuTnvuRrO+GzCe7weG8PB5hCb
	yq7RLRyfBOQXsn54NlOsrm7HmQigxX4ERM/jSnOkEbx7aPeOhpN+lngzbdr/gSYuau3EYL
	pYzcR32XpJ+HuuGeIKvRgDKkvtPCaUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-hT8UhjlENNqtnLDIWTg1JA-1; Wed, 02 Sep 2026 09:41:43 -0400
X-MC-Unique: hT8UhjlENNqtnLDIWTg1JA-1
X-Mimecast-MFC-AGG-ID: hT8UhjlENNqtnLDIWTg1JA_1788356502
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-482e05af072so926546f8f.3
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 06:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356502; x=1788961302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BRhy8W81mqy36OEvhVyBzZ3Evc0oZiCvH7zL9mD3AoU=;
        b=AT1lZWICc61U8s55gCMC1iiA6wnvnR8aI7Q1VTij7aBxjR8/C3QEqU4+uU3tw7sRzw
         Sr1XWC7XSOMUi1TgQAQNMyJcfvHizMkAeDNh86ZqbeRpFZPWoLR5R7e3w9uiczuLRgd5
         5BQF4V64h/eOgqzuBbI2mAixNWefXuFR8kfIKdqJ/ZHFQGtLnoTbHHBdgu8RCiLIwG5S
         AJEd5FMXXRP8AviygixDGGtGWSwO6k+tIGYMLQ7dHmN53tMg1GbwObiP4GM54eLwcltm
         bajk3RYhCGNERKbjN/Giw8ALUv2jL1Y6JDdtEJAZpqFGqZ9kNWLjgTPdY5qM6sNbLQVC
         B9OQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+1BnLcJoJcXaiinGXMQyi68jGx6jora4WztEQTrZfuEwl2fRTPrPVvvVhqa75DrAQwB838dMvtOeUph6OrQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nW6wo1zYGrS87QT01C8RUejIsvoxM9pIkoH+oIc9OCY3wY263L
	lnZrLgM4hXOgEGZ1InTQ3X5dbsRWv5Fym+cg5CJxUqEn78/62Dlzz11FVaJJQrt6sugBT5tFZbk
	Lkh8J87aTBEmZWRvqVmBjLB8Ea5M88LPsmj7oWBDUY8horRzoz3sD7SRFMIJ85eKBx8QxDaxXPZ
	Xc
X-Gm-Gg: AR+sD12Jh+lAUO839YgRJLT4420VyWomuNZOByPF+lf6s9tn7gcRl99Ct3OdlljE2+m
	d5wpD8Tg8VwC35jEwmPuADrT2JBF2LnQaUNF+wBFJniLvikF9S9tWdeP9uBJ9TSu7JwbixjMcmE
	NsLAFGWp8sGdXfkXgEasVQBi36JmtpTzC3WVPrki9C9/zihMapsMuRhmI30tjZ/0cJeI6szm9yh
	J+U2ZlbV2zXYdc4zXFNhFqN0nwOulwylf7NttlXs/+cdNJujxsDasgI7pZ0uhU6ejXt2R9W+hcK
	nNkg9dXGJ42N6V1w0h2p2W+0rF3qhZWcrLrNYON3xejyWELBj6PlDHZWygj8MOtamug=
X-Received: by 2002:a05:600c:3587:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ce583bc25mr85207705e9.16.1788356502285;
        Wed, 02 Sep 2026 06:41:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3587:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ce583bc25mr85206655e9.16.1788356501767;
        Wed, 02 Sep 2026 06:41:41 -0700 (PDT)
Received: from redhat.com ([187.15.128.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b456sm172790195e9.2.2026.09.02.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:41:40 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:41:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, jen@redhat.com,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: add =?iso-8859-1?Q?Eug?=
 =?iso-8859-1?Q?enio_P=E9rez?= as Maintainer
Message-ID: <20260902094126-mutt-send-email-mst@kernel.org>
References: <20260902092459.1983909-1-eperezma@redhat.com>
 <apgahfkAdwYcu_5a@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <apgahfkAdwYcu_5a@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7cpGmOKWoYKQeKeYeb2a60Qa1rclGFaXnEM1XmMLAQk_1788356502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 02, 2026 at 02:48:58PM +0200, Stefano Garzarella wrote:
> On Wed, Sep 02, 2026 at 11:24:59AM +0200, Eugenio Pérez wrote:
> > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > ---
> > MAINTAINERS | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a19da74d00c..a92c5712d8cc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28877,7 +28877,7 @@ VIRTIO CORE
> > M:	"Michael S. Tsirkin" <mst@redhat.com>
> > M:	Jason Wang <jasowangio@gmail.com>
> > R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > -R:	Eugenio Pérez <eperezma@redhat.com>
> > +M:	Eugenio Pérez <eperezma@redhat.com>
> 
> Should this be moved up before R: entries?
> 
> BTW thanks for the effort!
> 
> Stefano

Good point.

> > L:	virtualization@lists.linux.dev
> > S:	Maintained
> > F:	Documentation/ABI/testing/sysfs-bus-vdpa
> > @@ -28954,7 +28954,7 @@ F:	include/uapi/linux/virtio_gpu.h
> > VIRTIO HOST (VHOST)
> > M:	"Michael S. Tsirkin" <mst@redhat.com>
> > M:	Jason Wang <jasowangio@gmail.com>
> > -R:	Eugenio Pérez <eperezma@redhat.com>
> > +M:	Eugenio Pérez <eperezma@redhat.com>
> > L:	kvm@vger.kernel.org
> > L:	virtualization@lists.linux.dev
> > L:	netdev@vger.kernel.org
> > @@ -29009,8 +29009,8 @@ F:	include/uapi/linux/virtio_mem.h
> > VIRTIO NET DRIVER
> > M:	"Michael S. Tsirkin" <mst@redhat.com>
> > M:	Jason Wang <jasowangio@gmail.com>
> > +M:	Eugenio Pérez <eperezma@redhat.com>
> > R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > -R:	Eugenio Pérez <eperezma@redhat.com>
> > L:	netdev@vger.kernel.org
> > L:	virtualization@lists.linux.dev
> > S:	Maintained
> > --
> > 2.55.0
> > 

