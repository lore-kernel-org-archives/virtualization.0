Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7BC63793
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B34613AE
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B34613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DEA760772;
	Thu, 22 Jul 2021 12:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJfheRCofKCB; Thu, 22 Jul 2021 12:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 111486062D;
	Thu, 22 Jul 2021 12:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D50B1C001A;
	Thu, 22 Jul 2021 12:55:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1B24C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 12:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93C75404F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 12:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gu5PUV_QqQQT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 12:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A32E3400DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626958525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1CwiWu4T1TCrXr2lCQ50ReEt7fD3KW4sYxtYxQrRVQw=;
 b=bqwGdoQMPWctexDqhtJ/CEPvumJ02nUrZg+NTN8fxaLYofI06RoagEvEBortPhdQnm3Lb+
 BroF/Y9soe9+V2kiN7fN3v+BxsEAePmjvtRyhKhFe1emTHQ//Xl9jI152peliphiDP9Loq
 joCuCo8yMWaFUVLphLdPkPHZQ/E94cY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-vR_MCWYCPh63tpYdBjIqQA-1; Thu, 22 Jul 2021 08:55:23 -0400
X-MC-Unique: vR_MCWYCPh63tpYdBjIqQA-1
Received: by mail-ej1-f72.google.com with SMTP id
 p20-20020a1709064994b02903cd421d7803so1766904eju.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 05:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1CwiWu4T1TCrXr2lCQ50ReEt7fD3KW4sYxtYxQrRVQw=;
 b=CveBhjl0Q0rmvJmA+hu7xu/iPGl00G0u7EUIQO5YUzWrIfC6qqBP/mqjQxCstqdURt
 Lbs9MiaAettLl/mhn601/Nwg6R4HzIbCYYrEHgHBvj9IjNcerr5lZ1tg+Z1AEmBNykSV
 3zlCyTGNpyMrQKQ9LAwB9nnojv/4kCzoynPj/RBi34rV8pKSLWsiDkITB3IopaKY3PiF
 cZk+/GWEoDMLYzvPXse1O7rIcYtKg/fJnKAHImSJ6yAq9NlKg7thGFkdZoYzSC7teZ9y
 QYR1H4gVcSOoY2J10buJrfarcXt8GG13BpgLlxJQCHrhTIPbcv2+5L3DEjyFCloQQ8Dh
 rLgA==
X-Gm-Message-State: AOAM530hY+BYtTUU0wXk39sqxnTuaFqxoq2EFbagTg7cBkw+Plg40BZa
 SaZofqkBBpObet+Kq7/0pkkXK5UA4LVdlKpt3YRo2mGHWaS+grD6LkTHmEF0P6O8mGld8WPmq2/
 jPgrO+BHlMY49WRVCgaoQL42akP+tBcerrlKR2rybwA==
X-Received: by 2002:a17:906:4b47:: with SMTP id
 j7mr43399492ejv.104.1626958522043; 
 Thu, 22 Jul 2021 05:55:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQU28JFAqvNmUaGfaHpdW27wO3IJ4E+xBiNDz/aPu1UOIaWniwAJM4pJxCmsaa9I5ynqJCHA==
X-Received: by 2002:a17:906:4b47:: with SMTP id
 j7mr43399477ejv.104.1626958521846; 
 Thu, 22 Jul 2021 05:55:21 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id g11sm12413592edt.85.2021.07.22.05.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 05:55:21 -0700 (PDT)
Date: Thu, 22 Jul 2021 14:55:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] virtio/vsock: Make vsock virtio packet buff size
 configurable
Message-ID: <20210722125519.jzs7crke7yqfh73e@steredhat>
References: <20210721143001.182009-1-lee.jones@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210721143001.182009-1-lee.jones@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiang.wang@bytedance.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ram Muthiah <rammuthiah@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jul 21, 2021 at 03:30:00PM +0100, Lee Jones wrote:
>From: Ram Muthiah <rammuthiah@google.com>
>
>After a virtual device has been running for some time, the SLAB
>sustains ever increasing fragmentation. Contributing to this
>fragmentation are the virtio packet buffer allocations which
>are a drain on 64Kb compound pages. Eventually these can't be
>allocated due to fragmentation.
>
>To enable successful allocations for this packet buffer, the
>packet buffer's size needs to be reduced.
>
>In order to enable a reduction without impacting current users,
>this variable is being exposed as a command line parameter.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: virtualization@lists.linux-foundation.org
>Cc: kvm@vger.kernel.org
>Cc: netdev@vger.kernel.org
>Signed-off-by: Ram Muthiah <rammuthiah@google.com>
>Signed-off-by: Lee Jones <lee.jones@linaro.org>
>---
> include/linux/virtio_vsock.h            | 4 +++-
> net/vmw_vsock/virtio_transport_common.c | 4 ++++
> 2 files changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 35d7eedb5e8e4..8c77d60a74d34 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -7,9 +7,11 @@
> #include <net/sock.h>
> #include <net/af_vsock.h>
>
>+extern uint virtio_transport_max_vsock_pkt_buf_size;
>+
> #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
> #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
>-#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		virtio_transport_max_vsock_pkt_buf_size
>
> enum {
> 	VSOCK_VQ_RX     = 0, /* for host to guest data */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 169ba8b72a630..d0d913afec8b6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -26,6 +26,10 @@
> /* Threshold for detecting small packets to copy */
> #define GOOD_COPY_LEN  128
>
>+uint virtio_transport_max_vsock_pkt_buf_size = 1024 * 64;
>+module_param(virtio_transport_max_vsock_pkt_buf_size, uint, 0444);
>+EXPORT_SYMBOL_GPL(virtio_transport_max_vsock_pkt_buf_size);
>+

Maybe better to add an entry under sysfs similar to what Jiang proposed 
here:
https://lists.linuxfoundation.org/pipermail/virtualization/2021-June/054769.html

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
