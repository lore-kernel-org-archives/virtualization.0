Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C21FCCA47F
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 12:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB397610F0;
	Thu,  9 Jun 2022 12:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqt1jXxsogWp; Thu,  9 Jun 2022 12:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 522D3610EC;
	Thu,  9 Jun 2022 12:46:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27285C0039;
	Thu,  9 Jun 2022 12:46:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEF8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D8D2610E8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVoGcuQ3Xgau
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E100610E6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654778776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=;
 b=bfaVa0reba5JNx1JCCi449akB/iE7w7HJkh+iPewcoKUtXRVntBOZRj18BsRFXEJQD7Xt3
 GObsr5AzbK9k5Qx9iLnaJWAyVgOUUAb6wweVt7qXGOICRsO1ol959im5WFYdFixia0rC7b
 ZHeTquzJ+C6aZV+E1vVG8wDxl9vLE1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-i7VOkGf_PVaKV6J9BGozJA-1; Thu, 09 Jun 2022 08:46:15 -0400
X-MC-Unique: i7VOkGf_PVaKV6J9BGozJA-1
Received: by mail-wm1-f69.google.com with SMTP id
 k32-20020a05600c1ca000b0039c4cf75023so6958060wms.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 05:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=;
 b=X8fNwgjvgbHFw7Sl36YyaWwNCK7hB8gAwb84vpHkQAlBiFoUEFxyalbXRCHrY8MnCE
 fhINojyY2DGqEs3uhNFYY1QUI6bUl+qt6hEwF28cViIgQ8AcUzddftcc45F8MtkOFHzD
 l6agoEsLCiQR9/ncVdz4TZRr0G6v+87OHCkF6LCw+hneqOKxGFPBs35Pk9kZ/P+MFwXT
 kGW/DgUP9jCfdO7W7hQXxiplEoE87zrDn06imCQ/AybgPSUKy0iFQn0hUq6tGQ8RAHYE
 f0eP3TPUXCpGvzK46jjOEOc6YDoiDb9f29FEw48bV1JIvwnODg1Lyd1AHbOLEzJCqqsu
 aq9g==
X-Gm-Message-State: AOAM533iu1XTMYhrJdTDe73o8EEuOUBH5KJck+J09cVVK14aZbr+lwoJ
 e8kZ79vhA2ibsMghNa1SZDF7b1m8Pg0co581PT5Y7ESN8vjtRS3yyrM5aCAn1mZVg88k9YVFQ2X
 VWF0MJDgn8IIgCmrFEApNwhGrvAL9j6DmJczCEqeYiQ==
X-Received: by 2002:a05:6000:168b:b0:218:54da:90ba with SMTP id
 y11-20020a056000168b00b0021854da90bamr12022153wrd.283.1654778773731; 
 Thu, 09 Jun 2022 05:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFg5i2EPJ88Gv87gtw7EHVrLhSwsyQAltgpPZk1DxRKIUlDObIOhdmhH9jKki5ThpOI9Vqng==
X-Received: by 2002:a05:6000:168b:b0:218:54da:90ba with SMTP id
 y11-20020a056000168b00b0021854da90bamr12022117wrd.283.1654778773451; 
 Thu, 09 Jun 2022 05:46:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8?
 ([2a09:80c0:192:0:20af:34be:985b:b6c8])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c224700b0039c693a54ecsm3854607wmm.23.2022.06.09.05.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jun 2022 05:46:12 -0700 (PDT)
Message-ID: <c204c627-ec6b-cd8c-412d-57c8f55c61fa@redhat.com>
Date: Thu, 9 Jun 2022 14:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 01/19] secretmem: Remove isolate_page
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-2-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> The isolate_page operation is never called for filesystems, only
> for device drivers which call SetPageMovable.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/secretmem.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 206ed6b40c1d..1c7f1775b56e 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -133,11 +133,6 @@ static const struct file_operations secretmem_fops = {
>  	.mmap		= secretmem_mmap,
>  };
>  
> -static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
> -{
> -	return false;
> -}
> -
>  static int secretmem_migratepage(struct address_space *mapping,
>  				 struct page *newpage, struct page *page,
>  				 enum migrate_mode mode)
> @@ -155,7 +150,6 @@ const struct address_space_operations secretmem_aops = {
>  	.dirty_folio	= noop_dirty_folio,
>  	.free_folio	= secretmem_free_folio,
>  	.migratepage	= secretmem_migratepage,
> -	.isolate_page	= secretmem_isolate_page,
>  };
>  
>  static int secretmem_setattr(struct user_namespace *mnt_userns,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
