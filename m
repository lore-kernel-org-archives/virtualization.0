Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F44DC4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 22:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9844B4046A;
	Mon, 17 Jan 2022 22:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzppi1rZKJmb; Mon, 17 Jan 2022 22:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C931D403E7;
	Mon, 17 Jan 2022 22:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1BE2C0031;
	Mon, 17 Jan 2022 22:31:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD574C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 22:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC40660AB3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 22:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VZ3Cb-SUekF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 22:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C07E60AAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 22:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642458704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FL822A+VhuSR8ouSoFdCDXJX7fbLnOA4cmggcaKq1ko=;
 b=X9kdFCS15zxFmC++ouhL56o/sQub5mCxYt2HhEYwDQNq1AQU178ANEk9UtYq1aQVZpgpdY
 FwFbRWGdKtbIbXlGNzom0rdnk+cPwBXa22xRZSQb/6MqTKoLLy0Fw6g5zfoGrVS1gk6KY6
 HVWKGJyEZJ2Fk6+tKQ+vqIq0RIPU1kQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-nJVqF_qWOC685i2pF6uvEQ-1; Mon, 17 Jan 2022 17:31:43 -0500
X-MC-Unique: nJVqF_qWOC685i2pF6uvEQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 s9-20020aa7d789000000b004021d03e2dfso4998308edq.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 14:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FL822A+VhuSR8ouSoFdCDXJX7fbLnOA4cmggcaKq1ko=;
 b=c9AxJpgghfNDaw/wSya8qHBZANWQ3qAeezQgvF1TrdF77VNe4hmVp5t0OiS2QNamJ5
 O+Pa6hG08h2d6kz5Qy3hVSMr1yQI9LXTq28zo1QD44A2apJUrq7hDpMiAzyD7jn0GE0a
 g9U3bCKn49iB2VXhpX7AlKiGDyre2kpLpymBQR6HFUa3SHfZVSZeYHJymXNJjxrtMMtn
 SVNvnT4z9aivP/djSR6khHBft8I0hOLqO1iBP5EiOYq0IMfSLGtB0h4K0RVMIJxuk3se
 hLHq1mhTkQkRfzxw+TXJYCq3mb0V4kIxA5EWPWkv8kk592zITbHCo2UGnk6DpK6+FevD
 wZjA==
X-Gm-Message-State: AOAM5309Yad09XTLZ4sDtfrWAnGqQ6HLqyfABpx/3jXfdXOXHWf/c91R
 sKADzNgU7AU5v/Bd42zrftXVlZyltbp5CtVbvnY8r9ABJjAub7wxAQCOye0etDbuuVCh1QxVNEB
 2wbseCqgFrRFy8Ql5m46Wzith7AK+486yRME9tewPEA==
X-Received: by 2002:a17:907:3f94:: with SMTP id
 hr20mr8801509ejc.88.1642458702583; 
 Mon, 17 Jan 2022 14:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFtcIaT07HfzGtTIKKXfoD/SNDOq7+REx2KhQH3zo4ePI7rSI/H0kRcW3ViUs+z49kNyQvBw==
X-Received: by 2002:a17:907:3f94:: with SMTP id
 hr20mr8801484ejc.88.1642458702391; 
 Mon, 17 Jan 2022 14:31:42 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id a1sm6330754edu.17.2022.01.17.14.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 14:31:39 -0800 (PST)
Date: Mon, 17 Jan 2022 17:31:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vdpa,qemu_fw_cfg: features, cleanups, fixes
Message-ID: <20220117172924-mutt-send-email-mst@kernel.org>
References: <20220114153515-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220114153515-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yun.wang@linux.alibaba.com, kvm@vger.kernel.org, trix@redhat.com,
 flyingpeng@tencent.com, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, guanjun@linux.alibaba.com, jean-philippe@linaro.org,
 lkp@intel.com, xianting.tian@linux.alibaba.com, pasic@linux.ibm.com,
 eperezma@redhat.com, luolikang@nsfocus.com, wu000273@umn.edu,
 lvivier@redhat.com, keescook@chromium.org, somlo@cmu.edu, jiasheng@iscas.ac.cn,
 johan@kernel.org, christophe.jaillet@wanadoo.fr, flyingpenghao@gmail.com,
 dapeng1.mi@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 labbott@kernel.org, gregkh@linuxfoundation.org, lingshan.zhu@intel.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 14, 2022 at 03:35:15PM -0500, Michael S. Tsirkin wrote:
> Jean-Philippe Brucker (5):
>       iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>       iommu/virtio: Support bypass domains
>       iommu/virtio: Sort reserved regions
>       iommu/virtio: Pass end address to viommu_add_mapping()
>       iommu/virtio: Support identity-mapped domains

Linus, just making sure we are on the same page: Jean-Philippe
asked me to drop these patches since another version has been
accepted into another tree. So I did and sent v2 of the pull.
Hope that's clear and sorry about the noise.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
