Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5AFC433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Dec 2021 08:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3418B60A99;
	Mon,  6 Dec 2021 08:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTXbPrRtwgIT; Mon,  6 Dec 2021 08:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CA5660A90;
	Mon,  6 Dec 2021 08:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09F10C001E;
	Mon,  6 Dec 2021 08:41:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E9B0C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35FB440462
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cX3R5tOBPIlQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BDA140461
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638780079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWGpIh47snyALgTQHCz30lE3sTFpFQWexm7titSzVRI=;
 b=bFzzM5mVbExASWPES66Ywhq/LsxU+FdSvs9OnUcoo4uXFkzazPZ8gOHT/ffS8+TJLVKBV0
 +Fy+HrhCqBWvAlZj2EOBi+qAcLmBSNtnZJvjdABIvsoPJa8DxN4zVF0AUBiUfcckoI60vY
 Emvan2e3yc6Rf/NliGjnlneqgNenZmg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-IHQGzT9LPrmf_IupbT3MPw-1; Mon, 06 Dec 2021 03:41:18 -0500
X-MC-Unique: IHQGzT9LPrmf_IupbT3MPw-1
Received: by mail-lj1-f198.google.com with SMTP id
 h17-20020a05651c125100b0021ba28cf54dso3172035ljh.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Dec 2021 00:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWGpIh47snyALgTQHCz30lE3sTFpFQWexm7titSzVRI=;
 b=jcg68EMsc4RtiySHh9dcsO7eV4LKvoJ3Frzphx+v9qWyaSBTqSyUqzZHSsSigJ7/Dp
 LlQG9YWWSmQVjUk7DkYxPrk/o43ZB2qo5gKKZS0VtWrOAaZI8wL1jznQmWmgNJvTnDfA
 SGpeSlEkcM0HLWOI+IyJz4/D56Biip932GI9HtB6SiFnAP5wL//aXH27frypqCIJF4An
 vUvgy/IMfMw6Oswt+4brHH97yTRIif1WwHLHJjG75ftP2XxwuakDcWL+f3m3tTnj/3Oa
 m4SE0xbj2tMPI5/78k05nWxxhCH/iPADaH8en/9qCaLFhPwxzW+UtmuqiTmM/PDxVKpS
 v1sg==
X-Gm-Message-State: AOAM5328q2z+QnPR7jcINumNE8f7HN5mvZGwm6Q/x/9ylGIP/wlmE4mE
 C2hqb+wtpapyBHOGG0XA1NqauWB6g+5niz8NnvByOTtUJUFGuK+VzKC6vjw7yo+2eZ0Yl3uwzmp
 iXvp7dYqIn7X4oHijAlsgSo+sPYHTOqw0WhWLwytVcgRiDkIFTNYG4Sx1+Q==
X-Received: by 2002:a05:6512:3987:: with SMTP id
 j7mr6521996lfu.199.1638780076536; 
 Mon, 06 Dec 2021 00:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxymmwV6ZMLUAEdWBv6GE+nuHZ0FknR8xBSnM6wo3F1m8O/VtZ+7SnlzVmzqgqKI9rgjdwSd/zbzIcRywJxbrc=
X-Received: by 2002:a05:6512:3987:: with SMTP id
 j7mr6521977lfu.199.1638780076299; 
 Mon, 06 Dec 2021 00:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org>
 <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
 <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Dec 2021 16:41:05 +0800
Message-ID: <CACGkMEs-Y=67owrS9f4Spg+y5qg3p6CQ-S+Bcu=nOHZ5d0BNbQ@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Dec 6, 2021 at 4:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 6, 2021 at 4:12 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Sat, Dec 4, 2021 at 2:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> > > kernel runs into a link error:
> > >
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> > > eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> > > eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> > > eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> > > eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> > > eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> > > x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> >
> > Intersting, all those belongs to the legacy library.
> >
> > And I just have a try and I can complie alibaba eni without
> > VIRTIO_PCI_LIB is set.
>
> Ah, so the problem is in drivers/Makefile:
>
> obj-$(CONFIG_VIRTIO)            += virtio/
> obj-$(CONFIG_VIRTIO_PCI_LIB)    += virtio/
>
> We only enter this directory when one of these two symbols is set, but
> in my randconfig
> build, neither one is. I'll send a new patch.

Yes, we need to include when VIRTIO_PCI_LIB_LEGACY is set.

Thanks

>
>          Arnd
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
