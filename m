Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC1FC2D0A8
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60C52071E
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtCh74j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60C52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 762D285540;
	Mon, 28 Sep 2020 19:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ks1YMgEI0EpY; Mon, 28 Sep 2020 19:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C021E8559F;
	Mon, 28 Sep 2020 19:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8095C016F;
	Mon, 28 Sep 2020 19:29:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43A60C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2BDF186F6D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6kYOWXFnimn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:29:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEB6186F95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:29:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601321374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7R0uSUBVOBC3ELw6r6XW5F6NVJS5n7iWxx/t8OjrN0=;
 b=NtCh74j01vL4lh6YzeGWLIZV10AV+V6BGaKCulrCuDDmAf+4xeSk3xHk0fOU1vjjiX+LIC
 hPwJmrrjvDzO6VMaxGy5+zWCLwieICp9vi37VXhAFJwlQNuf5uYDNsc+OR/bye5I96+Xz7
 IXh1BMOb8BM0/8MJ+22ilqrniMUK0wo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-S_qb1WsJNhefJG7oy5-A0w-1; Mon, 28 Sep 2020 15:29:30 -0400
X-MC-Unique: S_qb1WsJNhefJG7oy5-A0w-1
Received: by mail-wr1-f70.google.com with SMTP id d9so780189wrv.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 12:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g7R0uSUBVOBC3ELw6r6XW5F6NVJS5n7iWxx/t8OjrN0=;
 b=s9xbP6Uok0G+n7b+uXXflkR8mHaVkiWI2T+KEV7oFMJrFi9qCDXPblTV8h02Kr+XAx
 O2mCHHMn2S0YgmtPinLxkwVu4RU5z5lQ1w8HY2ZDd++2JrjRTJXVFMVDQl1tNKRmoJmz
 8eR5zkmPmq29Zng+dtF5qD5u8gENFa2ARbBLSb6p5/3w6R1RYNBgau0mAKqz37tX6LKh
 nLY6hY2EOEg5npk1gEd0uWxy1IR4sdps+ivWi3srleaT6LFTqKb0XNTJQmscTjpqxpbL
 LceZS6gkqfI9XkoXxtR+47S6nMpp2z40aQKeu6VYmWSP7vK8GveOMKzWN4TAVdtCqNSM
 haRw==
X-Gm-Message-State: AOAM530rnOKzPMXf09RhlCMElmi85yFi0VJfTUU5hUvvkA6f7jDN+ZAQ
 ndMaBlT0/355RzQoZBZLHFRWQlUbDyu+cNq8y2IZ+cb0mVp3qzxGH6Ka4SKi8zGo43iE81hGVaT
 mTGCa9KgkmvCziKNaITHGqdtIi8guOyt+rJSB3M0GKA==
X-Received: by 2002:adf:e304:: with SMTP id b4mr27440wrj.141.1601321369186;
 Mon, 28 Sep 2020 12:29:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE21P0wkiAkvryE+2wIqsoKtS+RuwPRqx3bJhGPxwgCgHmMCakq2DNpqAYhl0gF/KFYyDoXA==
X-Received: by 2002:adf:e304:: with SMTP id b4mr27421wrj.141.1601321368968;
 Mon, 28 Sep 2020 12:29:28 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id n10sm2662427wmk.7.2020.09.28.12.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 12:29:28 -0700 (PDT)
Date: Mon, 28 Sep 2020 15:29:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vhost: Don't call vq_access_ok() when using IOTLB
Message-ID: <20200928152859-mutt-send-email-mst@kernel.org>
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

Hmm I was sure the addresses are HVAs in any case ...
Jason?

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
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
