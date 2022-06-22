Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476B0C43334
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 15:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6B4841A43;
	Wed, 22 Jun 2022 15:39:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6B4841A43
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWxc6hI7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQwXEZrV-g4l; Wed, 22 Jun 2022 15:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9750F41B4F;
	Wed, 22 Jun 2022 15:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9750F41B4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7648CC0032;
	Wed, 22 Jun 2022 15:39:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80D80C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4556F844FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4556F844FA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWxc6hI7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jz8RGGXa7gRF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B7F0844F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B7F0844F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655912382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=mmuSHgKDVltBBaocwx3EquASJGmTmEFdcWeuv/KlcRw=;
 b=aWxc6hI7SsoOMlldsfa+qOHXBWwNvrMe3UZaiD93BW9fnlVvfy/VIqZq4Dejw1R2cgb0rn
 drtmA5bLR+KUUQ01Z38dOhHdkmeFwcRQn06MQKJ3ZaWo+Prflaj4PIva2PjO7Gy3nyE96U
 6I4qq9CciWZEmw7VHvpXjU5E2p3ZpDY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-sgmVdPuiP2GfX_4xkaAcFg-1; Wed, 22 Jun 2022 11:39:41 -0400
X-MC-Unique: sgmVdPuiP2GfX_4xkaAcFg-1
Received: by mail-wm1-f69.google.com with SMTP id
 c185-20020a1c35c2000000b0039db3e56c39so9359wma.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=mmuSHgKDVltBBaocwx3EquASJGmTmEFdcWeuv/KlcRw=;
 b=Q6ZPK1tFrmfPVB7kJrOr/lrfqXcNq4Asn0PARTbQ+e/bNxGpDtJwd/uGx5P8Z8nIwa
 UAnLojscpYzjqvwD7t5TFBBC/sUqnrl4y65aZ2641bBtivC1W7kG5T1El5tUOWSJg+KL
 6Y2A5adwqJSlUw7dYpk64U5l7diGQXQHC4gI4oRkRGn0vR001lxA5PJqhH0R9ILwGla8
 VgIjMv2gyHXrt41BQj5UttiZWUUVA9UXEF06q034vrLsUasUbeiU37OXbtzwqKRzm6Sb
 +5VS/1dUE7ogIzdGsqbcfvIDgV5iYdGmARQkMv1dCSc155ur5CgIss42fSQy15MuQhYE
 +oJQ==
X-Gm-Message-State: AJIora/zxzs5cCjOQsuacwBdFySpWiecqHEdd7o1zXy+Nn2/OpUawZil
 08IYc055tSfWDnydpO6d7s7TE1vTiIRPwRxshWG+++blHpY8ZIxW29xahKb+s+1PywtuZxk0mkR
 FQGUcpFQ9ibjNyFv5u6aSoF5iNxL2NvKl76fMLZyF4A==
X-Received: by 2002:a05:600c:3d09:b0:39c:8244:f0 with SMTP id
 bh9-20020a05600c3d0900b0039c824400f0mr4596280wmb.118.1655912379912; 
 Wed, 22 Jun 2022 08:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1suwP0/q7LdWOLozhlFqGtO4AS6K806ttJOK37+C+F6RXlaflIDVvUBzaaj64wEPX4DzF3Zjw==
X-Received: by 2002:a05:600c:3d09:b0:39c:8244:f0 with SMTP id
 bh9-20020a05600c3d0900b0039c824400f0mr4596258wmb.118.1655912379652; 
 Wed, 22 Jun 2022 08:39:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 l1-20020adff481000000b0021ba1b6186csm1884068wro.40.2022.06.22.08.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 08:39:39 -0700 (PDT)
Date: Wed, 22 Jun 2022 17:39:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: vhost-vdpa tests in tools/virtio
Message-ID: <20220622153936.to2yh5zixjevy4r4@sgarzare-redhat>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Hi,
while developing/testing the vdpa-blk support in libblkio [1], I 
realized that we added several regressions with the "[PATCH v2 00/19] 
Control VQ support in vDPA" series (patches/clarifications already 
sent).

To minimize these problems in the future, I was thinking of adding tests 
for vhost_vdpa in tools/virtio using vDPA simulators as devices.

What do you think about this?
Before starting, please let me know if we already have something.

Thanks,
Stefano

[1] https://gitlab.com/libblkio/libblkio

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
