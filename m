Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47032C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD1221D91
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABi7/9SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD1221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6C21B2E15A;
	Fri, 25 Sep 2020 10:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHJQW4OIRftV; Fri, 25 Sep 2020 10:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 317A62E161;
	Fri, 25 Sep 2020 10:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F26FCC1AD6;
	Fri, 25 Sep 2020 10:23:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3CE5C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C004D2E161
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itRybOZSzZ4M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:23:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8688A2E15A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:23:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601029390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8U1FHT96w/PLZq5zU9S1B7ShBJVy7YnIM6zbSDnntI=;
 b=ABi7/9SN/Vbj+98I2cHodnBGduC/rxDQkcgFuIsypcDQeAZcYaNMQMVeb2J72ntKmnaA7i
 tO9H39UuvhQBgDWTo2gMuZNh9pFUrfv555cxZnjTi5+d5IyYUYI2vMTb9sOMOovOeoQMlM
 oRMU6k0+5KE+nwMF/QwTxVMMll4rucQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-X2S7DZe-Owex-kp4o5xheg-1; Fri, 25 Sep 2020 06:23:03 -0400
X-MC-Unique: X2S7DZe-Owex-kp4o5xheg-1
Received: by mail-wr1-f70.google.com with SMTP id v12so897164wrm.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 03:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N8U1FHT96w/PLZq5zU9S1B7ShBJVy7YnIM6zbSDnntI=;
 b=CmCx1XiZqq+vX7NhKdFxCol29fggeosiVStQSwtiN3/9Bi6z2Fdtd0XmGPSxPu57Pi
 D1bUKw0hyiJjikzZMsgnsO+sktOhNxMI2qYP2pW6ZVg/TNyjrHtoWrpVXgIe1UYAE5S/
 1/3sFZoyzPAO79Le5sGuCjokjT655WFb+X2XCTuIMNZnuaUT9oEPW/HaAoULrHWm125r
 dVavjcy3i6+jttGD+acrIkqqgXjUu3bKzxl8ClqzGxLFZvNFtf43+dD5dHCvtoM3/XAw
 gK+3vqsj4tLXHq03NiiiwwyKCRnJSJVqDb2Vwh8Z3x0yB/gttl64HCxxGee2JEiuGWxt
 V5nA==
X-Gm-Message-State: AOAM5333rxkdIlo4IgmRwC7tshWp55B2r10fXmKhyrbjU3SgwxHLsVb8
 tydPbp0z31NkPzdO6pvUxYHYq305ti5yxsqTTAdEEFHr3VPysR1nP16rxBqPv9HGUIFn8Vug2v1
 Y8BtDuuB3fqH1pN4aE1C/ubJhcaQu6q9JezpMGworLQ==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr3728298wrw.331.1601029381665; 
 Fri, 25 Sep 2020 03:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiECiPGTS15kvZqa8R0xHOPr4KjpmYEDueiFgt/xYTRs755Rb+d0YFWnl/vVYKdot5K3D6nQ==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr3728283wrw.331.1601029381484; 
 Fri, 25 Sep 2020 03:23:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d9sm2246590wmb.30.2020.09.25.03.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 03:23:00 -0700 (PDT)
Date: Fri, 25 Sep 2020 06:22:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925062230-mutt-send-email-mst@kernel.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
MIME-Version: 1.0
In-Reply-To: <20200925084806.GB490533@myrica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
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

On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> > 
> > v3:
> > * Add patch 1 that moves virtio-iommu to a subfolder.
> > * Split the rest:
> >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> >     support.
> >   * Patch 4 adds definitions.
> >   * Patch 5 adds parser in topology.c.
> > * Address other comments.
> > 
> > Linux and QEMU patches available at:
> > https://jpbrucker.net/git/linux virtio-iommu/devel
> > https://jpbrucker.net/git/qemu virtio-iommu/devel
> 
> I'm parking this work again, until we make progress on the ACPI table, or
> until a platform without ACPI and DT needs it. Until then, I've pushed v4
> to my virtio-iommu/topo branch and will keep it rebased on master.
> 
> Thanks,
> Jean

I think you guys need to work on virtio spec too, not too much left to
do there ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
