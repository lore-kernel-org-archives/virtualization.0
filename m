Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D69EC19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E859B40C6B;
	Thu, 11 Aug 2022 08:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E859B40C6B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQJPS1wr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p43tPM5Wfcou; Thu, 11 Aug 2022 08:27:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E7D640C62;
	Thu, 11 Aug 2022 08:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E7D640C62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2861CC0033;
	Thu, 11 Aug 2022 08:27:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56B8C60FAE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56B8C60FAE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQJPS1wr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pr7686_3Wfqy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:27:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9332460E64
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9332460E64
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660206463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRCed6nnEDFTJS61x3dawnYdkP8v3FkULNF0fZ1BK3g=;
 b=fQJPS1wrc72d7UNWjKfB2ZZ9RJ+tJDqjzbfBeVCmgyzavPpEE9bCF9+Nr9QAOigB3YK+5o
 3zL18Yx0y5eOaqR5u0ofABAe4AbrSP+5OwceQ3kW0l1zsIM7MNYWsM4lLDvZ77cUZ6hfEc
 sngEKRcfGG+vq3GXlQCyxYy+jz9GyG0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-gvsXvpthM_qcSn24u7T7QQ-1; Thu, 11 Aug 2022 04:27:40 -0400
X-MC-Unique: gvsXvpthM_qcSn24u7T7QQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 n30-20020a05600c501e00b003a3264465ebso2416169wmr.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=fRCed6nnEDFTJS61x3dawnYdkP8v3FkULNF0fZ1BK3g=;
 b=21lgQyd5c03vKH/lftrTRWpp+qWI1GCKV0RQISUS4pYdW8go4kaYC7vertalPZWmNV
 5idCa3UJR1Tv1fuztaygrZhfK1fuZ2LruToLm2ZgAidhCcvn+EEylyOTG8AVXFShmxFk
 Evt6VpGJRxGO/6huA9u1mXas8JfbKeRm1zpe6Rg2bWsdlOYf/jxMmlAvMpaJG7bzr3QB
 5M+jv7/i7MM+jvKmZYKnL0HDOMa3yQ2edYKh7eL4mUs6f4aa+43n7QnV0nr7GDMSPHX4
 ZxAbyEs3XOqpLanyV8OufKJeH2B1sKc898wKZg7vWMhZ08oLoR9pF9qDPk23Zkg/TrcV
 SH0g==
X-Gm-Message-State: ACgBeo129urA0No6ZJzIwWJoe9cv3IN+T8pK1vaMxRxAJqR2Ub2JnAI3
 v7Ofb/uVDX5512tUTzb1ItY6PzdAHtvj1cm8Z6Ntd2PRaiegZKe42qklvX/x1g49qEu9Vu5UKW2
 qGWNYf18MkiZl9rTpt4om3oC8a17lL2s4M4433p2sIg==
X-Received: by 2002:a1c:a3c4:0:b0:3a5:512f:717a with SMTP id
 m187-20020a1ca3c4000000b003a5512f717amr4823096wme.192.1660206458779; 
 Thu, 11 Aug 2022 01:27:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5sw3H77GbQvlSeiH8m701pegTIDjU8UzoPnZf53/Xhmt7IzjB7QDado1bpqhPaIYYSo6lqUw==
X-Received: by 2002:a1c:a3c4:0:b0:3a5:512f:717a with SMTP id
 m187-20020a1ca3c4000000b003a5512f717amr4823072wme.192.1660206458571; 
 Thu, 11 Aug 2022 01:27:38 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 m7-20020a056000008700b00222ed7ea203sm8822453wrx.100.2022.08.11.01.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:27:37 -0700 (PDT)
Date: Thu, 11 Aug 2022 04:27:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v7 1/4] vdpa: Add suspend operation
Message-ID: <20220811042717-mutt-send-email-mst@kernel.org>
References: <20220810171512.2343333-1-eperezma@redhat.com>
 <20220810171512.2343333-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220810171512.2343333-2-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 hanand@xilinx.com, martinpo@xilinx.com, gautam.dawar@amd.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 10, 2022 at 07:15:09PM +0200, Eugenio P=E9rez wrote:
> This operation is optional: It it's not implemented, backend feature bit
> will not be exposed.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> Message-Id: <20220623160738.632852-2-eperezma@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

What is this message id doing here?

> ---
>  include/linux/vdpa.h | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7b4a13d3bd91..d282f464d2f1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -218,6 +218,9 @@ struct vdpa_map_file {
>   * @reset:			Reset device
>   *				@vdev: vdpa device
>   *				Returns integer: success (0) or error (< 0)
> + * @suspend:			Suspend or resume the device (optional)
> + *				@vdev: vdpa device
> + *				Returns integer: success (0) or error (< 0)
>   * @get_config_size:		Get the size of the configuration space includes
>   *				fields that are conditional on feature bits.
>   *				@vdev: vdpa device
> @@ -319,6 +322,7 @@ struct vdpa_config_ops {
>  	u8 (*get_status)(struct vdpa_device *vdev);
>  	void (*set_status)(struct vdpa_device *vdev, u8 status);
>  	int (*reset)(struct vdpa_device *vdev);
> +	int (*suspend)(struct vdpa_device *vdev);
>  	size_t (*get_config_size)(struct vdpa_device *vdev);
>  	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
>  			   void *buf, unsigned int len);
> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
