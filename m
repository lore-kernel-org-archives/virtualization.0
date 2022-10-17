Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B929C433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 06:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEF9282446;
	Mon, 17 Oct 2022 06:10:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEF9282446
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g792YOxN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJgBkFPC5pzr; Mon, 17 Oct 2022 06:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A68282410;
	Mon, 17 Oct 2022 06:10:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A68282410
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1FEC0033;
	Mon, 17 Oct 2022 06:10:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71F16C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 06:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3831460E5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 06:10:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3831460E5F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g792YOxN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3WQZTKvB9AU7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 06:10:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7BEA60BF0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7BEA60BF0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 06:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665986999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v20PsHQp4Qr88/YGRnhqDCcY6Y/q2BfOq83xhjsjfWE=;
 b=g792YOxNNELLHGMCvgHen3fZ+AAnmOaglvU1UfKi4SO90tifa7JEnG4yDSlpYdmcGLABrW
 dn6mYSZW2fOm8sgAjXBi/efFPP3eabFe2iay/uXI1S06N3GEYQLjHxorORNb0o63NnDeVS
 AJH6Z41dc8/5cfpGtGOqlri1VdD0DRA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-Y2F_S-AbOJSYl13z68XgoQ-1; Mon, 17 Oct 2022 02:09:57 -0400
X-MC-Unique: Y2F_S-AbOJSYl13z68XgoQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 v10-20020a4a860a000000b00480b3e2b5afso2777799ooh.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Oct 2022 23:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v20PsHQp4Qr88/YGRnhqDCcY6Y/q2BfOq83xhjsjfWE=;
 b=rWEe3tGUa/PSVT8ARTJ0eTSx0Vkqwph54LaECL6olkUObVAFW5DxLbRZBz/zFdaqpX
 6Q0KMIzGYLGNTnimFhc3UMa3ITiKnRlIRhguHYbDFIHtbklVTCEq9BPgiBj2+SGVjGC5
 2nPUfVkbDRbq8bcximiEbsul4XcE7vpEOjf/5usUEuvPhPXPv58Samxo56OijivOdChZ
 y54kA76L2iDEB8iBMmcuKgUYyfkkzI6Qyy9LvJ9PZnEqhOM9H5ZHxeKzK+nj5b7wzzsl
 BXTNvJw5rC66aGOyJMpVsS8YiPamip49rCLEfqSWGq+C2Z/ZRP7HxVo9wOJ1IP43XO6Z
 rBqQ==
X-Gm-Message-State: ACrzQf1LiXzfCFXcchInX4QRL4GLUiM26v/n9gis3c+RC+YIlTfQuoy5
 +rpchcxf4bWZIgroOyK/1ph4wHP9UaWM5YGLEgKMjKkrnI1S3BlpBuePmZPlZc2k4sKh496s1lA
 EwAAYw5IXUCxJ4Sanj/vwkLHD8cKNhy8lGXwk1kQTcsB5CaKkPKLOdVyrmA==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14165210oad.35.1665986997316; 
 Sun, 16 Oct 2022 23:09:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41XKqiAwqq1+LJqy0pjBH7CDaaGUaBJECgFukJbjvEBs+g6HV7XQp1KrgniibZS6klAviHK6cZxtQfuDC2mw8=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14165187oad.35.1665986997103; Sun, 16
 Oct 2022 23:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221014042037.23639-1-jasowang@redhat.com>
 <87o7ueh5bd.fsf@meer.lwn.net>
In-Reply-To: <87o7ueh5bd.fsf@meer.lwn.net>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 14:09:45 +0800
Message-ID: <CACGkMEuMX2b6pQwaKMQy+OEFoB7BLs0BmxqORYeP-D7oo5irmA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
To: Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: otubo@redhat.com, cohuck@redhat.com, liuwe@microsoft.com,
 linux-doc@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 mikelley@microsoft.com, andavis@redhat.com, stefanha@redhat.com,
 kkashanjat@microsoft.com, virtualization@lists.linux-foundation.org
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

On Fri, Oct 14, 2022 at 10:02 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Jason Wang <jasowang@redhat.com> writes:
>
> > This patch summarizes the status of hardening and TODO of hardening
> > virtio core and drivers.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
> >  MAINTAINERS                            |  1 +
> >  2 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/security/virtio/core.rst
>
> Do you really need to create a new directory for a single file?
>

Not sure, but I think we can start without a dedicated directory.

> Regardless of where it sits, you'll need to add this file to an
> index.rst file so that it becomes part of the docs build.

Yes, I will fix it.

Thanks

>
> Thanks,
>
> jon
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
