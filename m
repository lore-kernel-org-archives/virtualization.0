Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F668EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 11:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 352EA83B88;
	Thu, 22 Jun 2023 11:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 352EA83B88
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HKcWs6DP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smSI-NEr5iGC; Thu, 22 Jun 2023 11:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE7CC83B47;
	Thu, 22 Jun 2023 11:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE7CC83B47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8D33C0037;
	Thu, 22 Jun 2023 11:59:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7F7C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B11B341FBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B11B341FBB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HKcWs6DP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5D2pj23EvyY6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:59:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF06C41F7F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF06C41F7F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687435151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
 b=HKcWs6DPAhU6wfPnHBl6G6Jy2lxAo47NSLCmBXEfeoO9iYb2vuqc8aqpgKWA5HPgrcvnV+
 saFjDIBqwl6RgNIDlRcw7k3z1ZPXrFs7namUC2su4EBicuGWq4G+hS35jVJEvKJSVAHjkB
 bQ612WGXELIjTpKkJMoDMLcARRUFHX8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-y3asSUsPMDesBGgC4vQvOA-1; Thu, 22 Jun 2023 07:59:10 -0400
X-MC-Unique: y3asSUsPMDesBGgC4vQvOA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9885a936d01so362607166b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 04:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687435149; x=1690027149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTTkA2sp2q9Z2LAXZ1QDFqA4SF11T5ulFHu3zl8eY5M=;
 b=IdQ2qpM+HgY0zHgMFPOB980XFsa487d7tYab127jngHyXSOr3LgbIyylZU1uN+DQ+d
 1xcVj/HvdZTK6d3l9u/zmXXWeR4iRtj1UmnennHZ7A4C0MxeeqlIEEgOiSAKWPhGZa+X
 E5tb/LnegJKCBL2PNv5JTllzaFKqy0fGp3U+5XBY/i/CvKAbqt5XgCPMvQj8pwF/BB0V
 rhSDG88UIBTM3oWgcbxt66f7i+PFbuLwNBchJ5XxnCQ12jEtOfrfvAgVcLngUhYasYoP
 eSnjI5b84EpZmvY930LguvYjYROberFU8zVnRjXhWse+WfAa1Cm/YaAWVgpt0wqeA3cy
 ph5g==
X-Gm-Message-State: AC+VfDxhkf3nn2AN1uOTbQXrYPwJAH5dsDiOTqUEuxEFQG6pzt9n4a/S
 ZxWpwTZmti6C5K3V27A86ilrHA3PHXtlha5M9Sk1CqAPcb2pCe16PZsy95mUtt5sp3nI1Zt4PB5
 IwjMFm1QZxH5EW/ve9ATXtp3ZloUrAriac6RabrhcSg==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id
 go34-20020a1709070da200b00988e8e16360mr8670201ejc.8.1687435149350; 
 Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60H5p6tlUuyW+YXWTMB9vjFrAWl14WNSb9PT+fUHAJkRDpLgoKLJFf4fBEpXMrE8mEIpD8PQ==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id
 go34-20020a1709070da200b00988e8e16360mr8670182ejc.8.1687435149020; 
 Thu, 22 Jun 2023 04:59:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ef:2a1f:ee44:7b4f:4310:5b81])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm4484108ejj.49.2023.06.22.04.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 04:59:08 -0700 (PDT)
Date: Thu, 22 Jun 2023 07:59:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 0/3] fixup potential cpu stall
Message-ID: <20230622075819-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 amit@kernel.org, gregkh@linuxfoundation.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org,
 luiz.dentz@gmail.com, davem@davemloft.net, johan.hedberg@gmail.com
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

On Fri, Jun 09, 2023 at 09:18:14PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.


I applied this after tweaking commit log to address Greg's comments.
In the future I expect you guys to do such tweaks yourself.

> Xianting Tian (3):
>   virtio-crypto: fixup potential cpu stall when free unused bufs
>   virtio_console: fixup potential cpu stall when free unused bufs
>   virtio_bt: fixup potential cpu stall when free unused bufs
> 
>  drivers/bluetooth/virtio_bt.c              | 1 +
>  drivers/char/virtio_console.c              | 1 +
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
