Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90274C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 10:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17B77402C8;
	Wed,  9 Nov 2022 10:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17B77402C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C1Eo/z9K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sBilDCVhL6Xi; Wed,  9 Nov 2022 10:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6EE9F402D2;
	Wed,  9 Nov 2022 10:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EE9F402D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4867EC0033;
	Wed,  9 Nov 2022 10:10:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC68DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A6BD40B15
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A6BD40B15
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C1Eo/z9K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9wLTLdgRHEX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9240D4019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9240D4019D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667988644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5MPz3Ec+EPgg7rG8vMEpdX68m++2s8DqWYBcdW2qsvI=;
 b=C1Eo/z9K0XzWDaxc+N2ZUnny0vBIxOYELgbh6/qYFOnLDLMRo22mvJfbf407k8f1NbuxZA
 95UXa2IWafvCjJdGwxs1vZeLkTcaDjhFV0qv0R5e/u9ZQ6inbKsZcTFBxTrd7wCQVsuWAh
 jF6Z3SDexZ6bgJ8pNEDtNUqaXH8pD7M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-ljxAHuh-Oo2_2HAfTgF1mQ-1; Wed, 09 Nov 2022 05:10:43 -0500
X-MC-Unique: ljxAHuh-Oo2_2HAfTgF1mQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 71-20020a0c804d000000b004b2fb260447so11457394qva.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 02:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MPz3Ec+EPgg7rG8vMEpdX68m++2s8DqWYBcdW2qsvI=;
 b=4wKRDN/EtSFbc3wI1DtPJbpZgOToLF2Yflyvv61CCv4yMG6QME54hlLpRxI5eTkGOw
 6M4FRz+8aTCVDph+l0xBDE69js54vzQeUYgC4smXRLSj8ibHC59iPoucFK77utZw+iP4
 UvqaBQxQK3h+bu0bOYSfSrI7+Nr2GiXg8rNwevzUM712Vns/hPXXcQWxXHZKd7HJ1+SL
 /J8RAu/9wMAbousgj0yIOqXYUw/BEDTtLoih+9Iq65W0+k5U/nHhfhWY2Vv2qHu1y+IO
 i3RchQPdn8kkwalEAU4rzy1qbhk2Edmjrn0tzu7frKtx0PGayXY8QX/C5sg9fO2CAnCB
 u9Yg==
X-Gm-Message-State: ACrzQf1I5KoV3RCBdu390lAXA2WML7ps9mSI/BdOqDTMFGZCqfX+GsqT
 p+fbqp3rywTu77qs3jeVkQ4Pd3kdUqzKGCTaBwJ2x/Yz7cd6FRxuBMynozHuIV9Wvf1ngzVbZRr
 Me3ncNE0D67bZbpfAKpFB6XBhdhCi4ejZKesObgC7mg==
X-Received: by 2002:ac8:5058:0:b0:3a5:3cb0:959 with SMTP id
 h24-20020ac85058000000b003a53cb00959mr32919857qtm.123.1667988642846; 
 Wed, 09 Nov 2022 02:10:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7zaE5m+054WqSltDiseEsHQRGbV23se1lE6TQwdYPc3zaWSm4fkB44f0GuQqZbDqR+b7Kc9w==
X-Received: by 2002:ac8:5058:0:b0:3a5:3cb0:959 with SMTP id
 h24-20020ac85058000000b003a53cb00959mr32919847qtm.123.1667988642628; 
 Wed, 09 Nov 2022 02:10:42 -0800 (PST)
Received: from redhat.com ([185.195.59.52]) by smtp.gmail.com with ESMTPSA id
 r4-20020ae9d604000000b006fa2b1c3c1esm10651656qkk.58.2022.11.09.02.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 02:10:42 -0800 (PST)
Date: Wed, 9 Nov 2022 05:10:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
Message-ID: <20221109051030-mutt-send-email-mst@kernel.org>
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-3-sgarzare@redhat.com>
 <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
 <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Nov 09, 2022 at 09:18:23AM +0100, Stefano Garzarella wrote:
> On Wed, Nov 09, 2022 at 11:28:41AM +0800, Jason Wang wrote:
> > On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > vhost_iotlb_itree_first() requires `start` and `last` parameters
> > > to search for a mapping that overlaps the range.
> > > 
> > > In translate_desc() we cyclically call vhost_iotlb_itree_first(),
> > > incrementing `addr` by the amount already translated, so rightly
> > > we move the `start` parameter passed to vhost_iotlb_itree_first(),
> > > but we should hold the `last` parameter constant.
> > > 
> > > Let's fix it by saving the `last` parameter value before incrementing
> > > `addr` in the loop.
> > > 
> > > Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > 
> > > I'm not sure about the fixes tag. On the one I used this patch should
> > > apply cleanly, but looking at the latest stable (4.9), maybe we should
> > > use
> > > 
> > > Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")
> > 
> > I think this should be the right commit to fix.
> 
> Yeah, @Michael should I send a v2 with that tag?

Pls do.

> > 
> > Other than this
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> 
> Thanks for the review,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
