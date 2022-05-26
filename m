Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42635C433EF
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 14:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6876613AA;
	Thu, 26 May 2022 14:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_1_pIuoTMXq; Thu, 26 May 2022 14:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D84FB60FF7;
	Thu, 26 May 2022 14:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA43AC0039;
	Thu, 26 May 2022 14:23:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC51C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76B7840604
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lpKELtGIlqdH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CB4640127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653575010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIs2TnkQYfNX5UnfDwJthJ+utgn6CIbjyk+tWQwa1VU=;
 b=W8bfC2piwqgoF9yzadnqronglWO4nyR49R+gBdytb6ZkJ77D1wQTYWCMC4etXI2Vj0lfe0
 OvE7gDaCLmSjZ9LrqP/jEn2DrKKYeq1+hIHaLOowcWWBNAcbEhlVbu7zIROegh8zliZLS7
 s5/m4H/HgmEmdmQ5fdRPbJXuZa0U79U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-R7dmEWsKPLWhX7ee4_R4TQ-1; Thu, 26 May 2022 10:23:29 -0400
X-MC-Unique: R7dmEWsKPLWhX7ee4_R4TQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 w21-20020a05622a135500b002f3b801f51eso1653251qtk.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 07:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PIs2TnkQYfNX5UnfDwJthJ+utgn6CIbjyk+tWQwa1VU=;
 b=wCnTS7XdCIE3oV2AoFNtpmlyYdxtIKD3kVNageYsb0rs2EpBCZe2gWo5+26DHQSNXc
 tvABhuRiuQYmGAa4mh9Y2nW6KxaX2DnF5fxjFldJ9v8OYGViPw73upvDbl681nX6498Y
 k8Ck2hE2nfKSb6dN4MHI/wHGeRri+G0nLxb7VLOx3/RaoQOQSmiV4dPu2whW3xOFPn27
 yvlqPxlwcZyp0r1PdxCZtER9y5TUi0QfGC/OGFkNJnZ2OF2KXdAzI8B3+chdwvYKalxu
 M/AA979gahknInoxt5SEZ4qCsUTBfMeI/JQY3Ru8tcE4BRhhoNDzUujaVmmViwnYJhIQ
 jTMQ==
X-Gm-Message-State: AOAM5324Bu/mhFIh8oiu+nZ7OiBbvB9Yemv4NHzedK4+2Me4FPIzEObr
 OpKlW4xLtM/SfqJinO0Hvz9h79LmR+qlOCEo7AHNSS+Ag7kpSWCW5sXPiI0CS9jSCqJssHDDEdJ
 bm4TFOUb57xMhTRMoUL/6mjwF7KHbbxH9ryyKG20t6Q==
X-Received: by 2002:ae9:e90d:0:b0:6a3:28eb:1a4f with SMTP id
 x13-20020ae9e90d000000b006a328eb1a4fmr25047880qkf.21.1653575009375; 
 Thu, 26 May 2022 07:23:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnsTslbqm3Ty98MkhbvTDM22jLrcctXdBNbGWftZfctg4y2SKQBw+AQi/5d92FEvX7YhHSHQ==
X-Received: by 2002:ae9:e90d:0:b0:6a3:28eb:1a4f with SMTP id
 x13-20020ae9e90d000000b006a328eb1a4fmr25047843qkf.21.1653575009105; 
 Thu, 26 May 2022 07:23:29 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 j19-20020ac85f93000000b002f3bbad9e37sm1031494qta.91.2022.05.26.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 07:23:28 -0700 (PDT)
Date: Thu, 26 May 2022 16:23:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 1/4] vdpa: Add stop operation
Message-ID: <20220526142318.mi2kfywbpvuky4lw@sgarzare-redhat>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <20220526124338.36247-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220526124338.36247-2-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com, hanand@xilinx.com,
 martinpo@xilinx.com, gautam.dawar@amd.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 26, 2022 at 02:43:35PM +0200, Eugenio P=E9rez wrote:
>This operation is optional: It it's not implemented, backend feature bit
>will not be exposed.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> include/linux/vdpa.h | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 15af802d41c4..ddfebc4e1e01 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -215,6 +215,11 @@ struct vdpa_map_file {
>  * @reset:			Reset device
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>+ * @stop:			Stop or resume the device (optional, but it must
>+ *				be implemented if require device stop)
>+ *				@vdev: vdpa device
>+ *				@stop: stop (true), not stop (false)

Sorry for just seeing this now, but if you have to send a v5, maybe we =

could use "resume" here instead of "not stop".

Thanks,
Stefano

>+ *				Returns integer: success (0) or error (< 0)
>  * @get_config_size:		Get the size of the configuration space includes
>  *				fields that are conditional on feature bits.
>  *				@vdev: vdpa device
>@@ -316,6 +321,7 @@ struct vdpa_config_ops {
> 	u8 (*get_status)(struct vdpa_device *vdev);
> 	void (*set_status)(struct vdpa_device *vdev, u8 status);
> 	int (*reset)(struct vdpa_device *vdev);
>+	int (*stop)(struct vdpa_device *vdev, bool stop);
> 	size_t (*get_config_size)(struct vdpa_device *vdev);
> 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> 			   void *buf, unsigned int len);
>-- =

>2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
