Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3BBC4321E
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 11:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1400A405D2;
	Tue, 29 Nov 2022 11:04:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1400A405D2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hg/kX5p9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wm-WgSnHqnT1; Tue, 29 Nov 2022 11:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 905D4402F2;
	Tue, 29 Nov 2022 11:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 905D4402F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 573CFC0032;
	Tue, 29 Nov 2022 11:04:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E358BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 11:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1AE98132D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 11:04:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1AE98132D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hg/kX5p9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CoDvIjGNeSmg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 11:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D175E8131F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D175E8131F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669719881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jP1lHwdu35rqNpotbU76INnOwZ02nFRE30r1lYA4fPg=;
 b=hg/kX5p9Mvo0ErlVBnbmat7liHmgs+XSbEdzu33z8TFEcwNF7qNTfUF7LT2jF/scwBYTz+
 y7EAp3pmK/o+AL5Hlq6hDqkHvAX8yr6UKZGpbPTt2mVmbvlc6UdCkRmPFNxWON3x4PITeR
 vSBK1ih0Kijpn1ehJ/IXFjdbhyxJNhs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-JT7ZHXEdP0SWbzr9Wz0Ohg-1; Tue, 29 Nov 2022 06:04:40 -0500
X-MC-Unique: JT7ZHXEdP0SWbzr9Wz0Ohg-1
Received: by mail-wr1-f72.google.com with SMTP id
 s1-20020adfa281000000b00241f7467851so2748382wra.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 03:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jP1lHwdu35rqNpotbU76INnOwZ02nFRE30r1lYA4fPg=;
 b=QrZNtKZ3IrKQ17QrDyiZSdoePAFYsoLhTLifM+gpSbGkVGw3+yOnSNNFLg+jDy3Ep8
 XekkUES635hA9yJGiATdEYlYfOAvpbv6HE4O/RqfaqBNEcglVqMBnXFh29E0PtzJeV33
 69QFWm+bY3ooKgql/Fz8jHizHaLFK/f9dhVbFo80xZce6GCW5PCYWEYtXvH849HExuGn
 JOoxIcgbb7Eb23qTZxbRcN4YSI7+Rgce/d9xsa34JAA29FDAzcU5pAK6B98U8/I75aJy
 cSVAho091aOot3BUVCSgMyxTkHxqnOAXY2gEeSyvUgQq5wqjCgf7GDo7vN3oPVbqMktM
 3oxw==
X-Gm-Message-State: ANoB5plrMXt9KH5nf/nw8weJyzzw4m01vUfyX5qUj9hGkH/ZqO08du9a
 67wK3LNsLx8ADoLwJY+EFzLMVThQJOTi7bvteC+E7C98KRfkdyVPIJdX6p+LYGUj/PgH4LoRpZZ
 LT9tkZn1Qfd7B53nDpNja8fJfzOS8wZPhEg2oj4AZLQ==
X-Received: by 2002:a7b:cd94:0:b0:3cf:bfca:22db with SMTP id
 y20-20020a7bcd94000000b003cfbfca22dbmr34988742wmj.134.1669719879049; 
 Tue, 29 Nov 2022 03:04:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4NbwVRB2fltIZOFuNnT04oH6010qEOdlLCy93XSSBL0Wqo54FdgLuvoevGqGXLITY7UrnkFg==
X-Received: by 2002:a7b:cd94:0:b0:3cf:bfca:22db with SMTP id
 y20-20020a7bcd94000000b003cfbfca22dbmr34988721wmj.134.1669719878807; 
 Tue, 29 Nov 2022 03:04:38 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c3b0900b003c5571c27a1sm2318495wms.32.2022.11.29.03.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Nov 2022 03:04:38 -0800 (PST)
Date: Tue, 29 Nov 2022 06:04:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: config interrupts not working
Message-ID: <20221129055940-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400F1F670E4095492F25E8FAB129@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400F1F670E4095492F25E8FAB129@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, Nov 29, 2022 at 08:07:45AM +0000, Eli Cohen wrote:
> Hi,
> 
>  
> 
> This commit:
> 
> commit 73bd56abe1709352ab123952c96cc3255d0cbeff
> Author: Michael S. Tsirkin mst@redhat.com
> 
> Date:   Mon Jan 10 00:47:51 2022 -0500
> 
>  
> 
>     Revert "vhost-vdpa: add support for config interrupt"
> 
>  
> 
>     This reverts commit 634f7c89fbd78f57d00d5d6b39c0ade9df1fe27f.
> 
>  
> 
>     Fixes: 634f7c89fb ("vhost-vdpa: add support for config interrupt")
> 
>     Cc: "Cindy Lu" lulu@redhat.com
> 
>     Signed-off-by: Michael S. Tsirkin mst@redhat.com
> 
>  
> 
> Removed support for propagating events from the driver to qemu. As a results,
> link state changes are not propagated properly leading to link issues.
> 
> Any reason why this work removed?
> 

Yes, it had abunch of bugs, I tried to fix some but run out of patience.
In particular see 87zgo3xr6w.wl-maz@kernel.org

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
