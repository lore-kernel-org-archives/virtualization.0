Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF381D279C
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802733; cv=none; b=cHesPgVob6kVZmh7bVOxGmsGHAM0Hiv5ZBEWtOcd1/HrqNB0DS/l2D5J2F6cL9epo/RCw0VhmAklrKeEe23CdnlPgWVvqwGc+LwokMk7fTiiNn7xmNOyQf8tGr/WXErIFWUxfmlNq8oB88CzjThPam+KbFGHwJlaByxHZom5qWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802733; c=relaxed/simple;
	bh=KQQVt8mWQ2a+CSHUo/gXDOQmuOZ+6Zu3LjXHZJJ+4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SBrPra1ZJPR/hhy+xHbf/7fwNjA19CgTsG0Tbuc283v+3ebp7YPPA1NQClKOJz/6+79R+hFB93Nm+X8IiFrBOSkBoTHVQrVN35RxDjS1ZIG8YDAgwsa/1LpyGqN9ucGSuBflXmAWiPP/OfkXuMFDNfD3ROSnSZHGhpN0sLhWLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0358NlA; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0358NlA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80D1040561
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 10:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jB9eI5RNIVql for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 10:32:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4805040524
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4805040524
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K0358NlA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4805040524
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730802728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDkgsC3BrhZ0kyiyirNXj2do+NLwdZ6ZkrR26QPE3ak=;
	b=K0358NlAwxvrd2oIkAFFamyI3lkwvypvTZ4Ue5aqLGCZqfG4jc70Ru1qWqggCed82ms6zj
	3fgl133eQy6rm++JqGWYhLgOlaayr+cZLwsW2X/FgQMmwvY8qI+L73EZ7zVDR+JIn9bfnw
	6BsPmFoj0GPjZ8flR8ENs3nrD8ka/h8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-QY_nhzx_NtiGZ7eIZMadag-1; Tue, 05 Nov 2024 05:32:07 -0500
X-MC-Unique: QY_nhzx_NtiGZ7eIZMadag-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso464408366b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 02:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802726; x=1731407526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDkgsC3BrhZ0kyiyirNXj2do+NLwdZ6ZkrR26QPE3ak=;
        b=cUNAYD+Y/ZbO/AAJgp+Pw5jL85ztT003gDgAg8fibOUQdFH6DNdRsOSoRzjWRleZB0
         FEXvADFdM/J1cF2CnJjHx7mmR0JueHZhprAmBP4hyxqWp68hwkqD2n4lkcIwT7jHdMPY
         IlpgRLMxdZMM9NaDcTq7R5/EY46QklXWfmw5vkAcADjASWh3dAd/TNGe4U85zhALdkaq
         5YYMO9hYUNLykbG3yVsSWelm8ZsfHBtZh44BhNY5blIjmY1CudFhuOd58kB6vEDoJQR7
         A2men4p8p5Z+nIQ1w3OvBAPSWx67R+oRNS7HD7WNSXfOKZu1VI3N1Rh72YCT/V6VOjmI
         ETVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTzTkXUUKOsFh0gPTcMvdinFmecBRgRUI7pPoJqeJB7K+GRu4yVdBEEm6K+fBdizkH5lhDqsflPsWVUtRRKA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwvSKt27FE7lWDkW6dirFRbInpVFob5B5XLrGaeuZ7/LL4K/uFB
	x47XFLYrwvPeeFw1RBh4uOhhlw0WGj2TJvkuw+fNGsmGYzHMCfd2y/tcPkLXm/Z0jY5tvXPujQz
	oGoLFHHODvufe9MMeoEpuET0ywzZTl/i/6EJE1pL+YRjjFOIH3ZWBqFogurM3PqRd3YV0kbf5HD
	vBhFk=
X-Received: by 2002:a17:907:7f14:b0:a9a:6855:1820 with SMTP id a640c23a62f3a-a9e3a5a0357mr2329930266b.15.1730802725691;
        Tue, 05 Nov 2024 02:32:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8pn5mXBYyCXad9NtOusQYg1cDHZEi/qp4dBkevi3rLiuZtladhvA0ngNV6jgn+j+I6cqrUQ==
X-Received: by 2002:a17:907:7f14:b0:a9a:6855:1820 with SMTP id a640c23a62f3a-a9e3a5a0357mr2329924666b.15.1730802724759;
        Tue, 05 Nov 2024 02:32:04 -0800 (PST)
Received: from sgarzare-redhat ([134.0.5.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d5478sm113074066b.45.2024.11.05.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:32:04 -0800 (PST)
Date: Tue, 5 Nov 2024 11:31:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
Message-ID: <6dtic6ld6p6kyzbjjewj4cxkc6h6r5t6y2ztazrgozdanz6gkm@vlj3ubpam6ih>
References: <20241105072642.898710-1-lulu@redhat.com>
 <20241105072642.898710-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 05, 2024 at 03:25:26PM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 15 ++++++++++++++-
> include/uapi/linux/vhost.h |  2 ++
> 2 files changed, 16 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index c17dc01febcc..70c793b63905 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;

I don't know if something is missing in this patch, but I am confused:

`r` is set few lines below...

> 	int i, fd;
>+	bool inherit_owner;
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
...

	/* You must be the owner to do anything else */
	r = vhost_dev_check_owner(d);
	if (r)
		goto done;

So, why we are now initializing it to 0?

>@@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		if (ctx)
> 			eventfd_ctx_put(ctx);
> 		break;
>+	case VHOST_SET_INHERIT_FROM_OWNER:
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d))

And here, how this check can be false, if at the beginning of the
function we call vhost_dev_check_owner()?

Maybe your intention was to add this code before the
`vhost_dev_check_owner()` call, so this should explain why initialize
`r` to 0, but I'm not sure.

>+			break;

Should we return an error (e.g. -EPERM) in this case?

>+
>+		if (copy_from_user(&inherit_owner, argp,
>+				   sizeof(inherit_owner))) {
>+			r = -EFAULT;
>+			break;
>+		}
>+		d->inherit_owner = inherit_owner;
>+		break;
> 	default:
> 		r = -ENOIOCTLCMD;
> 		break;
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1e192038633d 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,6 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+

Please add a documentation here, this is UAPI, so the user should
know what this ioctl does based on the parameter.

Thanks,
Stefano

>+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
> #endif
>-- 
>2.45.0
>

