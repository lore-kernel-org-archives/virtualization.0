Return-Path: <SRS0=fSpH=EL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91AC00A89
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 11:34:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A702078E
	for <virtualization@archiver.kernel.org>; Thu,  5 Nov 2020 11:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="am9ld7oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A702078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C44E858B5;
	Thu,  5 Nov 2020 11:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmQwkGF2wYhf; Thu,  5 Nov 2020 11:34:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 03E9F8587E;
	Thu,  5 Nov 2020 11:34:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8342C088B;
	Thu,  5 Nov 2020 11:34:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC29C0889
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 11:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0447A204AF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 11:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oAmp0AvrykhA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 11:34:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5F94B20361
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604576071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqAyd5oPIZ6twy3M+P8m2ePirTM3ef9UMxPbSLSvBUQ=;
 b=am9ld7oaxhV9Dn5gAFmVCkzVDnKHE8pXmk+R2N8fhFgou3Q2lIt2eQn1S6sAZaHTgg3qog
 7QqGQo8rPetZonKpSIXASvByZB0UqJjj3/nwITnYbc2IWt0GnNwtZaD9hHQSJnPMpoKgFU
 Zm2PGNECm+o8BVxGL4Cj5mfYRDufwhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-CKDof9iRPs6yY3cC_MY5pQ-1; Thu, 05 Nov 2020 06:34:29 -0500
X-MC-Unique: CKDof9iRPs6yY3cC_MY5pQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84B22186841A;
 Thu,  5 Nov 2020 11:34:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C210C6266E;
 Thu,  5 Nov 2020 11:34:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D61CE9D0F; Thu,  5 Nov 2020 12:34:25 +0100 (CET)
Date: Thu, 5 Nov 2020 12:34:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] drm/virtio: use kvmalloc for large allocations
Message-ID: <20201105113425.q45omct7eb44eraq@sirius.home.kraxel.org>
References: <20201105014744.1662226-1-senozhatsky@chromium.org>
 <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
 <20201105070054.GD128655@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105070054.GD128655@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Suleiman Souhlal <suleiman@google.com>
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

On Thu, Nov 05, 2020 at 04:00:54PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> On (20/11/05 07:52), Gerd Hoffmann wrote:
> > > -	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> > > -			      GFP_KERNEL);
> > > +	*ents = kvmalloc_array(*nents,
> > > +			       sizeof(struct virtio_gpu_mem_entry),
> > > +			       GFP_KERNEL);
> > 
> > Shouldn't that be balanced with a kvfree() elsewhere?
> 
> I think it already is. ents pointer is assigned to vbuf->data_buf,
> and free_vbuf() already uses kvfree(vbuf->data_buf) to free it.

Ah, right, we needed that before elsewhere.
Ok then, pushed to drm-misc-next.

thanks,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
