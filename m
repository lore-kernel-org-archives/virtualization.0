Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85460C433FE
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 15:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0307440467;
	Tue, 18 Oct 2022 15:40:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0307440467
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DrMrY0Wg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3gUGMMgU7qv; Tue, 18 Oct 2022 15:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 695C7402DC;
	Tue, 18 Oct 2022 15:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 695C7402DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DF3FC0033;
	Tue, 18 Oct 2022 15:40:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79998C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 15:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 549018330B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 15:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 549018330B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DrMrY0Wg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Y-CSWxtZHFB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 15:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6096F832E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6096F832E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666107598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1ntOmfZrs8dqZ6k2VCqVjRnTeyOx20Q25jn6A/FnCk=;
 b=DrMrY0Wg/sPGMRCzUJ0PjL05Y3pOkEf9V+JEwvTeDLTLYYU97XbKxcC0GRMi8DL9KXPURj
 I2OYqj0B4SvKtL0ht8Tc3HT/kL/q51Xs7O/E46CKhSnzV+Y+p5DwQDCt+g+LY2/X3TRklp
 oHs0EKyFAbQ1x49mVhcsdmI3wCGeB8k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-dghq5QJ8PKW70EBPHWvQZg-1; Tue, 18 Oct 2022 11:39:57 -0400
X-MC-Unique: dghq5QJ8PKW70EBPHWvQZg-1
Received: by mail-qv1-f71.google.com with SMTP id
 lu3-20020a0562145a0300b004b1d6f4130eso8809562qvb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1ntOmfZrs8dqZ6k2VCqVjRnTeyOx20Q25jn6A/FnCk=;
 b=CnPzLar0Wo0tYp0ikkQuPeBqZV76wabdlbubukH1/KGbl6rO++03Eq+ETWm1AoUbro
 NQcL3r8z3yPEsGN0TINVyukZhJLsV0dw4NNYMJ3uNjiskoxtikv3YYJuNG8zhTVH7L3P
 g1ik+2sD6BvLeCD2OdI0xnxABSB9dxD57MgdfJdTQOKKHvBHgOg26qZ/deGl2g0447QD
 jJv1TRhy96c7wys9qKzzNQXN/QV0Xp0G9AQpqAMBTyeBIMvM61GLJfttb7Xw61QVSg10
 mi1K8aMAt84NY4ZIUQtWmJ+vMm63+0YlJ9nimpvrkM+C/Q/ensJSjyuEEBjxJOdU0yD9
 7AMw==
X-Gm-Message-State: ACrzQf0mPRQxcconamW5iblFsxR2lqmClb+XdWRrQCTwwFreB9ZBZXtA
 jlc7KAlUvD1Bst+YXC1h/d9cgL8eiPmQbaSRf5256UV92NVqlgKH06x+RACXW8bwwqweHoQ1RIG
 AdX2ZijfDO1H5+dRnMIayDy1cx82nFyNX/1npQdJvEg==
X-Received: by 2002:a05:622a:95:b0:39c:c9df:8db with SMTP id
 o21-20020a05622a009500b0039cc9df08dbmr2576328qtw.349.1666107597125; 
 Tue, 18 Oct 2022 08:39:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7otvOjB+1WMOHwHy+ISe/cHO3iDr0yYS4pArNJuJCmujDYQmiQUjY8SAsUr16B5Qj+1fUiBQ==
X-Received: by 2002:a05:622a:95:b0:39c:c9df:8db with SMTP id
 o21-20020a05622a009500b0039cc9df08dbmr2576312qtw.349.1666107596881; 
 Tue, 18 Oct 2022 08:39:56 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.166.161])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05622a124f00b0039a08c0a594sm2083410qtx.82.2022.10.18.08.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 08:39:56 -0700 (PDT)
Date: Tue, 18 Oct 2022 17:39:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
Message-ID: <20221018153948.2ocwejx4ut3sf3br@sgarzare-redhat>
References: <20221014042037.23639-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221014042037.23639-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: otubo@redhat.com, cohuck@redhat.com, liuwe@microsoft.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mikelley@microsoft.com, mst@redhat.com, andavis@redhat.com,
 stefanha@redhat.com, kkashanjat@microsoft.com,
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

I'm not a native speaker, so the following suggestions can be wrong :-)

On Fri, Oct 14, 2022 at 12:20:37PM +0800, Jason Wang wrote:
>This patch summarizes the status of hardening and TODO of hardening
>virtio core and drivers.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
> MAINTAINERS                            |  1 +
> 2 files changed, 50 insertions(+)
> create mode 100644 Documentation/security/virtio/core.rst
>
>diff --git a/Documentation/security/virtio/core.rst b/Documentation/security/virtio/core.rst
>new file mode 100644
>index 000000000000..b8baa104d7c8
>--- /dev/null
>+++ b/Documentation/security/virtio/core.rst
>@@ -0,0 +1,49 @@
>+================
>+Virtio hardening
>+================
>+
>+The virtio core and drivers should not trust the devices. This means
>+all kinds of input from the device must be validated before being
>+used. This document summarizes the current status and TODO for this
>+validation/hardening efforts.

s/efforts/effort

>+
>+
>+Status
>+======
>+
>+The virtio core and drivers has done some basic hardening:
>+
>+* Config callback hardening: The core makes sure the config interrupt
>+  callbacks are enabled after the driver is ready and disable before
>+  the driver is removed.
>+
>+* Descriptor ring hardening: The metadata of a descriptor were copied
>+  and stored in a driver private memory that can not be accessed by the
>+  device. The eliminates the device triggerable behaviours through the

s/The/This ? (not sure)
)
>+  descriptor ring.
>+
>+* Device configuration space validation: Some of the virtio drivers
>+  validates the fields of device configuration space before try to use

s/validates/validate

>+  them.
>+
>+
>+TODO
>+====
>+
>+* Input buffer length validation: The virtio core needs to validate
>+  the input buffer length validation before passing them to individual

Remove "validation"?

>+  virtio drivers.
>+
>+* Virtqueue callback hardening: The virtio core (or with the help of
>+  the drivers) should guarantee that the virtqueue callbacks should not
>+  be triggered before the driver is ready or after the driver is
>+  removed.
>+
>+* Transport specific data validation: The virtio transport driver should
>+  validate the virtio transport specific data provided by the device
>+  before trying to use them in the probing.

s/in the probing/during the probe   ?

>+
>+* Device specific validation: Driver should validate the device specific
>+  metadata before being used by a specific subsystem.
>+
>+
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 673b9f9b8d8a..b33cc5c751c1 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -21516,6 +21516,7 @@ S:	Maintained
> F:	Documentation/ABI/testing/sysfs-bus-vdpa
> F:	Documentation/ABI/testing/sysfs-class-vduse
> F:	Documentation/devicetree/bindings/virtio/
>+F:	Documentation/security/virtio/core.rst
> F:	drivers/block/virtio_blk.c
> F:	drivers/crypto/virtio/
> F:	drivers/net/virtio_net.c
>-- 
>2.25.1
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
