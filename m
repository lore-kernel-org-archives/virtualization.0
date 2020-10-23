Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCFC388F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:34:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4360620E65
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCRqLcHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4360620E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9575887910;
	Fri, 23 Oct 2020 15:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4Vw5Vr4F0UQ; Fri, 23 Oct 2020 15:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02CA4878FE;
	Fri, 23 Oct 2020 15:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1F6CC088B;
	Fri, 23 Oct 2020 15:34:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56AA9C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 51D1486B04
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QQVoLbWE6WJV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:34:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7C89A86A37
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADAkD04qBn0B56sR0AT6lBpOwDqugN8IZrafwTxz76g=;
 b=HCRqLcHW4q7ojaBs/4C0/84Dp2HbLv7HMxp7zvjs/yIkjeIR/qlZft4/myReBLuvvvLo5t
 /5NiC/INXHJvr5/SKWTKPSagnwlWlgyIK7bOcxhMv1fK5CbHNpHpXJlF/gLs5WOvF8zxoW
 AS40EkvGNfrvW3+/jbSYyuo5X8EXxdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-6fLU9xqyN5Wrrt4Zl_bywg-1; Fri, 23 Oct 2020 11:34:33 -0400
X-MC-Unique: 6fLU9xqyN5Wrrt4Zl_bywg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB22818B9F09;
 Fri, 23 Oct 2020 15:34:31 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C41070597;
 Fri, 23 Oct 2020 15:34:28 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:34:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net] vhost_vdpa: Return -EFUALT if copy_from_user() fails
Message-ID: <20201023113326-mutt-send-email-mst@kernel.org>
References: <20201023120853.GI282278@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201023120853.GI282278@mwanda>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org
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

On Fri, Oct 23, 2020 at 03:08:53PM +0300, Dan Carpenter wrote:
> The copy_to/from_user() functions return the number of bytes which we
> weren't able to copy but the ioctl should return -EFAULT if they fail.
> 
> Fixes: a127c5bbb6a8 ("vhost-vdpa: fix backend feature ioctls")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Needed for stable I guess.

> ---
>  drivers/vhost/vdpa.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62a9bb0efc55..c94a97b6bd6d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -428,12 +428,11 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  	void __user *argp = (void __user *)arg;
>  	u64 __user *featurep = argp;
>  	u64 features;
> -	long r;
> +	long r = 0;
>  
>  	if (cmd == VHOST_SET_BACKEND_FEATURES) {
> -		r = copy_from_user(&features, featurep, sizeof(features));
> -		if (r)
> -			return r;
> +		if (copy_from_user(&features, featurep, sizeof(features)))
> +			return -EFAULT;
>  		if (features & ~VHOST_VDPA_BACKEND_FEATURES)
>  			return -EOPNOTSUPP;
>  		vhost_set_backend_features(&v->vdev, features);
> @@ -476,7 +475,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>  		break;
>  	case VHOST_GET_BACKEND_FEATURES:
>  		features = VHOST_VDPA_BACKEND_FEATURES;
> -		r = copy_to_user(featurep, &features, sizeof(features));
> +		if (copy_to_user(featurep, &features, sizeof(features)))
> +			r = -EFAULT;
>  		break;
>  	default:
>  		r = vhost_dev_ioctl(&v->vdev, cmd, argp);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
