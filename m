Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E52C433FE
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 02:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3B8A40580;
	Mon, 24 Oct 2022 02:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3B8A40580
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7/zlFHR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hk_9JbtdJnBi; Mon, 24 Oct 2022 02:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBCA34054E;
	Mon, 24 Oct 2022 02:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBCA34054E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C01A8C0033;
	Mon, 24 Oct 2022 02:01:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34074C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06A04403A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:01:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06A04403A4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A7/zlFHR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OflUs6PsurpD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:01:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19F5F40127
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19F5F40127
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666576892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6wdvQ6duZTbfBMv6HUfxf5GdSznVSWkhVMKCWk6H8Q=;
 b=A7/zlFHR9fgW0Rp8hdHtNn10+wci0T4WRrde7fwBTBmlzbyVjpt+BzkGT7/7qctCDQoz9S
 ctXqwGqSS4TxV/A7rmnlYgjS4abGkWaLDuJCVa/zH8YffmRk8eolvmxGjxMi9BEZGQ1Utj
 3eJ/H4H+tL1ysRnzUdnSX/u01xvXoWY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-teWaio8POQiW6UaACv5zqA-1; Sun, 23 Oct 2022 22:01:31 -0400
X-MC-Unique: teWaio8POQiW6UaACv5zqA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13aeef5b55aso4714627fac.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Oct 2022 19:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d6wdvQ6duZTbfBMv6HUfxf5GdSznVSWkhVMKCWk6H8Q=;
 b=FA+ww+wpoVkCcQ0TzExPkyI/y/oshJGSwQUJlCk2ur2QXKYqpP6KSZGFW5qoYxDgNy
 Lv+eegsGpBeMZF8a/Kbr1L4GJPe1QxnfMzn2Jf89bmys4p1o5fLB/rDP9i0vO5GrV+I6
 BfLVC9FeCfnHvM8vmI1Nnea5mIyHCJbx1OXu+quobS8WhZpLlLeYtL39Xm93tPHJgC0Z
 cPJT927ogEqa+KBiIpcR/3GzNEsnSJPYRGhy/477sNqWoqsdGEWcvHfAnJigY3J+LLek
 37+k9u3pjqCDkQOpLknGD4cfXjLZjVdpudFUZuSqyLlNNNBYqmZUqwPZ5XlCSDlgUScU
 vXPQ==
X-Gm-Message-State: ACrzQf2hxgN2VhZVg4VjVoTLEM9fk9p6fkJ5M8feahtEmVhQ4Iayr8+p
 gcVuZDGWdZTV5I0jvcdr8dOErtUi7cGT+Y28bjaWwvn6KmSbaeOIp//LdJU97rDPIlkpbb9ZbFX
 8jJ+PgyEtcogoExTAdawOrVkBKPcIt+En3bh9DyN5FeqRy1F1V+Ejm9t1Rw==
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr13646649oop.93.1666576890659; 
 Sun, 23 Oct 2022 19:01:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68bvPmwcdaERMmLzDCe+QfAbwSfmdTvC7MR0CFQeGmzO3Qmm8e834LLnoo15fuG7dJcRzbqBgalK11K7R+Lgo=
X-Received: by 2002:a4a:c590:0:b0:480:5ecf:85f4 with SMTP id
 x16-20020a4ac590000000b004805ecf85f4mr13646642oop.93.1666576890463; Sun, 23
 Oct 2022 19:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Oct 2022 10:01:18 +0800
Message-ID: <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
Subject: Re: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Mon, Oct 24, 2022 at 9:56 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The get_vq_num_max of vdpa_config_ops is mean get the max size of vq,not
> the max number of vq,it is kind of confused,rename it.
> And get_vq_num_min rename to get_vq_size_min,
> set_vq_num rename to set_vq_size,
> rename implement of this ops also.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---

Not a native sparker. But num_max came from virtqueue structure:

/*
 ...
 * @num_max: the maximum number of elements supported by the device.
 ...
 */

struct virtqueue {
        ...
        unsigned int num_max;
        ...
};

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
