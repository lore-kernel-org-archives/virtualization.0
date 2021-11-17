Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FF1C433EF
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 13:36:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8546152B
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 13:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA8546152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B69C608A9;
	Wed, 17 Nov 2021 13:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3c8MCgIeklz; Wed, 17 Nov 2021 13:36:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07E05606E6;
	Wed, 17 Nov 2021 13:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE7C5C002E;
	Wed, 17 Nov 2021 13:36:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED8DEC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD31B606A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m1QGyn2Wgnuo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A61760631
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637156192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SK2TdqbjzxRCpSlP0TvvJit4nEgW8bEodm600zd0IYE=;
 b=VZu0PSmTOxJNzpkzKSBDyVM2NUsd1GNodCDAu/I5axo7kaaQ3YI6bIu1LZzMUrJVN6ar8v
 FndWqvkPvkgLhRTe7BzAx9/v5DDy8R7hbZrLt2xmKOHjqztfPaVxXkvl06qkErfN6GW7tm
 Qa5YYS282CQEJ9q8olbnqkRmGprPkCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jUkCIIuUOKu50c2c93vElg-1; Wed, 17 Nov 2021 08:36:31 -0500
X-MC-Unique: jUkCIIuUOKu50c2c93vElg-1
Received: by mail-wr1-f70.google.com with SMTP id
 r12-20020adfdc8c000000b0017d703c07c0so378515wrj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 05:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SK2TdqbjzxRCpSlP0TvvJit4nEgW8bEodm600zd0IYE=;
 b=4Bu1py4xblE0JRdKQM8+nzk74g7BUgbsvYVGSoejNNd2+P0KXVV+cave5KLTVGaVB6
 2tt3YyGmuefyUkzQk2w/6PQrOW3ttku4pjg0fx1iYp4adxFMl7JVjZ+XHF0UINh01//Y
 xYkqokYE64A3XLEErd39SaaAOLmVV8RJK3h7sPk7wx21Sa7sT+MKQMKy6kVNyGs/7lhb
 NiJ9r3glq58LQk3N+Z8wAk0OFImgJyUz6i1sehVWJwwnnrcFsyKINzcW4SFJvwQSQQD8
 NnewadfoBPA7QuPGKi7J0v7bIBdRsShME2tUGa0o1GQKUg7re1GqGfMKW3woP02yIPFA
 aCag==
X-Gm-Message-State: AOAM532zStd3gMO1sBNsuLfMGkWpG6XXOAWG/HrzGnF+jRhtAXUG1nSL
 K4lfHdj0swngtYDCD/iRrBVg9rPPEJiE51W+Z1htGCTltVMi2F1THne07Imt5hcms8OSypriYHo
 NK9Z8EdSQHPLQTIqfLyakRWtNrzRvJlqfyw0eLW+/aA==
X-Received: by 2002:a05:6000:1564:: with SMTP id
 4mr20530955wrz.9.1637156190403; 
 Wed, 17 Nov 2021 05:36:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ0sABF1qvuK58kJUnESp+eHxLFzBz00Rb29xHqk2ffbhesVemAQ2ajo4kl9otsuqOenJyaQ==
X-Received: by 2002:a05:6000:1564:: with SMTP id
 4mr20530928wrz.9.1637156190210; 
 Wed, 17 Nov 2021 05:36:30 -0800 (PST)
Received: from redhat.com ([2.55.155.110])
 by smtp.gmail.com with ESMTPSA id m125sm5479396wmm.39.2021.11.17.05.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 05:36:29 -0800 (PST)
Date: Wed, 17 Nov 2021 08:36:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [RFC PATCH] virtio_balloon: add param to skip adjusting pages
Message-ID: <20211117082747-mutt-send-email-mst@kernel.org>
References: <20211117100634.3012869-1-stevensd@google.com>
MIME-Version: 1.0
In-Reply-To: <20211117100634.3012869-1-stevensd@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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
Message-ID: <20211117133626.4lLjjtHIGSaBM5XnpvkXF_ww-jY2O09jzmnFvbl9FAM@z>

On Wed, Nov 17, 2021 at 07:06:34PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add a module parameters to virtio_balloon to allow specifying whether or
> not the driver should call adjust_managed_page_count. If the parameter
> is set, it overrides the default behavior inferred from the deflate on
> OOM flag. This allows the balloon to operate without changing the amount
> of memory visible to userspace via /proc/meminfo or sysinfo, even on a
> system that cannot set the default on OOM flag.
> 
> The motivation for this patch is to allow userspace to more accurately
> take advantage of virtio_balloon's cooperative memory control on a
> system without the ability to use deflate on OOM. As it stands,
> userspace has no way to know how much memory may be available on such a
> system, which makes tasks such as sizing caches impossible.
> 
> When deflate on OOM is not enabled, the current behavior of the
> virtio_balloon more or less resembles hotplugging individual pages, at
> least from an accounting perspective. This is basically hardcoding the
> requirement that totalram_pages must be available to the guest
> immediately, regardless of what the host does. While that is a valid
> policy, on Linux (which supports memory overcommit) with virtio_balloon
> (which is designed to facilitate overcommit in the host), it is not the
> only possible policy.
> 
> The param added by this patch allows the guest to operate under the
> assumption that pages in the virtio_balloon will generally be made
> available when needed. This assumption may not always hold, but when it
> is violated, the guest will just fall back to the normal mechanisms for
> dealing with overcommitted memory.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> 
> Another option to achieve similar behavior would be to add a new feature
> flag that would be used in conjunction with DEFLATE_ON_OOM to determine
> whether or not adjust_managed_page_count should be called. However, I
> feel that this sort of policy decision is a little outside the scope of
> what the virtio_balloon API deals with.
> 
> ---
>  drivers/virtio/virtio_balloon.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index c22ff0117b46..17dac286899c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -133,6 +133,21 @@ static const struct virtio_device_id id_table[] = {
>  	{ 0 },
>  };
>  
> +static char *adjust_pages = "";
> +module_param(adjust_pages, charp, 0);
> +MODULE_PARM_DESC(adjust_pages, "Whether or not pages in the balloon should be removed from the managed page count");
> +
> +static bool should_adjust_pages(struct virtio_balloon *vb)
> +{
> +	if (!strcmp(adjust_pages, "always"))
> +		return true;
> +	else if (!strcmp(adjust_pages, "never"))
> +		return false;
> +
> +	return !virtio_has_feature(vb->vdev,
> +				   VIRTIO_BALLOON_F_DEFLATE_ON_OOM);
> +}
> +
>  static u32 page_to_balloon_pfn(struct page *page)
>  {
>  	unsigned long pfn = page_to_pfn(page);
> @@ -243,8 +258,7 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		if (should_adjust_pages(vb))
>  			adjust_managed_page_count(page, -1);
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
> @@ -264,8 +278,7 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  	struct page *page, *next;
>  
>  	list_for_each_entry_safe(page, next, pages, lru) {
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		if (should_adjust_pages(vb))
>  			adjust_managed_page_count(page, 1);
>  		list_del(&page->lru);
>  		put_page(page); /* balloon reference */
> @@ -775,7 +788,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	  * managed page count when inflating, we have to fixup the count of
>  	  * both involved zones.
>  	  */
> -	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM) &&
> +	if (should_adjust_pages(vb) &&
>  	    page_zone(page) != page_zone(newpage)) {
>  		adjust_managed_page_count(page, 1);
>  		adjust_managed_page_count(newpage, -1);

A problem here is that the host also cares: IIUC
with VIRTIO_BALLOON_F_STATS_VQ we are sending the info
about page counts to host, changing what the stats
mean.

So I suspect we need a device feature for this at least
to control this aspect.



> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
