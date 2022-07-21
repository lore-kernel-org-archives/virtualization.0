Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE139CCA488
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5122B60ADB;
	Thu, 21 Jul 2022 09:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5122B60ADB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iw/Imv9P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saQlGY-G6utg; Thu, 21 Jul 2022 09:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ECE58606AA;
	Thu, 21 Jul 2022 09:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECE58606AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C55DBC0033;
	Thu, 21 Jul 2022 09:17:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78671C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44AF9405F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44AF9405F7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iw/Imv9P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D-dJO62a4TkL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:17:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 961AA405EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 961AA405EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658395048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bR+13URxlsE5fUg4TpB1VjQB2DqN5gnlwoyPW0ASkV4=;
 b=iw/Imv9PmgfqY2qXC2EKYrZ2QZrmrOPnLZWVlIJrClIIoC2eootbWaV1/k8+Wj8norcKjL
 07zBOwqSdxJwnD6+WZptfJPrVLmUTjS5pOs2/0w+rj6SNra6MuDBeT0PCwnGupwZOJaBwf
 nSMqF58TPQiF2JtQ7hD6eCkfi3LL1s8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-n0m1cNFqNKmzYelRHU-lng-1; Thu, 21 Jul 2022 05:17:27 -0400
X-MC-Unique: n0m1cNFqNKmzYelRHU-lng-1
Received: by mail-lj1-f199.google.com with SMTP id
 z11-20020a05651c11cb00b0025d8baefafdso157116ljo.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bR+13URxlsE5fUg4TpB1VjQB2DqN5gnlwoyPW0ASkV4=;
 b=7eny0LnH7uQFM0mwdkjuGJI181gGsipBJsldTJecDN6eNRwEuTjniG9QCMS2J+DCNL
 1fXeL2Rn+eV8au8KKPSq7VhRCQVCn6eOHI4ngMbefwaPxbZEQga4dYjfvYqVa6A59n4i
 l8rwPQQcRd5HBMmlZp7GbCxErZSYEod45imQGrlk3oz0ivYdC3HldvC+thx8ps7PUIdQ
 FRzm+3INj56nWFXp9zA8rrUwSaJi0Vncnte1zVHjUtV4OEmpcsYlVkY/iUZSxtFnj5Bn
 bP+1mhoW2YGGwYCQ8/C+xbHdX+1kDVNO/aGeOMDAi2GllF1qcuh1NmuTkdZLiCwfScLR
 yTqg==
X-Gm-Message-State: AJIora/oKK5vGF+j6ZE7L4Lm29s782LRLY6th7tkeAgjcwfeVMji/cg5
 eX9FKHT0bj66o+LHX1N179U434Ws17TBg8/NxnMyBT3Ye2Gn1vmWzjpDzGlWuQBkO0wSih8UfoL
 CWSv91DtyXHr7Hcu27oir8lWG1RmpRhe+PBhH+PHjXNdnwaWFzAxLXCRQ2A==
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id
 o12-20020ac24c4c000000b00489fe2cc877mr23999865lfk.238.1658395045576; 
 Thu, 21 Jul 2022 02:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u24Xku7CH2NvwPr1v5mlb7apJiFJtOLNJ3rS6Tv1FeUAK8VufO6AwqK+LPzXVGJzRjJ+q60K4VfTtan1dp7c4=
X-Received: by 2002:ac2:4c4c:0:b0:489:fe2c:c877 with SMTP id
 o12-20020ac24c4c000000b00489fe2cc877mr23999841lfk.238.1658395045042; Thu, 21
 Jul 2022 02:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Jul 2022 17:17:13 +0800
Message-ID: <CACGkMEtvjy1_NYHOV=VKMWcggYnOUBk3PRue=t0Kd4wtHjfzQg@mail.gmail.com>
Subject: Re: [RFC 0/5] In virtio-spec 1.1, new feature bit VIRTIO_F_IN_ORDER
 was introduced.
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Thu, Jul 21, 2022 at 4:44 PM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote:
>
> When this feature has been negotiated, virtio driver will use
> descriptors in ring order: starting from offset 0 in the table, and
> wrapping around at the end of the table. Vhost devices will always use
> descriptors in the same order in which they have been made available.
> This can reduce virtio accesses to used ring.
>
> Based on updated virtio-spec, this series realized IN_ORDER prototype
> in virtio driver and vhost.

Thanks a lot for the series.

I wonder if you can share any performance numbers for this?

Thanks

>
> Guo Zhi (5):
>   vhost: reorder used descriptors in a batch
>   vhost: announce VIRTIO_F_IN_ORDER support
>   vhost_test: batch used buffer
>   virtio: get desc id in order
>   virtio: annouce VIRTIO_F_IN_ORDER support
>
>  drivers/vhost/test.c         | 15 +++++++++++-
>  drivers/vhost/vhost.c        | 44 ++++++++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h        |  4 ++++
>  drivers/virtio/virtio_ring.c | 39 +++++++++++++++++++++++++-------
>  4 files changed, 91 insertions(+), 11 deletions(-)
>
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
