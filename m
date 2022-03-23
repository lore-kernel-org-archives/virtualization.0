Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A4EC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5CB541B75;
	Wed, 23 Mar 2022 13:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WHcZQhyM8le; Wed, 23 Mar 2022 13:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88C9041846;
	Wed, 23 Mar 2022 13:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 628A3C001A;
	Wed, 23 Mar 2022 13:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E43BFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5E6461389
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PO-hCg5o-YS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F187060F4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648041730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=suvndhg5i90sE3alVpWaoy01Es5EJ/QlvWcm+elPd0I=;
 b=FgU+0eOeaFnECfgba/NpMTbwe7BhZ959PsuLJKHykEcLfwYQRNNC2xPoiZlHWWtMGyatvB
 fYu6fGC0sRSNtfkpXR5VKrJVtMMHs/gtRqYGwTdvMQlOLUs62Moy5lNZG2aU+DhY079IJ2
 nejvFEuRSk9LkyVoKzuGy6k9XkFzXSY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-qDpagPe_MEW2ZI_wwUSUQA-1; Wed, 23 Mar 2022 09:22:09 -0400
X-MC-Unique: qDpagPe_MEW2ZI_wwUSUQA-1
Received: by mail-wr1-f70.google.com with SMTP id
 p16-20020adfc390000000b00204006989c2so510330wrf.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 06:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=suvndhg5i90sE3alVpWaoy01Es5EJ/QlvWcm+elPd0I=;
 b=5N65V0zUCnaZkUn0mReRz/RDAATN+zY+Oo6wpblksLRhMYOlzEBkb6Z6C8Qo28CBRy
 ZMwXCXK54KGnYfkajwQ3NXmB2m6PGrIw9Hn2J1+BdZBV7I3oNeEtd0xRHhRhvTNBCYeQ
 mL518D+uRPabqaB9duQ9rC33uo2K/mPmJGKvI6zkLT/3o+cCFGusXjQInmtCO2D2TIiD
 kVWBKB2pe1ZNqSPQW/ARVBnK0+iZ63wI0Lo0dva0wufGuyFa5hYMAnmfEEqmCiBPaBbD
 H/C0c5bsiCSNwAumWEjgBb9qaRuD/ZQJvK8mZKrShsNKa4UZ1opSpa/9vsMRPHXBzOi/
 C9sA==
X-Gm-Message-State: AOAM533HEMSxwj/8274fvw989Z39X4BRGLvmtdpaDHKJdeAgDS9dt5rb
 +YgpTcxmtKDDG2PmXHln9+Dx5KnBgm+VKdGwThHyOtOaYhGGrvdOHyj/llsEtkGJgErmivj8cE1
 ELuGh9RdXerNF10K/o0DIgpLzy8RkTnv5YS0l2q4IdQ==
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id
 y7-20020a05600015c700b0020587a287bcmr2861198wry.260.1648041728540; 
 Wed, 23 Mar 2022 06:22:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyp9kjUHrJnPA7iyjXS+pAxAeSdHIG+pVsNH4tY9VWV5thpBNO3b44rofEKgNXV0UAniIaJg==
X-Received: by 2002:a05:6000:15c7:b0:205:87a2:87bc with SMTP id
 y7-20020a05600015c700b0020587a287bcmr2861171wry.260.1648041728292; 
 Wed, 23 Mar 2022 06:22:08 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 g17-20020a05600c4ed100b0038ca32d0f26sm4091594wmq.17.2022.03.23.06.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 06:22:06 -0700 (PDT)
Date: Wed, 23 Mar 2022 09:22:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2 0/3] vsock/virtio: enable VQs early on probe and
 finish the setup before using them
Message-ID: <20220323092118-mutt-send-email-mst@kernel.org>
References: <20220323084954.11769-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323084954.11769-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Asias He <asias@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 09:49:51AM +0100, Stefano Garzarella wrote:
> The first patch fixes a virtio-spec violation. The other two patches
> complete the driver configuration before using the VQs in the probe.
> 
> The patch order should simplify backporting in stable branches.

Ok but I think the order is wrong. It should be 2-3-1,
otherwise bisect can pick just 1 and it will have
the issues previous reviw pointed out.



> v2:
> - patch 1 is not changed from v1
> - added 2 patches to complete the driver configuration before using the
>   VQs in the probe [MST]
> 
> v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/
> 
> Stefano Garzarella (3):
>   vsock/virtio: enable VQs early on probe
>   vsock/virtio: initialize vdev->priv before using VQs
>   vsock/virtio: read the negotiated features before using VQs
> 
>  net/vmw_vsock/virtio_transport.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
