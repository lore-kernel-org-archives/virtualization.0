Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C01EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:16:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E4F60F9E
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26E4F60F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D47C16077E;
	Fri, 22 Oct 2021 10:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-XQIFo5dQvu; Fri, 22 Oct 2021 10:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 621F660669;
	Fri, 22 Oct 2021 10:16:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 415A9C0020;
	Fri, 22 Oct 2021 10:16:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5005CC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 322DA60669
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbJONOZrkakn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 419566077E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634897797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Ua6AlWGP/sF0k/9C+Oe4lvK1ja5qFbabdZX50rHRTo=;
 b=EV8drQ7b6SCWq5hYUHl4mzDlsicvZDY/VuGqDmhcL1RlBNtSBgnvViTAgugIw2KJqsyblU
 v6bxGT6+N8t4j4pQsn18jJXhiyMOLjB8yEG7o/wEqWf9CISaO9zLC2ZxYOvFWFfoxHdOsb
 m6rLmHCc81fMzSuxX3Q/Mwo7Z1qgzEk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-45Oj0a2gNLiRoe6J0FNUog-1; Fri, 22 Oct 2021 06:16:33 -0400
X-MC-Unique: 45Oj0a2gNLiRoe6J0FNUog-1
Received: by mail-wm1-f72.google.com with SMTP id
 f20-20020a05600c155400b0030db7b29174so838906wmg.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 03:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Ua6AlWGP/sF0k/9C+Oe4lvK1ja5qFbabdZX50rHRTo=;
 b=zYY6p0JHvHneykQSQK+PbVziF0judNxdqjG4oy/W+I+BmdrpV0UQlI3XiEh/OcxIMe
 G8523TeR6YhLpbg9x6vhqo28+2dJlqPHvACALLq87Nw3h4twgiMRhCnnnufWZzgFCMWg
 1yidq7nuyzCFdehapLl9enPsTi1V5z5vIdhKRpFG2yB1PRIpFbTbGIHWhdE/Xp9hDEM8
 Y9EzTlOfNpR5RlpGPpacAqn/K8mPIAu9KRRgLPHRlbJLfCwZ4BEYrj5kCbNg6olgBoZi
 jFN898byv9uDoFZh6t60BbSFRP3lUAdUoaFQyxd8tRAAwxOIe4tw4jy0O/1K5ivIbXrm
 Tr8A==
X-Gm-Message-State: AOAM532Kue0jy43ooiWgKIfRMBYcqwn8jBy1nszO84pDPwcN8k8QEvbp
 Yp7pKHTg8fty6aTO5yQKkAWOlyKxe7WEMe4S9tq8WlGPzdRYkYVhU3U1p1BEyYx/vdgC4DUOOfs
 K1Rxw4gtZ76VCd+pg2in+n14E4NYgouviI0wNzBp1Ag==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr28727643wma.53.1634897792768; 
 Fri, 22 Oct 2021 03:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEZzL+h9cZG8/oLjmA/xeoY2tZbkrdYLdiosUOwjpIOmyClQhzTd81n72WWT/9c6Hntn6urQ==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr28727621wma.53.1634897792540; 
 Fri, 22 Oct 2021 03:16:32 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id l2sm11285587wmi.1.2021.10.22.03.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 03:16:31 -0700 (PDT)
Date: Fri, 22 Oct 2021 06:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <20211022061534-mutt-send-email-mst@kernel.org>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: joro@8bytes.org, virtualization@lists.linux-foundation.org,
 eric.auger@redhat.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org
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

On Wed, Oct 13, 2021 at 01:10:48PM +0100, Jean-Philippe Brucker wrote:
> Support identity domains, allowing to only enable IOMMU protection for a
> subset of endpoints (those assigned to userspace, for example). Users
> may enable identity domains at compile time
> (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
> runtime (/sys/kernel/iommu_groups/*/type = identity).


I put this in my branch so it can get testing under linux-next,
but pls notice if the ballot does not conclude in time
for the merge window I won't send it to Linus.

> Patches 1-2 support identity domains using the optional
> VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> spec, see [1] for the latest proposal.
> 
> Patches 3-5 add a fallback to identity mappings, when the feature is not
> supported.
> 
> Note that this series doesn't touch the global bypass bit added by
> VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU should
> be attached to a domain, so global bypass isn't in use after endpoints
> are probed. Before that, the global bypass policy is decided by the
> hypervisor and firmware. So I don't think Linux needs to touch the
> global bypass bit, but there are some patches available on my
> virtio-iommu/bypass branch [2] to test it.
> 
> QEMU patches are on my virtio-iommu/bypass branch [3] (and the list)
> 
> [1] https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07898.html
> [2] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/bypass
> [3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass
> 
> Jean-Philippe Brucker (5):
>   iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>   iommu/virtio: Support bypass domains
>   iommu/virtio: Sort reserved regions
>   iommu/virtio: Pass end address to viommu_add_mapping()
>   iommu/virtio: Support identity-mapped domains
> 
>  include/uapi/linux/virtio_iommu.h |   8 ++-
>  drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
>  2 files changed, 101 insertions(+), 20 deletions(-)
> 
> -- 
> 2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
