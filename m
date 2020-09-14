Return-Path: <SRS0=alD2=CX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756EC2D0A7
	for <virtualization@archiver.kernel.org>; Mon, 14 Sep 2020 02:42:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB80217BA
	for <virtualization@archiver.kernel.org>; Mon, 14 Sep 2020 02:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRlZ0BW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB80217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE1B3867FD;
	Mon, 14 Sep 2020 02:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2XDXOmaNY86; Mon, 14 Sep 2020 02:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 055CE867FE;
	Mon, 14 Sep 2020 02:42:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0C4EC0864;
	Mon, 14 Sep 2020 02:42:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FBB0C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 02:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 52DD985C19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 02:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xRZQjy_v9Jla
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 02:42:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E54FC85C06
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 02:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600051340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAara/ChDatzgfsJw1KVRRZSOmBMiVP7kGi1yosi4Xw=;
 b=HRlZ0BW++QJigQqTe2SISXhqvQwH5C7pbmSnnPBCG6SJvocbGLghunF7RKeEMMrc5JbpY7
 Y+sCF4cuf1j3cLuGTZuk/5iYCZL2n+JMWDOIKUKVMmkIvCOZTbtalakk8PLKv/Wzfh+3PM
 MtVaTJtW2VabgNEtLw0ukAmEHrfFNNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-PMEHTvPYNtivp0j5MCgq1g-1; Sun, 13 Sep 2020 22:42:16 -0400
X-MC-Unique: PMEHTvPYNtivp0j5MCgq1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 729CE1074658;
 Mon, 14 Sep 2020 02:42:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 674AE60C87;
 Mon, 14 Sep 2020 02:42:15 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4CED7180BACB;
 Mon, 14 Sep 2020 02:42:15 +0000 (UTC)
Date: Sun, 13 Sep 2020 22:42:15 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Li Wang <li.wang@windriver.com>
Message-ID: <1199326218.16921082.1600051335160.JavaMail.zimbra@redhat.com>
In-Reply-To: <1599836979-4950-1-git-send-email-li.wang@windriver.com>
References: <1599836979-4950-1-git-send-email-li.wang@windriver.com>
Subject: Re: [PATCH] vhost: reduce stack usage in log_used
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.2]
Thread-Topic: vhost: reduce stack usage in log_used
Thread-Index: s9yTJ0ICAZlN+4H+zWFH+IIKdn+BDA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
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



----- Original Message -----
> Fix the warning: [-Werror=-Wframe-larger-than=]
> 
> drivers/vhost/vhost.c: In function log_used:
> drivers/vhost/vhost.c:1906:1:
> warning: the frame size of 1040 bytes is larger than 1024 bytes
> 
> Signed-off-by: Li Wang <li.wang@windriver.com>
> ---
>  drivers/vhost/vhost.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b45519c..41769de 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1884,25 +1884,31 @@ static int log_write_hva(struct vhost_virtqueue *vq,
> u64 hva, u64 len)
>  
>  static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>  {
> -	struct iovec iov[64];
> +	struct iovec *iov;
>  	int i, ret;
>  
>  	if (!vq->iotlb)
>  		return log_write(vq->log_base, vq->log_addr + used_offset, len);
>  
> +	iov = kcalloc(64, sizeof(*iov), GFP_KERNEL);
> +	if (!iov)
> +		return -ENOMEM;

Let's preallocate it in e.g vhost_net_open().

We don't want to fail the log due to -ENOMEM.

Thanks

> +
>  	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
>  			     len, iov, 64, VHOST_ACCESS_WO);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	for (i = 0; i < ret; i++) {
>  		ret = log_write_hva(vq,	(uintptr_t)iov[i].iov_base,
>  				    iov[i].iov_len);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	}
>  
> -	return 0;
> +out:
> +	kfree(iov);
> +	return ret;
>  }
>  
>  int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> --
> 2.7.4
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
