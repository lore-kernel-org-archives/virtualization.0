Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324CEC4708A
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 13:16:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE627613BF
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 13:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE627613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABA0640284;
	Thu, 27 May 2021 13:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p645Domt4xeN; Thu, 27 May 2021 13:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A3744023D;
	Thu, 27 May 2021 13:16:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BC29C000D;
	Thu, 27 May 2021 13:16:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75CC2C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 567E2608B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GK0SQKTZ8_kf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C1A66089B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622121359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9vY/BiDViLtd8TcBlCuY8UCaNLhSVwGFXrNTGgxdVJg=;
 b=HwNne2aHQJaNMM7L5bszw1ljUVVI20aQvjfmkZUMu0gBkoMc+RZW71R46JwDJXtFRbMZ17
 nI8RBpUUmZPfUIkDU0TT2p4CQh3MP8gkPWNDkQABmNqVmNVMMIXHD7qYm2uyK+CIuwIFEh
 5MpQcZjeFx839LFU6vrlc0pb1RyH4xc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-v9JD7mBtOR-q9Ch4K0nDeg-1; Thu, 27 May 2021 09:15:53 -0400
X-MC-Unique: v9JD7mBtOR-q9Ch4K0nDeg-1
Received: by mail-ej1-f70.google.com with SMTP id
 r20-20020a170906c294b02903e0626b3387so1649333ejz.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 06:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9vY/BiDViLtd8TcBlCuY8UCaNLhSVwGFXrNTGgxdVJg=;
 b=LH/chF1XAAbJR2RfrvDRFKNPsM2EubnEgeO9UR5X9lmEdxBgr/OjjaogMjljyek3Y4
 Y2O2HAAQ28rJ9e2JiAZFCRPKfxXVMtjsE6B2mcNILzwTTEHaaEuQvNpBD47PSLfec14U
 /NPw0U+BWvBQ5iStnZ4isuz+OUT4SJJyD9BJiC/C6LgivqLkSjgmQwJSBiuAHSFegw90
 dbf2oGID/SNd6FHBynRSrmV112OB+yRHE6w2KrxEavDGRCEKedPeEC2AeuzeeQGYRl0i
 LRGm1ND6gaTro/ChZjgJIfX5PG1Ad16pLlmF2ogPXv3zNIA1n+ueFj242DhUaVTtA3yK
 p3+Q==
X-Gm-Message-State: AOAM530dYjkBXvdXURioJhjO+jLy8MQaZkfl1ZDFhfJPhvewPiAHz8pp
 e3ppOGtyX01tsPpB8izfcm+6RdgeRdK4SF2f+K95py4utFdNT4S7MfPlKcCRJFQEQS8BuP1Lqov
 R/m5Nl2ZFZKIPNUZGcCmMmsPW3PnEj9AOi9VXFUuUDA==
X-Received: by 2002:a17:906:11c8:: with SMTP id
 o8mr3687134eja.499.1622121351955; 
 Thu, 27 May 2021 06:15:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8bc2gPuJ5aFpYG9sGVUfn3+RTEkYNOamSmZeR3QiYFooYR/Z1Q9XEy0KXDsXvBmtYi+tL9Q==
X-Received: by 2002:a17:906:11c8:: with SMTP id
 o8mr3687104eja.499.1622121351723; 
 Thu, 27 May 2021 06:15:51 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id m19sm1152744edd.12.2021.05.27.06.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 06:15:51 -0700 (PDT)
Date: Thu, 27 May 2021 15:15:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [PATCH v6 0/2] virtio-vsock: introduce
 SOCK_SEQPACKET description
Message-ID: <20210527131549.qs4z4re7yxsb37f5@steredhat>
References: <20210524183232.2513690-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210524183232.2513690-1-arseny.krasnov@kaspersky.com>
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

On Mon, May 24, 2021 at 09:32:29PM +0300, Arseny Krasnov wrote:
>This adds description of SOCK_SEQPACKET type for virtio-vsock.
>
>Here is latest RFC implementation for Linux, with more details:
>
>https://lkml.org/lkml/2021/5/20/2386
>
>Also this patchset has patch which replaces enums to defines in
>virtio-vsock part of spec. SOCK_SEQPACKET patch is based on it.
>
> Arseny Krasnov(2):
>  virtio-vsock: use C style defines for constants
>  virtio-vsock: SOCK_SEQPACKET description
>
> virtio-vsock.tex | 74 ++++++++++++++++++++++++++++------------------
> 1 file changed, 46 insertions(+), 28 deletions(-)
>

The series LGTM!

Let's wait for other comments.

I'll send a follow up patch next week about feature bit for stream 
socket (bit 0).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
