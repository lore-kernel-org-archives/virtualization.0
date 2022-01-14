Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6E2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 08:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09182400A9;
	Fri, 14 Jan 2022 08:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDJipcw7tFn8; Fri, 14 Jan 2022 08:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D87D40275;
	Fri, 14 Jan 2022 08:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC347C002F;
	Fri, 14 Jan 2022 08:02:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0927C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9DD940275
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4P8cWAmjCcKr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:02:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC021400A9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642147331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klb0nnUjuvobPotelSx3DfHypMSRSFWqMkVcwCb1ESI=;
 b=PoqYoQXlFIWys5suqyfWfH3zPzUoXWBWJbZr9p/XNjHoBcBJurpp5fjcWfArv2QeuLQDkm
 YbhxT6vuLL6hoCCHgEtsxdG6sHEMgAVLI3IvYQaypGsXu8g1TKK+Pa45Dtlx6Q3JS9Lrq+
 T3xHCO8BB7SfiFova3Tjmo0OYgdGskk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-zCJV3zIZN2OEbcy9CMIEPQ-1; Fri, 14 Jan 2022 03:02:10 -0500
X-MC-Unique: zCJV3zIZN2OEbcy9CMIEPQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 q16-20020adfbb90000000b001a4838099baso1542591wrg.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 00:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=klb0nnUjuvobPotelSx3DfHypMSRSFWqMkVcwCb1ESI=;
 b=1BKAXLvNWXcjrzrWIyK6uDXnS9wGhnoGMiJFJHaFtBaQpmsM1KLVyMG4z5SCnQhJrD
 0dRgdCb6dK/0G2iWk40iYqRgY8GDLqMO4nAZrVp0rjb0i/wlD3CAHDN3U4k0RdnS9fDq
 NC4SK34PCJvioOG4060Sov1OJjT7IKCYRhHGrAUH9XsJ2YLbKEr15V9eLSbqn0baIQV9
 B3VBPcwESZ0TPCeQeCDL+YsINY9HhLMlBfAUxwFSAkUOXtdL3NAXS2hKt7ZoEyOlpfW0
 Uc+tJ543yGKg4omYyiOSTq9frpsI8hdJtVjFwxT99IDoeclyP1izfo+aXWN/W/fxh2Gd
 imcw==
X-Gm-Message-State: AOAM533PXVa5vVpsODdKAA8j/87UvYEJKF59ENMi4Ze/NzDB8Sw5gx29
 0W5/PkYPcebNjJa2JKoCt6F29F+8CEAPEEVDuaZEfqr751w++pSHAf8/fUyBXoygxndZk11jjlz
 V1/XZF5kAH+SwElf43LaLdCW42IVfzLfX0Ajn097smw==
X-Received: by 2002:a05:6000:188d:: with SMTP id
 a13mr7447582wri.297.1642147329115; 
 Fri, 14 Jan 2022 00:02:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjqJT5sGU0ZJyw8nvYxiwmgy2EIiuoaOLJLNLYx14PQLad/rO2oCWq7DkWPydBZBlnn2TR1Q==
X-Received: by 2002:a05:6000:188d:: with SMTP id
 a13mr7447566wri.297.1642147328909; 
 Fri, 14 Jan 2022 00:02:08 -0800 (PST)
Received: from steredhat (host-95-238-125-214.retail.telecomitalia.it.
 [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id o12sm5576911wrc.69.2022.01.14.00.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 00:02:08 -0800 (PST)
Date: Fri, 14 Jan 2022 09:02:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114080205.ls4txgj7qbqmc3q5@steredhat>
References: <20220113145642.205388-1-sgarzare@redhat.com>
 <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 14, 2022 at 02:18:01PM +0800, Jason Wang wrote:
>On Thu, Jan 13, 2022 at 10:57 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime. In this case, the device would go to re-read avail
>> index to access the descriptor.
>>
>> As we already do in other place, we can cache the value in `avail_idx`
>> and compare it with `last_avail_idx` to check if there are new
>> buffers available.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Patch looks fine but I guess we won't get performance improvement
>since it doesn't save any userspace/VM memory access?

It should save the memory access when vhost_enable_notify() find 
something new in the VQ, so in this path:

     vhost_enable_notify() <- VM memory access for avail index
       == true

     vhost_disable_notify()
     ...

     vhost_get_vq_desc()   <- VM memory access for avail index
                              with the patch applied, this access is 
                              avoided since avail index is cached

In any case, I don't expect this to be a very common path, indeed we
usually use unlikely() for this path:

     if (unlikely(vhost_enable_notify(dev, vq))) {
         vhost_disable_notify(dev, vq);
         continue;
     }

So I don't expect a significant performance increase.

v1 coming with a better commit description.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
