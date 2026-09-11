Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76547669A
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130275; cv=none; b=CXqGYmWqTUqkBeZa/pZGuycHKYzOkXuKSwUnc+wObF+p+XZ1dfkZBodXIs/mu+6Vq93pMSsZWihKzxquKAv5ct355GjQUqDC+LhThY4nXeOMfndeFz32L/kIDDF06kfBlypFIp84Pcm0tM2OvK6CowcXrgbOJXod8TmgCPYAdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130275; c=relaxed/simple;
	bh=DPV9nZ2tuZC9Vf3UqrU8CW0urglkq7RragP398hHe/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DdNOHQ3ntcwDPjhXDXWG9pL3XfO34tK0a7fh7MhvOBUt4BJl/FGriQUxknWL8/2ZSl3fpL3fy3wgsToWr68OgWoh11NraGFdECLPBR+WO/ATw3Vzg+7Ah6CCim/j+gPpixKC0FSQ5OBu19EKB/qW9tQtNQn2cx15BL1iqZHd0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoMsLq1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoMsLq1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789130272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JTS7PBVapSbj0SlRRVYRECPQGWduxlCI7H9TX0/I6IA=;
	b=VoMsLq1+pBggChrFSVJmfFpCX+zH+r4F+x48yNvgYbKJxO+JPWU2UIT0ZNs+ROqvZXvvc5
	62bH5DpPyHK8fAzE5WSlcj7PfD8B09SworfY6sywxx7ZNsyrBrSw4e4YMHXox96lu0bqQe
	0Nno/MxgmvvD/VkizNk+GhH+smOQDog=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-OGoq2ylvORu9OELCdAbpKQ-1; Fri, 11 Sep 2026 08:37:49 -0400
X-MC-Unique: OGoq2ylvORu9OELCdAbpKQ-1
X-Mimecast-MFC-AGG-ID: OGoq2ylvORu9OELCdAbpKQ_1789130268
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so7227425e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 05:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130268; x=1789735068;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTS7PBVapSbj0SlRRVYRECPQGWduxlCI7H9TX0/I6IA=;
        b=ZF+tmZEPjW/na3fzBodggyb/8Wo2JPuVLVAAYDuObaHu4I+B0Maku9Q40l3ChAV1Im
         aspQL0zZqS9I9lOpv9ii3vq4lfZC7uvX2MwDyLbRYMwD2vVVGeD7ejeaS8Z/6YZuS2Fe
         RUX2mUF4xfeq8Yuee13PH8lYJ+9YNrtnirsRytoNOROjfbzaYxtAfUS1BwF3QRXFA6Fx
         z/kJfRh4FfOhHlriOXEjXKPU2REbC0jk00SsM6GY5h+YSQeOwR2VtMpe+705t2OLHnz6
         mU8PtACyNBINmeX7P5Qvk+/M1wTz58MCO9qcbLTAa/4jz9BDGQRXEzbZmVZt8XxAJciR
         Ql4w==
X-Forwarded-Encrypted: i=1; AKwUvBwABovWQIcDTid+RN/TAVLkCWhfnsdWnZpHhaWV7qXi06Z8xIq5vW8LhTtIKoGjbnDkcGlU7kex/hKVY0TXPA==@lists.linux.dev
X-Gm-Message-State: AFuF++liNx3MzPZKZBXLh9mxLpba4EwXiZbmRyqhygZvpuwTaQHb/ROV
	db479ScAKmE+jKVMTGSIp7E2vrRMzivHh6JP5dZ8o6Yok2dRVzgYKP3X5a9ooOgHXIXSNedEY50
	9sbIGz2KUjuk43ChWbtwMB+eAnAauyLoTyx3UxydXCnZGMjp8SR82GzhtSoR997eU97J1
X-Gm-Gg: AYBFou3BULjXA0iYX5UjokhmOdBMjBfs3qO4yfTJjWcaeqUWjYcdOpG4vMAVa4Mt2/1
	rWvh1flebOO3eXi6KYTL7Ty3lSaNjjop82uylQaXdasu/npioYF2qYjQK+/QlD+YOTEssh31cFc
	bNtDDlNDDRaNwTnCXwnKHIk0GM4GZjXZtChoRo5hAE6EzaW5TAzq3ZpoO2wivWtEYZ9l4k3yl2x
	DovImU2FLtJyDY3iD+o7yoot3KKVss/Sv0xalX+R9BjLLqGWjaj7glTRhQKXZtZpZ4RZO1OELua
	/8/Ey9+/xb2b80sVtcw7G0IsjTa3oFmC9LPu7gPcz/8xtdHM30j0gFH0nZ4cGNuPZhWQadRtQNL
	Ivk69GSs0WPjCzmrS1OXdDDk=
X-Received: by 2002:a05:600c:3588:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49e619d530emr50197125e9.32.1789130267595;
        Fri, 11 Sep 2026 05:37:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3588:b0:49c:fc6c:be1a with SMTP id 5b1f17b1804b1-49e619d530emr50196375e9.32.1789130266965;
        Fri, 11 Sep 2026 05:37:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c39086sm137607995e9.10.2026.09.11.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:37:46 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:37:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] virtio: synchronize callbacks after device reset
Message-ID: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fB3TNZNFHdO4AZKswXOQDQebvOOwm2qsIHuqWUF3-hk_1789130268
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
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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

