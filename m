Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF7EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 12:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E90660C19;
	Tue, 20 Dec 2022 12:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E90660C19
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TuqQSVhG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OCRdbazEjNVF; Tue, 20 Dec 2022 12:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EDB4F60B92;
	Tue, 20 Dec 2022 12:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDB4F60B92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25B03C0070;
	Tue, 20 Dec 2022 12:52:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86200C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 640304053E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 640304053E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TuqQSVhG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TxRM_8OYNKC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96C29400C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96C29400C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671540728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
 b=TuqQSVhGLDXNhqVlsVPL5rU0XOqt3bZpqyBAiEOoM8DzRZrMRgRNoEHvGfeUgt7ykBBTky
 JRg9YqQLLvZ1j1ye+wkbmkowZ32fUyVdvdI0IAYqCXhPu/SrgU5xNkcMirJLZoYDsAeVxW
 pq4T5LX7brNwK+8lCyLZEcK9a87Evuc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-IdlcA8bCN5yyAb4jiVXxSg-1; Tue, 20 Dec 2022 07:52:07 -0500
X-MC-Unique: IdlcA8bCN5yyAb4jiVXxSg-1
Received: by mail-qv1-f70.google.com with SMTP id
 nt2-20020a0562143c0200b004c74f7ec3afso7014228qvb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 04:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
 b=hwBSxa+SA8BZ02jfsbXqTAQKBoY42qsXBod3Gbcp3DImbwQH6GH9b3qeb2ThruwwbS
 YI7BIbuN4qXZKOdM4GbYPeCPna6gUVswoMFmARz8qYJL/zBJ55HnmlID1DUUlPm1/NHx
 OXPyGTB6x0Q0LAQV/Tnmee+miUl01qyHJr2HvoyWZhCWqn1AevHeBc2AUGJ+5M08E1qE
 zkdnS2FezNZMagCqhW6fuHkZsKN8nrlHIHpcvp8b5YVpTOH35FhB9jazCMnaShFRXs65
 LsUtUs9n40tqabwyA8/9zhpAbtYo3DdtT74HgRWq2JOOgap/6ft8YU7VVuRopvFMFL86
 DyEA==
X-Gm-Message-State: ANoB5pmCQPpM0MMLsdQHxDo0P3qVCjuGX4kM9ah/8dB6oxGcXMszVYQX
 LpvoSJ60+rgu7V5ilNVFeJ32ROL9+B2Zb2zRyYhyfMjTbXdHsbaxxO4KXLYbKRGDFfEMb8C/ALy
 ieRFc+gGrBzrRX8womeZQLCaZX1hRl67gGlExrZI3vg==
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id
 b4-20020ac86bc4000000b003a81d3c47e9mr43531120qtt.48.1671540726782; 
 Tue, 20 Dec 2022 04:52:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OPTSizknvCW8hT8hFc92s3UWJz2R3Fi5ZFpNOvn/FDZ7TfsX9i098IAGzf0JLhm5JkP5L8A==
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id
 b4-20020ac86bc4000000b003a81d3c47e9mr43531096qtt.48.1671540726541; 
 Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 r17-20020ac84251000000b003a50ef44a77sm7507788qtm.28.2022.12.20.04.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Date: Tue, 20 Dec 2022 07:52:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: zone append in header type tweak
Message-ID: <20221220125154.564265-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

virtio blk returns a 64 bit append_sector in an input buffer,
in LE format. This field is not tagged as LE correctly, so
even though the generated code is ok, we get warnings from sparse:

drivers/block/virtio_blk.c:332:33: sparse: sparse: cast to restricted __le64

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 73cd5db0d7d5..dc577e8bfa30 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -104,7 +104,7 @@ struct virtblk_req {
 		struct {
 			u8 status;
 			u8 reserved[7];
-			u64 append_sector;
+			__le64 append_sector;
 		} zone_append_in_hdr;
 	};
 
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
