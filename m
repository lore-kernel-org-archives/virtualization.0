Return-Path: <SRS0=a9Wa=EC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7916C388F9
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 15:28:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A1C22202
	for <virtualization@archiver.kernel.org>; Tue, 27 Oct 2020 15:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StVGGlOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A1C22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77AA42050A;
	Tue, 27 Oct 2020 15:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jCS-5fNFabxS; Tue, 27 Oct 2020 15:28:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E34172048A;
	Tue, 27 Oct 2020 15:28:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A55C0859;
	Tue, 27 Oct 2020 15:28:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4980FC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 15:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4570887286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 15:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8ub7DOCy5Y2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 15:28:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 91AF687031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603812533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mlWO+8V1OcYguip2KBsMhYWBSFJwL/+zUDmEZaIbfJ4=;
 b=StVGGlOwtyvhP/3laWCb2RdgGghjqmvxjiuHFj/uDWwEjrCRxo7uHo6sUFMQvND77hfAIR
 WT+QPVvEaaNvCs0H1I+oBxeYYl4txCa4sKLUKeeaDhXUa9wrQBJu873e7nvCjUgmu/lwoJ
 vqz4OB+guTB2fYykjJQ83Q6BhRTKL1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-h0qCXRVPPjKAyKByW_F01A-1; Tue, 27 Oct 2020 11:28:48 -0400
X-MC-Unique: h0qCXRVPPjKAyKByW_F01A-1
Received: by mail-wm1-f69.google.com with SMTP id s25so710919wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 08:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mlWO+8V1OcYguip2KBsMhYWBSFJwL/+zUDmEZaIbfJ4=;
 b=FNBMjoHp5yI1rn5bd8PgC1msrSSXF3yMxKqSJAehRlOh/jcOx4KMY+tHGbR8m2bD8K
 33iR+sdaf3gRHRZtBBCnnS/GPR0NOz5Vvtbnb34InXOwjcffFNutspved/EqW1AwwDlM
 Ac9ErrrpN4Dr8AaqVrKGLylWi8IhUnB3NM9xK0ImfM4yL/jggYRMTADhyU3VEbuLEeE2
 nThZ+SLaDCqSR084SWUjB4GM/Vcp9zB4sMhb67SUxnVenBtyhSXAj1BYvtXETsI+b+1c
 C16LH8/3p7BT4ssOf8A2bWHmEoP18jdrHFfZ/o/u/4nFVB2xdR4diaytXG3Yq3GSixFW
 JBiw==
X-Gm-Message-State: AOAM533hHl4mFrg1iGCWLMv77Vp6Uy/5Qjm1VO9zANFLhzp1vhSsY4S8
 YfYg0thpBA8syWq9U0j2cAyyC4w0EjKbD1PJ7Tt5ttXxpB1wAwzsbpi1tG3rHtnt50UXHkwKSvq
 r5zJ+gEeWeQHaLrUpG89djkV83UGdQQ051Hi809byDg==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr3177554wms.182.1603812526986; 
 Tue, 27 Oct 2020 08:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuH3n7lQ9eR5dnqf6yc1oFeHmyleXhbTjubsRyj6zs3Jak/y/oaUl12gqM18qHQ8tFGKD6AA==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr3177537wms.182.1603812526789; 
 Tue, 27 Oct 2020 08:28:46 -0700 (PDT)
Received: from redhat.com (bzq-109-65-21-184.red.bezeqint.net. [109.65.21.184])
 by smtp.gmail.com with ESMTPSA id 3sm2370433wmd.19.2020.10.27.08.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 08:28:45 -0700 (PDT)
Date: Tue, 27 Oct 2020 11:28:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 3/8] vhost: vringh: use krealloc_array()
Message-ID: <20201027112607-mutt-send-email-mst@kernel.org>
References: <20201027121725.24660-1-brgl@bgdev.pl>
 <20201027121725.24660-4-brgl@bgdev.pl>
MIME-Version: 1.0
In-Reply-To: <20201027121725.24660-4-brgl@bgdev.pl>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo@padovan.org>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 David Rientjes <rientjes@google.com>,
 virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org,
 Robert Richter <rric@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-gpio@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, James Morse <james.morse@arm.com>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Tue, Oct 27, 2020 at 01:17:20PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Use the helper that checks for overflows internally instead of manually
> calculating the size of the new array.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

No problem with the patch, it does introduce some symmetry in the code.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/vhost/vringh.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 8bd8b403f087..08a0e1c842df 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -198,7 +198,8 @@ static int resize_iovec(struct vringh_kiov *iov, gfp_t gfp)
>  
>  	flag = (iov->max_num & VRINGH_IOV_ALLOCATED);
>  	if (flag)
> -		new = krealloc(iov->iov, new_num * sizeof(struct iovec), gfp);
> +		new = krealloc_array(iov->iov, new_num,
> +				     sizeof(struct iovec), gfp);
>  	else {
>  		new = kmalloc_array(new_num, sizeof(struct iovec), gfp);
>  		if (new) {
> -- 
> 2.29.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
