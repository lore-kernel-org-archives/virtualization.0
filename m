Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7773C43334
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24E234237E;
	Wed, 13 Jul 2022 05:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24E234237E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiI8x3s0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIxqLk9IVQyK; Wed, 13 Jul 2022 05:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 448A842347;
	Wed, 13 Jul 2022 05:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 448A842347
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 151BAC0033;
	Wed, 13 Jul 2022 05:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B99D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C807400EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C807400EA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BiI8x3s0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iy3LFaavFmLG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C16704010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C16704010C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657691850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=boFEgVNblenrHqqVS1jnj2EIYdHHRnh1yN8Lis/KYmM=;
 b=BiI8x3s0hX8msS4A6Z9qZ9hBJqRYnxYcpWlT7y/pk7y1AObOQ6KEF1IUnx+igCoF5uWJxl
 U77MvtwH5RLHHw/8WQNKbYWqdslHx4XgvIa6b8HEe1bufitrMxyYiPYfJMKrLPt5Ldv5Zw
 YmVou4BYA1ZgcVxQNgAXAT1OVYTfVCk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-Vw6-nFXtMReXL-D4IcvL5Q-1; Wed, 13 Jul 2022 01:57:28 -0400
X-MC-Unique: Vw6-nFXtMReXL-D4IcvL5Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 23-20020a05600c229700b003a2eda0c59cso503524wmf.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=boFEgVNblenrHqqVS1jnj2EIYdHHRnh1yN8Lis/KYmM=;
 b=ZTTnsFUXVhl355oo19WiH1Sz3fjAZw8y1nxKjus4XEA/0L6he7yLtT25qWkIP+nHyF
 po8ynnI+2W7UV3x79HEIUkZlNbsC1QVuUKyFtVmry981mW+E2R5yTOJJj0kFFgamnt7C
 mKwsTooNeBJ9se1/nw0arbIWNEFWA6aJ6U0wyvGos0UyA2YKzTX8zdyEEhbsTzXwGTQS
 h8fMCPNAY/Z+OeQUzsEVORgpfFBvaov2SITgEhuv+A5CS3U1mWSettr1q3BKWOH3kaEH
 SzHO1SgV0akeJstBNXXUC3dwwPlgkx5FNs0xw3+4S9Il+dS8YKQUYxpkmmi+6LXSkmVe
 h1Hw==
X-Gm-Message-State: AJIora9HO1Q/d1zdErUlbx8MzPqeepAZ/MAWdZShzVU7LdLE2fF+VDp0
 oqcJneg0ySId16QDQyH0lWi1ZVKd3LXoosqXSn8RvFkYpTfPp7zR6PEUmJ0yZfpKO0Kz+aYi8vF
 jSJzSt3YPy6Z/pnaRNt9aD6IrLOWTvNdelTf5G4zMUg==
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id
 q12-20020a1ce90c000000b003a04c68f109mr1621687wmc.56.1657691847728; 
 Tue, 12 Jul 2022 22:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSytF+rvA1u+0E60+EIyQ2fAAbilzoYpgj7lzqFVhdTGbFXS0W78UwvlB3/qhIbzv2YWWIHw==
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id
 q12-20020a1ce90c000000b003a04c68f109mr1621674wmc.56.1657691847492; 
 Tue, 12 Jul 2022 22:57:27 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 co1-20020a0560000a0100b0021cf31e1f7csm9833670wrb.102.2022.07.12.22.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 22:57:26 -0700 (PDT)
Date: Wed, 13 Jul 2022 01:57:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
Message-ID: <20220713015352-mutt-send-email-mst@kernel.org>
References: <20220706050503.171-1-xieyongji@bytedance.com>
 <20220706050503.171-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220706050503.171-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiaodong.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com, songmuchun@bytedance.com
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

On Wed, Jul 06, 2022 at 01:04:59PM +0800, Xie Yongji wrote:
> Taking iotlb lock to access bounce page in page fault
> handler is meaningless since vduse_domain_free_bounce_pages()
> would only be called during file release.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

vduse_domain_free_bounce_pages is not the
only one taking this lock. This commit log needs more
analysis documenting all points of access to bounce_maps
and why vduse_domain_get_bounce_page and file
release are the only two.

> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 6daa3978d290..bca1f0b8850c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -211,17 +211,14 @@ static struct page *
>  vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>  {
>  	struct vduse_bounce_map *map;
> -	struct page *page = NULL;
> +	struct page *page;
>  
> -	spin_lock(&domain->iotlb_lock);
>  	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>  	if (!map->bounce_page)
> -		goto out;
> +		return NULL;
>  
>  	page = map->bounce_page;
>  	get_page(page);
> -out:
> -	spin_unlock(&domain->iotlb_lock);
>  
>  	return page;
>  }
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
