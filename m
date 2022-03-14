Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 11:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ECC681270;
	Mon, 14 Mar 2022 11:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lDaOtqlDjHVc; Mon, 14 Mar 2022 11:18:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C452381272;
	Mon, 14 Mar 2022 11:18:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92119C001D;
	Mon, 14 Mar 2022 11:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A00C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59AB401C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYZGUYT-_LB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4941A40236
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647256713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94yZ8Ee9OWvvJcJtZxzDfFV5QEVi/J74BGlcCI7ylcg=;
 b=iTehklKkmpTJVcP+FtpsUFVyWSNFYjCijtPrP9B8a3Yjf+HW+d+IEkQvI1n5QaNgUNi252
 xqKT2KvJgTJpkImypR+eMuQQtAnkul7B/P8Xa+LOnVJ4uSjnT92f3jY7ECdB1C8uLT5h5Y
 HxqolUhz2APyg8eEET8J05DYd51cx2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384--_DQXpfLMlK9rixiDD5YrQ-1; Mon, 14 Mar 2022 07:18:32 -0400
X-MC-Unique: -_DQXpfLMlK9rixiDD5YrQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 q14-20020adfea0e000000b002036c16c6daso4233988wrm.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 04:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=94yZ8Ee9OWvvJcJtZxzDfFV5QEVi/J74BGlcCI7ylcg=;
 b=JN/4SyJoGCz+kwpcIBSFKhDZ3cATxQOdh9VkpFyqf597pHi+IEKKEUtf3VAjvqiGKr
 hTOJE287YiGL5AzVbR2ZaViQxlgPQedJIgTOUB0dRUhdFD+Fpi6+sjpDRp2mce0Yx7pm
 Cxl88USQy7gEY56vifccBAFj229cI3rcmsyjvyGzpe0IdQV5PpRx4lUdTvjBTCntKONm
 Xklz12TMpzcDmWR4uvSyLhdH69C/EeEotsbI22gBq6n8G6DrHjDptTiaZ/0rwNfNiWE/
 L2q6HJRQxS+hb+yoTvOUrzyGZpEJaGtqqPjm60gS6fqtRJysvLd3ZF1X3bLCCZaBBRqc
 risw==
X-Gm-Message-State: AOAM532vLDOg1SDPMgEpB4a2HMEQkl9wmoUbtn4vFWoKjn0dC24MB5IA
 ZM8OuyLmtilwtJ4AMZpvLms+loWoD8FnECvzKR+vzOuuN4bljy3lZDtOQ4DljkuhRCDLnwBfvuq
 MtjMMxyd6ZOb/I/Hvb4HaEQNFMW/KPFjZ4ZzXV1MLyw==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id
 n2-20020a7bcbc2000000b00388faec2036mr16943568wmi.190.1647256711264; 
 Mon, 14 Mar 2022 04:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq6t7eaj5EJP9tCPvTN7C6me+iJSExdWU5nQ8du+qksKogpsq/sPoFtPdhqRGeALl9NhPdOA==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id
 n2-20020a7bcbc2000000b00388faec2036mr16943555wmi.190.1647256711041; 
 Mon, 14 Mar 2022 04:18:31 -0700 (PDT)
Received: from redhat.com ([2.55.155.245]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b003842f011bc5sm18915646wmq.2.2022.03.14.04.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 04:18:30 -0700 (PDT)
Date: Mon, 14 Mar 2022 07:18:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 01/16] virtio: add helper virtqueue_get_vring_max_size()
Message-ID: <20220314071819-mutt-send-email-mst@kernel.org>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-2-xuanzhuo@linux.alibaba.com>
 <87cziohnhr.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87cziohnhr.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 14, 2022 at 10:50:08AM +0100, Cornelia Huck wrote:
> On Mon, Mar 14 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> 
> > Record the maximum queue num supported by the device.
> >
> > virtio-net can display the maximum (supported by hardware) ring size in
> > ethtool -g eth0.
> >
> > When the subsequent patch implements vring reset, it can judge whether
> > the ring size passed by the driver is legal based on this.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_mmio.c       |  2 ++
> >  drivers/virtio/virtio_pci_legacy.c |  2 ++
> >  drivers/virtio/virtio_pci_modern.c |  2 ++
> >  drivers/virtio/virtio_ring.c       | 14 ++++++++++++++
> >  include/linux/virtio.h             |  2 ++
> >  5 files changed, 22 insertions(+)
> 
> Don't you also need to init this for ccw (even though we won't do ring
> reset there), just for completeness? (Any other transports?)

rpmsg?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
