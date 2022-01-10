Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36F7C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7515F40396;
	Mon, 10 Jan 2022 06:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sgpiddU9kE72; Mon, 10 Jan 2022 06:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81A8B40122;
	Mon, 10 Jan 2022 06:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57493C002F;
	Mon, 10 Jan 2022 06:53:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5D2C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A13181456
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yV-PSX7Zw7jD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:53:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 472778144A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641797590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAVEX5XE4qRstgXFBPQSZ2U9wJsRWTTP8EB2CgNFLGs=;
 b=e2p6wquVgdzQgqxcjh2970TqO7WNLJSm8t7U0mqodvee2no8dc+I9B7hOMfp46bPc4zmzq
 AIuLsY5G9WUUS6u+Of0wL4HkAQqPhXE4JOF2K0aE9LqTTFTC4UHGrYCqyxsUGchIyvx1hX
 UwtZtTIY1gzEIbPwM64kQrpCrXGZu50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-9hLPWoVEN_We22l_2YDH0Q-1; Mon, 10 Jan 2022 01:53:09 -0500
X-MC-Unique: 9hLPWoVEN_We22l_2YDH0Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 h26-20020adfa4da000000b001a652d52d8eso1826221wrb.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bAVEX5XE4qRstgXFBPQSZ2U9wJsRWTTP8EB2CgNFLGs=;
 b=fRb605UnPKZy83aB33yqzKsTYRG4dABn/Z1Wl+d4gTHOu5vh9Jz4LHoO3U8XNfR1b4
 vBKjQoRU/fnAwv+2F4jV55k2N0F/uUUZg5YSfcpUpQrmGPhaT7FgAfAkjCPdjH5c/EUl
 Un5S+LCe9/c7AdQ2ltCdyBM6xOP6cs9Os1mkAAv55TKJaWnxnsfOcmiLa9sUYoVFQQHX
 O0FA6bKsvIEf2BLCw+AZ6/HPzMW37pHZBYqqQOEfxEMRVpyyU25LFJ+FBKZOI+evQV9M
 jlmMVG8RFnR7C+mZ/ts4/dCd0rSlq36idGmRliCJ/8XoGbUBVjSSNp9p6v0nFUxZymbw
 A6yg==
X-Gm-Message-State: AOAM5310U41Cqg71EIJ30MGTyDeCCB446qDrCPSnbvw2At5KnUj04Bwu
 LS3BXSv11FIK3L0KyIUkLw1JLuZZ3ydFpip8jDbRsIr+sktpU0c5mR0ArJLc+adrRumVbd3ARKD
 HxYt2OZQ/JUMAzQpx1R36YtDD8/4v0KA02MPoH07V4A==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr64027057wri.63.1641797588098; 
 Sun, 09 Jan 2022 22:53:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyU4FC9pKm0TfR5HrVjZt3VG3toxN3FDZI29ak/UncvO20L/QqXmxSE3a4/iC/fhg46NNI7Pw==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr64027043wri.63.1641797587914; 
 Sun, 09 Jan 2022 22:53:07 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id f5sm2858744wmf.47.2022.01.09.22.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 22:53:07 -0800 (PST)
Date: Mon, 10 Jan 2022 01:53:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Message-ID: <20220110015040-mutt-send-email-mst@kernel.org>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <YdiABvwrK3WxfHqb@archlinux-ax161>
 <233b923b-e6e2-0d47-8230-df91a35ee4de@oracle.com>
MIME-Version: 1.0
In-Reply-To: <233b923b-e6e2-0d47-8230-df91a35ee4de@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, eperezma@redhat.com,
 Eli Cohen <elic@nvidia.com>
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

On Fri, Jan 07, 2022 at 05:43:15PM -0800, Si-Wei Liu wrote:
> It's unfortunate. Don't know why this series got pulled into linux-next
> prematurely. The code review is still on going and there were outstanding
> comments that hadn't been addressed yet.

Most patches got acked, and the merge window is closing.
The only couple of issues seem to be with this specific patch, and I
think I fixed them up.
Still - I can hold them if necessary. What do others think?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
