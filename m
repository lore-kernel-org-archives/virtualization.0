Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE93CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 16:05:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6331C60E2E;
	Tue, 18 Jan 2022 16:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toSQyuPp4lhn; Tue, 18 Jan 2022 16:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0811D60D89;
	Tue, 18 Jan 2022 16:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C36C0031;
	Tue, 18 Jan 2022 16:05:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57705C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 16:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CD2940987
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 16:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5p6ExyxIeF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 16:05:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C2864094C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642521938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhZD4dPv70JAO78H9By+vkFUlblrnCP8Y+T8IluG7A8=;
 b=G7/R2s3JGQirZ1AS5wNJ9qd7L0naRZloIU8G+iuorh7tBMfzfuDk8XKnvIm6TJXKfDKN3+
 T4QZUKmvUWtPg3blcxqJ25ESdDc5f1XGSOsildFfO8S82WHGB+PZPoBGc1vi1T8Ag4hCBY
 DQ4qu3vOgJ6HtdXuTixt0aJnbTSI1XA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-2QWSDv-7OnSa2Y6V_OPxcg-1; Tue, 18 Jan 2022 11:05:35 -0500
X-MC-Unique: 2QWSDv-7OnSa2Y6V_OPxcg-1
Received: by mail-ed1-f70.google.com with SMTP id
 z6-20020a50eb46000000b00403a7687b5bso1614142edp.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WhZD4dPv70JAO78H9By+vkFUlblrnCP8Y+T8IluG7A8=;
 b=vH64AE5e2A0QXAaIIGJoF5QMgseEiYY/UR1PEE7/5BliS6vy47oCmZWgAe/OJxXWnN
 DdTXbWAvFNac2Gu1szh3ySgrLMUGQSmHm0Z50DV+3knyjvbOx8Lsd6BwcSq/tAcK2dUH
 7SVii3EXUr4DZ6/mfq0Yzi449vyTtY40aB4LP/QILCkalcLSJIpWPdOqvj/TjTdNP6vu
 rwVwHVKbTIwQU04U92dN5nn8RTPdTd99gTDY0lQJUTCl7XQa1XPc56zGXFZEk0beP6m4
 Uo3rzW46n2CMjSyQ3qHZVoO1uNAY5Fe4xVHQGFtH1y5+QeSHj9RersI1wymXOH64vYMZ
 QxOg==
X-Gm-Message-State: AOAM530OGicNhz5T97a9gKF+F3ne90/grLJzTlkW7fVusw7SMZYU77pK
 rBXuPfomQMzr4k4SsERc8aZs1MIpNQSEMpJnQE9ifuxz5FM5eXVaml75397IYwM7EmJri3Hf0S5
 MyKPh9oaryYF+bjm38wR5BgJyotYTCBnEAmufbJ3eVQ==
X-Received: by 2002:a17:907:2d0c:: with SMTP id
 gs12mr20937054ejc.4.1642521933911; 
 Tue, 18 Jan 2022 08:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMIUKlxn6tFfblRwkqdvCO8G6NzJbINTIEtiCcNtNEqcSEi7Vs9smK5rWgr9UoQa82C3qEDA==
X-Received: by 2002:a17:907:2d0c:: with SMTP id
 gs12mr20937047ejc.4.1642521933713; 
 Tue, 18 Jan 2022 08:05:33 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id u18sm200313ejc.110.2022.01.18.08.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 08:05:33 -0800 (PST)
Date: Tue, 18 Jan 2022 11:05:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] drivers/virtio: Enable virtio mem for ARM64
Message-ID: <20220118110512-mutt-send-email-mst@kernel.org>
References: <20220118084858.175305-1-gshan@redhat.com>
 <2f0d1a5f-7e75-04b1-f2a1-f52385dae3b5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2f0d1a5f-7e75-04b1-f2a1-f52385dae3b5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shan Gavin <shan.gavin@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 virtualization@lists.linux-foundation.org
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

On Tue, Jan 18, 2022 at 05:38:20PM +0800, Gavin Shan wrote:
> On 1/18/22 4:48 PM, Gavin Shan wrote:
> > This enables virtio-mem device support by allowing to enable the
> > corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> > architecture.
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> > v2: Improved the comments about the kernel config option (David)
> > ---
> >   drivers/virtio/Kconfig | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> My git-sendemail should have been broken. A list of receivers are
> dropped automatically though they were explicitly specified, but
> linux-arm-kernel@lists.infradead.org was missed to be copied.
> Fixing all of them through thunderbird :)
> 
> Thanks,
> Gavin

Pls bounce the original patch to me so I can queue it.


> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 34f80b7a8a64..74c8b0c7bc33 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
> >   config VIRTIO_MEM
> >   	tristate "Virtio mem driver"
> >   	default m
> > -	depends on X86_64
> > +	depends on X86_64 || ARM64
> >   	depends on VIRTIO
> >   	depends on MEMORY_HOTPLUG
> >   	depends on MEMORY_HOTREMOVE
> > @@ -116,8 +116,9 @@ config VIRTIO_MEM
> >   	 This driver provides access to virtio-mem paravirtualized memory
> >   	 devices, allowing to hotplug and hotunplug memory.
> > -	 This driver was only tested under x86-64, but should theoretically
> > -	 work on all architectures that support memory hotplug and hotremove.
> > +	 This driver was only tested under x86-64 and arm64, but should
> > +	 theoretically work on all architectures that support memory hotplug
> > +	 and hotremove.
> >   	 If unsure, say M.
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
