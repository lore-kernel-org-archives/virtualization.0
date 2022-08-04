Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B341C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 06:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 939A1403AA;
	Thu,  4 Aug 2022 06:43:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 939A1403AA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WV/eZ3bk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_xGcGVsFAWM; Thu,  4 Aug 2022 06:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21F27401A3;
	Thu,  4 Aug 2022 06:43:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21F27401A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 055B5C0033;
	Thu,  4 Aug 2022 06:43:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36914C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02A58410C3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:43:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02A58410C3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WV/eZ3bk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LGLXzdfipkEf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A72E410AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A72E410AB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659595427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=etE/HEljW3n9gi2kgJ+08I6r4hl++q+slAsHwKnymb0=;
 b=WV/eZ3bkLxPZc86yvFsnWNwsLjOeYPrOTEZPKrqQ4A0+PTljnVbGgN/R/xTk9+C8Y8MR50
 MBrL+9fSJ9aJTFzLFxnrBWU/wGaf2CXp/YtUt086R3vIN0wVSYMdGxHeOYGLz679mbZE0q
 MKvBtU9yZIWK5zr8D3gz5dOz3Oj/UMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-KZEB7sSkM5ep7p5OmooelQ-1; Thu, 04 Aug 2022 02:43:46 -0400
X-MC-Unique: KZEB7sSkM5ep7p5OmooelQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 h65-20020a1c2144000000b003a30cae106cso2200524wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 23:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=etE/HEljW3n9gi2kgJ+08I6r4hl++q+slAsHwKnymb0=;
 b=HuhnhNogHBxaoTIqY9ggYbpxt8hjX+taM7ky//qnUgtNe0J0aojaroAKNXDJ+gCcKR
 amMaKxYKWYgJAu3vJYvkbfKO/cXF1G+JntLz98as0ZbSOPIN1w5J/vzPrSBMOmd8CQj2
 IavUUpqcb3jobMKQkDimnBlBHm3+PhDJU9QJfdtgd0ESaGIHdj4FRex14ZeDTqecxRTo
 RiDc+xLN+BCtHtJX2SsKw0KO+SxojHDSaXJaapUnT/ZfZD5TTJjonH7MFQlN+zkt9tz0
 h8U1ISO8f9CuUbwRozBcd9ZSl/FVGgHhHsL7AH3cAVwCS3tVYHo/MCXYLAinpiCyZv3A
 scXA==
X-Gm-Message-State: ACgBeo3bLHbd2YKkXiRAwkXCJJ2pRHSl+T5294HVRnppsvjSYV8BH5gg
 XlvEN6MvR+zXRSb97rxXWfzjV1drCwUBrJTLQIKT6YCFwI4IKSEA+hYGZJKVW6NJu0Fa8593Xgn
 UyVYVAXtXYbWdF0wjB0+AIEhyOojOIeq4NgCbGi6TeQ==
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id
 l8-20020a05600002a800b0022068934ff6mr343252wry.170.1659595425189; 
 Wed, 03 Aug 2022 23:43:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6w2s61lEurzw/cepQN3/TpaVHJS92nikXz4ZMajLFYZSaoV7mZWQ+mvCDH8D9MqcDbY7UvBg==
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id
 l8-20020a05600002a800b0022068934ff6mr343246wry.170.1659595424946; 
 Wed, 03 Aug 2022 23:43:44 -0700 (PDT)
Received: from redhat.com ([2.54.191.86]) by smtp.gmail.com with ESMTPSA id
 j42-20020a05600c1c2a00b003a30c3d0c9csm5189459wms.8.2022.08.03.23.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 23:43:44 -0700 (PDT)
Date: Thu, 4 Aug 2022 02:43:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: memory locking in vhost-vdpa
Message-ID: <20220804024211-mutt-send-email-mst@kernel.org>
References: <780fba4c-458f-0abc-ae48-4cf806401228@virtuozzo.com>
 <CACGkMEtLutWVnG_SHbP9+K851k4ZN3hdtZGxaYpbAz3wzEvSGA@mail.gmail.com>
 <20220804063911.c6w7f757yqnfep4u@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220804063911.c6w7f757yqnfep4u@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, den@virtuozzo.com,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Aug 04, 2022 at 08:39:11AM +0200, Stefano Garzarella wrote:
> > technically we can switch to use the va mode, but it might have some
> > performance impact (mostly the copy_from|to_user()).
> 
> Would the cost be comparable to implementing a vhost-blk device? (IIRC vq in
> vhost uses copy_from/to_user, right?)
> 
> Thanks,
> Stefano

Well not in exactly the same way.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
