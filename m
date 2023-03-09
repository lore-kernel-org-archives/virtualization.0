Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9366C64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 09:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75030612A7;
	Thu,  9 Mar 2023 09:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75030612A7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hfr7v9g1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tax3o2_DXb0l; Thu,  9 Mar 2023 09:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F06A3612A4;
	Thu,  9 Mar 2023 09:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F06A3612A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB43FC0035;
	Thu,  9 Mar 2023 09:08:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8D83C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3518417E0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:08:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3518417E0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hfr7v9g1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgG0WqgU356A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2CE1402A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2CE1402A1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678352920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srx6n4gHkwmgsQ7OIE1qCU+GHs3BJds+nIoKBUJIQzE=;
 b=Hfr7v9g1gh4/K8xTyfd5Mz6osEDxZoek1m/NCNLfWiNvOGZuJPoCgs+O5LOM8qkZXbbm+z
 68RZmWU4ex7mx872O9kihdRJymsZpxtUpQlrYX52O6PogYsagr+iP5SDSLEN+BbAEL/obi
 RxOt1BDkFqcdfbmGii4Juet17GxLsWg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-AQXKoMjsPJqa8I5orZRypA-1; Thu, 09 Mar 2023 04:08:39 -0500
X-MC-Unique: AQXKoMjsPJqa8I5orZRypA-1
Received: by mail-qk1-f200.google.com with SMTP id
 eb13-20020a05620a480d00b00742be8a1a17so831446qkb.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 01:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678352919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srx6n4gHkwmgsQ7OIE1qCU+GHs3BJds+nIoKBUJIQzE=;
 b=L0kUeFV91AzzFYUo4sNxXXRQ2+T0hMizfqV7Z40WC78QV5m3DI2T7nff9k4KRMHgcv
 C7ofOIPKBYbyRCpmW34vEGAj1LKruEhrbOFaZPA4GL2YdhZbp1e4E4OXsvPYl+xNL2oq
 iYv4u+CO5EX6OV/8X1j9YFafJ6Z3uvv7dIz7+ufaLi50ujpkR7Kt6OjpDZq1DqaR+CRP
 5zJbhslj/si6MXzCh3p6etMUy1BT7QIpVlJ9INSkBhJMcX2nbQut6SyeluSxFpXKxuzQ
 a7KE/P7xYa2t4XvXbwnBbZEFSrp2u2xhgQ+PGk0WMYUDM1cc0lULemp/kMSI4emHP2ty
 rOlQ==
X-Gm-Message-State: AO0yUKWFQZ4QBGubaHlhJmtZZE4oG/4keNITwSIQdk6SDudinihEpc2O
 JlXtyGcVFryEe8B5bispybjWKv9RWBSfaBeMtjaKsmpD31pH0exbdLvF1ROvsOdWoHsS/Beg08l
 MfOezlvt20hRqv7idDo0fB63B+zu7vjNM0fUImCo7eg==
X-Received: by 2002:a05:622a:60c:b0:3bf:c5ab:a0db with SMTP id
 z12-20020a05622a060c00b003bfc5aba0dbmr38984338qta.41.1678352919004; 
 Thu, 09 Mar 2023 01:08:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/d8xNHSc1KF09A6BOMVU1+xsSGs0gU6ARd/TmG6uhTMDQO4mBh2NmpStvK4BR9Za1QDXGlWg==
X-Received: by 2002:a05:622a:60c:b0:3bf:c5ab:a0db with SMTP id
 z12-20020a05622a060c00b003bfc5aba0dbmr38984317qta.41.1678352918690; 
 Thu, 09 Mar 2023 01:08:38 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 b3-20020ac85bc3000000b003bfb820f17csm13555612qtb.63.2023.03.09.01.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 01:08:38 -0800 (PST)
Date: Thu, 9 Mar 2023 10:08:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Message-ID: <20230309090834.57bwsiahnlt6r35a@sgarzare-redhat>
References: <20230309084920.oj66qnighnnyet3f@sgarzare-redhat>
 <tencent_19934693116B0C1C8402B2A22F5355205F09@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_19934693116B0C1C8402B2A22F5355205F09@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: rongtao@cestc.cn, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Thu, Mar 09, 2023 at 04:56:09PM +0800, Rong Tao wrote:
>Hi, Stefano.
>
>I'm wondering, does '-h,--help' help() should 'exit(0)'? Is '-h' considered
>a successful run and returns '0'.

You're right.
I thought -h would return an error, but that's not the case, so I guess
this patch is fine!

Thanks,
Stefano

>
>Best wishes,
>Rong
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
