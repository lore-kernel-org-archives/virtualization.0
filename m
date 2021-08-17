Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1884EC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 09:32:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B7360F35
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 09:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99B7360F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5522260803;
	Tue, 17 Aug 2021 09:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTzX3Yih_mDi; Tue, 17 Aug 2021 09:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 415AD60035;
	Tue, 17 Aug 2021 09:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01FB4C001A;
	Tue, 17 Aug 2021 09:32:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71985C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 09:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 691C360755
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 09:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHXc30PYyE6d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 09:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4D1C60035
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629192739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tXO0rYgdhyeDYBKbOyKfCbfOOPtHG4G1MWXLBg7l68E=;
 b=PzlrqY4BzM/4Y0tHhazPr+/iXxOpEJQo9VUvoxJerkMnUZ6le8fCfz7CE1IZdCNmIcadl2
 P/V/+hGYh+hWxv2sPI9J7+Zo85xyEcZV65qfvVwaXh6woHL+rINVlRWkz87cP5v6Q+BXu2
 5N+eYNZGDyTMWqyKGPFl6Zlo8oCmjAY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-MW_iBpfSM2Sg9x3VqLxf3Q-1; Tue, 17 Aug 2021 05:32:18 -0400
X-MC-Unique: MW_iBpfSM2Sg9x3VqLxf3Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 e12-20020a05600c218cb02902e6bbacdcd1so658089wme.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 02:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tXO0rYgdhyeDYBKbOyKfCbfOOPtHG4G1MWXLBg7l68E=;
 b=R9ZeLYYNM+/j0sk3CslBdJeax8X9YKNTw5ObL/HojyV+WL6D13yDzpHAWty3hUDeYc
 h64OzylOi4TaR5u3McDh2X3GaWnehRVa6wLAV8sWf7qSj01lPJBMi87aPFUJ/wCS5RXv
 5EtTO5YU49VSqRxmz5hvhKakU76ecQjYVXHNKWpPLSnJz1uRCASvUg0i3CUiypA7cyZy
 xUVGoFDGPsXaztJtLRVoFlGGfupflxCizxUXupsQA6Y8DPUcj9iTVpssmk6AjVi/JUbk
 nuzt+hImDISTScxyO7ZSimGRC8M+w4R2iQ4JrfJe/xJiQytolQIKa2RjDouj+PY/ImLJ
 gLfA==
X-Gm-Message-State: AOAM533g+yBbHozWOVFukvfA5e14Rfa3LBq0U86Vb4gx+EngtfoukvHt
 lV69x45033cKbcn0IVut1ptYpX9rxYy08R3sHVeltqPCL/szghz4IJlvn64YBim1Jl5daCtV5a0
 2kLZY8R3OPczfAPkHsYhx9NJNbcDY3dKHcxGpG5iObg==
X-Received: by 2002:a1c:1f17:: with SMTP id f23mr2445346wmf.136.1629192737019; 
 Tue, 17 Aug 2021 02:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZebtc9nXfqDyMD/ZWMOGBaaLkmeU7uLr7GiJexUrvciVWIfZqrerPJXKpkvUSOmHuGSxz7w==
X-Received: by 2002:a1c:1f17:: with SMTP id f23mr2445334wmf.136.1629192736834; 
 Tue, 17 Aug 2021 02:32:16 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net.
 [82.29.237.198])
 by smtp.gmail.com with ESMTPSA id e25sm2097816wra.90.2021.08.17.02.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 02:32:16 -0700 (PDT)
Date: Tue, 17 Aug 2021 10:32:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRuCHvhICtTzMK04@work-vm>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
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
> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > This patchset adds support of per-file DAX for virtiofs, which is
> > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Can you please explain the background of this change in detail?
> 
> Why would an admin want to enable DAX for a particular virtiofs file
> and not for others?

Where we're contending on virtiofs dax cache size it makes a lot of
sense; it's quite expensive for us to map something into the cache
(especially if we push something else out), so selectively DAXing files
that are expected to be hot could help reduce cache churn.

Dave

> Thanks,
> Miklos
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
