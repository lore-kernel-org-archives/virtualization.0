Return-Path: <SRS0=5vFd=ER=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA2C388F9
	for <virtualization@archiver.kernel.org>; Wed, 11 Nov 2020 10:50:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A109F2072C
	for <virtualization@archiver.kernel.org>; Wed, 11 Nov 2020 10:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnvTuVK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A109F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2BBC886812;
	Wed, 11 Nov 2020 10:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0JpsRqldShL; Wed, 11 Nov 2020 10:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7948F867E3;
	Wed, 11 Nov 2020 10:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70AEEC088B;
	Wed, 11 Nov 2020 10:50:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AE2C016F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 10:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1830F228EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 10:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8DmY90bovBlp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 10:50:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id EB44C2000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605091838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnA7XsiGSJFXhW6YNgCg1O0O0+tMAkowMzr0RmATALo=;
 b=ZnvTuVK5FsVtsj2ls3L/0j1BBP2vJyBJjMhgaPFm6y6lcyHGhJ2JGCo0xgQ+RR4vcgHZdq
 wB/sdqf4X/BbGI5m4qwy+vBkYecNF0kf9GjMQaiA9cHHtY4ne8deTWlDNNHHgzkIaCPiPg
 gF1Z1MWx7XWKB0d/hyLmtOyppTGU6NE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-_Q4qQqbgMUO4s8pTj31Wrw-1; Wed, 11 Nov 2020 05:50:36 -0500
X-MC-Unique: _Q4qQqbgMUO4s8pTj31Wrw-1
Received: by mail-wr1-f69.google.com with SMTP id y2so464988wrl.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 02:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mnA7XsiGSJFXhW6YNgCg1O0O0+tMAkowMzr0RmATALo=;
 b=OIXLEhhzKl96O9wRCG2QiBLyxkALWotexkfKpBkjVdOPoRCUwy6xgLve7D81WqTBig
 iZumraiR6opCfkncLq5xfLl9L1342kzLA8dPi60DDR4srDAYam+eHJsCh8aZGKMSe5xJ
 pgnuxKMQMCEaleyHqb6aFz/o+N4XbQiS/VpZt++c/sQ75WnAZeL2FHhqXzIEFEim4tGo
 cM3eE4ee5t/hdq1IjtzyDt2qpCEJw6B7AJxMUjE4hWY0tr7bupCVfpnEEHywzExlVgY5
 L8GrlpEDFf54eoiWovt1GlRNhlSZEHmmTO0rn3T01KzPOfSHddLiIsRavuH8unlPY1Z9
 mosQ==
X-Gm-Message-State: AOAM531sWTYJePeyTCHhsbog5ztAVuN2REHsdgLHQlPCOCOq+RrSgxx5
 egXM0iPn5cNNtZmOwjlEUVwhVF2Mpf2DiHI/OCc+JHcRwa/S13BGpUVy6//yh1zZ9+4Qhcrb77r
 nQNGSPuNg2W37m+Q1le6N5HINMAC5xjUdFmWmp+hPtQ==
X-Received: by 2002:adf:eeca:: with SMTP id a10mr24970193wrp.186.1605091835504; 
 Wed, 11 Nov 2020 02:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxz4TPJxgCHN7vv+R3d7jzN9KDvG9vgiS4za2+hlcdJRS27vg4GofYWp6iFMLk0C1lnkV/R+w==
X-Received: by 2002:adf:eeca:: with SMTP id a10mr24970172wrp.186.1605091835295; 
 Wed, 11 Nov 2020 02:50:35 -0800 (PST)
Received: from steredhat (host-79-47-126-226.retail.telecomitalia.it.
 [79.47.126.226])
 by smtp.gmail.com with ESMTPSA id p4sm2017826wrm.51.2020.11.11.02.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 02:50:34 -0800 (PST)
Date: Wed, 11 Nov 2020 11:50:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] vhost_vdpa: switch to vmemdup_user()
Message-ID: <20201111105031.mtdbvt7grkxeuwn4@steredhat>
References: <1605057288-60400-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1605057288-60400-1-git-send-email-tiantao6@hisilicon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 11, 2020 at 09:14:48AM +0800, Tian Tao wrote:
>Replace opencoded alloc and copy with vmemdup_user()
>
>Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>---
> drivers/vhost/vdpa.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 2754f30..4c39583 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -245,14 +245,10 @@ static long vhost_vdpa_set_config(struct vhost_vdpa *v,
> 		return -EFAULT;
> 	if (vhost_vdpa_config_validate(v, &config))
> 		return -EINVAL;
>-	buf = kvzalloc(config.len, GFP_KERNEL);
>-	if (!buf)
>-		return -ENOMEM;
>
>-	if (copy_from_user(buf, c->buf, config.len)) {
>-		kvfree(buf);
>-		return -EFAULT;
>-	}
>+	buf = vmemdup_user(c->buf, config.len);
>+	if (IS_ERR(buf))
>+		return PTR_ERR(buf);
>
> 	ops->set_config(vdpa, config.off, buf, config.len);
>
>-- 
>2.7.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
