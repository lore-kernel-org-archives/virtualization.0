Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C2CC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 01:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DC07401A3;
	Thu,  9 Dec 2021 01:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTdAD-lN6Xbc; Thu,  9 Dec 2021 01:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 36FA7401B1;
	Thu,  9 Dec 2021 01:33:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BEC0C002F;
	Thu,  9 Dec 2021 01:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 659B1C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D28F401B1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nrf7FR6hi_cU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76E1F401A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639013590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/au0VW0wAExMZ4vn/Bx8IxSlAKlCAT2/4s6CN6RIj4A=;
 b=fvtNk+MXIl6Xm94KKp2Fo18b4eGIw/uWVrAuIuq9as4r+R5gK5x9ZYvElN5E8swAuppVYd
 S/A4rNozE71wtHcFU+p//GdPKHeT8mmulcWIeMqWqk5msJsuQ5DLup7BknN4EpyFoZvwga
 R2gs1KhHK5LyPvMLpYPnkjbX+TWauB4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-w-yee11AODGzmspNgDfIow-1; Wed, 08 Dec 2021 20:33:09 -0500
X-MC-Unique: w-yee11AODGzmspNgDfIow-1
Received: by mail-lj1-f197.google.com with SMTP id
 83-20020a2e0556000000b00218db3260bdso1242630ljf.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 17:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/au0VW0wAExMZ4vn/Bx8IxSlAKlCAT2/4s6CN6RIj4A=;
 b=oRNyCNWx8LIvQZu4mAVcCOIPxD9C7nDmE1mFXE2sTIdktY1ymI/kycdz1v91NXd+ym
 hAtWMF+jVHD5hwQrohACOJLHgw0X6IBmvNTsoba863VbEPirpXsDUpYxKLsPE9ofa3ps
 Ymi5ktx9IzfPvPQa89sckT5fySqB9cE7FWhX5bXtGE5rpUdg3I3xVENwO+SpAtKrGvMQ
 N/bEt3irC3SolTP8Kjg9dR7qy8oiAFGZYQDw2k4UhZ8AdysBFvXgnwOXHAHVQ2uRX+hA
 N/ggOfHhvV+CFj0BIAlMMS/hZ3eyzl9sQQDQI6o4ffTojMO7cU4SyAuNkqYYZRyHw+Fx
 V9PQ==
X-Gm-Message-State: AOAM533iM4zYiB7GTlDxgTsiOsLO54OdJLZAvxmTuCJkeBISSu7KevYZ
 yY2Xa4D/vHewZEEUMVNVRaT58j4zvbBMqjgj55oKfm/2ZOBzcOUe3BFk46iV6tAFAXwVK0LDNc8
 lnX+oH6b+jmWvLBkMrtxmLluDA8jM3G/6LMXiSswLkXF/emPJS5dy/LtJhA==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3099113ljk.420.1639013588039; 
 Wed, 08 Dec 2021 17:33:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9TIw97IDz1kTMGFm4/WfgNr13bxFC2QWir9Lu5dBhoF7DJZIPEMJbCSwnNHaVGu6he9vtyKqqUpoOUjTDKro=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr3099088ljk.420.1639013587840; 
 Wed, 08 Dec 2021 17:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-2-michael.christie@oracle.com>
 <CACGkMEskNm079dzOaxNOFA6_K4r-9=hAs8VXcxqi4SKDKtozsQ@mail.gmail.com>
 <6726418f-c9ae-04ba-eae4-0f36f048dff5@oracle.com>
In-Reply-To: <6726418f-c9ae-04ba-eae4-0f36f048dff5@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 09:32:56 +0800
Message-ID: <CACGkMEucoBD5XsP8Yrp=SeZA9QsyJa0FJ62k+7Ph7Zmpu1RgRw@mail.gmail.com>
Subject: Re: [PATCH 1/7] vhost: get rid of vhost_poll_flush() wrapper
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On Thu, Dec 9, 2021 at 12:41 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 12/7/21 9:49 PM, Jason Wang wrote:
> > On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
> >> It gives wrong impression that we are doing some work over vhost_poll,
> >> while in fact it flushes vhost_poll->dev.
> >
> > This "problem" is a byproduct of 7235acdb1144 ("vhost: simplify work flushing").
> >
> > Before that we indeed have per poll flush flush.
> >
> >> It only complicate understanding of the code and leads to mistakes
> >> like flushing the same vhost_dev several times in a row.
> >>
> >> Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.
> >
> > Not a native speaker but since we don't have an per work flush, is it
> > better to rename this simply as vhost_flush()?
> >
>
> What about vhost_dev_flush?
>
> For the existing naming when we have a function exported we tend to have
> "vhost_" then the object/struct it works on then the action.
>
> For work we have:
>
> vhost_work_queue/init
>
> (we also have vhost_has_work which doesn't follow that pattern but
> would sound strange as vhost_work_has so ignore that one).
>
> For dev operations we have:
>
> vhost_dev_reset_owner/set_owner/has_owner/cleanup/init
>
> For the flush operation I wanted it to reflect it flushed all work
> on the device, so I mashed up the work and dev naming above and
> I agree it's a little strange.

It looks fine to me.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
