Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFACC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 10:37:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A597D604AC
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 10:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A597D604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 714ED40368;
	Tue, 17 Aug 2021 10:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iw87te75cgv2; Tue, 17 Aug 2021 10:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F351401CE;
	Tue, 17 Aug 2021 10:37:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0AC5C001A;
	Tue, 17 Aug 2021 10:37:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A193FC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D505401CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ytSNuOf-K6ps
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:37:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89D12400E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629196648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ylAqgdbrJZr9xkOSrjkKyy1IPEuT4QXdJGcAzYJ78VY=;
 b=igsu1UmpNTW0nrWwKeO/271xyHuhOOwFRNAdZpecIHCkb5LiaDUKEGeTGwray4y9VInJHy
 bn8cnPVw3qdM3SwYb3u0PL3+8gVoY/xHoOTocPPu6rJQUtx6BCIDidPIhHWabYW8tQ/RX8
 1EqTUaW4p7d0GN+UdPtIvcrbn5Guw3k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-cSS4PGC6OyWRsNenUV9ZLw-1; Tue, 17 Aug 2021 06:37:25 -0400
X-MC-Unique: cSS4PGC6OyWRsNenUV9ZLw-1
Received: by mail-wm1-f69.google.com with SMTP id
 z15-20020a7bc7cf0000b02902e6a68ffd3cso694996wmk.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 03:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ylAqgdbrJZr9xkOSrjkKyy1IPEuT4QXdJGcAzYJ78VY=;
 b=PibvNsemo1QUGO64YxMxWFzsHUo20KZPkL1CSrr0fFXBYebDJ0pd8v9QH3pill7xCa
 iALGZyhMeqZP27d0KW19sjpSi2zoFjvgOJJSOcTqxfAq6orCvt+JgW6Lzji+u7TeVVbe
 FsWSvBns0TRhJ3UR6XbdAHjg/OwmL4bhoW0we1Z5agm0kdu805hMo7m6mBZiNRdpD4CL
 HTWDpmHuHM+eIrKK9+t3WqsL5c5bSbZvRw6UXVPszyX/y0sktM4q0AEZNLIRSjG59bLq
 d9K75E6S96jnBJhcv2G2DPYEJvx1pgJUXantHaPz4O6sqPx5Ob0VcKdi9eRKE1R40lD9
 salw==
X-Gm-Message-State: AOAM532Gh5Kzw86A6j8zVSkw+JP24ieCTLOcMMLttSnB3Lz3aWPgFBoC
 tXuAQ2SNSk6aUO+kKT0CgJ1879FUMLrEjQZDJqC7klu9FZnMcGWH79/82VvXw+t6QV+EwavuD5u
 uK7EWFYyJAOw/h+NpGFjN2GrPvW/FtwfsKEATV6FF/w==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr3194592wrq.349.1629196643850; 
 Tue, 17 Aug 2021 03:37:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIw4MIhbeuweeJtzdTPOXRFRTTdHSmvBxHZb0P4/fi6Kf+/mQJrX0KPtKDSsy4idKQTTiLcg==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr3194578wrq.349.1629196643725; 
 Tue, 17 Aug 2021 03:37:23 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id p14sm2022341wro.3.2021.08.17.03.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 03:37:22 -0700 (PDT)
Date: Tue, 17 Aug 2021 11:37:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRuRYJ2+hOa704sS@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

* Miklos Szeredi (miklos@szeredi.hu) wrote:
> On Tue, 17 Aug 2021 at 11:32, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Miklos Szeredi (miklos@szeredi.hu) wrote:
> > > On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> > > >
> > > > This patchset adds support of per-file DAX for virtiofs, which is
> > > > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> > >
> > > Can you please explain the background of this change in detail?
> > >
> > > Why would an admin want to enable DAX for a particular virtiofs file
> > > and not for others?
> >
> > Where we're contending on virtiofs dax cache size it makes a lot of
> > sense; it's quite expensive for us to map something into the cache
> > (especially if we push something else out), so selectively DAXing files
> > that are expected to be hot could help reduce cache churn.
> 
> If this is a performance issue, it should be fixed in a way that
> doesn't require hand tuning like you suggest, I think.

I'd agree that would be nice; however:
  a) It looks like other filesystems already gave something admin
selectable
  b) Trying to write clever heuristics is only going to work in some
cases; being able to say 'DAX this directory' might work better in
practice.

> I'm not sure what the  ext4/xfs case for per-file DAX is.  Maybe that
> can help understand the virtiofs case as well.

Yep, I don't understand the case with real nvdimm hardware.

Dave

> Thanks,
> Miklos
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
