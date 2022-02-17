Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6266DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 10:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC2436F6D3;
	Thu, 17 Feb 2022 10:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNmPPfc8XLuc; Thu, 17 Feb 2022 10:55:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 63FE960AB0;
	Thu, 17 Feb 2022 10:55:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8C7C0011;
	Thu, 17 Feb 2022 10:55:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD483C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 10:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D145840201
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 10:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6kkiaaw6d8oj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 10:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A632740143
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645095353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SVVrv0XzxZp6BNg4MW7Kf403dJznZFRZXE0N1PtvrY=;
 b=gu3zD63GONcnM+WbjSX8bB8JxIblmhMRg6Z1YVDTKb/U6hrTmeoKpStRXvIkZbTvcZmmpD
 5+4F7ZX8OoZV8MBpBJJk0oPbQnNLxrww8BB91WZjqpKhq04a44qZiUGqofzAcwVFsp+YUb
 YlbEsNn4qAl1Rw4ChfmQFg3Ydqn8Xn0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-tADbncDzNNioOvfc2S9pmA-1; Thu, 17 Feb 2022 05:55:52 -0500
X-MC-Unique: tADbncDzNNioOvfc2S9pmA-1
Received: by mail-qk1-f199.google.com with SMTP id
 bl5-20020a05620a1a8500b005088d061be4so3756702qkb.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 02:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+SVVrv0XzxZp6BNg4MW7Kf403dJznZFRZXE0N1PtvrY=;
 b=5tGOVr6/GOdTRORxGja3jLGvC6kr3EbsJbecdLZmUNxD6DxRfzy2QtpyPFEgWufLKB
 B1b88ScC17H3TxYjrAOYpINrADi670fntFzvLhDHNiglYBAyhwYiSmibqW2Oi2sH3fT4
 J/6Pmlb9HQTgCqIS3HLnWBeNV4Hc8rrwq1LLCNLuO3y/0S0UOt7CAAQZ/OoIMb0QNJa/
 nFV6lUAIuRUZl+1+W3u3uJXzrmzO0WG4M0t77kHW+8QTVQhuLLORaZ87dE8dk7Zplu8S
 7oO0ULpEfmYQ1J0VG5PHD5WEm/Pwd4qDVZ/Vh0LeM/L9cOjXduXwgrSttQ0OYJGrTxCb
 /s3w==
X-Gm-Message-State: AOAM5339G9+P9ck+NPPw4q8a1cYZYGIPXzmpH9Ha4aDK7gYgY6PW0bAs
 ejUN6R1RDtpHA7g8AiqxHHlhf/sYg38HLeDqcOztY08cIo1dvjhB7M8GJyQ9FxUjPgTfCqPswmN
 j6NgFDnDmM0C+Bsmw3sFPt0c5+LqaFV6u0JirHU736g==
X-Received: by 2002:ac8:5854:0:b0:2ca:e931:ee3d with SMTP id
 h20-20020ac85854000000b002cae931ee3dmr1789942qth.578.1645095351790; 
 Thu, 17 Feb 2022 02:55:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5u/OTKf8MMDFqRd+enwKoRcIHT3VUf826e9f/sDW0ckdE7DExk66SAfQVFLhM/QfNCrYrSw==
X-Received: by 2002:ac8:5854:0:b0:2ca:e931:ee3d with SMTP id
 h20-20020ac85854000000b002cae931ee3dmr1789928qth.578.1645095351552; 
 Thu, 17 Feb 2022 02:55:51 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id r129sm19729955qkf.99.2022.02.17.02.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 02:55:50 -0800 (PST)
Date: Thu, 17 Feb 2022 11:55:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] virtio: Add definition for VIRTIO_F_NOTIFICATION_DATA
 feature flag
Message-ID: <20220217105544.p6z3n2i4yjj7qb3s@sgarzare-redhat>
References: <20220217095545.195426-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220217095545.195426-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Thu, Feb 17, 2022 at 11:55:45AM +0200, Eli Cohen wrote:
>This is required by iproute2 to display the capabilities of a vdpa based
>virtio device.
>
>Previously, drivers/net/ethernet/sfc/mcdi_pcol.h made use of a private
>definition of this flag. Modify the definition to rely on the new
>generic definition.
>
>Signed-off-by: Eli Cohen <elic@nvidia.com>
>---
> drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
> include/uapi/linux/virtio_config.h   | 6 ++++++
> 2 files changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
>index d3fcbf930dba..2603e04dae06 100644
>--- a/drivers/net/ethernet/sfc/mcdi_pcol.h
>+++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
>@@ -21477,7 +21477,7 @@
> #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_LBN 37
> #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_WIDTH 1
> #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_OFST 0
>-#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN 38
>+#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN VIRTIO_F_NOTIFICATION_DATA
> #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_WIDTH 1
> #define       VIRTIO_BLK_CONFIG_FEATURES_LBN 0
> #define       VIRTIO_BLK_CONFIG_FEATURES_WIDTH 64

It seems to me that VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN is 
not used, otherwise I think now we need to add #include 
<linux/virtio_config.h> where it is used.

Anyway it seems a right change to me.

>diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
>index b5eda06f0d57..30eb76dcdcad 100644
>--- a/include/uapi/linux/virtio_config.h
>+++ b/include/uapi/linux/virtio_config.h
>@@ -92,4 +92,10 @@
>  * Does the device support Single Root I/O Virtualization?
>  */
> #define VIRTIO_F_SR_IOV			37
>+
>+/* When negotiated, indicates that the driver can pass extra data beyond
>+ * virtqueue identification when sending notifications
>+ */
>+#define VIRTIO_F_NOTIFICATION_DATA	38
>+
> #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
>-- 
>2.32.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
