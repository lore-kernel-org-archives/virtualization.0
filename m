Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:37:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD8A60EDF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EFD8A60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B655C404BE;
	Wed, 27 Oct 2021 02:37:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkheIunrI-AB; Wed, 27 Oct 2021 02:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6DC8A404B6;
	Wed, 27 Oct 2021 02:37:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41861C0012;
	Wed, 27 Oct 2021 02:37:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC6FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4F46404BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u40cLR0ESEWR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:37:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43889404B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635302249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/QyiQUpgKsOG/cjdPPM0OAFVzZJ4RB+AB4nqT/l7qk=;
 b=b2mGtPTIyR8mVMW2UKICFwXCSV+OhVT7KopgY/SX7Mdu0PVZvJ63CPCPvqXNF3CNHWx44R
 WNnwCUK3g7CXTTlzIh0aF/fW6KXpV6VrHiiWYmehNgUiaDj4O86/YACLzaB4HH8F2kfdZ5
 MQUOvtu2Nsuflem4ahcmgTh7WV60lOs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-EBYLasl4Oj-wmHmEYpi9_g-1; Tue, 26 Oct 2021 22:37:27 -0400
X-MC-Unique: EBYLasl4Oj-wmHmEYpi9_g-1
Received: by mail-lf1-f70.google.com with SMTP id
 c41-20020a05651223a900b003fdb648a156so646335lfv.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 19:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a/QyiQUpgKsOG/cjdPPM0OAFVzZJ4RB+AB4nqT/l7qk=;
 b=mnav5YDxpXbZuUdPrmxiyBtXHUbajM9XSxQnT71ucx1h+Q9NHahpzYG0ooC/bMXaaA
 PtEx008V17wzVxMDNdrmHUaAeiLyc1OlvVTtB+85tn9syMkmqebAfJjYXfqaKCPiyXWy
 0mJsKbDzowcZspeo6YZj4UaoVyyPbhp1KURGauhvQD596Sq+MxoVIyktbRyNddGbAjOr
 Bb2s5DBrDO7zBo9mUht/rY6xsdM7u7/3ye4MqdvddVS7BlaATHkbITFkS0t830x5K42b
 YBgaP8ELX+OupOnOHQXogDFdhPZ9NHnt20vAhHeFKvULvLV1o2Y0pw6a03o0iWKzWHLO
 JQrw==
X-Gm-Message-State: AOAM530nou8p5G0CGRdAsyfGbdwEzGLE+OKS/2KOCCjaLaYX9FJy3uqw
 VWcU79sULrooMvUwSFVtqdeKtFx6dawee8z6UH0llGbSuutu7MTQFgHcw1hK6VWbrb1T2bNJm4A
 Y1/P2REPCPeSk9ZnlHv5efldQNFGL0s9SNx/rMTZDfkqUbqDFnUBqZPgWwg==
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr4837433lfs.348.1635302246312; 
 Tue, 26 Oct 2021 19:37:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmO0YmiqgEcYfuQMIcBEjDNbuvbcTM2ziLI1KoxFqXTo8sonq9p3tYxb+D/WfdElwlmRq0nkzK598R6+coRfA=
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr4837421lfs.348.1635302246139; 
 Tue, 26 Oct 2021 19:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211026134725.345020-1-yangyingliang@huawei.com>
In-Reply-To: <20211026134725.345020-1-yangyingliang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 10:37:15 +0800
Message-ID: <CACGkMEtQFSxLezBiPofS3C6bL-AZEx6VgQKQrF-JP9hCNmQojg@mail.gmail.com>
Subject: Re: [PATCH -next] virtio-pci: fix error return code in
 vp_legacy_probe()
To: Yang Yingliang <yangyingliang@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Oct 26, 2021 at 9:39 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Return error code if pci_iomap() fails in vp_legacy_probe()
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c3ca8a3eeb54 ("virtio-pci: introduce legacy device module")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 9b97680dd02b..4ca3ef38d3bf 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>                 return rc;
>
>         ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -       if (!ldev->ioaddr)
> +       if (!ldev->ioaddr) {
> +               rc = -ENOMEM;
>                 goto err_iomap;
> +       }
>
>         ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
>
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
