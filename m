Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F978C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:45:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F1120738
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0of7bpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F1120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E52686667;
	Tue, 29 Sep 2020 07:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLsEsURmffn4; Tue, 29 Sep 2020 07:45:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 45BF086566;
	Tue, 29 Sep 2020 07:45:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C836C0890;
	Tue, 29 Sep 2020 07:45:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A552DC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B99A86566
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1h3PiK-9ASZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:45:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C93B085F6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:45:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601365537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+9sAOtKEe29ld0FF+l1aCaoyNACbHHQtUzJc8aMjXk=;
 b=d0of7bpiOvydH/ZNb1+LwoM7gzq1hcJTQWBsLSA6uuiubGmsS4gi+hJ9JL5TxYuuJX/f29
 pFv5L5J3MAWDwYx+4cQD92d6OSuZj1dxTF2YJff2+OkMfq6JNG3u/atWri1RuqXEwI3sBZ
 gh6l9E8I2Kbq9x1h/MGC2+l8qAkjoNg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-X--4BxUIMwOsoV_PPZA4KQ-1; Tue, 29 Sep 2020 03:45:33 -0400
X-MC-Unique: X--4BxUIMwOsoV_PPZA4KQ-1
Received: by mail-wm1-f71.google.com with SMTP id m25so1490806wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1+9sAOtKEe29ld0FF+l1aCaoyNACbHHQtUzJc8aMjXk=;
 b=C+V6En24vQvcXfaB4dFWkWOC8sgIB+lP0OlEjOG9hzyp60WogH03VQ1vqEEYZoiG7x
 Hkz/O9Veu6CwctwrLRdpYxq5rDTYoViBYh6882B2jMWCboroKDcRtlnqrWYlYLC1ZPh1
 Vqsm7gR6xoBI8mule8EG2bfcUj2DjXubfLPeX8xF22QnRED/rOg4FxQV/F5nMyimmGfl
 dtdcGpiwE9xDv/6JtWU4yyAZL0omRvOu/aW8DVqMi7skele/ECbz8LC1Gky3rTBHovfV
 ebKM9hrrl43CigsXZd1lWnySHFqwAzILALnyUqUlLLn40QvnqrXXbste7zvkHFxDSwti
 mR+Q==
X-Gm-Message-State: AOAM533++HhP5rJazdomKjJ/siqUTfY6cpeg7h68lin93xqTjRAEPx1N
 RrHmBGcmBFbJ8Glo5+xRTb5xORokUXL1NCOqnGXYE/GfmGHdOyKjDKknkjbv/DpiDz08+z7H7Mg
 B9z0KI0z5ZaM9DXsba8FZ93E4Mscym5+zH9Ex6EbgSw==
X-Received: by 2002:a1c:1bd1:: with SMTP id b200mr3149917wmb.171.1601365531986; 
 Tue, 29 Sep 2020 00:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVXyN8T+1pYGTvhFLvLpxttwSL6WyYHVFkUGy5/+wp03N2mwSfIfnBECxhR1qh6UyzNKksMQ==
X-Received: by 2002:a1c:1bd1:: with SMTP id b200mr3149899wmb.171.1601365531746; 
 Tue, 29 Sep 2020 00:45:31 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z11sm4729299wru.88.2020.09.29.00.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:45:30 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vhost: Don't call vq_access_ok() when using IOTLB
Message-ID: <20200929034358-mutt-send-email-mst@kernel.org>
References: <160129650442.480158.12085353517983890660.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160129650442.480158.12085353517983890660.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
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

On Mon, Sep 28, 2020 at 02:35:04PM +0200, Greg Kurz wrote:
> When the IOTLB device is enabled, the vring addresses we get from
> userspace are GIOVAs. It is thus wrong to pass them to vq_access_ok()
> which only takes HVAs. The IOTLB map is likely empty at this stage,
> so there isn't much that can be done with these GIOVAs. Access validation
> will be performed at IOTLB prefetch time anyway.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1883084
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Cc: jasowang@redhat.com
> CC: stable@vger.kernel.org # 4.14+
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  drivers/vhost/vhost.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b45519ca66a7..6296e33df31d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1509,7 +1509,10 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  	 * If it is not, we don't as size might not have been setup.
>  	 * We will verify when backend is configured. */
>  	if (vq->private_data) {
> -		if (!vq_access_ok(vq, vq->num,
> +		/* If an IOTLB device is present, the vring addresses are
> +		 * GIOVAs. Access will be validated during IOTLB prefetch. */
> +		if (!vq->iotlb &&
> +		    !vq_access_ok(vq, vq->num,
>  			(void __user *)(unsigned long)a.desc_user_addr,
>  			(void __user *)(unsigned long)a.avail_user_addr,
>  			(void __user *)(unsigned long)a.used_user_addr))

OK I think you are right here.

Jason, can you ack pls?

However, I think a cleaner way to check this is by moving
the following check from vhost_vq_access_ok to vq_access_ok:

        /* Access validation occurs at prefetch time with IOTLB */
        if (vq->iotlb)
                return true;


> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
