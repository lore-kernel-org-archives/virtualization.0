Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037D1C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AC5F83A82;
	Thu, 25 May 2023 07:45:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AC5F83A82
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRvdO5tw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HzE-DZ9XFvYh; Thu, 25 May 2023 07:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2302583A5C;
	Thu, 25 May 2023 07:45:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2302583A5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC99C0035;
	Thu, 25 May 2023 07:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F096FC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAC8542A48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAC8542A48
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRvdO5tw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7_bHYsZb1Mlq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D7594015A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D7594015A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685000724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=moqm2xMtvs1QXIlu4uTeryrCfPMIkNPE51IfYtbbbXc=;
 b=eRvdO5twmhV7fLf8r82TH11k5aLsV/LpxyjUw8foeaL+41+LuOm/c9rvVseq72dON/QCP9
 qV2pkNJTn0Jt2zswnO7oCfy8X4rhFjx7XZmgcnQct2Fsu1e0DuPqDXlsUs+4rsfYHxPYWl
 NRW+hYBqD0wFOThbFSaW1T+hM48+X88=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-YlbPd0nYOCW4Iwh1wEuWvw-1; Thu, 25 May 2023 03:45:23 -0400
X-MC-Unique: YlbPd0nYOCW4Iwh1wEuWvw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6238c3bf768so11113446d6.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685000722; x=1687592722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moqm2xMtvs1QXIlu4uTeryrCfPMIkNPE51IfYtbbbXc=;
 b=dnJ916Va22Lqb2oX/tR+bFJfONCdkGgfD1yWyIMfnjB6q3UIAnaOqayt/v0L/zskqi
 uI+1Bdz1I3JHP5kQI3IPJobLooR3Kzz5l4hThI6kYJ5+DMLygsXA/IduU5NDV0aZQqIm
 W/sSgiz673Jdk+/ODqOqKnhPihcaeIY625+El7/enkvrdeBHIBsQD9MXS5SVGM7LGAzS
 WKx5K0Gd2HDWy2wENaf/6exxQqpwRAyHHXkoqJAnpKYQlwss65GlRuetBKH3mvTa85Cc
 aGDCjEw0pZIITB+zeq2zbwJStrQxLFFIf2Td2DVTaLmIX3VHz7MFgYzcGaMNwxY+JBOp
 lj5A==
X-Gm-Message-State: AC+VfDxJmnGwVIlpK5HK75laguSkN3hiWrHiLyaB9l6jif6W2ott8GqJ
 vkFk/AKgXPtleo941MvThwJSVDGi5dsCPUlF4SJTE5O9GvUkgMMGn5CiPA4vhSvd0plOP1KtkZv
 fsLs09b9CjzdJLa1oWc28PFA9ds2imx1rhlOOadERWd9trojiFpPt
X-Received: by 2002:a05:6214:5013:b0:5ef:56e4:f629 with SMTP id
 jo19-20020a056214501300b005ef56e4f629mr514382qvb.38.1685000722333; 
 Thu, 25 May 2023 00:45:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HCJKGlMVKZnjVIAhyXmrhUFUNU35N4whAygVzlGeR13jXaM1sA9iXGP6ukgCNVa86jNz5fg==
X-Received: by 2002:a05:6214:5013:b0:5ef:56e4:f629 with SMTP id
 jo19-20020a056214501300b005ef56e4f629mr514372qvb.38.1685000722072; 
 Thu, 25 May 2023 00:45:22 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44250000000b0061b698e2acesm234148qvq.18.2023.05.25.00.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:45:21 -0700 (PDT)
Date: Thu, 25 May 2023 03:45:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Rong Tao <rtoax@foxmail.com>
Subject: Re: [PATCH] tools/virtio: Add .gitignore to ringtest
Message-ID: <20230525034503-mutt-send-email-mst@kernel.org>
References: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_C8F0F579940491D14055C82FABE812478505@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>, Rong Tao <rongtao@cestc.cn>,
 open list <linux-kernel@vger.kernel.org>
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

On Wed, May 24, 2023 at 08:36:12PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Ignore executions for ringtest.

I think you mean "executables".

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/virtio/ringtest/.gitignore | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tools/virtio/ringtest/.gitignore
> 
> diff --git a/tools/virtio/ringtest/.gitignore b/tools/virtio/ringtest/.gitignore
> new file mode 100644
> index 000000000000..100b9e30c0f4
> --- /dev/null
> +++ b/tools/virtio/ringtest/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/noring
> +/ptr_ring
> +/ring
> +/virtio_ring_0_9
> +/virtio_ring_inorder
> +/virtio_ring_poll
> -- 
> 2.39.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
