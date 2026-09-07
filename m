Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F423A564
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775433; cv=fail; b=SpfgANbMQnh9Q9pyJZwO3YR85RK4hOVHjrvm3KQEUY/7ZAG3fqvoouF/jT82wkkY8af9SDcawYHeNMJwlx38ATndT2JQtSIXMszyu96v1GtSzBe5ORBk6IZcQtE7d2Fx2bFiohNM4+bz4eVhmT1A443HnfnGcy1NPf5BPmjSZg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775433; c=relaxed/simple;
	bh=taXTc8t7jL99ksLm+NqxwaqOr7jS9mZBmvjMDJCVE4g=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c7TIF3mMour549e0ocjOV0LHHkTigoxUqPz1/NAXs5zPa5gZe8myPAWbgkKSfd87+wWZWVOw/dYIhlebuI7klV7zdBcBFg93Abw16j5IBCb2pxHODBwuTREI9uUxMEkxpj/tpAs+LmKguLZylZuUkB+eUfn8+N5O7s8odPvYA3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxR7JBaz; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxR7JBaz"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9B20605E6
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.742
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xBtNrDo2bgmd for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2026 10:03:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF38E605D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788775430;
	b=AM83kOB4lFWLsRSB4vnS5xLUzmzzAWIvcg4nNxjVRG/o695k88vJ+CSfCo8ZeX0irJvN
	 1IF92TvINCORNS0TpDCBVDKnoXBK/lMjtyWzJfLC4k9cLG2XpWJxkrb9LpSHvZC8wiHGy
	 n5lL6OmhyvPF5/Xv2aUl2wQYwjpnm3WLlFcN+YntIcmR6sPjlDVSL0SzCcePZQdj3CzWr
	 lGIYLU1GF+wls08ZCATJ/XUmP6lbUxF0GdZ01kLb2aZtATSswN0t8CD6rkbEKxuhLtBoo
	 WoHDReNaIn8jV+qcNB9TpQRLlAWOLfe7ZeRJJzllKM19IQu6b7Gs0Cd3fVrj7Cbgqbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788775430;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:Cc:Subject:Message-ID:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=kFIjBLwrnQNzpzBiLrwLCrhQmY54y00GCWAvNQxRSQs=;
	b=s9gTJ6ifNDIQFwkDj52TcS5PYznG7BYxl6IJa9O8cXd1ReIoP0WhoJBhRJwJ5MOuCfqq
	 nSZsPORE4Ua05+N7gvejSp6ahEKK95Pltt+qNxTbDvDP/WtBh7L6FLCHKJNWsXDYrvZ1V
	 /1g+fmsHNTTLf7P1fjUFNsPiRxftZhFpe92OhWm6n+f4nL5BwfBUvgKsNKQbgLiuw6GdL
	 Zwwf7lmY5b1dVjCVrLG7agcGd9oAwRGQqyJHHLq3buTQUWNSjD7Aa3yriNiZ8YjBiOxM+
	 KHSI+SylHekEJpC1wM6QqgpveZUwnamviwUc7VlksRxCJbumq+rxtUGcrJsg/LTDMeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fxR7JBaz;
	arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fxR7JBaz
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF38E605D5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788775426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFIjBLwrnQNzpzBiLrwLCrhQmY54y00GCWAvNQxRSQs=;
	b=fxR7JBazs95yUALhjX6jg+Y53eYy/bEIByNgVjqSmvBfhIhGIRCc1Ci9nUuKWYFKFMMkqD
	tSPpppNNF23NY5W36bQ68KiIxHP5HbDpuT8Zf46YPPpzoH12H1BwUeZe5olNVtHtK+ZM8a
	lpS0mtWe9BlP/maLA6OB/SAgVxLihnc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-d9Lj99NaPXOLVqWJNFrd-Q-1; Mon, 07 Sep 2026 06:03:44 -0400
X-MC-Unique: d9Lj99NaPXOLVqWJNFrd-Q-1
X-Mimecast-MFC-AGG-ID: d9Lj99NaPXOLVqWJNFrd-Q_1788775424
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2542cd4faaso394276566b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Sep 2026 03:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775423; x=1789380223;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFIjBLwrnQNzpzBiLrwLCrhQmY54y00GCWAvNQxRSQs=;
        b=rJMcD6oVKgiOIxy8cIpsZir5cqtDJ3WBDyuekX+8MRpkBgTKrGFfJwtb0S1nNgmG0B
         WK+vO4NSSFi/5ByUDhzOt+cZoRX+c1ujI1l7B3fj98SzW2gGboZlkO1cYmz5HYjb1znJ
         ZQ9BhsxOkyqu0qQk4MhU9FjUS4PG+mBVOLmG3ek7ewgtdjXZBuANBwfuF1ISjl+uTc9w
         d0V41zMeqyiHe/JPHkbW8nCPOwQoW2FmUgsNx0F3dZzf5dyvRO5xadzvKIN56RxFy1EG
         xoPvwKG/ndvSI4TNGVlAaQO1oR+CWkm1SZBD8Dw3q493RSRdafX1hI6gY8hcgBxvbky5
         Zcmg==
X-Forwarded-Encrypted: i=1; AKwUvBxY6++6ZPF3Vfm9reYEhofdt44NVYPMfQFJb8VM0nM3Smc1qUSQduXrcpNXNR4lIP+/XFhX6RPgnzqbACI7Kg==@lists.linux-foundation.org
X-Gm-Message-State: AFuF++mqUlcyCPoCKTO8rYpUoYQ5QehetXPhLgJSupm0rKzRAhUMnhEh
	pM+9Mnd9rewX6NGOr8Se92OFGoQi1W/Oo2C2j7O0qhvKTEPHMCY2btUyl3ekevyr8ZHxmJE2I2v
	3szgAzrkn51kTfnOMV80o3Hkof2cus7gaWT0zSp7Zzl2oiMt3Z/u4Rutg4kUNA8RZtregB+ksbG
	cyYfkQHPU=
X-Gm-Gg: AYBFou3hj1NWZatzb5JzOHqsma6XbrfbVRlesPycxPhQzKC3oLArnV/UDVqGw0k8zBZ
	UC7HevD2x67k7yv/WJ0z1n/S5oE7bdI4Fodvt8YXELUvz+7/7xYH8E1nyeVzDtw/n6r/PGo11uv
	/lqtPtaNWnAg8MwLzU9DfA2pUJ+2ve6bkPiL+qdtqu9KF6xe81ezZMtsuoUzgBP0TeamjpfNfqZ
	1ZoAzEgycNzdmAVhGXTpeEey/mOY5omn5dV+W376ywLNQ3dSHUNi9Te11HPZx8n+8VuG/0nSfOx
	jtQhp90L+abRus+332kIgd+NZGNogYw8BsmG5oP32XXaUMv1IzKgnS+DlYsTzg4/1DACzdTnHCB
	xNTr4MlstaADdQ5FXfzH4LOo=
X-Received: by 2002:a17:907:3c92:b0:c15:f598:60c0 with SMTP id a640c23a62f3a-c260c65c118mr914662366b.4.1788775423510;
        Mon, 07 Sep 2026 03:03:43 -0700 (PDT)
X-Received: by 2002:a17:907:3c92:b0:c15:f598:60c0 with SMTP id a640c23a62f3a-c260c65c118mr914659566b.4.1788775422856;
        Mon, 07 Sep 2026 03:03:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5921e2sm450449166b.46.2026.09.07.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:03:42 -0700 (PDT)
Date: Mon, 7 Sep 2026 06:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, Chris Mason <clm@fb.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	virtualization@lists.linux-foundation.org, ksummit@lists.linux.dev
Subject: How is sashiko bot deciding whom to Cc?
Message-ID: <20260907055646-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 2
X-Mimecast-MFC-PROC-ID: xmkGyiYi-bawlw9Gy-p_i1cZpSXVU9Mo-nd_Im6nqK8_1788775424
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

There doesn't seem to be a Sashiko list, so I added ksummit as the most
likely one to catch attention. 

If you run b4 mbox  20260905153514.B55561F00A3A@smtp.kernel.org 
you will observe:

From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Sat,  5 Sep 2026 17:20:59 +0200
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Pérez <eperezma@redhat.com>, Dmitry
        Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Pawel Moll <pawel.moll@arm.com>, Cornelia Huck
        <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>,
        Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>, virtualization@lists.linux.dev, linux-input@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] virtio: implement synchronize_cbs for remaining transports
Message-Id: <20260905152059.89560-4-kmehltretter@gmail.com>
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>

with this diffstat:
---
 arch/um/drivers/virtio_uml.c             | 10 ++++++++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
 drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
 drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
 drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
 include/linux/remoteproc.h               |  3 +++



the sashiko bot replied to it:

From: sashiko-bot@kernel.org
Date: Sat, 05 Sep 2026 15:35:14 +0000
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Vasily Gorbik
        <gor@linux.ibm.com>
Reply-To: sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 3/3] virtio: implement synchronize_cbs for remaining transports
In-Reply-To: <20260905152059.89560-4-kmehltretter@gmail.com>
Message-Id: <20260905153514.B55561F00A3A@smtp.kernel.org>


So it picked some mailing lists but not others, and some specific people.

Is that opt-in somehow? I'll be happy to get Cc'd on the auto-review email.

-- 
James

