Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28822FACA
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585832; cv=none; b=O4ObHLgh6NNmYlj3upOR9Pc1CmAoB0R0FUfDeu/GsA3ET3/vEXkStyXtUw2f0pTxtknWXY4DPqqepjA9YcdEHVJ1PIzqDTfuNW+3iC5zoBiR7Sq1XGg77xc/3qDni7D1meVN3itcC08uiy4h6BTmrewgOWVxJKKPyXOXhvewMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585832; c=relaxed/simple;
	bh=C5dSvFClHUK1mf991gzXd1Vn4vGKVld6B02AmFGbYzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nXkSc6H5QGvMy53c/KWmJqcYUToDu8GX1UO9BsHyiILfjbfq9JX0U/0gIDZXt+IgWTlFjGPgOO8Df5ytYgh/lQEvot/3cruKKMrXF2fqJjZ6tx9RX1lF8RAy4WsVQbsH7uQkOWH0Jjkagcq5I0norUwNsYjn0ZRDRMtjoDFV/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC490/WB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC490/WB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3914406D1
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxKvSgfR1Q-S for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Mar 2025 19:37:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E897F406CF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E897F406CF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XC490/WB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E897F406CF
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742585827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QQC0oRuX+H1qRng4JbQdwL2Ntm0XtGldJhk0GkoAWw=;
	b=XC490/WBrBOJAgJuVozqmTFwvaVP7TpCTUxp+KDdJXTOPAa1GTwDpflh8pLPTsWNzRwNvU
	Fy6sTiL4ucT/nJqJgJchpfVW8kp283o7vqOGIgLpl1GflFjcSAy9XRd66ejLxMayXnwuRn
	9yzOYG90LK6o5q2YbpxneVwhfBaNt+k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-GFIozKGUPuyD2ndBq6aU-Q-1; Fri, 21 Mar 2025 15:37:05 -0400
X-MC-Unique: GFIozKGUPuyD2ndBq6aU-Q-1
X-Mimecast-MFC-AGG-ID: GFIozKGUPuyD2ndBq6aU-Q_1742585825
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224364f2492so33682495ad.3
        for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 12:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585825; x=1743190625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QQC0oRuX+H1qRng4JbQdwL2Ntm0XtGldJhk0GkoAWw=;
        b=XXo+DLoZVIMnxGgkJLQNUrOO3Mys/L2c9t8CRwAYngR+qcx5P+9GQrZ5dr8/u7J38W
         QJqk68rI//CkEJGJn82qNlG2VBJUBSH1X6zLXfXR18dz3X1hBsX+Z3sfl7VhFr3/EuXo
         CHh9snxa3GXstChnGSkkZrzDDfBPC7kjqQoJsHeevEDRYSD2NzVtexcaMqXsxFV4GOJv
         3BfCi1qLwfkB0HiMnJUN/g08BF4Ux8Q61Oof96Lt+uxbTBGEBV13vKgDTt+hlarWE81+
         zzTQ5ivlFXOfT+0bO+5q/spuU20ifzXYkmDGrSN80JMV9NVmrvYQ5Cw96zS9emNTEC3t
         4EEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYpWoImbD8SXE3vppDVJCRjjwVqAnNdy+NEpvFBmgkUWkunRuFPUDzXbZuGzww3cmEAVej2PV/oCNbTgYCKA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyW6JAbUytsxE9ovP7L+MYskq8QgdZly6UbZvNIkPhPE6KvXaAd
	fag2PpyXff/JvF/Zcfsl0AEWxhgCAsFq4dHA2H2z+5tTTbu/2sR4WJA3F3317YPs4WwZCKHtSlC
	s+FcOXYQcQBaBsCbq9RYsbp3HrmkuPu1hnz0E0NKEOnD4RDlXC3QNXRY+g+Cg7tsJkLF1LWYb5/
	0TmAA=
X-Gm-Gg: ASbGnctFzaw9wrSq3I5IYUoEd2p0AdavS9CevqSBvDEcJFFwUXSkFkk4FqsJ+1kzY+S
	p28Rtfv4YrTNdhjS4CO9FVIAA78WBa+c7UhfIB5EY9oJO9dB7gaTuduTT3kpqYPK4phRmiEG5jj
	sougeEPzbDqLo7tcY3x77Fl4/faSwOU6CJEYjbvNGbl+nrxufEARV87EGcO83u+Arp0analYQE2
	oyYv0PjVqqSx1oqje6z668KeZG5eoralxwZtzN6KOo3I4pFUkTb5SG4stVHWpbbq/Av2HfZRfmi
	j3bvv+uQ
X-Received: by 2002:a05:6a00:398d:b0:736:b402:533a with SMTP id d2e1a72fcca58-7390593b622mr6060488b3a.1.1742585824596;
        Fri, 21 Mar 2025 12:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEowWUXagoZIoweCvQRfmtjqA/SNMQoj6gAyfhHZS9vDb6q+jhLEaKJ62zuuxrIuV9JfDVSgQ==
X-Received: by 2002:a05:6a00:398d:b0:736:b402:533a with SMTP id d2e1a72fcca58-7390593b622mr6060440b3a.1.1742585823983;
        Fri, 21 Mar 2025 12:37:03 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c72sm2500514b3a.59.2025.03.21.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:37:03 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:36:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
Message-ID: <20250321153611-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vZSiOsy9HcL2tC5cKqSgqndn72GcrK-JDs-5l-INX6g_1742585825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2025 at 10:32:02PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API. 
> 
> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode.

This seems to be on top of an old tree.
Can you rebase pls?

> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> 
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the default value is true.
>  2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
> 
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function pointer in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
> 
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to void.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
> 
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
>  
> Changelog v7: 
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops and add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>   
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (8):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Introduce vhost_worker_ops in vhost_worker
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: uapi to control task mode (owner vs kthread)
>   vhost: Add check for inherit_owner status
>   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
> 
>  drivers/vhost/Kconfig      |  15 +++
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  15 +++
>  4 files changed, 259 insertions(+), 19 deletions(-)
> 
> -- 
> 2.45.0

