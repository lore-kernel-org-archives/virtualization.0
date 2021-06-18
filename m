Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DBDC48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2FA610A3
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2FA610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 893D083BC5;
	Fri, 18 Jun 2021 14:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bk1iaQBRfFx; Fri, 18 Jun 2021 14:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAE9A83AFB;
	Fri, 18 Jun 2021 14:50:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B3F0C000D;
	Fri, 18 Jun 2021 14:50:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA73C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87C7B4042F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFMSTf9Q4Gl5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FC0A4036E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624027801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oL9pIabX0KT1NXGW77/lB+mc2YzSI9c2Q7CpgKFSy3Q=;
 b=b8HfEs9JyxoTF7No+BlMuQoZ+p56+O5XNEBqYBjg2V6/ACCDhD6jiV19JUph13n/SQUAcs
 6yWRGRLF6rSRMkY77NbISWxnlorWinVQdKeekJZU+TjT6cx3iGRf8AO18onQHqDk8tug/D
 jFMYPXcDxnwmpaQYTwM1ZwKg7Ld8IqA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-8mNV6AcKMWe6F5kWdHejog-1; Fri, 18 Jun 2021 10:49:58 -0400
X-MC-Unique: 8mNV6AcKMWe6F5kWdHejog-1
Received: by mail-ej1-f69.google.com with SMTP id
 l6-20020a1709062a86b029046ec0ceaf5cso1645165eje.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oL9pIabX0KT1NXGW77/lB+mc2YzSI9c2Q7CpgKFSy3Q=;
 b=L6mT62DdZyjwKnTmndLaIOD/+SmSaCQi+NfsCPxZZtOKwASiPGe/gd50DpIuI7KoTs
 vt8EYs3FcHJTLz/huZq4pLHlMy9vJFu/QP/K5yhjDO9fZLC0FiU1q2vOLEd67ELM9ZOm
 ZRR7gbcCUNiPxodK3F68P92AuxCj7xiIh/+Kazvi9PjRavTvODTXbhFWgIyc+K+UtVWw
 OpNmAZn3BgYMxzQNTG66OyYLAo3krwhTzEwz3qeu7SG4B8EuMKELkXVj6MFJhtZXsfMk
 EjvKxWhXv9mLAyl367jwTw5yMXRYHnjBCmGholgEvh+/qRqp1amCFPbhOhsVNksiBDpH
 dO9w==
X-Gm-Message-State: AOAM532EiMwcMcIrt6xwloUFK4UxVIIqdegLQBAL2Rr0rzuJkM2JW5L8
 xdqCEp6FEIbqAwn8gGOlpw3FaFJ7g60a0tmK6DRTVReQ1+qtcvrKcpFfEdSuV5Ah2R97IoPTH24
 EJh3+fq4KTcpeCqhGZbtE9JKechrEEeEstZ2VoVvYHg==
X-Received: by 2002:a17:906:2e81:: with SMTP id
 o1mr11584977eji.446.1624027796760; 
 Fri, 18 Jun 2021 07:49:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNraZVEMjjY5Sr89uVAeQb58bHtYpLJW9gzLO9skv69flQelN73It9fKmplpQVdmHdmC+8ZA==
X-Received: by 2002:a17:906:2e81:: with SMTP id
 o1mr11584962eji.446.1624027796606; 
 Fri, 18 Jun 2021 07:49:56 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.175])
 by smtp.gmail.com with ESMTPSA id dh18sm6424119edb.92.2021.06.18.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 07:49:56 -0700 (PDT)
Date: Fri, 18 Jun 2021 16:49:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v6 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210618144951.dr23qqfuy6qrd2ne@steredhat.lan>
References: <20210524183232.2513690-1-arseny.krasnov@kaspersky.com>
 <20210524183420.2514296-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210524183420.2514296-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 24, 2021 at 09:34:15PM +0300, Arseny Krasnov wrote:
>This adds description of SOCK_SEQPACKET socket type
>support for virtio-vsock.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> virtio-vsock.tex | 26 +++++++++++++++++++++-----
> 1 file changed, 21 insertions(+), 5 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index ad57f9d..9ef2b0e 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>
> \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>
>-There are currently no feature bits defined for this device.
>+\begin{description}
>+\item VIRTIO_VSOCK_F_SEQPACKET (1) SOCK_SEQPACKET socket type is
>+    supported.
>+\end{description}

The VIRTIO_VSOCK_F_STREAM is described in the datagram series by Jiang,
so this patch should be fine:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
