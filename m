Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70528C433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7C420732
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 08:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYobp+iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7C420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D43286702;
	Tue,  8 Sep 2020 08:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xCEQ34EBznTn; Tue,  8 Sep 2020 08:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D0C386500;
	Tue,  8 Sep 2020 08:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E95C088B;
	Tue,  8 Sep 2020 08:35:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 235F8C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 08:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EA8262051A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 08:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wafy1tQGxF+l
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 08:35:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B3A97203E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599554136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
 b=KYobp+izMjIsLYbetyGO8qyRENFEdEg4kk9uSq/1MtELgCj+boPgqz/TgJzDv51kOTqt/X
 6p20QeGLhZrKJ2AN8czM8Cprxm3dVsdpvU6aEdR4FgOT4yDCqNd0SpC4xFCcNMk8E32a0p
 UKqGxhlU3dFs60xRABAVMb80lChMzv8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-6imHe5FqMQGdHnS5fMJVuA-1; Tue, 08 Sep 2020 04:35:34 -0400
X-MC-Unique: 6imHe5FqMQGdHnS5fMJVuA-1
Received: by mail-wr1-f70.google.com with SMTP id s8so6670934wrb.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
 b=IZVT5P3qfav+nA600dfAEjA9ZYoICgcj/iDtG3HfjeG0h4vgSNdqbQSUvHGFx5MCU1
 oLdjXqxJwWDGS4z3yptyR6sRPF5sNHFKWtTD6QZXSQbYY2F/oCK+H8gXvfz2Od4mHLpA
 N6+BkNFRXvi/oS/L25iFJHkQBjPj4XJinSoT8JuFZqRVgaOaRT3YCsHXlsliogst12sV
 5iySpGIWlXcKCn3nDdqJ29chnoHAg6zxyE34+GhJjLtdMCQQDf/3dTK8XbVpZWR/i7jG
 zV3lARX4YNxEjhgSLzAypFl3t3hxnizntfOECDDIRyx28j48N7RkhE6xH+RG9IMV9Rn/
 j75A==
X-Gm-Message-State: AOAM5311PxkGwe1K95EvyoIo1XxZbvrTYhiwGe7irVRSgbCa7GJW4xvZ
 ffmC3IIqW9HQs78AuJ7iB4E9g2Us2q3TroC3vo5yBMuJC9uSFa8tG+rACvKM1pMkmTNuTka6+EY
 w8jmoKmjOpNG5FAK+zvKGNWPObqfIrKhWDch5XZXPdg==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173543wmc.103.1599554133720; 
 Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI7qjqWRvqDDMKuSEyexs2ZtKt48S7kwb/PYSoSmDiwm5Mm57vBJ7GtHojpCcdWEA5RCWEdA==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173527wmc.103.1599554133531; 
 Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
Received: from redhat.com ([147.161.15.98])
 by smtp.gmail.com with ESMTPSA id z203sm34774917wmc.31.2020.09.08.01.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:35:32 -0700 (PDT)
Date: Tue, 8 Sep 2020 04:35:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908043503-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
 <20200908085521.4db22680.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200908085521.4db22680.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>, thomas.lendacky@amd.com,
 linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 borntraeger@de.ibm.com, kvm@vger.kernel.org, hca@linux.ibm.com,
 david@gibson.dropbear.id.au
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

On Tue, Sep 08, 2020 at 08:55:21AM +0200, Cornelia Huck wrote:
> On Tue, 8 Sep 2020 00:39:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon,  7 Sep 2020 11:39:05 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> > > Hi all,
> > > 
> > > The goal of the series is to give a chance to the architecture
> > > to validate VIRTIO device features.  
> > 
> > Michael, is this going in via your tree?
> > 
> 
> I believe Michael's tree is the right place for this, but I can also
> queue it if I get an ack on patch 1.

I think Halil pointed out some minor issues, so a new version is in
order.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
