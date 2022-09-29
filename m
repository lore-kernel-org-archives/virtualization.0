Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B5C04A95
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 02:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C014340FCA;
	Thu, 29 Sep 2022 02:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C014340FCA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9t7K086
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVx1vefrA89P; Thu, 29 Sep 2022 02:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 58BA14023B;
	Thu, 29 Sep 2022 02:30:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58BA14023B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDDBC0032;
	Thu, 29 Sep 2022 02:30:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 517CEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 02:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A32A60F45
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 02:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A32A60F45
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L9t7K086
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7ZxGAgs9uyU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 02:30:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29D2560C2F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29D2560C2F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664418646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QXNXLRU8PMLEfJJoJq8W3G/s1ic9t+BxxX2dS4vHJU=;
 b=L9t7K086vLtjeQl98LHLvl3P7Kbm+tQSQs2/T3xWal6tV2bkNq2es9Gh7I0kIeqjsscmns
 gC2qdY5stxzoxO/tO+dnB2MlP83GpUHF2GJaAUH5fVKSrJnW+odgODVwoCMjh1oSk0tj7i
 MiqIGg87nMnjVuW55a1wwVlNKPyVcfU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-oBATMr5OOzaVcTqj5jlNvQ-1; Wed, 28 Sep 2022 22:30:45 -0400
X-MC-Unique: oBATMr5OOzaVcTqj5jlNvQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-12785ab6ab3so132403fac.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 19:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=8QXNXLRU8PMLEfJJoJq8W3G/s1ic9t+BxxX2dS4vHJU=;
 b=P6Sp4VNyWYby7feWtK+WlaJPk1gYTCePCj4+Av95fBAYM4FaPNvU2ELWXhYSIa8KXQ
 iGngZMlPCbrVjEb4lo1cGKZ5buWPsFk5OMj+SnZZntMaFe1Vyl80KwCzGUX8S1oF1ij9
 2l+54/6uXn35gfxw7szI6ZS805UBmWa0eAI3GzxzYjwc9PVSy3L5cJYVUI/p3xyhrNz/
 Ncyztm5Z6nHSIo80ppE/qGlRcle9n4FP+D8a2W2fa5pbOol1yCTNGMcoGrhbawzzbpeU
 3mVmoMKef7tGM9v0TrfZIJ814VEE5+s8tWEbdHwihBA+eRUronujB0Z+pZ3GT3mNU+Fe
 9ewg==
X-Gm-Message-State: ACrzQf3UssLgfrohuhR5Gqc6glJT0fEzWTIbVPyb1bcEb3fs8T/4xzmC
 0U9BI/DuTsG/m/sSg99Ayy30/RZCQ/3cRlmwilcAlLm7axWd4aFn4Pd2kSdDK4WypJRjZjzxqMN
 pCOecqETN8odZS0CWGPJkq7dD6o04fv1CJ/wcIJWTp0bVq4ZrrMHsP2IasQ==
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr5693951oib.35.1664418644867; 
 Wed, 28 Sep 2022 19:30:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cxjoIrT/eaGTsGJqz/dQ3DlD17JUKEQBrtUsl3H1pjCxun/bNtxts+L+mNLuXNM3li37fisri9ZvMxKU3JK0=
X-Received: by 2002:a05:6808:1b22:b0:350:c0f6:70ff with SMTP id
 bx34-20020a0568081b2200b00350c0f670ffmr5693942oib.35.1664418644678; Wed, 28
 Sep 2022 19:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220928104628.521-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20220928104628.521-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Sep 2022 10:30:33 +0800
Message-ID: <CACGkMEtaMRifeDDDk3kb7QY-1mO1V2t6PFjgRXwRoN8NbRaD=A@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Wed, Sep 28, 2022 at 6:47 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The background is that we use dpu in cloud computing,the arch is x86,80
> cores.We will have a lots of virtio devices,like 512 or more.
> When we probe about 200 virtio_blk devices,it will fail and
> the stack is print as follows:

Not for this patch, but I wonder if it's time to introduce per cpu
virtio interrupts instead of per device ones? This may help in this
case.

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
