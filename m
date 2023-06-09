Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D4EC83005
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 13:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17517424C6;
	Fri,  9 Jun 2023 13:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17517424C6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wkKfaDpQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xgoRqHMEjh0S; Fri,  9 Jun 2023 13:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F94C42486;
	Fri,  9 Jun 2023 13:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F94C42486
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29563C0037;
	Fri,  9 Jun 2023 13:41:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88F3CC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 13:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52F4960BD2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 13:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52F4960BD2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=wkKfaDpQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jUMLdUvKKTiQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 13:41:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4F4A60BA7
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4F4A60BA7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 13:41:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F096060E95;
 Fri,  9 Jun 2023 13:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D794AC433EF;
 Fri,  9 Jun 2023 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1686318075;
 bh=yjbSjmu9BKcOVBkALZ9aVw5SbohM/yF5/0fVveOk2Uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wkKfaDpQt2SdpI3FmTZKILMbpvdN+jr3R5Qu/MXyusQxnrqylXhPSiT4Cl19gOdY1
 d8QbhJPK/QtuMLzZuxM/keOSJTFy3eFpxi0dfEYYRlT9SfurNHZoPHSfJzBfaokBEv
 5Dmzre1r/j+r1lO1wOmlD8fWHIfoMuRmIoJa6K1k=
Date: Fri, 9 Jun 2023 15:41:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <2023060940-wrongdoer-wince-5701@gregkh>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <2023060924-skinning-reset-e256@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2023060924-skinning-reset-e256@gregkh>
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 mst@redhat.com, amit@kernel.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Xianting Tian <tianxianting.txt@alibaba-inc.com>, linux-crypto@vger.kernel.org,
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

On Fri, Jun 09, 2023 at 03:39:24PM +0200, Greg KH wrote:
> On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> > From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> > 
> > Cpu stall issue may happen if device is configured with multi queues
> > and large queue depth, so fix it.
> > 
> > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > ---
> >  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > index 1198bd306365..94849fa3bd74 100644
> > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
> >  			kfree(vc_req->req_data);
> >  			kfree(vc_req->sgs);
> >  		}
> > +		cond_resched();
> 
> that's not "fixing a stall", it is "call the scheduler because we are
> taking too long".  The CPU isn't stalled at all, just busy.
> 
> Are you sure this isn't just a bug in the code?  Why is this code taking
> so long that you have to force the scheduler to run?  This is almost
> always a sign that something else needs to be fixed instead.

And same comment on the other 2 patches, please fix this properly.

Also, this is a tight loop that is just freeing memory, why is it taking
so long?  Why do you want it to take longer (which is what you are doing
here), ideally it would be faster, not slower, so you are now slowing
down the system overall with this patchset, right?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
