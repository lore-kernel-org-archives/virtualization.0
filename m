Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBECBC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 09:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A6A881886;
	Tue,  9 Aug 2022 09:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A6A881886
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VdHhcNKG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id edQqS1OBkZiq; Tue,  9 Aug 2022 09:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C0AD81489;
	Tue,  9 Aug 2022 09:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C0AD81489
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E91FFC0033;
	Tue,  9 Aug 2022 09:25:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 109F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D20A981886
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D20A981886
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUZjbkrtd2VV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:25:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FAE581489
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FAE581489
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660037129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aqqu+qFj/qakh8EzyhZVSFcztg52TURh0kXItW5DWGY=;
 b=VdHhcNKGtUru1jucOkqtbpzNpelElBmcdR4WaEbejxtUy1SvTgoT3HNwBXtme7wzj6JY7Z
 Z+GMccgHUEsdQfLVbKTLSlMR9Q77Jvvcyz48x3yHTELlLIZNpip7lLa1gQKr6bQOKVwEkt
 NfgORZ8PpTyTlicxKg7OGAOrlR7foVY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-OwKpxMhMP36hCR_YZN2z_Q-1; Tue, 09 Aug 2022 05:25:27 -0400
X-MC-Unique: OwKpxMhMP36hCR_YZN2z_Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 m18-20020a056402511200b0043d601a8035so7094418edd.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 02:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Aqqu+qFj/qakh8EzyhZVSFcztg52TURh0kXItW5DWGY=;
 b=YGxQiujWvxP5pbcrMRGQvcFyWRHr8WpBAwStPF7qO7W5X0o0WY5JfSkcNw9nZaMC3h
 zU/gpzOZb3hF8XS7VKrZm3DKsOTjLsXrql/1kUVIl0frligeyFHsMv340d0U89TWsgoL
 SVFLZrYqDozie/uXGg02x0l5IxObq/8DloYOz1f8UBQ7r4QupFkpcjdMAtt2FokCc0fR
 5l99K1vK+mALxegJGHTTubPtrLxuFuv3o9M1pOeFqHFUoLVdwJ51QUnvJebqI5mEnYY2
 6qVqAYjT04FETYVUNq5kL/rBjQvvZBgRAumQO/xom4Psyr7QPTLM2cid6iyN8GTA8MDC
 +x2w==
X-Gm-Message-State: ACgBeo0ohvs2SYeOG2juioR93vW1r+mrbVIQUzw6oS3Uq6ECWiuNauLe
 tLIiof+EC7SnXO/oSNB+hh0ZzC+gM+NgLWLD/4nRQeet91LYLIGN5NvrLszhJiFPTZIFOE8mKTm
 DzfPaC3OSoi4RBkhE/FUYUjrV6LGhj+7OgS+pbnMsDQ==
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id
 m10-20020a056402510a00b0043dab257d68mr21090043edd.102.1660037126631; 
 Tue, 09 Aug 2022 02:25:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eE+E+X7HTYgNjlay6I8fMcGTMKGud1u7UurOKOIqoEMTlzHF+m9fWUv7dW698xmTfN0bSYA==
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id
 m10-20020a056402510a00b0043dab257d68mr21090030edd.102.1660037126461; 
 Tue, 09 Aug 2022 02:25:26 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 n25-20020a17090695d900b007305c007e43sm908561ejy.135.2022.08.09.02.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 02:25:25 -0700 (PDT)
Date: Tue, 9 Aug 2022 05:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809052255-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alexander.h.duyck@intel.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 kubakici@wp.pl, sridhar.samudrala@intel.com, jesse.brandeburg@intel.com,
 gavi@nvidia.com, virtualization <virtualization@lists.linux-foundation.org>,
 "Hemminger, Stephen" <stephen@networkplumber.org>, loseweigh@gmail.com,
 davem <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Tue, Aug 09, 2022 at 03:44:22PM +0800, Jason Wang wrote:
> > +             unsigned int mtu = vi->dev->mtu;

BTW should this not be max_mtu?  Otherwise if user configures mtu that
is too small we'll add buffers that are too small.  some backends simply
lock up if this happens (I think vhost does).
Maybe we should add a feature to allow packet drop if it's too small.
And send mtu guest to host while we are at it?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
