Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3CBC4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 13:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97091404EF;
	Thu, 29 Dec 2022 13:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97091404EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BbTRD2ot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJEa9sVh1kID; Thu, 29 Dec 2022 13:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F56540147;
	Thu, 29 Dec 2022 13:31:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F56540147
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00BA5C0033;
	Thu, 29 Dec 2022 13:31:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC6D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A390660D61
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:31:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A390660D61
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BbTRD2ot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-FCVw3XqAV9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7904460B55
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7904460B55
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672320693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1D/AekxKLpAcu+bYl7a0bmZjxWv5ZDkXjJgeYIo+ziA=;
 b=BbTRD2otKeksGpWt0cDOulkQEJAkETc88h7bwoN7gClcPhoek5yKoeNlyMB59Sow/opsNC
 LcjCPsv66LwOgASW5TARODlDJMH1Y4x32Dj77rx3YVLnWQ2AQK4nyvCG9/Ock3FQT/wQjp
 eBOzDfYLV0oOSXaEuZCf3l/Gwhc9QaM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-FIklEG7uMgqghcQNgRQqPg-1; Thu, 29 Dec 2022 08:31:32 -0500
X-MC-Unique: FIklEG7uMgqghcQNgRQqPg-1
Received: by mail-wm1-f70.google.com with SMTP id
 c66-20020a1c3545000000b003d355c13229so12668707wma.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 05:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1D/AekxKLpAcu+bYl7a0bmZjxWv5ZDkXjJgeYIo+ziA=;
 b=woE1NdCmBA49jSe1RegJF5011u+elBIrbtnmOUeLTUeq48ZoVc9yBiMU58r4jwcRh7
 kfofUKj+pKlHcdgMohV8AAUUhVPnr+M7V8NKSgKHM111AWNJMaS90WTuE9JDPJHUAgCK
 iSNdR9HyI/fkqkYOEjaBad3FePy8FJrbjEI62p4zbhShcv24nk9dzDg/ctJMY9cU0tCb
 IULA9rpqaLW6JDPEbQIe6TsX7glWom28s35h+KF/E1F71FsIg7HbLi0jbFKgqhIwOiIi
 7OqBNqUWinSsqQHZxD140QxQfwxQcz8C5VXjOsdLv8Yqav1320T03CRC2RSQDdL/1iV7
 9H0Q==
X-Gm-Message-State: AFqh2kpCIbxAdUsPK2AG9OHEr93XthDvwG54UMsCVhGjmTSJOZ2FIteL
 3He2H1XtVXBwrp9wgflNKvouigSrYf6TclXGEFxw6BljcqvxGvsarEK3WboYvi+wGF/l0dhjeIa
 GsCH5iOQOLpRrIiMn5nW/8Hyuu5HNuUWURhH/hikNaw==
X-Received: by 2002:adf:e409:0:b0:242:45e7:db17 with SMTP id
 g9-20020adfe409000000b0024245e7db17mr16250531wrm.66.1672320691718; 
 Thu, 29 Dec 2022 05:31:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWnvN6QyVN1zTOnSfNKEdIudugUP7fkbiKn5gbdcdRZxKN6fb0RQ8JfBa58bamIqgqaTnuhg==
X-Received: by 2002:adf:e409:0:b0:242:45e7:db17 with SMTP id
 g9-20020adfe409000000b0024245e7db17mr16250519wrm.66.1672320691497; 
 Thu, 29 Dec 2022 05:31:31 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 c17-20020adffb51000000b0027cb20605e3sm10757933wrs.105.2022.12.29.05.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Dec 2022 05:31:30 -0800 (PST)
Date: Thu, 29 Dec 2022 08:31:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221229082943-mutt-send-email-mst@kernel.org>
References: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
 <20221229030850-mutt-send-email-mst@kernel.org>
 <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_ApAnMTC0O81vO=hvRLssLYRnJsVUE5gd_aomCB+5eWLQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, Dec 29, 2022 at 02:08:34PM +0200, Alvaro Karsz wrote:
> > So due to my mistake this got pushed out to next linux release.
> > Sorry :(
> 
> No problem at all :)
> 
> > I'd like to use this opportunity to write a new better
> > interface that actually works with modern backends,
> > and add it to the virtio spec.
> >
> > Do you think you can take up this task?
> 
> Sure, I can do it.
> So, the idea is to:
> 
> * Drop this patch
> * Implement a new, more general virtio block feature for virtio spec
> * Add linux support for the new feature
> 
> right?

That's certainly an option.
Let's start with point 2, and get ack from people who objected to this
feature.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
