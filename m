Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F1E82CDF
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 21:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DB2661491;
	Wed, 27 Sep 2023 21:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DB2661491
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R8X0taxH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AkLeqyFckV3Q; Wed, 27 Sep 2023 21:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5378610A2;
	Wed, 27 Sep 2023 21:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5378610A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAF71C0071;
	Wed, 27 Sep 2023 21:30:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10B58C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D11B541730
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D11B541730
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R8X0taxH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8G8pX3PyxaIM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:30:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 696DD416CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 21:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 696DD416CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695850211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E/hWvDm1OcTrG/VO8KCVt4P4CK7b9Zrkcj60yfAmxHA=;
 b=R8X0taxH6sI8I3XqU14dZ4YMiMgOaByy5exxU9DKQzTLBw/xdvqpyMoEBQLYWMgz68K3c+
 Gs25f0of3ECmNy7ah6DsBI6vMta4cDIL/bsvGcR/pnKSRrQVbfAYhE/h8PUG5ey3Oyp7sY
 DvaTdyqNrxWiBxC8+sQ7k72qiZ+1Zj4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-3gTqGow3P7yEb-uOqqmyaw-1; Wed, 27 Sep 2023 17:30:09 -0400
X-MC-Unique: 3gTqGow3P7yEb-uOqqmyaw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so103588255e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 14:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695850209; x=1696455009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/hWvDm1OcTrG/VO8KCVt4P4CK7b9Zrkcj60yfAmxHA=;
 b=oBzrliJ9hoCR54GQ8CYu0Ah7nOoGRofh80hG5JSqm56E/IC1V1agg2OeZGfgR9vQ7p
 74WKkEM5jMeuKxT5VypF4ypk7eHwCDJkjAvZic+Y8ptY1o9g5lpPY3BPzJnyRubm1h36
 di3RsWnrPDLmIG93g3dWjrDnTJuUKyisB8dJ9FDwUozMO0TVy9tH9dBYTaz+cgacA7pj
 mR9x31OsXmz6+li8dGFsom7g/hLZX6ieF86zKNkA5Qw2dTJddnCDa+Xq8WbZEBjwxsgX
 uLImBGdPndwSQpg1Ams9rMsXUwHF0HtcKat82regBGg9hIwYBqtpY2R/0htyOVEBg+fd
 qE/Q==
X-Gm-Message-State: AOJu0YyeXpSe3vjbz5vyi821pAddExJBWEf0KGdvRKRpPJaKH/1lJ4iZ
 eD2rYCz8A0yhxbL5DlAmj/RZjzp86OqcQS2RtxCqZ7RjebEJ3RxIKb0ojdD2by4P7b9+8OT86gf
 w2k7QT3PlAm6A3IXeJooz/v+4CYrLHKIJilXZAoHJDA==
X-Received: by 2002:a1c:7c17:0:b0:401:c0ef:c287 with SMTP id
 x23-20020a1c7c17000000b00401c0efc287mr2914646wmc.27.1695850208876; 
 Wed, 27 Sep 2023 14:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEemzT3gLlpHYsXzcHz13K1oDD8XGSyUvzYYkawuzvrxg1U8rZ9W15Au84bTbbiacNpiQ4/Rw==
X-Received: by 2002:a1c:7c17:0:b0:401:c0ef:c287 with SMTP id
 x23-20020a1c7c17000000b00401c0efc287mr2914632wmc.27.1695850208496; 
 Wed, 27 Sep 2023 14:30:08 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 p10-20020a5d59aa000000b00323287186aasm9084532wrr.32.2023.09.27.14.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 14:30:07 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:30:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230927172806-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
 <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <20230927131817.GA338226@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230927131817.GA338226@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Wed, Sep 27, 2023 at 10:18:17AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 26, 2023 at 07:41:44AM -0400, Michael S. Tsirkin wrote:
> 
> > > By the way, this follows what was done already between vfio/mlx5 to
> > > mlx5_core modules where mlx5_core exposes generic APIs to execute a command
> > > and to get the a PF from a given mlx5 VF.
> > 
> > This is up to mlx5 maintainers. In particular they only need to worry
> > that their patches work with specific hardware which they likely have.
> > virtio has to work with multiple vendors - hardware and software -
> > and exposing a low level API that I can't test on my laptop
> > is not at all my ideal.
> 
> mlx5 has a reasonable API from the lower level that allows the vfio
> driver to safely issue commands. The API provides all the safety and
> locking you have been questioning here.
> 
> Then the vfio driver can form the commands directly and in the way it
> needs. This avoids spewing code into the core modules that is only
> used by vfio - which has been a key design consideration for our
> driver layering.
> 
> I suggest following the same design here as it has been well proven.
> Provide a solid API to operate the admin queue and let VFIO use
> it. One of the main purposes of the admin queue is to deliver commands
> on behalf of the VF driver, so this is a logical and reasonable place
> to put an API.

Not the way virtio is designed now. I guess mlx5 is designed in
a way that makes it safe.

> > > This way, we can enable further commands to be added/extended
> > > easily/cleanly.
> > 
> > Something for vfio maintainer to consider in case it was
> > assumed that it's just this one weird thing
> > but otherwise it's all generic vfio. It's not going to stop there,
> > will it? The duplication of functionality with vdpa will continue :(
> 
> VFIO live migration is expected to come as well once OASIS completes
> its work.

Exactly. Is there doubt vdpa will want to support live migration?
Put this code in a library please.

> Parav, are there other things?
> 
> Jason

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
