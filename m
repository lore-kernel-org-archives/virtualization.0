Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB96C4167B
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 09:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E66760ABB;
	Wed, 21 Dec 2022 09:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E66760ABB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVCm66i1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exeEcNZX7FNk; Wed, 21 Dec 2022 09:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE62D60017;
	Wed, 21 Dec 2022 09:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE62D60017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85CF2C008F;
	Wed, 21 Dec 2022 09:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F4BCC008E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 795F481EBD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:50:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 795F481EBD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVCm66i1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rf3YoBEVocSv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:50:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C031181EB0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C031181EB0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671616208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTgcQrziW5VujETu8NLZFtI7hg34vFn/f7FoknZcMU4=;
 b=hVCm66i1Ymqkh9+YjjJtnaIsbiJjUblOhuOYS+vJwyR1fm+ZScsx5Q3OnjCF6oRcBsf4yt
 BRR+Is1F3gX/0JqWxKH/mYi5d+xmKr9LrsTCFOma8KG9KWMgIBHjP4TEXCuBVRk4xmctwo
 lop6Br7yjljehwfeZv/TKTVohTFS3Ko=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-OiQ8jNA9Ovap0n7IorrJFQ-1; Wed, 21 Dec 2022 04:50:07 -0500
X-MC-Unique: OiQ8jNA9Ovap0n7IorrJFQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 z16-20020ac84550000000b003a807d816b2so6690370qtn.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 01:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTgcQrziW5VujETu8NLZFtI7hg34vFn/f7FoknZcMU4=;
 b=3qzy95+ratUsfSgokZTvH6PUXOenQYg7rOkLBVOewywj31SSyNxHfEnoIOuYqURMkp
 w8+q/f+HRotUWGQuYmHaQ10MXA//i+D0TdC5KtwkPF/ygpN70vXVFnwa5jfKCqaJWX8k
 aJzycra5Foy7wXIo6LfyIlHyTjFBxbKbVnq+0R+bm/nEydJF1lyatknu9nvtkBBr2aJT
 EXWaTo/tl+gn/yhC5ENnqoOTGNKufITvERGO1x1ispSramwzeFbXAF5cNoc5pWYioPEb
 UVtiLHy3cEO7UEV5w5x2YTiCoJ+F/IZ/Umj+1OWnqMRt5+TKCSbrKgLiR4Pb5mevLNvy
 Wl1w==
X-Gm-Message-State: AFqh2kr/OwNVJA5ngz/Vs6/7Rpsyw3NzbqBcL10lRNc5EIh5MH14fR6z
 zj0jqZribQvwkAOXMzEZ80tn2mhVoF1coMge+fGmJW8LutnLT5qG36o/EH+bec12nN8GxIZSaNc
 2qfspoHydj8SQKblWO2Sqih+EFxTh0c5bt6kuBtvoEg==
X-Received: by 2002:a05:6214:2d10:b0:513:520c:9180 with SMTP id
 mz16-20020a0562142d1000b00513520c9180mr1493844qvb.38.1671616206932; 
 Wed, 21 Dec 2022 01:50:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsqOkaJ1D2A6Dv07PmI1nhJvRa8UOdEQEYu1jCnu3iSlOtZ1p/WiOSE2yBkC7QN8kWGuOBveg==
X-Received: by 2002:a05:6214:2d10:b0:513:520c:9180 with SMTP id
 mz16-20020a0562142d1000b00513520c9180mr1493823qvb.38.1671616206640; 
 Wed, 21 Dec 2022 01:50:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 br12-20020a05620a460c00b006faf76e7c9asm10558965qkb.115.2022.12.21.01.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 01:50:06 -0800 (PST)
Date: Wed, 21 Dec 2022 10:50:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 6/6] vdpa_sim: add support for user VA
Message-ID: <20221221095000.m7bx26dohemrjql2@sgarzare-redhat>
References: <20221214163025.103075-1-sgarzare@redhat.com>
 <20221214163025.103075-7-sgarzare@redhat.com>
 <CAJaqyWdwa5P6hXJ5Ovup+Uz3293Asr10CLvi4JVQZqDL-M1p1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdwa5P6hXJ5Ovup+Uz3293Asr10CLvi4JVQZqDL-M1p1A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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

On Wed, Dec 21, 2022 at 08:17:41AM +0100, Eugenio Perez Martin wrote:
>On Wed, Dec 14, 2022 at 5:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> The new "use_va" module parameter (default: false) is used in
>
>Why not true by default? I'd say it makes more sense for the simulator
>to use va mode and only use pa for testing it.

Yep, you are right. I'll change it in the version.
I initially left it at false because we usually use the simulator to 
test the paths that would be used for the real hardware.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
