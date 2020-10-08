Return-Path: <SRS0=zhq/=DP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4883CC43457
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:01:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CE622226
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGBbzFWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE622226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1AF886D7D;
	Thu,  8 Oct 2020 20:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ntuc-xQvAZtB; Thu,  8 Oct 2020 20:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E34686D6E;
	Thu,  8 Oct 2020 20:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47BFFC016F;
	Thu,  8 Oct 2020 20:01:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68194C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6172D86D6E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nF8XvYv6PQ7Y
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:01:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C8D4986D42
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602187259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7ZjK4P1j2h8bXH0yXST1ACz87+diWlu/RJO8+yMMIg=;
 b=QGBbzFWFFuENGZejdGWF1t8W0SauljiH5+Rtd5fk3cqYtARLD1c1k4XFI674IhiNibDsPY
 HWItUrN7e2D2hQQAriPIJCzFP+IqU0wOxTJKfDWfO1J+uuJkADZ0GyFfUjeXaD2/jyBqbf
 OI08x7FM7bQiCe2mGiOHezFbCd3tNXI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-UYJjPdgvOdS2LgQSottzHw-1; Thu, 08 Oct 2020 16:00:58 -0400
X-MC-Unique: UYJjPdgvOdS2LgQSottzHw-1
Received: by mail-wm1-f70.google.com with SMTP id y83so3499265wmc.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Oct 2020 13:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N7ZjK4P1j2h8bXH0yXST1ACz87+diWlu/RJO8+yMMIg=;
 b=m9CR2EgU2UW226ssjulSHNjXKVjY1m8jq0ul2+iNCzMXFmNCU3+9D12dbtLX2BweLZ
 yOeBTiXVzj2RhLpFcGK3lO7xzBPXP+vuE3VPhaUJgNRKgV+QCP1YcpLsEHlVcHvwnjCK
 Dm66GsUg5eE7z1YnH6FRCokJh4//Yp/cwZceK+UzWzO7dQS/1GogLnjLdNG+ER+jJ61h
 IFUnSGJhUKgTXP9hU954UElWyViobqdGx34TksKRwjOllm9w9QqL2vBlDJQsrZjcgPk8
 7RN3XSI7IIHbZdoRP1nZ36I+IEUJ8nnOFmZumqzAkfos3Bvf0Q2gUzIEqReEd+jfCfUh
 juZQ==
X-Gm-Message-State: AOAM533eWJdKxzM28aZQAqieKbsxa+5IPqrnlwqOi7wEkfkFdkXwXYkn
 0sv34pzBPfQKaUCNi5wh6zq9xJsYUj8SnPpp5qQtp6zrmPr+N0Kfme7NMJ9uHqylOk+rhfXiPvG
 BipUFTWwRUTaR8IED+cinruQhIjJ2zeUa/eb6UtIkyQ==
X-Received: by 2002:adf:8562:: with SMTP id 89mr10925395wrh.214.1602187256865; 
 Thu, 08 Oct 2020 13:00:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWrfSGm9ixOxCPW8QdF5CAdI6tKiof9TUB2EwQFmEeCUUsDhhAjPVtVpxFRSxH/O9OPV7uVw==
X-Received: by 2002:adf:8562:: with SMTP id 89mr10925375wrh.214.1602187256545; 
 Thu, 08 Oct 2020 13:00:56 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id w11sm8493631wrs.26.2020.10.08.13.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:00:55 -0700 (PDT)
Date: Thu, 8 Oct 2020 16:00:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vringh: fix __vringh_iov() when riov and wiov are
 different
Message-ID: <20201008160035-mutt-send-email-mst@kernel.org>
References: <20201008161311.114398-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201008161311.114398-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Oct 08, 2020 at 06:13:11PM +0200, Stefano Garzarella wrote:
> If riov and wiov are both defined and they point to different
> objects, only riov is initialized. If the wiov is not initialized
> by the caller, the function fails returning -EINVAL and printing
> "Readable desc 0x... after writable" error message.
> 
> Let's replace the 'else if' clause with 'if' to initialize both
> riov and wiov if they are not NULL.
> 
> As checkpatch pointed out, we also avoid crashing the kernel
> when riov and wiov are both NULL, replacing BUG() with WARN_ON()
> and returning -EINVAL.
> 
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Can you add more detail please? when does this trigger?

> ---
>  drivers/vhost/vringh.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index e059a9a47cdf..8bd8b403f087 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -284,13 +284,14 @@ __vringh_iov(struct vringh *vrh, u16 i,
>  	desc_max = vrh->vring.num;
>  	up_next = -1;
>  
> +	/* You must want something! */
> +	if (WARN_ON(!riov && !wiov))
> +		return -EINVAL;
> +
>  	if (riov)
>  		riov->i = riov->used = 0;
> -	else if (wiov)
> +	if (wiov)
>  		wiov->i = wiov->used = 0;
> -	else
> -		/* You must want something! */
> -		BUG();
>  
>  	for (;;) {
>  		void *addr;
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
