Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3184FCD5BB9
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 13:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74A5D615F0;
	Tue, 19 Sep 2023 13:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74A5D615F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dTbZx3yP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IO-2iLnxZ6wu; Tue, 19 Sep 2023 13:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F31CE60F77;
	Tue, 19 Sep 2023 13:20:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F31CE60F77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D46EAC0039;
	Tue, 19 Sep 2023 13:20:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 112E9C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3664416F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3664416F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dTbZx3yP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3J0KW8bp_eqT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:20:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B453400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 13:20:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B453400B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695129599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
 b=dTbZx3yPdrjyksWEVcMmG9mQvP6WFbfKPi1PXwWmBmSuoNINoF228/lEGwmclizgDPlhay
 +fLBB8yPUCn16wHvKZ68o4o6bTt03xWAnZhwrTl0o2pTABfngezzmR9QPvk75QMSpaiJXN
 jsQ3b9KgRoMykULEvIx8uHuZ251fask=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-DfTSvmZcPtiXdNVXayNSug-1; Tue, 19 Sep 2023 09:19:58 -0400
X-MC-Unique: DfTSvmZcPtiXdNVXayNSug-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32005e5f2fdso113149f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 06:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695129596; x=1695734396;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=htK7pnwIzqRDFi5FwPMaJzCXKtfTe2X9wFdfV0qhhDg=;
 b=XI91/Jtt6yX8PSmR+3KtJaiyoczXKtwavm+KqH95a9yyx/8QfmzQZ5Zwih3iyXnanQ
 Xh2DAxdv8z0ooy6PeILeZvsbsAmWvbWYv6ImMbg5QTag08r7eCloXtMcSCQdsJvpCkHS
 usCivkXmsplNus9eaD1esGN0f5itEXF/F/EFx4MhG4Z2wZaFinYyJhu77zLdR2wrSwxN
 fXtYCI+R5FrrhEkJyZJFgYViHJ3Pw2YCgyDVJHSZYLb/evEurFF16DdQlPrW14lQb67J
 vJMFnPw/+Rn+xRrWfwkfUt7YtCFEw76NEvJYiOXLLWekWQBTXfGT99pwwvs5ymgeC+Mv
 Lm6w==
X-Gm-Message-State: AOJu0Yz7xCRp8fA3ONPlfVtHoawJbL2n0Udugkm1al3KSKvOdeZmFT0O
 i4HyCJCwWMUZLXVCBok4XoSi4IlAnTn8PSKb2CEIL0vUGT3RVBzGtPd3tdbVoxO/NwVeUL96k6v
 DdDFX7wtsfE+qQW0x4qLATLu3EcNDIpy8GAk0vm6uxg==
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id
 s7-20020adfecc7000000b0031f899b0a47mr10072508wro.4.1695129596646; 
 Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvl5GMANKuJZvPgoz3bArRsym+FAKYbCuhPA1oJy7XAET85TTZwn7Qk9G/FVTxfAXX1wyEcg==
X-Received: by 2002:adf:ecc7:0:b0:31f:899b:a47 with SMTP id
 s7-20020adfecc7000000b0031f899b0a47mr10072490wro.4.1695129596314; 
 Tue, 19 Sep 2023 06:19:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it.
 [146.241.241.221]) by smtp.gmail.com with ESMTPSA id
 cf20-20020a170906b2d400b0099bd453357esm7754752ejb.41.2023.09.19.06.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 06:19:55 -0700 (PDT)
Message-ID: <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
From: Paolo Abeni <pabeni@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 19 Sep 2023 15:19:54 +0200
In-Reply-To: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
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

On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
> On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
> > Hi Stefano,
> > 
> > thanks for review! So when this patchset will be merged to net-next,
> > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
> > Documentation/ patches.
> 
> Ack, if it is not a very big series, maybe better to include also the
> tests so we can run them before merge the feature.

I understand that at least 2 follow-up series are waiting for this, one
of them targeting net-next and the bigger one targeting the virtio
tree. Am I correct?

DaveM suggests this should go via the virtio tree, too. Any different
opinion?

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
