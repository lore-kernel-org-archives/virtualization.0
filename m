Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E85C433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 13:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 934AA40158;
	Tue, 15 Mar 2022 13:23:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdiWMG4vxMn9; Tue, 15 Mar 2022 13:23:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6CC940168;
	Tue, 15 Mar 2022 13:23:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9360EC0012;
	Tue, 15 Mar 2022 13:23:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C442C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A32C410A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:23:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHMRthK4LxVK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:23:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C0D9409E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647350625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IEpiYhsMGlq2ReYke60gfIQZ2QzqWJpfRL9F+OcYAMY=;
 b=eTh/+BtUq8mkG3eLN+XzrwBClSIGZkA7ig53ycIRZfiDtSRDQzjBPWC7xbBnS7LfFbRFar
 o9tPJ3styOFDEd71BxS9nUnMEZobNGjjvLDosa2tbua8a10xmRmVvKSvFI5Fs5xBi4KOZu
 ciI++kvLZCTUSSzyxwrphkdbKJ3iFt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-rN6PfgjZPNGh6a95Tglp7g-1; Tue, 15 Mar 2022 09:23:43 -0400
X-MC-Unique: rN6PfgjZPNGh6a95Tglp7g-1
Received: by mail-wr1-f69.google.com with SMTP id
 o9-20020adfca09000000b001ea79f7edf8so5282074wrh.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 06:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IEpiYhsMGlq2ReYke60gfIQZ2QzqWJpfRL9F+OcYAMY=;
 b=GBFiPhe5mYH3dMD3IPfiZsOKrpvuShtc9ORaQbuofQjIKxfZmvErLE8nNMNnB99LyX
 vG992fdukVWTjYtND0IFO2ur583XU4aANTgkZ0un+H7bm1ZfRrOgZUE8K76FmaGAg/N7
 p3ly83V5B7BWkjBbCF3zDMDUMBz9IL40PKlg+95C3s1Yl+wIqxdxrbL631VbiYcC3sHh
 5TYDSX2omQcN78BEfUhcpwgAKSJLK0ORqmnsozhhU6KDQajO/8NH5YImcorkoSiiQsqC
 GqT+yNqX8ohjAYPVFZDtHXsdd3Q+OHBZUnB+f0CBIhDHZt+IzmwXoYwvwPOB74UiF+Jq
 fyJg==
X-Gm-Message-State: AOAM531jODLhkBdrKDCru5kaOR9HYk+yPnXbPxPiYDoyBi7f51+RihTE
 Iy41Oio49HqS6ovgVCi1TsrzqPECN/NPHIBsjxh7j4Bh1q2yHOJ/Bxfc+4i7cUTDxrDvjc8dlJs
 i2v2G/8WggEfk0KP6T1g3ZH3hqYoUjiTp1+yuuVJIRw==
X-Received: by 2002:a5d:47ac:0:b0:1fc:f09b:c258 with SMTP id
 12-20020a5d47ac000000b001fcf09bc258mr20957688wrb.618.1647350622429; 
 Tue, 15 Mar 2022 06:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhcNjWTrbaoqdRbx7Oloh29YUHJlQt1KnYFPeCC8VNb6iBtIWGW90Cdk830Tz31dWtDzSVEw==
X-Received: by 2002:a5d:47ac:0:b0:1fc:f09b:c258 with SMTP id
 12-20020a5d47ac000000b001fcf09bc258mr20957671wrb.618.1647350622165; 
 Tue, 15 Mar 2022 06:23:42 -0700 (PDT)
Received: from redhat.com ([2.53.2.35]) by smtp.gmail.com with ESMTPSA id
 b15-20020adfc74f000000b001e888b871a0sm16230818wrh.87.2022.03.15.06.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 06:23:41 -0700 (PDT)
Date: Tue, 15 Mar 2022 09:23:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: trix@redhat.com
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315092101-mutt-send-email-mst@kernel.org>
References: <20220315124130.1710030-1-trix@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220315124130.1710030-1-trix@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: llvm@lists.linux.dev, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, nathan@kernel.org,
 xieyongji@bytedance.com, lingshan.zhu@intel.com
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

On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> ifcvf_main.c:49:4: warning: Called function
>   pointer is null (null dereference)
>   vf->vring->cb.callback(vring->cb.private);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The check
>   vring = &vf->vring[i];
>   if (vring->cb.callback)
> 
> Does not match the use.  Change dereference so they match.
> 
> Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 3b48e717e89f7..4366320fb68d3 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
>  	for (i = 0; i < vf->nr_vring; i++) {
>  		vring = &vf->vring[i];
>  		if (vring->cb.callback)
> -			vf->vring->cb.callback(vring->cb.private);
> +			vring->cb.callback(vring->cb.private);
>  	}
>  
>  	return IRQ_HANDLED;


Oh, absolutely. In fact vf->vring->cb.callback is just
vf->vring[0].cb.callback so it's wrong for any ring except 0. Does not
make sense.

So how did it work in testing then? No idea.
Zhu Lingshan, care to comment?


> -- 
> 2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
