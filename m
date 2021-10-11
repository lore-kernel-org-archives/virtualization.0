Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14983C433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:31:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E90600CD
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 03:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4E90600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AE214021B;
	Mon, 11 Oct 2021 03:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v--RejLWjgvy; Mon, 11 Oct 2021 03:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1BAC40124;
	Mon, 11 Oct 2021 03:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE7DBC0011;
	Mon, 11 Oct 2021 03:31:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11578C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8E016064D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fKuyzp3d13Q3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE1CC605ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633923109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DopLGzlmOB4HEdCaVkJ/RsYex88mvAawbRk2bHl6QL4=;
 b=UdQnChq+otYIX3B4PbPUTcpqle0XxcJAWBnJPW2wf7zv/NkxMP8zT6jnmX+URMVtT76mHM
 YCc6MndyeVHAWVz+pBBZaI4VplP0Y1ER8liMmcDHzLUyTBkVNcCZujpmjoAaey9DM1jRaw
 i++7Kg77hY+TTMk/WM9F026tcoYwkTw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Q78slLLSOXuA6dJfyTyzMw-1; Sun, 10 Oct 2021 23:31:47 -0400
X-MC-Unique: Q78slLLSOXuA6dJfyTyzMw-1
Received: by mail-lf1-f71.google.com with SMTP id
 br42-20020a056512402a00b003fd94a74905so62143lfb.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 20:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DopLGzlmOB4HEdCaVkJ/RsYex88mvAawbRk2bHl6QL4=;
 b=ZS0fV8Hty8/lmBcc4/yxiHI0tdUjM+GkP49PzrqodqdRswzpPwnDnoB5yfeqN5E2hM
 9l3FoyF0SIvlXAYUQjRkCJkk6p15tt+uCT5IGLI9PVpVg8sTq5SmhYzhjt1po5dsm9SD
 Fszvh+7SwVJSrCpeNNZ2BzEq4TG7f8c07EEugaeqBENikJMszsISMfYajGnMswA13RRf
 xWhnFYRrq8rlZMiLl7t75Oe11skilbs1sE3CxlCNt0RNQ7Y+gnJ+CHmjDqDzGFL48mWz
 ZHdTYIVozTj4/wmdHh87200HSSqHPZs4FmJrjvewSsh66HB7egfp4wvgn7GHDQJKNiJs
 4lQQ==
X-Gm-Message-State: AOAM5327j32If9/7Yeo2FUAg8M8hwYZYl494+ni4cAfAgWKMCV2oIHWY
 1loBffubUDPR1rMf95AMlNszXlRz4EKiWDpb+ljpBruLKygVbFh4DKSzrrZjaiNCp5Dl+BMDRHi
 8MMPpDH4oQ6lnAt4IUvK5C0jWEa3uxoX1RHlxxC63zOwbHVcTHA0nKEi9ug==
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr25388732lfg.498.1633923106315; 
 Sun, 10 Oct 2021 20:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYohr1FlcKG2NxgTdHVVMnCKaJn7rrf94S26N3UdjJfTh6R3wipgXYVNmB+4t0jp2WQTKZQ5h1Rb1nHWApW0c=
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr25388719lfg.498.1633923106150; 
 Sun, 10 Oct 2021 20:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211006202904.30241-1-rdunlap@infradead.org>
In-Reply-To: <20211006202904.30241-1-rdunlap@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 11:31:35 +0800
Message-ID: <CACGkMEvTdhD3GJfKJgb1pGSuxDNRPSFDFN12-zwAmB6=7E1OXw@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: fix documentation underline warning
To: Randy Dunlap <rdunlap@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

On Thu, Oct 7, 2021 at 4:29 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix a VDUSE documentation build warning:
>
> Documentation/userspace-api/vduse.rst:21: WARNING: Title underline too short.
>
> Fixes: 7bc7f61897b6 ("Documentation: Add documentation for VDUSE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  Documentation/userspace-api/vduse.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-515-rc4.orig/Documentation/userspace-api/vduse.rst
> +++ lnx-515-rc4/Documentation/userspace-api/vduse.rst
> @@ -18,7 +18,7 @@ types can be added after the security is
>  is clarified or fixed in the future.
>
>  Create/Destroy VDUSE devices
> -------------------------
> +----------------------------
>
>  VDUSE devices are created as follows:
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
