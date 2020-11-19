Return-Path: <SRS0=WAh4=EZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A08C63697
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 14:46:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4713B22253
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 14:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHuiH1Sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4713B22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C028E273B5;
	Thu, 19 Nov 2020 14:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eBhPLLwWlNN; Thu, 19 Nov 2020 14:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9D8E22043B;
	Thu, 19 Nov 2020 14:46:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBFDC1825;
	Thu, 19 Nov 2020 14:46:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E390DC0891
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 14:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF1E186727
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 14:46:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSlNdsT-ALOn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 14:46:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 978FE865CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605797196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nBU9vCty/xUTtvWiRTKM3SNaAnXZsWQI+V6F25yzTt8=;
 b=HHuiH1Scv3UBL9+E32Ir9/c4HGjesuLFONctPpegf5X6X+V15E4WtC5YWn8Wz7MxABCy9+
 tVGwfQtY7yTqqzcT6nfoL6Gz5I6ok4NVUdtckTOSECyJs2hWh7SlUW5z+3/MaRhmgTAVOg
 IpsATjdLtfW7dqh6/CFESUPQLhRv0rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-256PEQHZMOGUB5H0BHWZjA-1; Thu, 19 Nov 2020 09:46:34 -0500
X-MC-Unique: 256PEQHZMOGUB5H0BHWZjA-1
Received: by mail-wm1-f70.google.com with SMTP id a134so2422205wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nBU9vCty/xUTtvWiRTKM3SNaAnXZsWQI+V6F25yzTt8=;
 b=mNViopRQU2zzioQ4phmMqLDtdy0IWB9zqW1Bo6PHwSvWdRikCP6qy1hIzGgdzQdYby
 U5EogaxNChpOs/TlRNB8btBQmMyWdIPvJBr+7Itqft5oU3h9N+qVdgHTW7GWMwuoj3aK
 X1inWc7H1SsAdqQaLNhwPnVKqKNJfWgJEgc0H7cpdkX5TD+goF6ZT037JA3fJDaivFml
 RcIEKA7yDb/sa6T7uRGIHUxjy1+RjnZkJUOSZSX3KkkXFF+a3kGWTngA520aoSkAyKag
 OH/VhEp42iCA1Fs0yiZiLritr1d6vesV93CLvrZNwc3kbbX6KtLnklSaBfnF8eOv9h1x
 Fq+Q==
X-Gm-Message-State: AOAM532Q0wbu3qn/0Ekw0fj3PRljBXCzAM/91ELObkUc49ESbFqk5XDE
 fUsdgH1XkHfyrn+gwzSb+/sNrLX3i45mxHmaAf/RqUHkfBUo2AsmjhlfbcQNVLbR0jWOeYugXPj
 H5rMrp7Sq/4OBXiic3JRCUFnIBzlxjCFeB7QePPT27Q==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4948926wmg.21.1605797193263; 
 Thu, 19 Nov 2020 06:46:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvmGgl1ENR3sYN4BkxpKKT1u0hPsLZxxmf1t2xm1+WIEcjQ7FNbjFySAZs3x19GfjQiwVI5Q==
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr4948910wmg.21.1605797193047; 
 Thu, 19 Nov 2020 06:46:33 -0800 (PST)
Received: from redhat.com (bzq-109-64-91-49.red.bezeqint.net. [109.64.91.49])
 by smtp.gmail.com with ESMTPSA id
 l13sm41378138wrm.24.2020.11.19.06.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2020 06:46:31 -0800 (PST)
Date: Thu, 19 Nov 2020 09:46:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
Message-ID: <20201119094315-mutt-send-email-mst@kernel.org>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201118113117.GF182763@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 pbonzini@redhat.com, Mike Christie <michael.christie@oracle.com>
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

On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> > My preference has been:
> > 
> > 1. If we were to ditch cgroups, then add a new interface that would allow
> > us to bind threads to a specific CPU, so that it lines up with the guest's
> > mq to CPU mapping.
> 
> A 1:1 vCPU/vq->CPU mapping isn't desirable in all cases.
> 
> The CPU affinity is a userspace policy decision. The host kernel should
> provide a mechanism but not the policy. That way userspace can decide
> which workers are shared by multiple vqs and on which physical CPUs they
> should run.

So if we let userspace dictate the threading policy then I think binding
vqs to userspace threads and running there makes the most sense,
no need to create the threads.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
