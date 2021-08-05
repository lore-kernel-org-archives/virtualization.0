Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48341C432BE
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 22:15:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8B861151
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 22:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC8B861151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AD01402B1;
	Thu,  5 Aug 2021 22:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eax6ms5tYzSa; Thu,  5 Aug 2021 22:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE2B5400C9;
	Thu,  5 Aug 2021 22:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1D42C0010;
	Thu,  5 Aug 2021 22:15:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B80C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 22:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72BB1405A1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 22:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whhs-NTtkUx3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 22:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8F6C40541
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628201720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MCW6M0K+DPxrj754zH128zD3EsmKOhs+543ICnuoMcc=;
 b=TBibYXZraFrLl/DCmk0188gibAw+AebBKSU0ENkgmOU33gdxqbKmRjr8ZIzTDbGtcmLQk6
 cpDxpHdtlmmazl5wgvgse73nf458Xm0dM8iEwkvrt+EkoOqZWXlYDDYbdfl/9qfX3v8CvZ
 U2q1TMtSv6oC+4RZhM9+Cg6nSwHQ+bI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-6ohK3iw_NfWq0paRuHtXgA-1; Thu, 05 Aug 2021 18:15:19 -0400
X-MC-Unique: 6ohK3iw_NfWq0paRuHtXgA-1
Received: by mail-ed1-f71.google.com with SMTP id
 dn10-20020a05640222eab02903bd023ea9f6so3847387edb.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 15:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MCW6M0K+DPxrj754zH128zD3EsmKOhs+543ICnuoMcc=;
 b=hRffJ0IzcnP6FFAeoEdWqT9ne/Jz9fDmHWecRO4eMFoLRXnW7dfbGvPeg8UBdYBuoH
 pmS/aW38Pq5L7arabn2qEpHm2jVDveEQYMJEZmpg2puspOFNSy41dXkfd+BWkwwTxGH0
 4kakzozdH7E75kNnQ00QKq9XYwMS/LWuBsSWboDffrNV77EEeyULh0dvCRd8L+/Fj2iF
 9HSPvO+ALITzZcaAdPDcT2wZJjMaUkgpgxf1Es+4AC/m6Ra+se2jYUMGs8HdvECtLSQA
 A0/JjOVbtl0WCdd7q3DN+ZRqqtlpqAgY9ggEkAPpAdT7oqaFkiv9Z5GwXO8dXOZJPDi0
 GGJA==
X-Gm-Message-State: AOAM532cVUNLzH5wECXfXgmMN39dpawPkrnbosMB00fGtDStWftJF9Qv
 OEkWIgsqjmSrYvDRYe/gZnFUBIxVF2N2gaKoStYMW7/KvLBUiPIXLXyxMDweg8eht7Sz+09JcBp
 1O193juLGZTgJ5Db6CzoofLBsDpkJxBAhicNQSIEfmw==
X-Received: by 2002:a17:906:2990:: with SMTP id
 x16mr6795237eje.554.1628201718428; 
 Thu, 05 Aug 2021 15:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIbQyYnx447QQy9o6qJM2wlkRIYr/HT4vvEFz63y63gHdgtaTBNV04YkPjLGwS1izVND2L5Q==
X-Received: by 2002:a17:906:2990:: with SMTP id
 x16mr6795220eje.554.1628201718163; 
 Thu, 05 Aug 2021 15:15:18 -0700 (PDT)
Received: from redhat.com ([2.55.141.248])
 by smtp.gmail.com with ESMTPSA id bm1sm2152353ejb.38.2021.08.05.15.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 15:15:16 -0700 (PDT)
Date: Thu, 5 Aug 2021 18:15:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH] tools/virtio: use 'unsigned int' instead of bare
 'unsigned'
Message-ID: <20210805181436-mutt-send-email-mst@kernel.org>
References: <20210729000402.45690-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
In-Reply-To: <20210729000402.45690-1-wangborong@cdjrlc.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Jul 29, 2021 at 08:04:02AM +0800, Jason Wang wrote:
> Replace the lazy way 'unsigned' with 'unsigned int' which is more
> accurate.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I don't see why this is more accurate. AFAIK it's exactly the same.

> ---
>  tools/virtio/vringh_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index fa87b58bd5fa..3e85f4ec210d 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -447,7 +447,7 @@ int main(int argc, char *argv[])
>  	char buf[28];
>  	u16 head;
>  	int err;
> -	unsigned i;
> +	unsigned int i;
>  	void *ret;
>  	bool (*getrange)(struct vringh *vrh, u64 addr, struct vringh_range *r);
>  	bool fast_vringh = false, parallel = false;
> @@ -654,7 +654,7 @@ int main(int argc, char *argv[])
>  
>  	/* Free those buffers. */
>  	for (i = 0; i < RINGSIZE; i++) {
> -		unsigned len;
> +		unsigned int len;
>  		assert(virtqueue_get_buf(vq, &len) != NULL);
>  	}
>  
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
