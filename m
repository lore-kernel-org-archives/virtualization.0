Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F386EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 17 Jul 2023 07:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CBA060BCD;
	Mon, 17 Jul 2023 07:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CBA060BCD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TF5eLLKK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xv8bycbJnXCb; Mon, 17 Jul 2023 07:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A35A60BE6;
	Mon, 17 Jul 2023 07:10:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A35A60BE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA704C0072;
	Mon, 17 Jul 2023 07:10:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A618C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 07:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D06A4408E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 07:10:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D06A4408E7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TF5eLLKK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrR877n8Pi9N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 07:10:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ACC89408C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACC89408C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689577811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDGr31xfPI7wr++njiKZZXCv7HpxjeiZGMfF1Pob4ss=;
 b=TF5eLLKKHp/QHZbJqh+iohMRXvJK4mu6mEntV/9ynS5cCQWQZx5NvUG6Bkz/5DkT+ndePT
 VET3Tp/ehEeQFnDn+dLf9/VZ5hjpz4oSDSCFhOw0ePA/dy8J8FlVbCXuhGezrEYMTXLjGY
 SwmtB/B5gyUMYtWajmjKptvaucON1Oo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-5DVig9yDPZq8Y5f0wpSZxQ-1; Mon, 17 Jul 2023 03:10:09 -0400
X-MC-Unique: 5DVig9yDPZq8Y5f0wpSZxQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso254678766b.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 00:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689577808; x=1692169808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDGr31xfPI7wr++njiKZZXCv7HpxjeiZGMfF1Pob4ss=;
 b=FrEv5KzmAkmHfr2htll8Wzw4pYLj13jj6iTAiFlubZoWnbjndAC1xd7kCM4X+/vJT6
 3GQrepqC5d0V2OIjMlYDIE0+FmQS/4hPYAza4dPdD16ZAsFzvDVlo54SQD7dc4ZMNbU/
 OxeyLm1oZEbY1Y0d9RAi4OSov7D4g7qpFiqL6AHmgR4RenDJag1h9t/RqBVO4d09QWx9
 puXd3ohfDVOLUqB4vnY96KQBKrWzg9ybLoq7pdjMOIwAk5FpzSbbtUM6gtc6yCfwaPHD
 Qkc7miRq1g4RnB5dpFRKadJZx1zADTD4lEPQhm8QDyBL03nbfwnpPmCO+coa1sp5g05w
 F8FA==
X-Gm-Message-State: ABy/qLb6PwlhcmDIxPVD32dcjC0fu0zPoOUL1I6UdSBsKokZGQWPb6P1
 DQZhEEWiPsY6eKYZ9zMQXvDJFBmS+Ko91RmzoFl/FzTi6/upDCSj1/3lrBlJ8ZggiIUACvEmAK+
 oncsNOlWF/cnGf70sFq/MQQZzjHwio/gWGL2GDf/0xw==
X-Received: by 2002:a17:906:2219:b0:993:eef2:5d5f with SMTP id
 s25-20020a170906221900b00993eef25d5fmr10443228ejs.27.1689577808261; 
 Mon, 17 Jul 2023 00:10:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErI+EM1miO3JyCJ4OjxcdqggPmpvYrWYvPVKP44yaFJfcVCVN9B7hxBYEpH64MpxCoQy+oGQ==
X-Received: by 2002:a17:906:2219:b0:993:eef2:5d5f with SMTP id
 s25-20020a170906221900b00993eef25d5fmr10443214ejs.27.1689577807924; 
 Mon, 17 Jul 2023 00:10:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-94.retail.telecomitalia.it.
 [79.46.200.94]) by smtp.gmail.com with ESMTPSA id
 f10-20020a170906390a00b00992b8d56f3asm8793110eje.105.2023.07.17.00.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 00:10:07 -0700 (PDT)
Date: Mon, 17 Jul 2023 09:10:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add vhost-scsi entry and myself as a
 co-maintainer
Message-ID: <4sgpeuiwhxtnpt4pvqocnbctdyamfzfakjxefv4o67lgubh6ko@ds7ms4ovodfv>
References: <20230715142027.5572-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230715142027.5572-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
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

On Sat, Jul 15, 2023 at 09:20:27AM -0500, Mike Christie wrote:
>I've been doing a lot of the development on vhost-scsi the last couple of
>years, so per Michael T's suggestion this adds me as co-maintainer.

Yeah, completely agree on that :-)

>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> MAINTAINERS | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 3be1bdfe8ecc..2c4a8a860ae0 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -22458,7 +22458,6 @@ L:	virtualization@lists.linux-foundation.org
> S:	Maintained
> F:	drivers/block/virtio_blk.c
> F:	drivers/scsi/virtio_scsi.c
>-F:	drivers/vhost/scsi.c
> F:	include/uapi/linux/virtio_blk.h
> F:	include/uapi/linux/virtio_scsi.h
>
>@@ -22557,6 +22556,16 @@ F:	include/linux/vhost_iotlb.h
> F:	include/uapi/linux/vhost.h
> F:	kernel/vhost_task.c
>
>+VIRTIO HOST (VHOST-SCSI)
>+M:	"Michael S. Tsirkin" <mst@redhat.com>
>+M:	Jason Wang <jasowang@redhat.com>
>+M:	Mike Christie <michael.christie@oracle.com>
>+R:	Paolo Bonzini <pbonzini@redhat.com>
>+R:	Stefan Hajnoczi <stefanha@redhat.com>
>+L:	virtualization@lists.linux-foundation.org
>+S:	Maintained
>+F:	drivers/vhost/scsi.c
>+
> VIRTIO I2C DRIVER
> M:	Conghui Chen <conghui.chen@intel.com>
> M:	Viresh Kumar <viresh.kumar@linaro.org>
>-- 
>2.34.1
>

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
