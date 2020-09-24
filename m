Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A0C4363D
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164E3206B6
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoTtA2E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164E3206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F433869B7;
	Thu, 24 Sep 2020 09:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtSU3M7yRMLb; Thu, 24 Sep 2020 09:38:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 950EA845D4;
	Thu, 24 Sep 2020 09:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83FA3C1AD7;
	Thu, 24 Sep 2020 09:38:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A69FAC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 947B6872D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bVP59KaD243b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6D5FF87497
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600940303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
 b=WoTtA2E2mX+8s1wtC8/nTjHU/aDj88CpLWVhtWoLxMm+K6oeYehARwUpm0kVgWA6yi//e+
 2laNguNMYzYrlLKPWg6nzU7Xz7tvXji7nHGTdTpZ4YyL81w/L2qu6HEZZk0GWyilLA/D1D
 9Sbg2nRGUNjDfz0pLYVZZg1tOOohktk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-P7pw9pk6OuuCiRS_VY_wpg-1; Thu, 24 Sep 2020 05:38:19 -0400
X-MC-Unique: P7pw9pk6OuuCiRS_VY_wpg-1
Received: by mail-wm1-f71.google.com with SMTP id u5so1017978wme.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 02:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GQMLt7r4p28L0sSJJPMjF6juRbduNigBdA5Pg+z0Rro=;
 b=tEzV83nLfVnFgEauxE5xJ1YTZUU0F5LQdA+ULIi6OYabnILGBps41KZw7QEhuWc9jP
 PNGJEPFORO6ypuIJZdjmuGdR5ntD/Ddt9qRUAQ8iyABVSmXR0bEniQpTnwK+RPwdom0Z
 exU+ehjH0RW9s7Ax7K8Gn3aim/htP3o07lx8h9YwAuRcBCzxSDjQEh0RJM19g8ZSBX00
 8jH2DlWT0hnmJiXXmsdc6y3zh4vfXz5Ybv7dymDA0/7Fr/SraRp+KvY43yBypYkqnccW
 5ma1eMGQuFo6JxHqu9507oP3nbFlTim3v55de6lmVTZVgmaGdUSOHreszBuZJ2iFaI83
 0aJA==
X-Gm-Message-State: AOAM530vKVUPt4TLVTA9GgIGAZeEjVZZ9Tq2/RlqmpKOTXx+mFbivhk4
 sFLNwPEnsu5m4zL42Favz6mFbEASLV4CJeNTBXEudncKDhjnzlZ6qN92AgWxUMOiD722LA/Jl7W
 u62Fc+VkwI1plE34m/g2mSyj2+5+X31a1qVAuFcXrPA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007446wrv.303.1600940298005; 
 Thu, 24 Sep 2020 02:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNfu1dfe6iZYDmyztM8WdEywh/avjWGmq3NjwJSF1cAVd6SUgRkwNdlaUiQJUtrdpjEEYZSA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr4007413wrv.303.1600940297782; 
 Thu, 24 Sep 2020 02:38:17 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c205sm2730814wmd.33.2020.09.24.02.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:38:16 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924053159-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200924092129.GH27174@8bytes.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Auger Eric <eric.auger@redhat.com>,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com
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

On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > OK so this looks good. Can you pls repost with the minor tweak
> > suggested and all acks included, and I will queue this?
> 
> My NACK still stands, as long as a few questions are open:
> 
> 	1) The format used here will be the same as in the ACPI table? I
> 	   think the answer to this questions must be Yes, so this leads
> 	   to the real question:

I am not sure it's a must.
We can always tweak the parser if there are slight differences
between ACPI and virtio formats.

But we do want the virtio format used here to be approved by the virtio
TC, so it won't change.

Eric, Jean-Philippe, does one of you intend to create a github issue
and request a ballot for the TC? It's been posted end of August with no
changes ...

> 	2) Has the ACPI table format stabalized already? If and only if
> 	   the answer is Yes I will Ack these patches. We don't need to
> 	   wait until the ACPI table format is published in a
> 	   specification update, but at least some certainty that it
> 	   will not change in incompatible ways anymore is needed.
> 

Not that I know, but I don't see why it's a must.

> So what progress has been made with the ACPI table specification, is it
> just a matter of time to get it approved or are there concerns?
> 
> Regards,
> 
> 	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
