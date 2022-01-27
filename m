Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E2C433EF
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 08:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80D6F41C50;
	Thu, 27 Jan 2022 08:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjDtpXt3pAVb; Thu, 27 Jan 2022 08:06:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2266741C27;
	Thu, 27 Jan 2022 08:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D83A4C001A;
	Thu, 27 Jan 2022 08:06:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C54E4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9ED2D6108F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txPd-2Yy_PeG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:06:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FBCC60F4B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643270788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=504wFKnHwwkFfPMgKXlwh2pWyCBgbL4WyM0tygoZNNQ=;
 b=e8naWrWu6u7mhAmIiMeML7u8RvLYBVV7uE4Kn+OdLzpepWt1PcgOZC/HcYlPmPnmd6oAWC
 doGy3rRD7GG6Cmq1yOhNv8mzwaqzbr7U3NDb/wTQV6v2fGQnV1pd3FWqWAvlMpJDPN03ij
 MlRxmkpm0vVdA811LHXnvxJ+DQlw5ow=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-OpTHYxD6O2eZ5n25-WQ7jA-1; Thu, 27 Jan 2022 03:06:26 -0500
X-MC-Unique: OpTHYxD6O2eZ5n25-WQ7jA-1
Received: by mail-pj1-f71.google.com with SMTP id
 em10-20020a17090b014a00b001b5f2f3b5ffso1477425pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 00:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=504wFKnHwwkFfPMgKXlwh2pWyCBgbL4WyM0tygoZNNQ=;
 b=du2gpmUcyrE+JZdv/9R7qkToBUfMP8cdvKEzGzUxk74KpGX5EfDWZ/MoqOCMVbMWSf
 odH8Hnun1sWjgm5PCVfxiVj2SdJ0OphLL16bfsx+ODFO0icJEwGOgn5yYTvwUnMNKggn
 pp/cy5+IC1LDu8BYXCTPymXo13DJVFca4U+cpUY0NwoDrqh6yfe8G963aavZ6k0CcDug
 ihtTrWKMFo7Y5B+253U26w43PB1VwlJHEu/he87M11QAQBIdlBykWzjZOrhbiO5XZBJr
 kwkN49FD1oxicTndRuYXg5XQQCrAg9ESVU1hKjYCpqRaEqUO54L7wBhVtxTwt7q+eydC
 N7gw==
X-Gm-Message-State: AOAM531MUV2/DSyLXTtHrJUNjGfmBHPDuQIFEtaRbwX1sgGf2AwcPm40
 FAojYE+lxTmk1W1NGUJ7iTliGHXowWlXeSh4qUFqvxdkrr0RCqKhCqgWieTG3AlkvKjsGGhdyit
 4VO6eNoD78MGCpgSA+iTbpI/D/XdMPXwT6zS/1UakbQ==
X-Received: by 2002:a17:90b:4c11:: with SMTP id
 na17mr12923671pjb.208.1643270785786; 
 Thu, 27 Jan 2022 00:06:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLKfGJjeS4YswQ/QKDZOAXPs/PKdHTyVn17lLFQab1SuE9NkeWoTsMumy/vbjTkOUgHRMDEg==
X-Received: by 2002:a17:90b:4c11:: with SMTP id
 na17mr12923639pjb.208.1643270785491; 
 Thu, 27 Jan 2022 00:06:25 -0800 (PST)
Received: from xz-m1.local ([111.197.238.41])
 by smtp.gmail.com with ESMTPSA id f15sm4385357pfn.19.2022.01.27.00.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 00:06:25 -0800 (PST)
Date: Thu, 27 Jan 2022 16:06:19 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
Message-ID: <YfJSezhQv1kXa1x8@xz-m1.local>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com>
 <Ye4r7tKFhP9VaT5/@xz-m1.local>
 <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
 <Ye6IhLCe6NDKO6+E@xz-m1.local>
 <CAJaqyWcdpTr2X4VuAN2NLmpviCjDoAaY269+VQGZ7-F6myOhSw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcdpTr2X4VuAN2NLmpviCjDoAaY269+VQGZ7-F6myOhSw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

On Tue, Jan 25, 2022 at 10:40:01AM +0100, Eugenio Perez Martin wrote:
> So I think that the first step to remove complexity from the old one
> is to remove iova_begin and iova_end.
> 
> As Jason points out, removing iova_end is easier. It has the drawback
> of having to traverse all the list beyond iova_end, but a well formed
> iova tree should contain none. If the guest can manipulate it, it's
> only hurting itself adding nodes to it.
> 
> It's possible to extract the check for hole_right (or this in Jason's
> proposal) as a special case too.
> 
> But removing the iova_begin parameter is more complicated. We cannot
> know if it's a valid hole without knowing iova_begin, and we cannot
> resume traversing. Could we assume iova_begin will always be 0? I
> think not, the vdpa device can return anything through syscall.

Frankly I don't know what's the syscall you're talking about, but after a 2nd
thought and after I went back and re-read your previous version more carefully
(the one without the list) I think it seems working to me in general.  I should
have tried harder when reviewing the first time!

I mean this one:

https://lore.kernel.org/qemu-devel/20211029183525.1776416-24-eperezma@redhat.com/

Though this time I have some comments on the details.

Personally I like that one (probably with some amendment upon the old version)
more than the current list-based approach.  But I'd like to know your thoughts
too (including Jason).  I'll further comment in that thread soon.

Thanks,

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
