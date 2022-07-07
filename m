Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83A7C43334
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 05:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3631040C66;
	Thu,  7 Jul 2022 05:16:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3631040C66
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JveTPD/P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Un-3sHsmrCc6; Thu,  7 Jul 2022 05:16:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2143401A0;
	Thu,  7 Jul 2022 05:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2143401A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74C05C0035;
	Thu,  7 Jul 2022 05:16:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E237BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B55A760DFD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B55A760DFD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JveTPD/P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laUj1p0e5xQs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82ED260B17
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82ED260B17
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657171005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/5gQIogadsVarAHL6peGmK6MYhegEwuOEcNLhHz0wI=;
 b=JveTPD/P/FtxCwwmmOlvWTUy8P0d7Htt6KcsTvzISaWBv7rHKtVnGlTV+yX8axUvu1S2Pm
 z7SXOyCnSkxmP6mhl8axq5U0M6dZcmeS93NYTiqnH5YdoNCe6cfPlpHho8ehGpzxGxkhOq
 yLkuPYRwAL6L4wH8EPha/JyyLI3Whlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-lgo7RpwPNFO1ADWPtB7xFQ-1; Thu, 07 Jul 2022 01:16:43 -0400
X-MC-Unique: lgo7RpwPNFO1ADWPtB7xFQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c126-20020a1c3584000000b003a02fa133ceso3405401wma.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 22:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1/5gQIogadsVarAHL6peGmK6MYhegEwuOEcNLhHz0wI=;
 b=1hYZHF0By9CSIiWD/932KxiV2CVDtYR4RyBqZpD399mLuwr7whSS/ajoz0PjwQXh0R
 iePg9vkxjiLRRATX86LQs4vBhMdKFIKmhlE0MoowSTDc9d7Igx1xpv4gVWkKPJ4TRz6c
 Dkkrq5enj7wQWEfSbEkn8wEYIhkDz7I7SqDWQU3F/yGozO9dce7pSl8tdwqHP4vdJfS1
 zD0leMXAgUoXrF991HpObgrSw60D6Goxqq8v6CWa3Mc2bVQ0dJogYXuumj9HMuATaBbU
 2+sIL4luZYDxlTvyUn62qLxq2uNB5yhnBlMVFqypHeTtH5dk9DwefXiuDSyzrBrenJVj
 obxA==
X-Gm-Message-State: AJIora/vQME04Ao3etQ5NdEZZoWxesGpzk+/zcFw5PJpmziGET8NzZuq
 voPhlq3rrpXx4ePx+S13RLFc4peyDlmpFmkePT5r0Wl28xvK3KWFWgBp6ESXCgp+X4c6fmxW83S
 wnnypezgVinaMfazhVeaOAwHsBEcPrcNNsvHQM7LY5Q==
X-Received: by 2002:a1c:770d:0:b0:3a0:3d95:4538 with SMTP id
 t13-20020a1c770d000000b003a03d954538mr2272523wmi.17.1657171002751; 
 Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1szzNKb24PPtBh+b6VdvF9GQriDQNIAizLQlki1SQSJXfirR97xglPrMIyx3ky0UhetxN3TpQ==
X-Received: by 2002:a1c:770d:0:b0:3a0:3d95:4538 with SMTP id
 t13-20020a1c770d000000b003a03d954538mr2272515wmi.17.1657171002572; 
 Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
Received: from redhat.com ([2.52.154.68]) by smtp.gmail.com with ESMTPSA id
 f18-20020adff992000000b0021b9416fa13sm15603260wrr.90.2022.07.06.22.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
Date: Thu, 7 Jul 2022 01:16:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: Re: [PATCH v2 3/4] virtio_test: use random length scatterlists to
 test descriptor chain
Message-ID: <20220707011015-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jul 07, 2022 at 10:44:08AM +0800, Guo Zhi wrote:
> Prior implementation only use one descriptor for each io event, which
> does't test code of descriptor chain. More importantly, one descriptor
> will not use indirect feature even indirect feature is specified. Use
> random length scatterlists here to test descriptor chain.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  tools/virtio/virtio_test.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 1ecd64271..363695b33 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,6 +20,7 @@
>  #include "../../drivers/vhost/test.h"
>  
>  #define RANDOM_BATCH -1
> +#define MAX_SG_FRAGS 8UL
>  #define ALIGN 4096
>  #define RINGSIZE   256
>  #define TEST_BUF_NUM 0x100000
> @@ -172,7 +173,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
>  static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  		     bool delayed, int batch, int reset_n, int bufs)
>  {
> -	struct scatterlist sl;
> +	struct scatterlist sg[MAX_SG_FRAGS];
> +	int sg_size = 0;
>  	long started = 0, completed = 0, next_reset = reset_n;
>  	long completed_before, started_before;
>  	int r, test = 1;
> @@ -197,8 +199,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  
>  			while (started < bufs &&
>  			       (started - completed) < batch) {
> -				sg_init_one(&sl, dev->buf, dev->buf_size);
> -				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
> +				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
> +				sg_init_table(sg, sg_size);
> +				for (int i = 0; i < sg_size; ++i)
> +					sg_set_buf(&sg[i], dev->buf + i, 0x1);
> +				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>  							 dev->buf + started,
>  							 GFP_ATOMIC);
>  				if (unlikely(r != 0)) {

random on data path is pretty expensive.
I would suggest get an array size from user (and maybe a seed?) and
pregenerate some numbers, then reuse.


> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
