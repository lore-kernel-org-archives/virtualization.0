Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE03C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:51:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9894B6023C
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9894B6023C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C54543069;
	Tue,  2 Mar 2021 09:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aOa6kLO3C4X9; Tue,  2 Mar 2021 09:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5295B43083;
	Tue,  2 Mar 2021 09:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BDF9C000B;
	Tue,  2 Mar 2021 09:51:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9E68C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89AE2430A0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-lWSxsRzkYY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDF2143083
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614678688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taBd6uLnFKceyekg9FzDQkJCAu7LLfUBn3MWlZnlhHs=;
 b=TRo3OewXdMJMAQxrGAYGYISDSDtd8leYQnX4LLxTihOXio+Ko8fWa+Bulfhql2mzihJcNq
 CW/KSd2q7ZeRgraPg2CNxzXkV6jNPANkImcn/QIhIpI3PB5u+0WO8niZEXXeEUBKl/tdGj
 bGIoGBqth7WGxqbeKzme8fpUhzfOXTQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-scY34ZUSOQS8KImin1HaLw-1; Tue, 02 Mar 2021 04:51:27 -0500
X-MC-Unique: scY34ZUSOQS8KImin1HaLw-1
Received: by mail-ej1-f72.google.com with SMTP id w22so8274965ejv.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 01:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=taBd6uLnFKceyekg9FzDQkJCAu7LLfUBn3MWlZnlhHs=;
 b=CXXW5bnzFsflLWrojY8UEAvr6UtLx6RrRfdcvd5V3JLzc5DlnVkdGlYaY8SO2AQIhx
 30HwlZJMr2c6A8WNqiFy5/ohLTDkxa9zAy6R5r/mp09qaGNk0Q3NN7iuDXk7CpAGRuji
 UKiPAScXDPh2YqzTy1ncjHJ0O7wc/hfdhhkeeVOg3rAuXq5UfmlzcVRpnJsHq7e85QXj
 rSrp1jGNPoqqq6SYqAzCPrZdGkp/6iuJ1iY8J5rRRuwMpfAy/w/ezbMjlKO7hrY3J5ac
 Rep1ckYLml5j9ISk8PrW0An2DvCQN7yUiWQUzuwiENnhGUo0EULaDB3LRuWwvSlSihnB
 qhiQ==
X-Gm-Message-State: AOAM531U+AxggwlvBSXhriYpai+SXcL+6oqjrAHOL2uLTSHBISrJDmtd
 985h3sBUpuEYG2uD/0W7hdlizdkpHnLjbXnWm+KHWb1MdUvLak9oaBm9fAz1NRhU5iW/IAk/aQn
 27cki4JcWLSgQALObzR6olrgdCzS6aF8o5pCwuBxvmg==
X-Received: by 2002:a50:e183:: with SMTP id k3mr20106120edl.45.1614678686032; 
 Tue, 02 Mar 2021 01:51:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVGIo5XKn8nNvUOxG42+dGS0VnbP0nQwS9Jyziu/Fx8Ig8UChySv7eaRLgbNCVP6IBt5vl/w==
X-Received: by 2002:a50:e183:: with SMTP id k3mr20106110edl.45.1614678685903; 
 Tue, 02 Mar 2021 01:51:25 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id v11sm17608252eds.14.2021.03.02.01.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:51:25 -0800 (PST)
Date: Tue, 2 Mar 2021 04:51:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: honor CAP_IPC_LOCK
Message-ID: <20210302044918-mutt-send-email-mst@kernel.org>
References: <20210302091418.7226-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210302091418.7226-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Tue, Mar 02, 2021 at 04:14:18AM -0500, Jason Wang wrote:
> When CAP_IPC_LOCK is set we should not check locked memory against
> rlimit as what has been implemented in mlock().
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Indeed and it's not just mlock.

Documentation/admin-guide/perf-security.rst:

RLIMIT_MEMLOCK and perf_event_mlock_kb resource constraints are ignored
for processes with the CAP_IPC_LOCK capability.

and let's add a Fixes: tag?

> ---
>  drivers/vhost/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ef688c8c0e0e..e93572e2e344 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -638,7 +638,8 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>  	mmap_read_lock(dev->mm);
>  
>  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> +	if (!capable(CAP_IPC_LOCK) &&
> +	    (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit)) {
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
