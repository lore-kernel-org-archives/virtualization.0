Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8B5C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 22:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD45A408C9;
	Mon,  7 Mar 2022 22:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JXesI7uGxoI; Mon,  7 Mar 2022 22:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F38B40734;
	Mon,  7 Mar 2022 22:40:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01EA0C0012;
	Mon,  7 Mar 2022 22:40:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8CCAC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA7E741727
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hbokd4qMu2gw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDE5241726
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646692795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJJnjNEDLDCxgTnNZiuLduAW9RdSuGCDd7yDQswPSHQ=;
 b=XjYpj5w0WyYp59YoxpO90KpD2P4RXY749mo/qsLlPgajXgarGewhuTmLV1JEmXh0VAFJl4
 VORHKlaLQ6i/6P0xTYCi6O3UjP475+kRXTxTcN6K/ALlK118xx0ypCjY6YMr4UKbNFSwTd
 +OiXSHHUxkQZMsTrYT2ON6oCAQlkdRc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-A_pfMXDGOAK9Au03VD01aA-1; Mon, 07 Mar 2022 17:39:54 -0500
X-MC-Unique: A_pfMXDGOAK9Au03VD01aA-1
Received: by mail-ed1-f71.google.com with SMTP id
 n11-20020aa7c68b000000b0041641550e11so3088723edq.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 14:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oJJnjNEDLDCxgTnNZiuLduAW9RdSuGCDd7yDQswPSHQ=;
 b=AmBn+reGnOaTVv3nfzFXfxn9fUFgd0M8ceUCnjDvvV9+HNyi0Vi/slYPlcmtY/gXma
 NBJnxcAt4lDag+JptDZB9yxJsw7fkG5xy1ugc++OJINoYoqT9Kl5yeGAL+9+qVSPq86G
 eFjELX7xNXIIfUfLcUgJlaBKFXTtz0T583FukfHmn8/QGV2/f7imrqwcoG66BANSjngg
 Z70n0O21XwSkOHCeN6hHTZBxQzYob1mZS1z1GaawO/5e051PemVqiq3ezmfahDOZzaaK
 +va8aLXEmjengRAO9I+jeiFunkPFQoBVvEzN8K9fsWatq+lkl0XB9OBsJeoal6VVGHCa
 u0SQ==
X-Gm-Message-State: AOAM532WJ+z4Aos+peXtzs0r41SAucSh6djPlgWVcldFNIDe3XRAB/8R
 8vDchQsX55lH7gtN+S1VxgmfURzExwQNieGHwNRpEeKHQX+1tQClypidCMDl5V8GcXn3rNMU+6T
 QUAFzggB4sGO9pkhlNdVlp8eRS+Ee9NR0vXGi5XR4Pg==
X-Received: by 2002:a50:f68b:0:b0:415:a36c:5c0b with SMTP id
 d11-20020a50f68b000000b00415a36c5c0bmr13019183edn.272.1646692791965; 
 Mon, 07 Mar 2022 14:39:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHmg2BC0xk8nWy9xaqU2GCk4lH6furT6guufXi8TPI/KI61k1O7Q5pN2MxtI0peMXSX0VM9Q==
X-Received: by 2002:a50:f68b:0:b0:415:a36c:5c0b with SMTP id
 d11-20020a50f68b000000b00415a36c5c0bmr13019168edn.272.1646692791770; 
 Mon, 07 Mar 2022 14:39:51 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 gf17-20020a170906e21100b006da960ce78dsm4913346ejb.59.2022.03.07.14.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 14:39:51 -0800 (PST)
Date: Mon, 7 Mar 2022 17:39:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220307173807-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YiZeB7l49KC2Y5Gz@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Mon, Mar 07, 2022 at 08:33:27PM +0100, Greg KH wrote:
> On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > during virtqueue clean-up and we mitigate the reported issues.
> > 
> > Also WARN() as a precautionary measure.  The purpose of this is to
> > capture possible future race conditions which may pop up over time.
> > 
> > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/vhost/vhost.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 59edb5a1ffe28..ef7e371e3e649 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >  	int i;
> >  
> >  	for (i = 0; i < dev->nvqs; ++i) {
> > +		/* No workers should run here by design. However, races have
> > +		 * previously occurred where drivers have been unable to flush
> > +		 * all work properly prior to clean-up.  Without a successful
> > +		 * flush the guest will malfunction, but avoiding host memory
> > +		 * corruption in those cases does seem preferable.
> > +		 */
> > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> 
> So you are trading one syzbot triggered issue for another one in the
> future?  :)
> 
> If this ever can happen, handle it, but don't log it with a WARN_ON() as
> that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> you want that to happen?
> 
> And what happens if the mutex is locked _RIGHT_ after you checked it?
> You still have a race...
> 
> thanks,
> 
> greg k-h

Well it's a symptom of a kernel bug. I guess people with panic on
warn are not worried about DOS and more worried about integrity
and security ... am I right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
