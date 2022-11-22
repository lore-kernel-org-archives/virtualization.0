Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723B2C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 06:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCCA24168A;
	Tue, 22 Nov 2022 06:33:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCCA24168A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsC3bwB/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hbz3rYkK38in; Tue, 22 Nov 2022 06:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CF1F41691;
	Tue, 22 Nov 2022 06:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CF1F41691
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9E4EC0033;
	Tue, 22 Nov 2022 06:32:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80633C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52D3A81F1E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:32:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52D3A81F1E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsC3bwB/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IHphHLoAWKyq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CA0381F1D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CA0381F1D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669098776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5DjO7BjpyUGy3S6uOAU9v7mQBK1GOx/SrNCagtFGjM=;
 b=bsC3bwB/+MDRhX8ZgpChremvMOIX+5elXCBVyT8w3+qQUkbnjeciG+bkhi5bGMw0Q+F5Zw
 tWPhX34EQBFFNJ+AEFu9ZjGzeiUOnM7iWmAY/LBVoCU2QrvqOdQroHxu6YI/IC5OeTnEQb
 /HclAQVWGzFcTCrCaGwzDYtninG1gPg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-OQ6bsC2KN7myhlmIr6I9hQ-1; Tue, 22 Nov 2022 01:32:54 -0500
X-MC-Unique: OQ6bsC2KN7myhlmIr6I9hQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 bk1-20020a0568081a0100b0035a0eaa5ff6so5109609oib.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 22:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5DjO7BjpyUGy3S6uOAU9v7mQBK1GOx/SrNCagtFGjM=;
 b=haJSR30TxCnvmseLsahXdmMrshcKXb9uRsP2rQs4Wah/LQ7FSxm7WEKi2om3B+iiu5
 Btn3OxANNtsjWqfn953iRRwbNhXCF/AyfbIIp+IjBNYSpuGJtMDvN24qCcoDj0405tU3
 8bEOFmIIBx+zlSJd9x0QfaVkdtDyA1Mg532xvtZZylK5GlIaadphJF+tfv4ygIY6Wsxd
 N6uvWbALLLicpiK+NmtNM5jCa0haBE1LuVuQ/jKqcr5NY72dI4ajgt3A2RiM4bITnVjy
 3iVnmCqQnA+KKQLu0vNZPqxz6UM+DCmq2uKEeNbAlUKkSkrL2O/f+1r/kQJhXAtk1Xaq
 oXAA==
X-Gm-Message-State: ANoB5pkktLE5Kgo5k8sLpd5hWyq1E4nWitrol5z8jPl9EbpdFO5mtrlo
 FpBpgbYZz0N26XiQcE4AqN6tA8tAdZNhSKB9tODyg3BDmf/SEfvCjHbmMCtVSutVWQ3ivZTay6i
 UjicDM2HDxVYS1arII/PQWn6GTHTjyO5aRoYUZVshFgj7UNGZwEq1XVRnaw==
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr11337013otb.237.1669098774060; 
 Mon, 21 Nov 2022 22:32:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JzAIPl3s0pitkJaRFZp3vPbW9B2doZPZpd4MPKePy8uj/VMJ81moMQRFVX8LAVZf99DB0wU+lIfnDqO3zuXg=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr11337001otb.237.1669098773829; Mon, 21
 Nov 2022 22:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-18-snelson@pensando.io>
In-Reply-To: <20221118225656.48309-18-snelson@pensando.io>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Nov 2022 14:32:42 +0800
Message-ID: <CACGkMEuVYUFJzdKDRGo2B3BNtaPaWduHr+jLNAfwCOzpr-5fcg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 17/19] pds_vdpa: add vdpa config client
 commands
To: Shannon Nelson <snelson@pensando.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

On Sat, Nov 19, 2022 at 6:57 AM Shannon Nelson <snelson@pensando.io> wrote:
>
> These are the adminq commands that will be needed for
> setting up and using the vDPA device.
>
> Signed-off-by: Shannon Nelson <snelson@pensando.io>
> ---
>  drivers/vdpa/pds/Makefile   |   1 +
>  drivers/vdpa/pds/cmds.c     | 266 ++++++++++++++++++++++++++++++++++++
>  drivers/vdpa/pds/cmds.h     |  17 +++
>  drivers/vdpa/pds/vdpa_dev.h |  60 ++++++++
>  4 files changed, 344 insertions(+)
>  create mode 100644 drivers/vdpa/pds/cmds.c
>  create mode 100644 drivers/vdpa/pds/cmds.h
>  create mode 100644 drivers/vdpa/pds/vdpa_dev.h
>

[...]

> +struct pds_vdpa_device {
> +       struct vdpa_device vdpa_dev;
> +       struct pds_vdpa_aux *vdpa_aux;
> +       struct pds_vdpa_hw hw;
> +
> +       struct virtio_net_config vn_config;
> +       dma_addr_t vn_config_pa;

So this is the dma address not necessarily pa, we'd better drop the "pa" suffix.

Thanks

> +       struct dentry *dentry;
> +};
> +
> +int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
> +
> +#endif /* _VDPA_DEV_H_ */
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
