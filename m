Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84A41F378
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209024; cv=none; b=dkFrlVqMivzk2i97FEt3nQbLIq4KtX5HGdMqJ77CSyZazD5Fm/5PsxdOEfsBKB5t/3e+7kyK4bZEODzCh4Bi8+67BmSYkPO1DggVyTXEzdVsqKfICfL+nHOnJYKwANa2UABlLZYmSXdGBXBjJmTG4YFUFPAKqzMSBgI0FX4cNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209024; c=relaxed/simple;
	bh=3CK3xCUajGrp7pvQnfknL5Fj9ZEZS2Pv8v/un+O/o8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gLKyEs5mZM5xOK+Ys3S+vNJoBSYdqBO1i8gEzltpP53oxUK7IeQqlk4vav+FnRyPM33eQMKxf9bQdxM+M9Odp+AxhaCx+WjZZHW8YRdWZ9g0LVmIoCtL8+oLNojjCegL6ba4YdGAsTUN6AbqTZB0abV3BznsMvrGk/Biy16KM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dqvt1Dt8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dqvt1Dt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789209022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv/+pDbq3xCxMWCwYrvbxXYMa9928ghppZcRWXUY5gE=;
	b=Dqvt1Dt8fdXefJdkkFuqAhy8e3TASVv5QvRJfIRApN6NaptkXMR94foH4b1OfDcvRZvvLO
	rhEFc/Cdbcqnk5xcnQjJrhgeQAnc0xqC5HRpe/L9VZqOo0v+Fi7nrXNhUVqhvCQKUh0KRB
	QE+zbKWVdxQ/4YBa7a9jC0ql3RVIOdk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ARJcvNGNPJC0uuPlWx5eDA-1; Sat, 12 Sep 2026 06:30:20 -0400
X-MC-Unique: ARJcvNGNPJC0uuPlWx5eDA-1
X-Mimecast-MFC-AGG-ID: ARJcvNGNPJC0uuPlWx5eDA_1789209019
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e64b80b94so9357735e9.3
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 03:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209019; x=1789813819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vv/+pDbq3xCxMWCwYrvbxXYMa9928ghppZcRWXUY5gE=;
        b=dxZhdeT1UI1ncXaqM5d3IFrTPWalGWJFIUdj1ghNr2u41cNG18GLUz64RWu/aeavQL
         HhUacEivhJr2ljYRGUb4/aOGsFOiLoVVhOkzhO0GWoYncZT6MBcW/ZkqJda8x2YDnmFi
         Sf1TwVhQWhzAnJglOmfvSom4N1TqNfroR5bLGpT39xMC9f8ei4VqnGIN6n3pTS8b9x/7
         sVR8pO7DNCkLgPDj3LHNh7MHp2NCzdZcm4lKRbdiWWVwi83L9lRAysrgGbWHf8qRJy8g
         QhbIOM2ECjzn7iw7nkCIBoKvZMuYh3hg7qUi1hxacFJQrp9vehn7vaOYuLp09/q/S2c9
         +9Nw==
X-Gm-Message-State: AFuF++lwyCH+mDujzox/xbjb9yI/FvadztS1ntnA5lu57hLSI3XI4sXR
	SpzpuSbTEYDwYqjHhsGswLqgiZIB/KGxkkCZ3maBx0jyKROajPnGj9L4YzKYviuMwnFp9AJaghI
	MXMGL71PBJIGaEuNwJS2TacAnD5ghpVzW2j5yyPN3SyFeWxYhEDkGcV1r4sYcVSuuboVak5Vwir
	lMPhnEOsg5prhw9NNKI/PL1marzpl9RKmQSKxD83p6XciBrg==
X-Gm-Gg: AYBFou0t95Bt+p/LWxgUQHqUr0lsLPvs1ejqAmlAFG2yReQHCnvkpuuJM1gzohy6J7a
	FJ4D1SNVgLtme2NGbQdtlnb5dwoe4Z9sNT81xk2D8Jx0uEPOB5XGbzEuhSeiHok47BW/aiY0oif
	M93RaByN089H5WQcF29gGk2jIiU+vsq4y/zk2W12EcivjRbhX4a6xzasmsT18TsNG/+4VirV/tl
	BcekXwrwRuMVCcOidNS/ETiElSl/jznLcRKiPsSba3xThCI4+F7BWW3qVQ8RESWl+WUfan1wVM7
	ssjPZo6nsAjwMBdN2OmDSrDnRZCU86IocdFOJmSUTc7T0RIk8e4DfS7peqM1t06pB+0=
X-Received: by 2002:a05:600c:470a:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e61878adamr168329815e9.1.1789209019311;
        Sat, 12 Sep 2026 03:30:19 -0700 (PDT)
X-Received: by 2002:a05:600c:470a:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49e61878adamr168329105e9.1.1789209018770;
        Sat, 12 Sep 2026 03:30:18 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6fe9d3e3sm21582255e9.0.2026.09.12.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:30:15 -0700 (PDT)
Date: Sat, 12 Sep 2026 06:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] virtio: synchronize callbacks after device reset
Message-ID: <8ae2995ee649adcfe1398f7f1c4fc9f7028c3db1.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789204858.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mw0abgIHOlWa09YtD8osPMiz9kXlpKywBhgBLAs5TQo_1789209019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio_reset_device says:
	Note: this guarantees that vq callbacks are not in progress
but in practice, only virtio pci correctly synchronizes the cbs.

On other transports, a callback that is already executing, keeps running
while the driver tears down the state it uses.

Add virtio_synchronize_cbs to virtio_reset_device fixing this for all
transports that correctly implement synchronize_cbs().

Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://lore.kernel.org/all/20260818040433.66986-1-kmehltretter@gmail.com/
Fixes: c46eccdaadab ("virtio: document virtio_reset_device")
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Karl Mehltretter <kmehltretter@gmail.com>
Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    unchanged since v2

 drivers/virtio/virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b6c9e927bef5..a8588d7ad109 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -264,6 +264,8 @@ void virtio_reset_device(struct virtio_device *dev)
 #endif
 
 	dev->config->reset(dev);
+	/* Flush pending VQ/configuration callbacks. */
+	virtio_synchronize_cbs(dev);
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
-- 
MST

