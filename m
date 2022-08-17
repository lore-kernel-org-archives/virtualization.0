Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDAEC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 17:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81912610F7;
	Wed, 17 Aug 2022 17:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81912610F7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk6gFmwc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IyAjk8Gapa4T; Wed, 17 Aug 2022 17:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 16BF6605AF;
	Wed, 17 Aug 2022 17:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16BF6605AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE9ACC0032;
	Wed, 17 Aug 2022 17:06:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3668C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C059F60AFD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:05:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C059F60AFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9YjyG0xGgAjC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D44A6605AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D44A6605AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660755957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GM7xEfwIL/rtVq+hrRvQ1hKtp4szoR86mfFhzUxnc2Q=;
 b=Qk6gFmwcztZi/pyhapHCDwe17a5LB9wwX3MeiW66I9bpAvv47mdA7aw8+RDHLZQS5BDhia
 A0UOWBJyKbAEYL1/yYv2KHyTzrs3IBEslSLNMGGIb+gEUfQWeuTW+PQjZnn84MXKF/DknD
 tFqzPnv4PtNaDFn97PRQMsSXELBkKI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-DHE0H_LUOtyfs3P4Gvso0w-1; Wed, 17 Aug 2022 13:05:56 -0400
X-MC-Unique: DHE0H_LUOtyfs3P4Gvso0w-1
Received: by mail-wm1-f71.google.com with SMTP id
 c66-20020a1c3545000000b003a5f6dd6a25so1338662wma.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=GM7xEfwIL/rtVq+hrRvQ1hKtp4szoR86mfFhzUxnc2Q=;
 b=sHuMASGvyrHDWFlhQjD6z2iL1eCBF3Nr+D/SG6Mxb7O4dxYOcS98ZLsDJlUOeo7wFx
 H+O1/0xNGyejJ1Io0U+zG+jC6xIfsRqJEVuEt0YqJQvVSzI/qU3xBrkZMm9HzvDXdPiW
 UiCkQby2Ns2aJziNra1Z5tTe91aUzigxXJj1egMu2n54T6aG0W5knWlCf4OJHFc6MB4E
 vGqZrk7Zn/L/oRyB6wfW4PQr0VL8nhpWRK41PsMSV1ZjSMqn9eZQsmOc4RpHKdBqF3Nk
 UctvaU8KvR5+4dRgVElO2sQVeuoOQ/eFShv0rYuAwXaa7el6zsg7NrFGQZxOu/JSZvZE
 XoPA==
X-Gm-Message-State: ACgBeo3BEnr/tM9+OeBFEth/mfsBC4//hUa4OHGHNIIeRoMjwEpPFtu8
 LraXo2HwywdBlOlwnn0f05p/1eFS7IlUh4FRVb7BFgL7SuNf9JFLtzLrlNE11LD9QeU8k6TNyAG
 H6IxDy1wvZBQtVC1ig/AyLOSyUCFSNf+GpyzcppeJrA==
X-Received: by 2002:a05:600c:4f4f:b0:3a5:a530:4fd7 with SMTP id
 m15-20020a05600c4f4f00b003a5a5304fd7mr2807115wmq.36.1660755955452; 
 Wed, 17 Aug 2022 10:05:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7W0d2By6SxNehemYA/+2Tlkpn9sxMVpxE7j6tOqnVgLuFdYAz5FyA4g0pMz5pYYDOiSN6AMw==
X-Received: by 2002:a05:600c:4f4f:b0:3a5:a530:4fd7 with SMTP id
 m15-20020a05600c4f4f00b003a5a5304fd7mr2807106wmq.36.1660755955238; 
 Wed, 17 Aug 2022 10:05:55 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 m9-20020a7bce09000000b003a3442f1229sm2645479wmc.29.2022.08.17.10.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 10:05:54 -0700 (PDT)
Date: Wed, 17 Aug 2022 13:05:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220817130510-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck>
 <20220808083958-mutt-send-email-mst@kernel.org>
 <20220817134821.GA12615@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20220817134821.GA12615@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, crosvm-dev@chromium.org, torvalds@linux-foundation.org
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

On Wed, Aug 17, 2022 at 02:48:22PM +0100, Will Deacon wrote:
> On Mon, Aug 08, 2022 at 08:45:48AM -0400, Michael S. Tsirkin wrote:
> > > > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > > > work around I describe might make sense upstream I don't think it's a
> > > > reasonable thing to do in stable kernels.
> > > > I think I'll prepare a patch documenting the legal vhost features
> > > > as a 1st step even though crosvm is rust so it's not importing
> > > > the header directly, right?
> > > 
> > > Documentation is a good idea regardless, so thanks for that. Even though
> > > crosvm has its own bindings for the vhost ioctl()s, the documentation
> > > can be reference or duplicated once it's available in the kernel headers.
> > > 
> > So for crosvm change, I will post the documentation change and
> > you guys can discuss?
> 
> FYI, the crosvm patch is merged here:
> 
> https://github.com/google/crosvm/commit/4e7d00be2e135b0a2d964320ea4276e5d896f426
> 
> Will

Great thanks a lot!
I'm on vacation next week but will work on it afterwards.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
