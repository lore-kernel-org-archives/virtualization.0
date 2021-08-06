Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E5C432BE
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:19:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE3B61179
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EE3B61179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED97683B45;
	Fri,  6 Aug 2021 07:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-rfHZ8nn9_h; Fri,  6 Aug 2021 07:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A90983B34;
	Fri,  6 Aug 2021 07:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43C83C001A;
	Fri,  6 Aug 2021 07:19:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9CCC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04F904047A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBWyqeLXd1do
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C0504047F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628234344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3mKwkaoUVrfQ+lC5tkgN91edlf3gr8pvb0ti7ZT+lk=;
 b=WZH27EUSyrWteg5OXqqo3Hr7DCnFBF0bjUwCbzVPi+KF2v5cgY7XMf5e3a698EUmk/WZn6
 lRIMFzXYdIl4F/lLEUUr5ycpHyaqEzlGmIgEFDIBjJ4MtgMD1vsKyqx9yUUz6gcPFtycT8
 ceB7kWdhB3gsGwYZ8H6b+J+lycJEuW0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-9OK8s_8vNBSZmwIjYa47sA-1; Fri, 06 Aug 2021 03:19:01 -0400
X-MC-Unique: 9OK8s_8vNBSZmwIjYa47sA-1
Received: by mail-ed1-f71.google.com with SMTP id
 dh21-20020a0564021d35b02903be0aa37025so2175037edb.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 00:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y3mKwkaoUVrfQ+lC5tkgN91edlf3gr8pvb0ti7ZT+lk=;
 b=KV7LhUHYxdbzv+RgdU5iHsQx/JZd8E2kQehnspyjq4g5ai+9ykn3L7BlgDhHHfqCsq
 SI4d21oIl+nBczxljm0shjBVif7WzMPBjcAVjnQlzQKZs9GlMU1VQmbCiHQrxyh74HmN
 pKK8KSQ7QZUQxqq1xeyE2h6nRtXS0QPUeRujeAcuS8+50Z+lAW7uX1SKdZfdATW+qwyM
 ta/W4TLuV7ICX3HCOH6bZtQVL0GmkEmxQF8EkNLqgTDd3e6/c/jMdYxR5jIIKakWI7Nv
 mfhVxAg+yD+D7aG8PB3uHT8ukj2RAFWs4s52qCJ/QfLhOdSx7snYvltriqMQnvV/R0uc
 1oHQ==
X-Gm-Message-State: AOAM5312sSxJnPGq3gxd9hjLD9wIwuwVP21ehW8D07yqK+2zXip1VHg9
 mEfnq7GAp6HHUpNSacrp23be191Flnd6wsVqbpcSV/QY7Cvbf+v7uDDTr/NsxZ+xOD7mdaRqcxP
 wA+iRekKjgwIEI/6GlbiHRBKzqTX6GCppF/FxHadJVQ==
X-Received: by 2002:a17:906:1c81:: with SMTP id
 g1mr8634571ejh.361.1628234339944; 
 Fri, 06 Aug 2021 00:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6JY7p7UFxuDeInSSMYr1fMOjaIuzdqeeTRahm0VW7d3WQBlqeSCHdg1JEhMKVsqgo8q29Yw==
X-Received: by 2002:a17:906:1c81:: with SMTP id
 g1mr8634556ejh.361.1628234339817; 
 Fri, 06 Aug 2021 00:18:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id g9sm3459573edl.52.2021.08.06.00.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 00:18:59 -0700 (PDT)
Date: Fri, 6 Aug 2021 09:18:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 1/7] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOM' bit
Message-ID: <20210806071857.h4zneiblcf5tathq@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210726163307.2589516-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210726163307.2589516-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Mon, Jul 26, 2021 at 07:33:04PM +0300, Arseny Krasnov wrote:
>This bit is used to mark end of messages('EOM' - end of message), while
>'VIRIO_VSOCK_SEQ_EOR' is used to pass MSG_EOR.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 3dd3555b2740..1de3211a2988 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -98,6 +98,7 @@ enum virtio_vsock_shutdown {
> /* VIRTIO_VSOCK_OP_RW flags values */
> enum virtio_vsock_rw {
> 	VIRTIO_VSOCK_SEQ_EOR = 1,
>+	VIRTIO_VSOCK_SEQ_EOM = 2,
> };

Already said, but I'll repeat it for completeness.

It's better to rename the flag 1 and use it in the same way we did 
before, so it's backward compatible.

Obviously we have to update the specifications too, explaining the 
difference between the two :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
