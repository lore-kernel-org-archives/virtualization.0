Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978E6C7EE2C
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 12:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0105661631;
	Fri,  2 Jun 2023 12:06:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0105661631
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfG2TzGy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXvE1khfkPuz; Fri,  2 Jun 2023 12:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AB5560C19;
	Fri,  2 Jun 2023 12:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AB5560C19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE8CC0037;
	Fri,  2 Jun 2023 12:06:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADA3BC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84C34426B7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84C34426B7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfG2TzGy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7jMNDytrjNLd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:06:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1ABC426AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1ABC426AB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685707581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r3eog2jJ180dc325mkmwjwsvnRZJ4iih8R1ZCYZSotw=;
 b=VfG2TzGyRPPWFBxHHyrLo7lyl8B6COm32M4E5qjbUqDNMQ3louEodLQmrPo/NMHyy3k/mV
 fAMc43oYFLNBmZe4ciul8AYyhzlgPEzlyrQcM12G3Lev+9IhMMOiHf7IMtBtWUoQox1mZF
 TmZKWuDQgZ5jG5vi3bmxNYDC0wvlOhA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-9DqcgwuFPiqh7d8oYZxVfA-1; Fri, 02 Jun 2023 08:06:20 -0400
X-MC-Unique: 9DqcgwuFPiqh7d8oYZxVfA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f612a1b0fdso11389235e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 05:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685707579; x=1688299579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3eog2jJ180dc325mkmwjwsvnRZJ4iih8R1ZCYZSotw=;
 b=i6nvpmPWmLBbGnKiA8GIvDqqGZ4OtOGZai8kAf3bupka4oOqRZx0cUA8NwP8J0KCMn
 U+0+piiUtHwwZhBEicrUdkzgZ8lBzjWG7prYCwqyW8/gKevBokVh0g/3Mcwxn1OvTHHx
 OhPjGh6xcyjijkpAnFRzQpaUFLpn/iLlhAXWk3R5VW/UX6EkY7Zhz3OgyOsjBVMDbflj
 lZshwFOKmJ45RuaEpYuhXAD6NlJnBCuW/Y6/uCIQwQljyvCzXsPazd1QBYP7Nim/afr3
 1aEovqP3vQ8JHsJXWA5f1z+40dVnFBnsij8U4kcH+xGw71rqKKEH/qMuF3z7rWKcWQ0W
 4srw==
X-Gm-Message-State: AC+VfDwd2xXN0UKQhYNfEixHi/HYdlKY8fS4cx83+HKhf3cTj0QdDcm5
 f1LC4ikbfTHmcZ4LIDTB2DVPDIDZTn7Y4s5eEI9ysXlJdEMwsj+p2Q2cqVjO1/A7udlipbEZDN9
 2eSDzejjGLL1NvAsDYmbxm7IqScCEIxue9Ih9UFex6A==
X-Received: by 2002:a1c:6a15:0:b0:3f6:89e:2716 with SMTP id
 f21-20020a1c6a15000000b003f6089e2716mr1982212wmc.33.1685707579183; 
 Fri, 02 Jun 2023 05:06:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5208596q5G59Oc8rJfdmFIY+/Vvnx/JmMv3Fx9NDu17J8RLqtPrBw/B/kjXPHSnF2ttJ7m/A==
X-Received: by 2002:a1c:6a15:0:b0:3f6:89e:2716 with SMTP id
 f21-20020a1c6a15000000b003f6089e2716mr1982190wmc.33.1685707578902; 
 Fri, 02 Jun 2023 05:06:18 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05600c365400b003f60a446fe5sm1760836wmq.29.2023.06.02.05.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:06:18 -0700 (PDT)
Date: Fri, 2 Jun 2023 08:06:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
Message-ID: <20230602080607-mutt-send-email-mst@kernel.org>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
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

On Mon, May 29, 2023 at 09:35:08AM +0200, Christophe JAILLET wrote:
> 'inq_result' is known to be NULL. There is no point calling kfree().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/scsi/virtio_scsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 58498da9869a..bd5633667d01 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -338,10 +338,8 @@ static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  	int result, inquiry_len, inq_result_len = 256;
>  	char *inq_result = kmalloc(inq_result_len, GFP_KERNEL);
>  
> -	if (!inq_result) {
> -		kfree(inq_result);
> +	if (!inq_result)
>  		return -ENOMEM;
> -	}
>  
>  	shost_for_each_device(sdev, shost) {
>  		inquiry_len = sdev->inquiry_len ? sdev->inquiry_len : 36;
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
