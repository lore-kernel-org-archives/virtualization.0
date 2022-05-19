Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB76C433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 16:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6A40612F2;
	Thu, 19 May 2022 16:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cb3y4qd365Ux; Thu, 19 May 2022 16:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66A0C60F6F;
	Thu, 19 May 2022 16:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A8ABC0032;
	Thu, 19 May 2022 16:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD2D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2A4841C0E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PEUmcYXNMbbM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5378A41BBC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652976284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cn9DGsidYHLKIgSfwQZyuGk5MNvO4cusQzW9CGpB6cM=;
 b=LbpIyEBfDzOPyhC6wR+8x3Ti/ZW1M5DVKCgkmDEkN4V7KPUxzB7bNRfEKnMwgwR2flI5jj
 4szAcoTzQYhvfUvDB7TAhE4iO5/fc8Yj2FCtYlLOfnGCykD63w7AtiRN2os2KBz7ZzDhbT
 pfcbUKVLinHBMQM631RHl8TVOnzK2JQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-kYMfccxGM3iiS0-xdaLzdw-1; Thu, 19 May 2022 12:04:42 -0400
X-MC-Unique: kYMfccxGM3iiS0-xdaLzdw-1
Received: by mail-qt1-f200.google.com with SMTP id
 g1-20020ac85801000000b002f3b281f745so4564275qtg.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cn9DGsidYHLKIgSfwQZyuGk5MNvO4cusQzW9CGpB6cM=;
 b=yy+uHXVmdL8mvocnySwedH5FI2puyKAeISvjmqSxal6Q5pILAMY4HFHo8mYZp1uifT
 X2Pkk7bpXJREDaaNAZWdGi67lBdm9c74F6QL8YrTPtJXeU+LESv5Yf9BgaMfZE8ugzjt
 xdEKPF8yMStGqr1wUSn+nZc2jyGusysnhD9gouaSwM4FeRdvspKeA81sWwTEFFAeshX1
 i6K0XRCTNOvOITR7cH3UvpKdMVeeSOkiYblUrhK8WwUF9H+wGV/7JccX5Ej+V5mPdCW4
 ahpnCSZyxuvfuERxhBJguxelI8L1MD7Wc1gXpb4JRjvShmVEvF6ElvusOwLQ8zsUHB0d
 nz7Q==
X-Gm-Message-State: AOAM533IK7laNE5AVhAbIff9VmX8VfU16D5MTRzSEksY8fshMv4fSWoc
 XVkXatgyKviEW48hib50s4lI3IMZHiBNiHQ1RQHsrLY2WmpsBcjmVPU+K3mAexIb5iE/KQYZLAB
 FYCk3w4+TqpunxfmaghZM68FvPCHoSHHA7Q7FANrYEQ==
X-Received: by 2002:a05:620a:29c2:b0:6a0:5fac:2f45 with SMTP id
 s2-20020a05620a29c200b006a05fac2f45mr3340503qkp.529.1652976282236; 
 Thu, 19 May 2022 09:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Oj1i3ECAaRC8bD7Zm1tmm+5AblYIrHtBAeojqUV3W8R84H9LagTNe0ivlgrCeQ6ZxU1Wmw==
X-Received: by 2002:a05:620a:29c2:b0:6a0:5fac:2f45 with SMTP id
 s2-20020a05620a29c200b006a05fac2f45mr3340446qkp.529.1652976281677; 
 Thu, 19 May 2022 09:04:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 z10-20020ac87f8a000000b002f39b99f6a3sm1590625qtj.61.2022.05.19.09.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 09:04:41 -0700 (PDT)
Date: Thu, 19 May 2022 18:04:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] vdpasim: allow to enable a vq repeatedly
Message-ID: <20220519160434.5s5jzwdmajewpqvg@sgarzare-redhat>
References: <20220519145919.772896-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220519145919.772896-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, kvm@vger.kernel.org, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 lingshan.zhu@intel.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 19, 2022 at 04:59:19PM +0200, Eugenio P=E9rez wrote:
>Code must be resilient to enable a queue many times.
>
>At the moment the queue is resetting so it's definitely not the expected
>behavior.
>
>v2: set vq->ready =3D 0 at disable.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Cc: stable@vger.kernel.org
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
