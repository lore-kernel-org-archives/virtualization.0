Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13812C11F68
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E5A619A3
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E5A619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82B6A60901;
	Wed, 30 Jun 2021 12:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BhyWuLHMPNHk; Wed, 30 Jun 2021 12:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4E7D605C2;
	Wed, 30 Jun 2021 12:11:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD418C001A;
	Wed, 30 Jun 2021 12:11:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43BA3C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 321EB402A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMoN_SQQkQJj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 433FF40288
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625055090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjLKivpmTxani+XPF3iGAiHLl5i/SxVPZjv2mKGxTR4=;
 b=EbluSdyFvc3I9Jb278vJRzcmj9H63nr1Uy1MKJ0/PmNffMiPhz2VcdyapobQYg9gl9MwPT
 qPvXxeXaNS6L4s4HvvwNGFWo8VYYpwBRphxVhsiV1N4RVOubkob13pcm3V+bEEfVeLp5hd
 r7s57EfPwA8HztDEfPId6IONjNfmccg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-OiA1WDdnN3agdnq7ymiexA-1; Wed, 30 Jun 2021 08:11:28 -0400
X-MC-Unique: OiA1WDdnN3agdnq7ymiexA-1
Received: by mail-ej1-f70.google.com with SMTP id
 gn22-20020a1709070d16b02904baf8000951so679968ejc.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HjLKivpmTxani+XPF3iGAiHLl5i/SxVPZjv2mKGxTR4=;
 b=gbbv5TkpRrdeQy1q43rNmYOwy74vva5XNmZ/UQU7VLrjEXlPY+UnCmp0NF/+ZAvAXW
 0ElVMT0stt8gDIvHCPrNfZ4SMypEGbbVnCEdtboo6Bsn/UDl3CqviQMvo+qRU4QuIuuB
 t6+fOY5nV85L3oriPsRaGjpa0Pstn2HhKtwNembCIrpGbdcY+FnioOvcZUl93mqjX55B
 LTeBHYWyZvz1shwNy0ik/3jUmxxpPRRfLmqTv6md6pTj9iGNa4qMx6cANLcfT5eLk0l+
 gSSiDVS9bQ6dCQhoKCiM43jENtEn8sVdfC9yIZYM7HpSukc30o5FhFIJuSG6Oe2nXd/A
 WL5A==
X-Gm-Message-State: AOAM531ne646ONjiaXT7TE7d6Ozotgs1oBUbDbOOacFCi5hYi4k/Ar4h
 XxtSIsdtHSPjUkS3ffZvyxY4iEUbI0q6NGa99VEyBwK8sbeceqnbrGQfY0kInwnif6oe92MmHH6
 8PKMI3a68rbGQF9j3yihZCkWIgbj20W1WcuxuB6edoA==
X-Received: by 2002:a17:906:4899:: with SMTP id
 v25mr35863376ejq.451.1625055087445; 
 Wed, 30 Jun 2021 05:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS+TPipViKVTyOBRlKGUsXt+XwfFGYR4iIVDCFdEFv1bf670kbuHjhW5TA+alh5BwQNtL7Mw==
X-Received: by 2002:a17:906:4899:: with SMTP id
 v25mr35863362ejq.451.1625055087282; 
 Wed, 30 Jun 2021 05:11:27 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id r12sm12637350edd.52.2021.06.30.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 05:11:26 -0700 (PDT)
Date: Wed, 30 Jun 2021 14:11:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 07/16] virtio/vsock: don't count EORs on receive
Message-ID: <CAGxU2F7SsxvCht2HbDb7dKsM_auHoxvHirgWwNMObjxOci=5nA@mail.gmail.com>
References: <20210628095959.569772-1-arseny.krasnov@kaspersky.com>
 <20210628100318.570947-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210628100318.570947-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Jun 28, 2021 at 01:03:15PM +0300, Arseny Krasnov wrote:
>There is no sense to count EORs, because 'rx_bytes' is
>used to check data presence on socket.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 84431d7a87a5..319c3345f3e0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1005,9 +1005,6 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>               goto out;
>       }
>
>-      if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>-              vvs->msg_count++;
>-

Same here, please remove it when you don't need it, and also remove from
the struct virtio_vsock_sock.

Thanks,
Stefano

>       /* Try to copy small packets into the buffer of last packet queued,
>        * to avoid wasting memory queueing the entire buffer with a small
>        * payload.
>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
