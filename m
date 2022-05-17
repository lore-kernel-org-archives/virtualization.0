Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74174C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 14:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AB5B84011;
	Tue, 17 May 2022 14:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_akBGaJCc3o; Tue, 17 May 2022 14:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D5BA84005;
	Tue, 17 May 2022 14:11:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D33C002D;
	Tue, 17 May 2022 14:11:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 000C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F122A611A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OEhc17gQ_WVd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4737560ACC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652796678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taJmMXDueR04kuIvyQM+QqedCDrH7VgNtbzgSVHGOvA=;
 b=OikcN1NkWzAyzzrG8vZUu6EiQyrGOJ9/BngafDWGPbatzmA4scaJFNGxSu9P5XiRgI5LZW
 3kXqnOtTFqxldowKpopqOxBXxWqhIKn63JOn4EnaifKnhmi6Pd71DjJRAySRavrzp+oQcq
 akuRfN3JygxbWGhQ97MlpS+czYHBgyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-Xwsr-qyYNOOPslXlWV7PFA-1; Tue, 17 May 2022 10:11:17 -0400
X-MC-Unique: Xwsr-qyYNOOPslXlWV7PFA-1
Received: by mail-wr1-f70.google.com with SMTP id
 w20-20020adfd1b4000000b0020cbb4347e6so4747224wrc.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 07:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=taJmMXDueR04kuIvyQM+QqedCDrH7VgNtbzgSVHGOvA=;
 b=5bsK66hzEbwrcAP++fWngqP3z79gszH3tfDyc4SyM1Swz5CUZhVQIE13k7Bx4bcqH1
 nIOBxSux4B30BiIOrPCY0RAwzZzruc/bAIPWgwoG+O56y/F2a583SGWW9dQQRDA2jSIY
 Sj0Tpn5wj8vKj1Lf+eQNZL8pyHHGDjtwOMY0uXFaIVXSMykY2XSGF2FnSfHwYq/mfWVs
 o4fMDzJ73eD+UUZ6b9OOWSHs+WE/GVSKsT4y5OOmxUWjVx6gRMXtUUSzsL2udc0w7d40
 UfnE6y+2eDLvKqZwpOu2imEYgU/fJJJf6lCp/P+drWBS4O2G86a1vva1E10RSYgpYBFn
 HHYg==
X-Gm-Message-State: AOAM533gdsjhrxkKYrnQBQrdK7pTTQZLyN/7+Yq+Q7/Dw6EIPwQCVtQz
 4x59GzVWNE6tU7OcwqnS1fGXHa4jl06CSCrmws2LIgVQoH0BWLXkqfFsSFFebSGpxIVEShRuo5b
 5Uhobt/7LhCtvTrunXWva+6rjKF8+BtSnYAHEyawY1g==
X-Received: by 2002:a5d:678c:0:b0:20d:e70:f73b with SMTP id
 v12-20020a5d678c000000b0020d0e70f73bmr6451088wru.411.1652796675842; 
 Tue, 17 May 2022 07:11:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBaleYfiImA0MXrWdsE93dz81GeDWub3UFmujnHRPChMZQ/z6WlGGfq4lT3NhwpsfqRvOcJw==
X-Received: by 2002:a5d:678c:0:b0:20d:e70:f73b with SMTP id
 v12-20020a5d678c000000b0020d0e70f73bmr6451064wru.411.1652796675587; 
 Tue, 17 May 2022 07:11:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c511700b0039456c00ba7sm2777279wms.1.2022.05.17.07.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 07:11:14 -0700 (PDT)
Date: Tue, 17 May 2022 16:11:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 4/8] vhost_test: remove vhost_test_flush_vq()
Message-ID: <20220517141109.ycngu2unpi4rdzqg@sgarzare-redhat>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-5-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220515202922.174066-5-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, arbn@yandex-team.com,
 stefanha@redhat.com, mst@redhat.com
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

On Sun, May 15, 2022 at 03:29:18PM -0500, Mike Christie wrote:
>From: Andrey Ryabinin <arbn@yandex-team.com>
>
>vhost_test_flush_vq() just a simple wrapper around vhost_work_dev_flush()
>which seems have no value. It's just easier to call vhost_work_dev_flush()
>directly. Besides there is no point in obtaining vhost_dev pointer
>via 'n->vqs[index].poll.dev' while we can just use &n->dev.
>It's the same pointers, see vhost_test_open()/vhost_dev_init().
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/test.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
>index f0ac9e35f5d6..837148d0a6a8 100644
>--- a/drivers/vhost/test.c
>+++ b/drivers/vhost/test.c
>@@ -144,14 +144,9 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
> 	*privatep = vhost_test_stop_vq(n, n->vqs + VHOST_TEST_VQ);
> }
>
>-static void vhost_test_flush_vq(struct vhost_test *n, int index)
>-{
>-	vhost_work_dev_flush(n->vqs[index].poll.dev);
>-}
>-
> static void vhost_test_flush(struct vhost_test *n)
> {
>-	vhost_test_flush_vq(n, VHOST_TEST_VQ);
>+	vhost_work_dev_flush(&n->dev);
> }
>
> static int vhost_test_release(struct inode *inode, struct file *f)
>@@ -210,7 +205,7 @@ static long vhost_test_run(struct vhost_test *n, int test)
> 			goto err;
>
> 		if (oldpriv) {
>-			vhost_test_flush_vq(n, index);
>+			vhost_test_flush(n, index);
                                             ^
Should we remove the `index` parameter?

> 		}
> 	}
>
>@@ -303,7 +298,7 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
> 	mutex_unlock(&vq->mutex);
>
> 	if (enable) {
>-		vhost_test_flush_vq(n, index);
>+		vhost_test_flush(n);
> 	}
>
> 	mutex_unlock(&n->dev.mutex);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
