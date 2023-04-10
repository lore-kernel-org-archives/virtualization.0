Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FC1C77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 11:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2892240B53;
	Mon, 10 Apr 2023 11:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2892240B53
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dt2Iar/e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4epWXTmWdDo; Mon, 10 Apr 2023 11:49:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EFD0400A6;
	Mon, 10 Apr 2023 11:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EFD0400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81217C0037;
	Mon, 10 Apr 2023 11:49:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C161FC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88B15400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88B15400A6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id huuZESCsNulN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:49:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F05B404B4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F05B404B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681127385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IdX9A2cTuLMGC5c/5nYygSYn711EAtAdcecz6KOLn0Q=;
 b=Dt2Iar/eJlJ9QE6fF+feuhkIK/5kk/NEmdhx5HIw84aod9q8Q26sOpz+HYEIrqwZQkioyH
 ND8wCxBSzog2jT0Rwjps6gj4wXJWWlLgXPLPIsAKGA+JX13NBdIC4NKqdXWadNK42+XLYA
 0X9WYMqnGTdd44lLp1rQEY0dH3IIgYE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-tsqt7XdKMNuig356n6jetQ-1; Mon, 10 Apr 2023 07:49:44 -0400
X-MC-Unique: tsqt7XdKMNuig356n6jetQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 g6-20020a05600c310600b003ee69edec16so3893797wmo.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 04:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681127383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdX9A2cTuLMGC5c/5nYygSYn711EAtAdcecz6KOLn0Q=;
 b=M7RHIVC74H+r2Kf0D1SPZ1sIQEqA2Xr+i+oplZYFmUzo0uIcRf84PP8l0KUx+G3ASg
 UF+CSL9ItTPn2Zfl5qd9lcOtp7xZPw/KNylegtdfogmui5wZ2GZnfwhk111FzfKhpkd/
 H08qN3toJYK1F/4/mu4aAuvxi6EecemZd3iBdTEO5RQgrFmbjQz1izLhJLgDTZaKmtfL
 4lAd+KkKnkK+F/YmPozDuvlXdm0ZQwLfyWaaKr3o6MbDbMh9KghXFzZudVbGFNPVNSag
 7KwIA+u1jMxH3UKP13PD/S3k6OUBtyyAccUUJlkR2Hltb8RYfp4mt/WjwtG3cWDvqe7Z
 Sy8A==
X-Gm-Message-State: AAQBX9cAheJ9+i7wFspbja3VPG7xd3HBSEz9p5nv2aXlQIfcsY8Tt2lB
 h3EIiAb3EPYw1LrvCiGE39ZInHLf+/9F4+kcS7SYO4mscihokiKgog5g5ZVdKtRq5vcm/Ns6yUb
 9+mPGFku5lyKNPs15vILu/60v0uoVgFjdVEA3QsH4hA==
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id
 c3-20020a7bc843000000b003f07b28e393mr6286345wml.9.1681127383481; 
 Mon, 10 Apr 2023 04:49:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350aAtSETWgLgh29QKPfaPRkt+2l+8Yf8254jf8O+Oz84Y5///MBqKYZ+7beWIEv18R2u1KpZ3Q==
X-Received: by 2002:a7b:c843:0:b0:3f0:7b28:e393 with SMTP id
 c3-20020a7bc843000000b003f07b28e393mr6286327wml.9.1681127383211; 
 Mon, 10 Apr 2023 04:49:43 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b003ee70225ed2sm13374390wmd.15.2023.04.10.04.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 04:49:42 -0700 (PDT)
Date: Mon, 10 Apr 2023 07:49:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH v2 1/2] virtio_ring: add a struce device forward
 declaration
Message-ID: <20230410074929-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20230410112845.337212-1-mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

s/struce/struct/ ?

On Mon, Apr 10, 2023 at 08:28:44PM +0900, Shunsuke Mie wrote:
> The virtio_ring header file uses the struct device without a forward
> declaration.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  include/linux/virtio_ring.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 8b95b69ef694..77a9c2f52919 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -58,6 +58,7 @@ do { \
>  
>  struct virtio_device;
>  struct virtqueue;
> +struct device;
>  
>  /*
>   * Creates a virtqueue and allocates the descriptor ring.  If
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
