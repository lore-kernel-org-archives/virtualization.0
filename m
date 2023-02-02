Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60789C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 10:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C33C640C2B;
	Thu,  2 Feb 2023 10:33:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C33C640C2B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5Cn17KW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZ9fjaKy21mk; Thu,  2 Feb 2023 10:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4669140C24;
	Thu,  2 Feb 2023 10:33:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4669140C24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9B97C0032;
	Thu,  2 Feb 2023 10:33:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7482BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 354DC40547
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:33:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 354DC40547
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-h4r8-WqC0v
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:33:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D11D540C19
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D11D540C19
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675333988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzY8WLXPZBGvGs13fwLVzvdB3zWOPAiALRIUHU5zbPE=;
 b=C5Cn17KW2dLp3uYazhRkdwNcakuaOrdtJrEVG/mvT+r5fUp2xzIA+HMIMAKEwtWTBP0f37
 s1u1pOC1JMA5uOaR4Sf/a3j34FJjErlYT0815kyGPftderUSqN8V0JZCPmnX4P7BFvHuSz
 k2+GrqjT2gHyt+k9i+8jgNGRr7L1Y9Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-8KpSrHuXNT-LEJ4M2y6AsA-1; Thu, 02 Feb 2023 05:33:06 -0500
X-MC-Unique: 8KpSrHuXNT-LEJ4M2y6AsA-1
Received: by mail-wm1-f70.google.com with SMTP id
 iz20-20020a05600c555400b003dc53fcc88fso740133wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 02:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzY8WLXPZBGvGs13fwLVzvdB3zWOPAiALRIUHU5zbPE=;
 b=69s6ARTb+nZCNNVitbyzQ389fRVyfPtUkoN4bFBbbD44JC/C5Id5wlT5NGzXe4iUeX
 Dw36lMkqGeB1mYnjKUQ1SxvMrl11XVNksag2A7w8NW/i11/uANIf0Q9N8XMW1yYBCBb7
 iqZKcNm34pMabN/9ttoYeCJPw0SrhnHv0Sm0038SR7cyISAboq/h7HruecyFj1cvyINE
 qlUfqbL73+6eS3YbrHjPS4qkvINdO1MTDaDPc9opUYW4aImOFEp6BeV1/NXK4YiWLbiM
 SUVZjg02/d4fqwhm8ujpns3PnPcZd03N+JlV7227nP9zGZKKqQiUNsTj0aacq8HD3JQd
 B4Cw==
X-Gm-Message-State: AO0yUKV5f+ucs2MRvTVMxD9GAq0KEXiC9MPZtFgXR81Sn12G5OAswvth
 SkU183+UYv7RW/5J8N1CW7zHpr4N3qkmNzpE29Cr36RE/vgWC5BzGbPeuCEP1CdTRhgukej1yKp
 ZKEMQlyEQMui1hRjfQs08CDyq0PrMJ8JiCbFE9lmdQg==
X-Received: by 2002:a05:600c:4e4e:b0:3d2:bca5:10a2 with SMTP id
 e14-20020a05600c4e4e00b003d2bca510a2mr5273852wmq.22.1675333984808; 
 Thu, 02 Feb 2023 02:33:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/fHx8aUDAB0froK+lS+HWGLVJXUV/PDw9YBioywtgcQQqxlZhTuxBLUkkhhVkUE0oQ07IROQ==
X-Received: by 2002:a05:600c:4e4e:b0:3d2:bca5:10a2 with SMTP id
 e14-20020a05600c4e4e00b003d2bca510a2mr5273840wmq.22.1675333984603; 
 Thu, 02 Feb 2023 02:33:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fc:826d:55d8:70a4:3d30:fc2f])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a1c544b000000b003dc4fd6e624sm4452688wmi.19.2023.02.02.02.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 02:33:03 -0800 (PST)
Date: Thu, 2 Feb 2023 05:32:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH v2 1/7] vringh: fix a typo in comments for vringh_kiov
Message-ID: <20230202053204-mutt-send-email-mst@kernel.org>
References: <20230202090934.549556-1-mie@igel.co.jp>
 <20230202090934.549556-2-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230202090934.549556-2-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
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

On Thu, Feb 02, 2023 at 06:09:28PM +0900, Shunsuke Mie wrote:
> Probably it is a simple copy error from struct vring_iov.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Drop the fixes tag pls it's not really relevantfor comments.
But the patch is correct, pls submit separately we can
already apply this.

> ---
>  include/linux/vringh.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index 212892cf9822..1991a02c6431 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -92,7 +92,7 @@ struct vringh_iov {
>  };
>  
>  /**
> - * struct vringh_iov - kvec mangler.
> + * struct vringh_kiov - kvec mangler.
>   *
>   * Mangles kvec in place, and restores it.
>   * Remaining data is iov + i, of used - i elements.
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
