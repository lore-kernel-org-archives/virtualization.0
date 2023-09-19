Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCAECD549F
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 07:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11E04813DD;
	Tue, 19 Sep 2023 07:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11E04813DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EA1PBUYy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsG1jbuMqdXd; Tue, 19 Sep 2023 07:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2BEB813C9;
	Tue, 19 Sep 2023 07:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2BEB813C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904C8C0039;
	Tue, 19 Sep 2023 07:54:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AFA4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21D598135D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21D598135D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4qn9k8C3OkQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:54:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B59281355
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B59281355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695110095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
 b=EA1PBUYyViTLO73SJ1nOc/IfMNNNcgj+3G7d9NPdqpfEJ4M+NRppCOFFa/EFr26Ro+xqAg
 slw5+QZ/+yokQL9H7oWC+VWbc5Y5Z9phh3IqEXBxaTfHFUbV1eI8sJoNj0zqHaSDrXNZA/
 O5/e2F1xqOUmUzo2w2KVKCHkCA+cI1U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-rFZIQttuNcuPwKRcxVsS8g-1; Tue, 19 Sep 2023 03:54:53 -0400
X-MC-Unique: rFZIQttuNcuPwKRcxVsS8g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5029bd7d9f7so6362821e87.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 00:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110091; x=1695714891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xq2PUpZjcLYmB0sc19KGgnU6q5ctsCTIhTwce+KUPmU=;
 b=AAfkZMP4pMNCyWAUWZDm1myW3Q7/kDGFlPq0Pz9xXJJqp4DB4EKbyfbxskLk50wsME
 Fw8YLzs3+bpySOD4icKkSeyZcwX/V+xageGHlapHtysGbl87SGSNjOZaQXWStkF6hSI8
 fPgpMq8SHfKhiLhLzrU8ppeux/YOsFyWHSMJShiKWdP8fhxLMK5amW3kbEyRpz18mZmN
 QSgtV9w7h9kVoEQijrzuuvR4t7Gkizu9OR6TIod4TnjxD2cNFitJWpHCeRx+qbMYZ2YT
 uxEUQckr0rydhNWZXxv+K6PrO9yKztpuxIkcY/N1wNIQEncraWjYTwZi+9d0u+jrY4OW
 WGvw==
X-Gm-Message-State: AOJu0YwqJV14fcw/JZy1uXsQZ/wVRpkVKhpZrvtUL9jTOqCL5B6CKo9k
 EVt7M7LwF5kXu3TCYHBMJ94clLO9PkRHo+/CRH61JE7gyfOYjxjg996W+6MpDUSkdOfWiA6Zz3P
 UiV7cpkTFbt11KO3sJgWFT75wgVci5WeceuJ/YxUJ8w==
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id
 w8-20020a056512098800b005007e64cff1mr7920472lft.14.1695110091616; 
 Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuCMWkGTykvVJzGOBWF+ltNRkIaGMXVMrzHnBowZKeRdkWnM1pfr62hc7g2qB3p0oGcC763w==
X-Received: by 2002:a05:6512:988:b0:500:7e64:cff1 with SMTP id
 w8-20020a056512098800b005007e64cff1mr7920452lft.14.1695110091255; 
 Tue, 19 Sep 2023 00:54:51 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.147.15])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a05600c068400b004042dbb8925sm14294571wmn.38.2023.09.19.00.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 00:54:50 -0700 (PDT)
Date: Tue, 19 Sep 2023 09:54:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
>Hi Stefano,
>
>thanks for review! So when this patchset will be merged to net-next,
>I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
>Documentation/ patches.

Ack, if it is not a very big series, maybe better to include also the
tests so we can run them before merge the feature.

WDYT?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
