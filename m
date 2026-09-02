Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307D456E15
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353347; cv=none; b=rZupnHYAzO86dFkVRDswBZ45D152htSi5Y0Ri1TNM0gENS28AnT61kRF5jJNgFOtn/PJigtuvcg5vwGudpqYggpvr2yD/ofbjQpcsr97AdRklBDCkqgho5AKEYg7TRWTRUDSbPqb5nAgOaBpp6MYQreQgGDA80T+SbSxYFpnN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353347; c=relaxed/simple;
	bh=W9k5cHk+Q9N4x4Oem4NuCeYy3xZ0p2ZMnnX3leIXLm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L2G1znO8aDwucrKS0jpFwfl25UelgUZhpsz+RIk6q2q/G7SbYzd5fuZHe/WWHPTtxpUckSaeadlbgoevbw6DO9SWOHRWAZbfjOkxMMrMJnL5JEB8Uh57zsauk9G1JtVvX0PdXHZSpZnvnUlKW0dtCoZH6aaSBtLo8XH+x8TSJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWH8bZsd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWH8bZsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788353344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lfd8/zwjOXKARscoyEL5q/2LpUM4smemvMzZyMNLMO8=;
	b=KWH8bZsdwRUU23C+UENiF26jwykyrPhxPt5X9ULWFJHZbK2Vv2CoadJua6sg2BxkILRnQE
	raDw8a1HodkzzpuruawJ4Vr4e+br2EWHHc/TFemV8L5yALO1KTlFuvT6aOCkwza7duOMwS
	4Q53gHXei0gw0wgjDc5aPelxnT/HUyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-YdHR0R-pPgO6LS_d6adTgg-1; Wed, 02 Sept 2026 08:49:03 -0400
X-MC-Unique: YdHR0R-pPgO6LS_d6adTgg-1
X-Mimecast-MFC-AGG-ID: YdHR0R-pPgO6LS_d6adTgg_1788353342
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso9196965e9.3
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 05:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353342; x=1788958142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lfd8/zwjOXKARscoyEL5q/2LpUM4smemvMzZyMNLMO8=;
        b=C1KSG1a8fCp3WOyh0qsWYYQv6YuCjdWiaksb8oVTtDugbT+BZnoSbStLnYb3HSERGG
         QLwwrx4/lfkxstvYFSp0bsOcLCBlkBFyeAFSxp/6hgarqpeq0l8PzEg3X2xTTZhR5w7d
         w5rE7+lmYxhBxLwv9UHRSD8nkVKx8rtJBXmidb0krH4E60xbA4LnfR9QOON/DNbW5HCm
         ghjFMmi++0E6NO4ZNIezcf2gkgDejsbc77fKarpTYyMcF6aTutNDOMkSd2dmW95xsmuz
         eIqmz+2abtj/VSFMHlZFRUCJYb+G2Fd9XhVvhgAQgpWpL0AgyW3lDui4KqUZH+hVBKsM
         RMWA==
X-Forwarded-Encrypted: i=1; AHgh+RpxU2TjuizT0wgr9APz+yt6s0d/9ER1vhbjB9f/BoL52uewvRNsRdIYd/ivuH40pCKvwOfOBGj005/6BOvJow==@lists.linux.dev
X-Gm-Message-State: AFuF++kZuYwHnch94bW8cm5u5ltXoVN0kyiTNfl7unDO30OpmL8Rqs1H
	yE/bqwh6VuUr3d+3+AR7TxEEDd9gJ6+9ejd5v0PO88v2KSoHd9F32R5hzl4r1uYzk7KhUHYDZ50
	Yl8DegD/BXPCfDyINM+VPY4gNistn2rcPA4HJ7Rvgq8Ckm0yk4E+sXWg3xLie0J1vWDTS
X-Gm-Gg: AR+sD13LMi1JrtlA0vMq6Mdh/xmScuDEouUJ6HmrkjL/+Jcx2FgzWcOZD59E0NuUMi8
	2LH3kjQu2eUfb7Rv5tv6zWK7zCLpuBRjQVwkVk9Lv0Ii2Rw3XM4TqNxn00UwUnDXGf+1GypVr9p
	kBIMw+vrUKmDtJ/CIFbcAbQm/SxVa+dHVkIGCMNWRAre9iI2xucEXtki926Gcuakm9hFU9fl7f0
	vlFOiZN7DLIcwQrOvNeT2LDy8TpsMDD5KGc6LnEcFztDeejqU/z+OvkoQB3RwXSvtzJOSeLe0XR
	WqKlTp40wYTla8GuFXLXcDLIRB2zHfk0YoqpWc/ifpWRebn8cpWUh2hSnahwi+FPVS9aUThA9FX
	iI4tBqKAf50kV1Kpvd/t2tT8YcMnQE55ZxzeS2AkH33R+JQ==
X-Received: by 2002:a05:600c:8705:b0:49c:cedf:f870 with SMTP id 5b1f17b1804b1-49ce58366f0mr83354615e9.16.1788353342228;
        Wed, 02 Sep 2026 05:49:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8705:b0:49c:cedf:f870 with SMTP id 5b1f17b1804b1-49ce58366f0mr83353405e9.16.1788353341664;
        Wed, 02 Sep 2026 05:49:01 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b456sm169105265e9.2.2026.09.02.05.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:49:00 -0700 (PDT)
Date: Wed, 2 Sep 2026 14:48:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: mst@redhat.com, Jason Wang <jasowangio@gmail.com>, 
	Laurent Vivier <lvivier@redhat.com>, jen@redhat.com, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: add Eugenio =?utf-8?B?UMOpcmV6?= as Maintainer
Message-ID: <apgahfkAdwYcu_5a@sgarzare-redhat>
References: <20260902092459.1983909-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260902092459.1983909-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KkaW0q-VqhBnI9s1hgFsDlVYB8CoryGNt2b8ysxmer8_1788353342
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 02, 2026 at 11:24:59AM +0200, Eugenio Pérez wrote:
>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> MAINTAINERS | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 3a19da74d00c..a92c5712d8cc 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -28877,7 +28877,7 @@ VIRTIO CORE
> M:	"Michael S. Tsirkin" <mst@redhat.com>
> M:	Jason Wang <jasowangio@gmail.com>
> R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>-R:	Eugenio Pérez <eperezma@redhat.com>
>+M:	Eugenio Pérez <eperezma@redhat.com>

Should this be moved up before R: entries?

BTW thanks for the effort!

Stefano

> L:	virtualization@lists.linux.dev
> S:	Maintained
> F:	Documentation/ABI/testing/sysfs-bus-vdpa
>@@ -28954,7 +28954,7 @@ F:	include/uapi/linux/virtio_gpu.h
> VIRTIO HOST (VHOST)
> M:	"Michael S. Tsirkin" <mst@redhat.com>
> M:	Jason Wang <jasowangio@gmail.com>
>-R:	Eugenio Pérez <eperezma@redhat.com>
>+M:	Eugenio Pérez <eperezma@redhat.com>
> L:	kvm@vger.kernel.org
> L:	virtualization@lists.linux.dev
> L:	netdev@vger.kernel.org
>@@ -29009,8 +29009,8 @@ F:	include/uapi/linux/virtio_mem.h
> VIRTIO NET DRIVER
> M:	"Michael S. Tsirkin" <mst@redhat.com>
> M:	Jason Wang <jasowangio@gmail.com>
>+M:	Eugenio Pérez <eperezma@redhat.com>
> R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>-R:	Eugenio Pérez <eperezma@redhat.com>
> L:	netdev@vger.kernel.org
> L:	virtualization@lists.linux.dev
> S:	Maintained
>--
>2.55.0
>

