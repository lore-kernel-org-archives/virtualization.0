Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92A020409F
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514695; cv=none; b=jsiMB72G/cln+d6PJTLsHDVGLaijepowsxG5+TvdRz7D7zzpxvYrXhVUuzFS41Ed56Odxj+yLktqW5mLiH2FzSrHUrFxBDWQMCQVxUvnNepBNZrp0+26/GV/o7osm1Er2kXezyiqPov1AlLRWqcEuY0vS0fTrOwSSeyWvPOhMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514695; c=relaxed/simple;
	bh=Tv6jLPBrzNjMWpo+/OOUTUfL/0e584MxIOISNnV7p8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=quS3u/ldqZXclLqpI5Z/CzXgCJDVko5gnvoOr27E+z6DxhmGx+kj7CZlFsEByn3QMjiN3uE5bw2N/QDehQXv2GEGU21ESdquGD6V4BMLOl18CHLHZys2N1AsxC2rpcaZUhVw0Q6cpGzlPERwE4FnYfom0lyu86g8Pwzx/RmCdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwmHzA7m; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwmHzA7m"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63573412AD
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPHzI6rILwnc for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:38:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B53E2412F3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B53E2412F3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EwmHzA7m
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B53E2412F3
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLR2CTlKlBh1tBHT4me7CSz9I+6Wecczia3M942yG/Q=;
	b=EwmHzA7mxWBoSMPd4/jKGQ19A23vs6TRB4LTsBMl7uhhmEk1APqnsv4ocCVfbqNrh8VAVY
	IBI0iUJ63PRWTQx9XHJNaPXDk+68yOS8VMo+pntb5xJjLW3yQ/pJ7g5++LTcYFwk2GZjc8
	L8d+T3UjylumRrVv0Ub6lMGnwN5z43c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-LU2Jr8WwPZyPMn-TzEF3oQ-1; Tue, 01 Apr 2025 09:38:11 -0400
X-MC-Unique: LU2Jr8WwPZyPMn-TzEF3oQ-1
X-Mimecast-MFC-AGG-ID: LU2Jr8WwPZyPMn-TzEF3oQ_1743514690
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso3557341f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514690; x=1744119490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLR2CTlKlBh1tBHT4me7CSz9I+6Wecczia3M942yG/Q=;
        b=LrA4CcoAMCw6nAweLkCseM/1rZ27eDn12l0dtsW2qpl2A0xhyi03Ys5Uqu/UKZuyN6
         DZhe3aYW0EOhn0+JwP2/YA9N8oF+DRxX82I9/RJ9c3LGI1yr2jPLCMNNxv1nFYfTqXV/
         J1loP/VHY1kqimM+g3sNzHwOwMl5viosXAndmSMAKVFjz4gcsyeU+IXaS9rZPRyfRap6
         TkKXVNk24vu6SC3yo3NU9Vvvr9T73BAS2ATvujBEzYPpR2hCxR8aFrTCa37MVGodaN6N
         DE+YHGbF/msABqpfw97+3FE0LycEOQKZy79gtDsWtYctxEPaJtvZEULD/3DAv33mvEQR
         MqTA==
X-Forwarded-Encrypted: i=1; AJvYcCX7zgPZm+SdUjaSOaP90dRS069OGpZj2cXtjF26btYTfjLr12VkAMu3B25yGsv+fqPrVRH5CujKLIxa7ItzvQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzql56Qg+G+et1TYF5/mQaVK3z/kglyZtn+eBVZDPscEpdTT6Sa
	9HE9w2ckSPwik0gVzp+5mu8G0TBvWCJ+v7Nt8M251TByULNgfHqL3TXbFOKZzN2iXEO86HxbqJF
	53VAq6b0itUPg9ZQ4fA6cOjV3J5xOU0vJuIeTO8jJprMxHpQ9A63d1HT5oZsDkAPMU6pFJe7i+S
	rxuG0=
X-Gm-Gg: ASbGncuJiz1KaSSk/8F/A8krRuKzme9PambcD0egaBbK0FcNUVL0kYfbx7ItGLKWZNN
	1sTlFhhmShQeWDUmYTdBo2WBzPSE+Ro7Ez1eqISvq+098e18DJWB7RcrBWnZAK5wyjDv1Lg5Ua9
	2suR8ftvGEWeV02BPthQtj7LvegYYvqvWrlu0FDN2gLflbNGrjx91KcEQTuluxRzxaJ2ynLK51G
	U9c8XGKplAY6uIPP4H5fSzYbhGUjhQGDD9axdJ76zVkBWBIG7oXMMCmYWI5xBMydtRWz5Cjvv+1
	cnQtO9wD/divw2fyrcujeyNTbK9vDlk/3LevVUPsJmnbEHcBwwwO/U2Owic=
X-Received: by 2002:a05:6000:40ce:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-39c12118e33mr10038714f8f.35.1743514689986;
        Tue, 01 Apr 2025 06:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlZRmu/hwz3PRTRaavlDQia8G1V08A9rc2gfYG8uSPBATLZEqFZ5bYSvbtyXL7+/sXwDad3g==
X-Received: by 2002:a05:6000:40ce:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-39c12118e33mr10038680f8f.35.1743514689549;
        Tue, 01 Apr 2025 06:38:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm13944756f8f.7.2025.04.01.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:38:08 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:38:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/8] vhost: Reintroduce vhost_worker to support kthread
Message-ID: <ylnfh4mwifvrnmlwpg6g4mjtfzc7z5qvn5hnnvxz6cepbkobcg@hsv3z2yp5w3f>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-3-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _nzlHBq_kn6gir-jae5x2p4SHtwx_0mm-MuCgIRWpgo_1743514690
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 28, 2025 at 06:02:46PM +0800, Cindy Lu wrote:
>Add the previously removed function vhost_worker() back
>to support the kthread and rename it to vhost_run_work_kthread_list.
>
>The old function vhost_worker was change to support task in

nit: s/change/changed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>change to xarray in
>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)

I tried to build commit by commit (mainly to check bisection), and I
discovered that nowdays unused functions produce an error (yes, we can 
mute it for example by setting CONFIG_WERROR to N), but I wanted to 
point it out:

../drivers/vhost/vhost.c:391:12: error: ‘vhost_run_work_kthread_list’ defined but not used [-Werror=unused-function]
   391 | static int vhost_run_work_kthread_list(void *data)

So not sure if we need to squash this where we use it.

Same issue also for the next 2 patches.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 250dc43f1786..9500e85b42ce 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	__vhost_vq_meta_reset(vq);
> }
>
>+static int vhost_run_work_kthread_list(void *data)
>+{
>+	struct vhost_worker *worker = data;
>+	struct vhost_work *work, *work_next;
>+	struct vhost_dev *dev = worker->dev;
>+	struct llist_node *node;
>+
>+	kthread_use_mm(dev->mm);
>+
>+	for (;;) {
>+		/* mb paired w/ kthread_stop */
>+		set_current_state(TASK_INTERRUPTIBLE);
>+
>+		if (kthread_should_stop()) {
>+			__set_current_state(TASK_RUNNING);
>+			break;
>+		}
>+		node = llist_del_all(&worker->work_list);
>+		if (!node)
>+			schedule();
>+
>+		node = llist_reverse_order(node);
>+		/* make sure flag is seen after deletion */
>+		smp_wmb();
>+		llist_for_each_entry_safe(work, work_next, node, node) {
>+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>+			__set_current_state(TASK_RUNNING);
>+			kcov_remote_start_common(worker->kcov_handle);
>+			work->fn(work);
>+			kcov_remote_stop();
>+			cond_resched();
>+		}
>+	}
>+	kthread_unuse_mm(dev->mm);
>+
>+	return 0;
>+}
>+
> static bool vhost_run_work_list(void *data)
> {
> 	struct vhost_worker *worker = data;
>-- 
>2.45.0
>

