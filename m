Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47246C433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12C62177B
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 07:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dACjHd4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12C62177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 930B787216;
	Tue,  8 Sep 2020 07:57:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2RXf71FB83Z; Tue,  8 Sep 2020 07:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DC768720A;
	Tue,  8 Sep 2020 07:57:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0576C0859;
	Tue,  8 Sep 2020 07:57:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFD6C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7CBF486591
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WqBK1_64V_2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:57:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A33EA85C67
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599551862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
 b=dACjHd4QD79dS/0LIXO0AHJrDi0ZlLYTBQMCyrE0QktMcVoocFdEaP7wgZ31M7as69DqrJ
 sDXgn+YC2tyqeWqcUsaRsug+lwwr0+IXvHqDmDBXhtV1FfcMb+f64M6yX8LliWhYkmiIMY
 6/K5DmDqCfdPooqYbRXGukI33tCsdBo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-FMnXyI7PNqG669cI3zbwag-1; Tue, 08 Sep 2020 03:57:38 -0400
X-MC-Unique: FMnXyI7PNqG669cI3zbwag-1
Received: by mail-ed1-f69.google.com with SMTP id x14so1955724edv.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 00:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hjajqtvEuISTBRgRpPMUCH8ji6lbeHsCmX5hSQj+D2Q=;
 b=H12/ba+W59sQF3m7KEIQAKpdw+rcrZwvPZH9SwFQJCHBy0Wy+cDYnwSOzIy2qkqJ0S
 ayGEKANd8RqatfKKP6JRNdMLa544V0u/aAXLBfJZMwccS5UbN49BXxmYnQpBC6INELs6
 dY5vSWoUFW1J+/hyS71IWnGD4eUjmaT9iGAP2Y0TyOuhPgECzytgAVyV0GhOKvQ0nuIj
 FB20lNNMWrpeK8GW5WSBMlGhNPDWF1imHsm2plzhZZbvXt3sZyyzfMmWhEQ3ZppmfzuJ
 La0MsvcljpdcmyY/m6z+9WpGepsFzNJvtjHizt+CftFz+W/1ucCmnTkX+MeeJtK+gvg4
 8Bvw==
X-Gm-Message-State: AOAM533PivkKVhwt6hBvpokmBM/DIc2/+OUIRy7OJ1sKOlUpntmR3tAX
 jPvCxS/J2z8iR2mG8CJWbTsocoDFxrHxyqZAHG816/SlkodsSxAqT3FsEFm1yftg1/WZr26BsQQ
 QnoBSvKpuzCrowMn+0M4Jlq29BggVHkmqQA27kQwd6w==
X-Received: by 2002:a17:906:4cc6:: with SMTP id
 q6mr17306530ejt.201.1599551857520; 
 Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpDLRo1CVGFPV8s2mB7FGn6jr+cgUVgJN/ozC0WS4OAeawUnu+/98JbXILSr3J/Bhzu7egLw==
X-Received: by 2002:a17:906:4cc6:: with SMTP id
 q6mr17306516ejt.201.1599551857341; 
 Tue, 08 Sep 2020 00:57:37 -0700 (PDT)
Received: from redhat.com ([147.161.9.118])
 by smtp.gmail.com with ESMTPSA id e4sm16024501edk.38.2020.09.08.00.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 00:57:36 -0700 (PDT)
Date: Tue, 8 Sep 2020 03:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908035506-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200908003951.233e47f3.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>, thomas.lendacky@amd.com,
 cohuck@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com,
 kvm@vger.kernel.org, hca@linux.ibm.com, david@gibson.dropbear.id.au
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

On Tue, Sep 08, 2020 at 12:39:51AM +0200, Halil Pasic wrote:
> On Mon,  7 Sep 2020 11:39:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> 
> Michael, is this going in via your tree?

I guess so. Still not really happy about second-guessing
the hypervisor, but this got acks from others
so maybe I'm wrong in this instance. Won't be the first time.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
