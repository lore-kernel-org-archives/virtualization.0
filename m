Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED99CA553C
	for <virtualization@archiver.kernel.org>; Thu, 14 Sep 2023 13:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D692B834C6;
	Thu, 14 Sep 2023 13:06:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D692B834C6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hIRVVVOz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUYsFBrvvjC5; Thu, 14 Sep 2023 13:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A67983365;
	Thu, 14 Sep 2023 13:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A67983365
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D74C0071;
	Thu, 14 Sep 2023 13:06:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A2DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 13:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 830D18340C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 13:06:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 830D18340C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s5HvlbIKiJ_q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 13:06:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CAB883365
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 13:06:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CAB883365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694696785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/pGng4Jlz5jKGWmwVqa99A3qKH6EyoanXPEX+/wRiw=;
 b=hIRVVVOzKiwgVi2u5A31m4hbSkkKjOsCcwEMo3YF2ynF969HokJTRo83QQm436VsU4RlMh
 FlOxZoqZvMtAtR1KbYi9vKbEpTeZScmgp/BjxmvpxCDCgknoivMek3sm/ZZqMEPO4nM8fV
 4OUCCXo4aMscBy4L5GQ3H2YND1drdHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-lQfiqINbMgakBYCg09gM0A-1; Thu, 14 Sep 2023 09:06:23 -0400
X-MC-Unique: lQfiqINbMgakBYCg09gM0A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c6c275c83so571680f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Sep 2023 06:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694696782; x=1695301582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/pGng4Jlz5jKGWmwVqa99A3qKH6EyoanXPEX+/wRiw=;
 b=uoOgPFAKxTTjXn3UWCI2oa6rwOVD7I3NCNbKXGJNr3J3aSrLUOBnEqIf16l06Qxcnq
 GTdaWyp6sJO3O2/i7eGwb1hPZjBf7olB82kVGrWVZ9kk9jtnNafEUXq1K60xGzg+wlGj
 gr12O5E+tu+mXvziiseVjByx+0GQA/6B1LJRlfdincW7YuCShNh/IAxVmxX/qY+0yn8U
 PcOuaD2o7y9UCaUMgnaMNlylK45RW2w4Qw4hrCGFeBGumnXqTa+764CAJ3lZBbI1CryQ
 lxV3XNibjWlaSdQcXOtMqI9xWvrF+5TAdvgSE089s3pVJdSKSbEvueHfWN/CtOBhJe0A
 DtoQ==
X-Gm-Message-State: AOJu0Yw2fdnTgaCgD+8huKCbYNJIyBrRx1VgLuol9b4XFKxfvAEZs9WN
 O13BpYw5SMsIpnUO5Bfb9GmndZVg30kO5m/vxWCyavjyCBEEgEzIbJw/ALmap7LygsLizH8kQ2V
 AfgEKSQ+2JDe7LlMd/fo1m8vyNwAA6jRRHeisoOqUWA==
X-Received: by 2002:a5d:6752:0:b0:31f:b91c:6ebc with SMTP id
 l18-20020a5d6752000000b0031fb91c6ebcmr4442861wrw.14.1694696782739; 
 Thu, 14 Sep 2023 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMprSt5Eq7z2+zyD9pVdEhDhOcN3K4FFKy92OAHwhT7/UABz6yxx0vX6SGjsriWT02u92rgg==
X-Received: by 2002:a5d:6752:0:b0:31f:b91c:6ebc with SMTP id
 l18-20020a5d6752000000b0031fb91c6ebcmr4442801wrw.14.1694696781669; 
 Thu, 14 Sep 2023 06:06:21 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.114.183])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c22c400b00403b63e87f2sm1940671wmg.32.2023.09.14.06.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 06:06:21 -0700 (PDT)
Date: Thu, 14 Sep 2023 15:06:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v8 2/4] vsock/virtio: support to send non-linear
 skb
Message-ID: <nzguzjuchyk5uwdnexegayweyogv5wdfgaxrrw47fuw2rjkumq@4ybro57ixsga>
References: <20230911202234.1932024-1-avkrasnov@salutedevices.com>
 <20230911202234.1932024-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230911202234.1932024-3-avkrasnov@salutedevices.com>
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

On Mon, Sep 11, 2023 at 11:22:32PM +0300, Arseniy Krasnov wrote:
>For non-linear skb use its pages from fragment array as buffers in
>virtio tx queue. These pages are already pinned by 'get_user_pages()'
>during such skb creation.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v2 -> v3:
>  * Comment about 'page_to_virt()' is updated. I don't remove R-b,
>    as this change is quiet small I guess.
> v6 -> v7:
>  * Move arrays '*sgs' and 'bufs' to 'virtio_vsock' instead of being
>    local variables. This allows to save stack space in cases of too
>    big MAX_SKB_FRAGS.
>  * Add 'WARN_ON_ONCE()' for handling nonlinear skbs - it checks that
>    linear part of such skb contains only header.
>  * R-b tag removed due to updates above.
> v7 -> v8:
>  * Add comment in 'struct virtio_vsock' for both 'struct scatterlist'
>    fields.
>  * Rename '*sgs' and 'bufs' to '*out_sgs' and 'out_bufs'.
>  * Initialize '*out_sgs' in 'virtio_vsock_probe()' by always pointing
>    to the corresponding element of 'out_bufs'.

LGTM, thanks for addressing that comments!

>
> net/vmw_vsock/virtio_transport.c | 60 ++++++++++++++++++++++++++++----
> 1 file changed, 53 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
