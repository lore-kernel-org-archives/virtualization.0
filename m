Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E21C433FE
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:22:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB74610E7
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEB74610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A533F606D5;
	Mon, 18 Oct 2021 09:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spJHDOHFOAtL; Mon, 18 Oct 2021 09:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 735AD6060B;
	Mon, 18 Oct 2021 09:22:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45EC6C000F;
	Mon, 18 Oct 2021 09:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23CC6C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C60340464
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j27Ow6-V5pqo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:22:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FFB440463
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634548945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCgIcEli4Hy6fZUSUfvUzm3uph2JXpVHIhNHgqUR3PM=;
 b=CzxsKNxq1XmCj43YXX9lvG1rkaPrLqz5eRrjIulWbIYzwIrUk9D7rtt7Rw8skpW24DRqxl
 9c3zm5uMHI7RE5nllm39j6+gWxxINaJtXCftj8KQdk85HD/9qzyIOqJtScBG0T4mnbiLnK
 FGrDFOQB/ClvR8mP6F30qtXa4vdGyA0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-fXCGADpzP9-fwIJH0Ilg-A-1; Mon, 18 Oct 2021 05:22:22 -0400
X-MC-Unique: fXCGADpzP9-fwIJH0Ilg-A-1
Received: by mail-ed1-f72.google.com with SMTP id
 t28-20020a508d5c000000b003dad7fc5caeso13754536edt.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NCgIcEli4Hy6fZUSUfvUzm3uph2JXpVHIhNHgqUR3PM=;
 b=rJsLup1GNUahhec/ggykWtZ8rM3TTOClPijvyLe5Di4o/WKs/+SerMuW/LnRi2CZNg
 q3nFIftNivafFtmI3gSZ+D47KS58jdq5F4HDKyRDelnfrH+REALBgF/ZOhpv/VM74FdC
 VpFsFUb9+Kb3TakYFYon9bEvbItRq0rsz7zvpJBvK00NbmRTVU1rVly3+WYs+MOMddqn
 u3l0T9horSKzQ4qLfqpEOzFa24peG5Dlgm+yrIFp8wdKgrZw2CcwW/KsmEYeESbl2nDp
 Ivl8tQivlsXQI/y35Isse2QM+ZOle7QSKeAW7Cs6t9N4rVxw5BCMb5JoyYgYiECGHs1J
 Vhdg==
X-Gm-Message-State: AOAM532brt9dpIhTIek/D59R1r0G0oZwVxuNk6NWZtN7JkNmgg4v3m9G
 watI8OTCHw90zT6CnipiQMUPRVJYuIaOcbc0quJc6N5IzodT0LiFZKP4mGjJu+K0bZ8oFyQpbtf
 /18LGGwDJW9m5OggmMTBe3kkD3qActdK32tH+nx/+0w==
X-Received: by 2002:a05:6402:50d0:: with SMTP id
 h16mr42591333edb.303.1634548941000; 
 Mon, 18 Oct 2021 02:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLLdY/SVE2A5EbgQs4aDLHqEJGy6ba3tgCEPVcVoMb9SEfTRVa7uSMHp1edmAC0OuA6o84Ow==
X-Received: by 2002:a05:6402:50d0:: with SMTP id
 h16mr42591306edb.303.1634548940833; 
 Mon, 18 Oct 2021 02:22:20 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id z19sm8608806ejw.44.2021.10.18.02.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 02:22:20 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:22:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 3/3] vdpa: Check for iova range at mappings changes
Message-ID: <20211018092218.i6wwq4burrjhbzyw@steredhat>
References: <20211014141236.923287-1-eperezma@redhat.com>
 <20211014141236.923287-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211014141236.923287-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

On Thu, Oct 14, 2021 at 04:12:36PM +0200, Eugenio P=E9rez wrote:
>Check vdpa device range before updating memory regions so we don't add
>any outside of it, and report the invalid change if any.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> include/hw/virtio/vhost-vdpa.h |  2 ++
> hw/virtio/vhost-vdpa.c         | 62 +++++++++++++++++++++++++---------
> hw/virtio/trace-events         |  1 +
> 3 files changed, 49 insertions(+), 16 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
