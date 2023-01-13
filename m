Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E66C54EBE
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 10:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2B7581F8A;
	Fri, 13 Jan 2023 10:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2B7581F8A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9uzagLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Hfe8b4PSubg; Fri, 13 Jan 2023 10:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E5EB820EE;
	Fri, 13 Jan 2023 10:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E5EB820EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47552C0032;
	Fri, 13 Jan 2023 10:01:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF03BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C00060E35
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C00060E35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W9uzagLs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pDsWz1nmvDh1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D859960B8C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D859960B8C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673604079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EczEE9EexjVmlZw39NUVKXIGqT7ZbUsB1oWT/kRdJFY=;
 b=W9uzagLs2sFeOMBAIOnbJOHlNsBLM7N8ZO6EP2QWrhkO/z8jnj6S25EN4KOX+Q9lnesgG6
 Tq7PaA/OnrjsJpSE5awVxqCfvxPlIq7kJrDlQO4qlQgb5RjiudBDah5q2MvxepjY83GhkA
 BqbGNW87gcx7bsg0f78cUhPtJFc7TQY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-OsRro8V6PJy32vnz67EyCg-1; Fri, 13 Jan 2023 05:01:18 -0500
X-MC-Unique: OsRro8V6PJy32vnz67EyCg-1
Received: by mail-wr1-f71.google.com with SMTP id
 d27-20020adfa35b000000b002bc813ba677so2923409wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 02:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EczEE9EexjVmlZw39NUVKXIGqT7ZbUsB1oWT/kRdJFY=;
 b=vR7BDJuvfa2bab9QmDpAvnHZ3HJxsKZUiceZrcfSSGxcpOQeA3kC2ac1QW/xQugoPC
 AQeGJGP/WP2mW4BZ+f4iVIczIa4wbOxGHxlhzo9nluSx+w1yT0kAXc5Rt8n84qV33Piq
 OgCmJxVW+OFZOoHA7NE2EOCaVN6GUMK4PWJ3Gvdg+8tgvZpp25Oc3J//bmHaJyGmg9RM
 UIWkDhLA1D8AUuMil8RI/RgWlJy3lvkhlnW55j3nm2M4/N/39hu8MvsAG6dtzrMcwr0I
 0Ug9f1+Fq99PnDW2S+shQ/xyPrMeiPrXKg3IqmVHWMP7o27TwWH+so9HLAN2HRJaA9/r
 y0Fg==
X-Gm-Message-State: AFqh2ko323KvA1Jx3gNAede7ECHqADa2UKzmcF6abEpQg0CgvYvQeyly
 KvoTa5ZO+34ZrIj210er4c44A3MqmeDHqv5xz/iBplrkn40w0/tif29JCVDsGbzIsObNP9zSJSD
 AfxjX581OkB9prZos5pwYirwfVWHuhco0nlG34A5iuw==
X-Received: by 2002:a5d:640d:0:b0:2bd:e5d5:78ca with SMTP id
 z13-20020a5d640d000000b002bde5d578camr437849wru.26.1673604077138; 
 Fri, 13 Jan 2023 02:01:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusl9tAUcjB8IanuOa9qP/xbsfov7bLo4IM93BQPLAyHtEc1TcEnk77dREtGbmxr3vg/WJRxw==
X-Received: by 2002:a5d:640d:0:b0:2bd:e5d5:78ca with SMTP id
 z13-20020a5d640d000000b002bde5d578camr437833wru.26.1673604076912; 
 Fri, 13 Jan 2023 02:01:16 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it.
 [79.46.200.244]) by smtp.gmail.com with ESMTPSA id
 j14-20020adff00e000000b0024cb961b6aesm18126891wro.104.2023.01.13.02.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 02:01:16 -0800 (PST)
Date: Fri, 13 Jan 2023 11:01:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: sebastien.boeuf@intel.com
Subject: Re: [PATCH v6 1/4] vdpa: Add resume operation
Message-ID: <20230113100113.cdnkwrbqkktp3gnc@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <6e05c4b31b47f3e29cb2bd7ebd56c81f84b8f48a.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
In-Reply-To: <6e05c4b31b47f3e29cb2bd7ebd56c81f84b8f48a.1672742878.git.sebastien.boeuf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 03, 2023 at 11:51:05AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>Add a new operation to allow a vDPA device to be resumed after it has
>been suspended. Trying to resume a device that wasn't suspended will
>result in a no-op.
>
>This operation is optional. If it's not implemented, the associated
>backend feature bit will not be exposed. And if the feature bit is not
>exposed, invoking this operation will return an error.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> include/linux/vdpa.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 6d0f5e4e82c2..96d308cbf97b 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -219,7 +219,10 @@ struct vdpa_map_file {
>  * @reset:			Reset device
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>- * @suspend:			Suspend or resume the device (optional)
>+ * @suspend:			Suspend the device (optional)
>+ *				@vdev: vdpa device
>+ *				Returns integer: success (0) or error (< 0)
>+ * @resume:			Resume the device (optional)
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>  * @get_config_size:		Get the size of the configuration space includes
>@@ -324,6 +327,7 @@ struct vdpa_config_ops {
> 	void (*set_status)(struct vdpa_device *vdev, u8 status);
> 	int (*reset)(struct vdpa_device *vdev);
> 	int (*suspend)(struct vdpa_device *vdev);
>+	int (*resume)(struct vdpa_device *vdev);
> 	size_t (*get_config_size)(struct vdpa_device *vdev);
> 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> 			   void *buf, unsigned int len);
>-- 
>2.37.2
>
>---------------------------------------------------------------------
>Intel Corporation SAS (French simplified joint stock company)
>Registered headquarters: "Les Montalets"- 2, rue de Paris,
>92196 Meudon Cedex, France
>Registration Number:  302 456 199 R.C.S. NANTERRE
>Capital: 5 208 026.16 Euros
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
