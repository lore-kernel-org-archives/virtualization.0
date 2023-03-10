Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A24EC64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7F314015E;
	Fri, 10 Mar 2023 08:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7F314015E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=domif4Cn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pg10MWm733O; Fri, 10 Mar 2023 08:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6CE6640123;
	Fri, 10 Mar 2023 08:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CE6640123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45F5AC0071;
	Fri, 10 Mar 2023 08:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E79DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E114360E4B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E114360E4B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=domif4Cn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keGxyWc_0w8G
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E495A60BB5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E495A60BB5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678438788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSOXOjdfBH4z2A2joOF3hu2wKWS36UlVXuUE3j0PT9A=;
 b=domif4Cn32MDarw8fygLJFF+xJ+0Sg4uw/p6rJkdPhIaqKIC8CHzMoKay1kcYr2s6txnSB
 P31JbKDl/S5qJxAGF/CoNaCzCyMu3R7E2jwX5GbPxSgNYAp6GO2PE/PLFzEK4CyT/Z3mSk
 1Tq+jYBMcFBCy8m+uJE3UkQ6GY/m1jQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-bXA8hW_GM-OVuDQyfTWoQg-1; Fri, 10 Mar 2023 03:59:47 -0500
X-MC-Unique: bXA8hW_GM-OVuDQyfTWoQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so1547183wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678438785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSOXOjdfBH4z2A2joOF3hu2wKWS36UlVXuUE3j0PT9A=;
 b=3d04n13Hyp+iWc/fzCuGow4M/7rGoNdgPnoT4LLC5e8/OG4aouOU6BSH8UvLMZJOIt
 u9cGUNu6YS6TNjhhA44ByJhh9VR+jpdTYHXKVNvLW0pCTKzx7/cMrdLCucn30l4IamSb
 kO7Qkog9LYncZ/Gn/mfA1gYIeuRfa1UQCoWKpkpsU0xHuIyVvDjeVC40oWFPDy5ex2jH
 Q6ayASfV9EftkUqyGspaw/os1ntGPrgZp91k3HKBe2pYLhRFKao2AWynZUHwqVRwOg24
 w/UHfB3WJG6ydBtIu0WwUhI7+VJTsP/iOlf9ySl32lBqkmmTmAvYoYcVAqPvYEc2cAks
 aV8Q==
X-Gm-Message-State: AO0yUKUtrSBluxhICMP/cGurk42UVNJ/NUxoWN0ARvuVEFH2bsKC6YFw
 w8dpmGBr2YkTP6pYa+e0iTneKViwjkEamkn7do09gS91BBI2IrO0nBHA8mY98fQTaRcSvcjt+4i
 vhOaofoFtLNNhbzAQLq/iResVMSJ+kvM3s9YhJsBGyg==
X-Received: by 2002:a05:600c:5028:b0:3eb:a4e:a2b2 with SMTP id
 n40-20020a05600c502800b003eb0a4ea2b2mr1942755wmr.4.1678438785211; 
 Fri, 10 Mar 2023 00:59:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/Az9JmFp4O0bJkHnPIfsNeuI++C8epvGL47tzv7KyRdo2SazZZqc3EbyXrfIt2qo/Y6T4r/w==
X-Received: by 2002:a05:600c:5028:b0:3eb:a4e:a2b2 with SMTP id
 n40-20020a05600c502800b003eb0a4ea2b2mr1942738wmr.4.1678438784936; 
 Fri, 10 Mar 2023 00:59:44 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c029000b003eb68bb61c8sm1525637wmk.3.2023.03.10.00.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:59:44 -0800 (PST)
Date: Fri, 10 Mar 2023 03:59:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v4 0/2] vdpasim: support doorbell mapping
Message-ID: <20230310035915-mutt-send-email-mst@kernel.org>
References: <20230227091857.2406-1-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230227091857.2406-1-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, eperezma@redhat.com,
 huangzhichao@huawei.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Feb 27, 2023 at 05:18:55PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> This patchset supports doorbell mapping for vdpasim devices.
> 
> v3: https://lore.kernel.org/lkml/20230213070446-mutt-send-email-mst@kernel.org/T/
> v2: https://lore.kernel.org/lkml/CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com/T/

Pls fix issues found by 0-day and repost.

> Changes v3->v4:
>     - use WRITE_ONCE  [Jason]
>     - start/stop periodic work when create/destroy vdpasim device  [Jason]
> 
> Changes v2->v3:
>     - add a new callback named get_vq_notification_pgprot to vdpa_config_ops [Jason]
>     - remove the new added module parameter 'parameter' [Jason]
>     - opencode the schedule/cancel_delayed() [Jason]
> 
> Changes v1->v2:
>     - support both kick mode and passthrough mode. [Jason]
>     - poll the notify register first. [Jason, Michael]
> 
> Longpeng (2):
>   vdpa: support specify the pgprot of vq notification area
>   vdpasim: support doorbell mapping
> 
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 67 ++++++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
>  drivers/vhost/vdpa.c             |  4 +-
>  include/linux/vdpa.h             |  9 +++++
>  4 files changed, 82 insertions(+), 1 deletion(-)
> 
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
