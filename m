Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ECDEEAA47
	for <virtualization@archiver.kernel.org>; Thu, 14 Sep 2023 14:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FD9960F9E;
	Thu, 14 Sep 2023 14:07:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FD9960F9E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Smh9Y4+V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tS1gtjJOA7l; Thu, 14 Sep 2023 14:07:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8820460F42;
	Thu, 14 Sep 2023 14:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8820460F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59B88C0039;
	Thu, 14 Sep 2023 14:07:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF963C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 14:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C47CB60F8F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 14:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C47CB60F8F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZ4f2q8eVEbe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 14:07:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D72A260F42
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 14:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D72A260F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHudOf8iuVH8gSyXltnig2N3UnhuMoM7BMALuIknbpk=;
 b=Smh9Y4+V0E8iGl2tK99/YSLEZ7tk7/TIM60joQp/0OEsknINpryR/BVrTrZ5VQ0LeS7Tt+
 hKr9USL8bMS1y2drG+YgacIianolPMpfuWY1ZRFmgEiQS3/pDv3DtqR2rf6Dom64B3ZIaD
 RttP/yS/OGG+4zhJnMpot3z4MgJb6CU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-idNKkJToMNOmae_BLhyqbw-1; Thu, 14 Sep 2023 10:07:22 -0400
X-MC-Unique: idNKkJToMNOmae_BLhyqbw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so7744685e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 07:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694700441; x=1695305241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHudOf8iuVH8gSyXltnig2N3UnhuMoM7BMALuIknbpk=;
 b=I9dziE/SshQ7A4daRpGXsVzveJzFb+YfsEizZoCiJQRJt69ra9uN1P8F7z24hQHnoX
 ZRg7HP6dryX/0FdevWwQwxRlslaJHFMMheTr1O4JNSF+Zl/O7erLZ74aN5IIeeLcOi2x
 1QcVhZ9KXzKzgxH2qrD/m2ogDEKuwCXjs91BKtmdbtZNrtBmwmXz8kmrC8lSVggCqO/W
 fNsVuAWfGvm243BFx31KsYQYp7Rv5tLj9rlxMYvayLECVFK+zjvwdrBzSLzmj8vS2osj
 1YLkRQZp3+pFFlKToFNx0sx8imEg5xSwqNPsuRsmeA2VeObhJz7udvGE/mty41Qe1OOR
 LeKg==
X-Gm-Message-State: AOJu0YzeckIHddko1MHhVriOXqy+OTqghgt4ukj9Nef2S/IlrLVycjrc
 4uR+JF2PjsyUWksczbh1tvmQud9GPZwztDOi+0FgeKSQeCxTs29J2KmYigQ+IZ1nSftprcoh5TD
 h6ApaTYhYAFJdiWRxRpVR2s1g4eg6oaDiY8YxSUGPlg==
X-Received: by 2002:a05:600c:22c6:b0:401:b53e:6c57 with SMTP id
 6-20020a05600c22c600b00401b53e6c57mr4834833wmg.9.1694700441099; 
 Thu, 14 Sep 2023 07:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIqdAUEhMIPyjpv+aXEvjvAdHzcpL3PZnpBEW96reh9Fs+X2mFI8Jv7Jj2JWmjIb6ifqV2MQ==
X-Received: by 2002:a05:600c:22c6:b0:401:b53e:6c57 with SMTP id
 6-20020a05600c22c600b00401b53e6c57mr4834802wmg.9.1694700440710; 
 Thu, 14 Sep 2023 07:07:20 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003143cb109d5sm1889389wrx.14.2023.09.14.07.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:07:20 -0700 (PDT)
Date: Thu, 14 Sep 2023 16:07:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v8 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <554ugdobcmxraek662xkxjdehcu5ri6awxvhvlvnygyru5zlsx@e7cyloz6so7u>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
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

Hi Arseniy,

On Mon, Sep 11, 2023 at 11:22:30PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset is first of three parts of another big patchset for
>MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) <--- this patchset
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/.
>3) Updates for tests and utils.
>
>This series enables handling of fragged skbs in virtio and vhost parts.
>Newly logic won't be triggered, because SO_ZEROCOPY options is still
>impossible to enable at this moment (next bunch of patches from big
>set above will enable it).
>
>I've included changelog to some patches anyway, because there were some
>comments during review of last big patchset from the link above.

Thanks, I left some comments on patch 4, the others LGTM.
Sorry to not having spotted them before, but moving
virtio_transport_alloc_skb() around the file, made the patch a little
confusing and difficult to review.

In addition, I started having failures of test 14 (server: host,
client: guest), so I looked better to see if there was anything wrong,
but it fails me even without this series applied.

It happens to me intermittently (~30%), does it happen to you?
Can you take a look at it?

host$ ./vsock_test --mode=server --control-port=12345 --peer-cid=4
...
14 - SOCK_STREAM virtio skb merge...expected recv(2) returns 8 bytes, got 3

guest$ ./vsock_test --mode=client --control-host=192.168.133.2 --control-port=12345 --peer-cid=2

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
