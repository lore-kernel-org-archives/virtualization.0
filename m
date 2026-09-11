Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEA45D906
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161620; cv=none; b=cmL9tv5qPTwwxC/x9qDAYd1MjZdC6oeEiq4rpLoUcOibAD9wIT0Z58DMW+IdU8LYVplW5wLQoNAldPw3k/cxVoL6sb9IVvxfpXYNQxYg8pMsr88ulVRnf8HzJs+HeNTJW6PcQj4gno2qUVVYpGE44TchH6i4RdM4Lq2trR1z5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161620; c=relaxed/simple;
	bh=RCHAL0lzCqQvQNb2FKlrU6gKEOcCvPQaZQ8kaXzV12o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=blRSmUUp8InBAPpSxPytf99GnDGUkLUK2DFPCsDuLtq7YTe0QEf2UbAVi47uARP1X8Zz6MXcfUaMcr5surbjfdZ4kdavpnH7dIQchWmWq+iTSoS/tApgyIcdpU8CRmhXm56rp1/4tjl0p16aQUlaSQdzdtSvaU/agguCbrsYYCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeFDGhbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeFDGhbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789161618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uu0NQ9lViNj2uc4OaUGE9Tv4kMpxfHFXYrk4Ng1zNOs=;
	b=VeFDGhbstdtviqVCO/iwPRFLH4BVc4awAdmU3ov3U3lu4hHuY3GUPUVvFvBhyLspSyeKXb
	Fu2JPB/4K3kbBDl/814DikwKLCfXUOFKq/QkO2MpuANfNaFtT8qao29XDGyPwzea8o05OS
	yOOtNBQqml3ns3ugK2GHROTuLRg8CUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-1koLa7TPPZWrQPJe-LC9hg-1; Fri, 11 Sep 2026 17:20:16 -0400
X-MC-Unique: 1koLa7TPPZWrQPJe-LC9hg-1
X-Mimecast-MFC-AGG-ID: 1koLa7TPPZWrQPJe-LC9hg_1789161616
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499913d1a79so9493075e9.0
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161615; x=1789766415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uu0NQ9lViNj2uc4OaUGE9Tv4kMpxfHFXYrk4Ng1zNOs=;
        b=MeAu+csK3vNrmCFop0/mKUlZK2e9oKooAn8WkyHAZH8X4KD4YU6J5T/mThooAplspz
         bBNnaGZTmeN/2YcPcBxqcRaR1UQZxxvmYsUNn6qdbv24YOF7Q1Rz7zRYOjv5excS2pq7
         v5/8KOIZKrZDIc0IhaJMevp/nHyZQUZeIwZB0Xzeeoyj/aq6Fx+ZNq5zKQADrA2nSJtD
         xhDaW/zeo2bvMJbQ3T/1ljKQjBjmoExx8SWt2SKfNXv10XiK06mjene90kdZcdoGazsW
         9Z/vWzeJEs1eYYyI08HzR1PFLKVYlT88lkvbSulAXHfz1PtJofaktYCeFU6z5OD8eORp
         5syg==
X-Gm-Message-State: AFuF++lLYAzagI0U9JSshwxcRayvQi31gnPLnvTR/bM4H4Ri8d9JWVO6
	FsHjYh+W0yOGKKYEgXXovGidmpYmTDwuK8r+0Aq8H6iDoMde4EAmZOm22li2kG/+2vNxTRGOuJQ
	oV63KI0vTz4Oo2LeOX6soppTBjLOKzI01ekCLPsWHqLDf4f5l58LioQ6mVd+Di7NQz34mUhT0F5
	aBBU9HoPDlPHUs7P2v+BBZ3uAcIvnpNtleColY48wMJiv1JA==
X-Gm-Gg: AYBFou2Vnj2ZuPeoAIBkUIc6No7ZUH+WTYMY+TRCntL7zYgvJCFTJ57zmgBDzdvLvvw
	ErM+l/w40jPExdWPfjyXTUPRo8OpPegZPoM4oLw7W6KVBXckrIKJK88PA0VWOj71sQBDV6Y5UXL
	xXrc0iCgEqRMTpZssIfE+o19m6JQADJCh4/vdSNP6mxuFI69SDwT8c76aUVQRZnWk7nSMxqOXKy
	GtKaWE8HTsNucEXpC2MhJVqhhY00dtesgirR1qDcF/Hv3qjqzRmbvfqlRuf+arUNfm6wDFxKe6D
	CpZHH5HPT1SwVJumAesLnRZyOE2dt0lHnRSuatyU4dqP6gl9EuiIPZ3csPEnnJsGcaY=
X-Received: by 2002:a05:600c:540e:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49e66922810mr89358475e9.2.1789161615505;
        Fri, 11 Sep 2026 14:20:15 -0700 (PDT)
X-Received: by 2002:a05:600c:540e:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49e66922810mr89357925e9.2.1789161615023;
        Fri, 11 Sep 2026 14:20:15 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm201623235e9.15.2026.09.11.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:20:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] virtio: synchronize callbacks after device reset
Message-ID: <01295278b402c2856b83568e07c86853f2d30e2b.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789160982.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GYnzIV5ROgqT4fBxwspXBpyNB6FejfBtkFZdDIlUqrE_1789161616
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
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
Changes v2->v3: unchanged

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

