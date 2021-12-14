Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476F2C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 03:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1D928136D;
	Tue, 14 Dec 2021 03:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzRjpkWtIrtV; Tue, 14 Dec 2021 03:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3B8481296;
	Tue, 14 Dec 2021 03:37:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C0CAC001E;
	Tue, 14 Dec 2021 03:37:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED65C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EDA3402EE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqhB9Xn1mCnf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:37:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A3FA402C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639453037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GmigQw+Jda3Lliex+uQcJxc3UovGH2gBKzLnkQYp7Fg=;
 b=e0+QrcLsLaL4GFOKZZeSTVF8egdA/12vYoTCS0JhUd0Nd1DUrXvZRWxIfulaXZdhqUUBR1
 1IOGREO06YSKJYKekh7H9fo9Tqziux4eihIi2zkXI3TKABqtFnq0JgAsMatsR+iJwbc3O/
 iAubTEsgj4TyfU80FxYuH38lGM5f/jw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-aNj_Abn0NIWHQOMrNz7jWw-1; Mon, 13 Dec 2021 22:37:15 -0500
X-MC-Unique: aNj_Abn0NIWHQOMrNz7jWw-1
Received: by mail-lf1-f72.google.com with SMTP id
 c40-20020a05651223a800b004018e2f2512so8439034lfv.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GmigQw+Jda3Lliex+uQcJxc3UovGH2gBKzLnkQYp7Fg=;
 b=K9VjhmwcmEfWJgUPr7IXmbWXT7Q4WE/YEMgwixU6e1dYvyDBU/Ol3haOH3TiV9euTa
 8SN99l9E1WsORfI9brT3Fd3YT7WlH8H3ebOeNTY9qfFR7WJxIviVagLWgYTHNTs1NwwL
 TeLe14ulRN+GaRMGwDnCfe7Hd28NWtbv+KXDtB7q/lHO4W6lfaHr7uw4rarvlV/Az0gw
 O+EC0tM4zWWowKl3bRdn7t8Efb6hmePC/NooNfMl9Lxj4Sm+OdPyvsCT4ooGxjlT5vdP
 bBt0dzCTxkkV8z6BHKXq0GjM2iyfoUjzvth44ivKKRPKZfaecE3Z8dKRTfmcJs6kZjJ1
 QQQA==
X-Gm-Message-State: AOAM5308bsDflFwdqJH+GF/882ohNuBOZMFwxOtUs+rQ/9XZY6deO8ne
 qnj4SixnKkrN27/ruOXG5+bjdlfsQx3/fTBuXIAx6LJQgYJQpu0LuJ8yYbc96IqJGzAgh65X0xr
 9elvcZIr+zuwvtU2uZtE4SoSzkLvHwLIiSdRhf8UI2Sz1mzYHoKRr9f7J0g==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr2359313lfv.629.1639453034490; 
 Mon, 13 Dec 2021 19:37:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0k1DmO7c+FkTE6tByR6WK4dELj22f28R7NJjhc3HDsW0lxqYYZJHgg0S3QdYWcb5LH6X157S8iuxqezNa+80=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr2359290lfv.629.1639453034267; 
 Mon, 13 Dec 2021 19:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-2-elic@nvidia.com>
In-Reply-To: <20211213144258.179984-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 11:37:03 +0800
Message-ID: <CACGkMEuZSiYfhe2S4LrBvmadqBU=PAi+-u+eDJx64PzidOWsdA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vdpa: Provide interface to read driver features
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Provide an interface to read the negotiated features. This is needed
> when building the netlink message in vdpa_dev_net_config_fill().
>
> Also fix the implementation of vdpa_dev_net_config_fill() to use the
> negotiated features instead of the device features.
>
> To make APIs clearer, make the following name changes to struct
> vdpa_config_ops so they better describe their operations:
>
> get_features -> get_device_features
> set_features -> set_driver_features
>
> Finally, add get_driver_features to return the negotiated features and
> add implementation to all the upstream drivers.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> -----
> v1 -> v2:
> 1. Fix to call vp_modern_get_driver_features() in
>    vp_vdpa_get_driver_features()
> 2. Improve calback function description
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
