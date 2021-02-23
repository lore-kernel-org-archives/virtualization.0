Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767CC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:56:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1618F64DDC
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1618F64DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C772C826EF;
	Tue, 23 Feb 2021 12:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvZ8ODehuMbE; Tue, 23 Feb 2021 12:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC30F83638;
	Tue, 23 Feb 2021 12:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC811C000C;
	Tue, 23 Feb 2021 12:56:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7AB2C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5A6E83A3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 444EKWcy23xK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E24AB83638
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614084982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGX4av4aELQvmxhToSs06FARrEgYr2ky959AcUMe3H4=;
 b=PUhJ/djDhmLh1c9fIwCGuSSd3uWrMIGEM+CBIR0J/KcXBHHIB5foXVpgLESTeurT4ExzIh
 2InF9OyxftJxzI7QhM9PEFKiewvnx54RgDn/+gFEjdCSJY9Gr4WUhgaaG9gVJOC9cPFZkY
 8qJHw+cdUcJIf2bcqArPiIxGL8IxahQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-kDTCyv0KNcCFROZMvWyyLQ-1; Tue, 23 Feb 2021 07:56:20 -0500
X-MC-Unique: kDTCyv0KNcCFROZMvWyyLQ-1
Received: by mail-wm1-f70.google.com with SMTP id t15so671815wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VGX4av4aELQvmxhToSs06FARrEgYr2ky959AcUMe3H4=;
 b=CbTV+kkI3PWLfZsKhLjNUakoyH3bk1KSGWZDbzrUQ/qcoPyc5fPLXPhQRH770BzU+l
 154CZw3PZeRQXMAK5ORY2axcplRf3ro6cci6M6yfKAQotQ7tTwcsymkvvQ9WL/EKmACr
 8H451zs3mC5mkHOZGDBUu0iFX057rgmqIHp0HaGraUJq5GVU2kimT6/wCR/3UTP1kMmh
 Ewnm3Hn13L1oZR7zZByVwlQzFIg7ry028Jhame4HG5PBeI6ojz9BXhP33aeaSKeII+42
 +v6ZOblRun+bfR6YniiZOGZ+PBsQvIyfuVQYagL0+whgVkyd91/66QIr7T7BkcXnC63T
 bInQ==
X-Gm-Message-State: AOAM530Qzv4BnmtwDDmr7TJd0PoPLXt7+iMJA0O5yOnDMVtWz8j0il2T
 EVTTctk5+24ZJc6vHFAMhka01Xyr08a3zpH6UV334ZGiHeCWwfLrsNEixsP8pp4n+VnscGKEy71
 kT6AcY4pVOpfdUD9J7g9Sj9tlkCmu0WB8SIPp5aIyWw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr6795867wrt.370.1614084979570; 
 Tue, 23 Feb 2021 04:56:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOkkpVZ/w6Xbi3Y2JFXjcz0IESdg+8qMCw1uDa0yv860hSl1r4oLfkfq1xmTV0zflrBRnYxw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr6795852wrt.370.1614084979471; 
 Tue, 23 Feb 2021 04:56:19 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z11sm533005wmf.28.2021.02.23.04.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:56:19 -0800 (PST)
Date: Tue, 23 Feb 2021 07:56:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210223075508-mutt-send-email-mst@kernel.org>
References: <20210218074157.43220-1-elic@nvidia.com>
 <20210223072847-mutt-send-email-mst@kernel.org>
 <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
 <20210223075211-mutt-send-email-mst@kernel.org>
 <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210223125442.GA171540@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
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

On Tue, Feb 23, 2021 at 02:54:42PM +0200, Eli Cohen wrote:
> On Tue, Feb 23, 2021 at 07:52:34AM -0500, Michael S. Tsirkin wrote:
> > 
> > I think I have them in the linux next branch, no?
> > 
> 
> You do.

I guest there's a conflict with some other patch in that tree then.
Can you rebase please?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
