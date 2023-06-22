Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27635EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 16:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A03AE408F6;
	Thu, 22 Jun 2023 16:10:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A03AE408F6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwray6HO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DgnlKr6kqjWI; Thu, 22 Jun 2023 16:10:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBD94417D5;
	Thu, 22 Jun 2023 16:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBD94417D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1966C0037;
	Thu, 22 Jun 2023 16:09:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E70C7C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C19B260B90
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C19B260B90
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwray6HO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0OzzN2HygxK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:09:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D248060598
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D248060598
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687450196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
 b=bwray6HOcggOG0Qs6ZSPAfKKrgb5vvAzgSSYoHta+jdwVo+eDdkMXMnNmqVLNli2Q5lN8M
 0/zkTXudIXJQ568ql5yv5HVx0nwc3x9WTIshx8H2JM5n/tLLVuklrortK2+iEBLsZ02O5e
 RKTWDZk/T6T/VZYItewZ3rqVzXdca7s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_iAFw1QgPwGjKPYM486Y2Q-1; Thu, 22 Jun 2023 12:09:53 -0400
X-MC-Unique: _iAFw1QgPwGjKPYM486Y2Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b45e6e1c44so54537961fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 09:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450156; x=1690042156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4ZeA3fCzpsP/weTyEHljBjdeImnc1sztgg04Zvr3Iw=;
 b=JHTQjmS7DRVZxSLrnvaOacJnYrsbsJKiKIXimVwkbp7+hAwOSyayKO8YjX5P/5JDSg
 4MwIaai8M3hZOXAVkphP4h0G8j1MtMu/Wf4B3EmxU+addZQSDIn7DwvGhn5J5Fl0gNIb
 k/pWo7gu+zaaRGkucipTFWFeeXCsVXuAnHTi11j7qDCGOYFkZUWCS3b8bTRbViS0jyIL
 5bStw/1NzuPndKJiXbq9uBjA9dK33ORMsU16eTI9ARuJqz6SszPTEcm+gWICV6OJMZQ5
 wmdnpFk0Gl/YbsL9nK/Xy9OKOq6Mur1mLL//X+tO6ZJgRX3Ys1otB0U1wDwhUVv9PM+0
 YfUg==
X-Gm-Message-State: AC+VfDwf/5yYOeoXsmeJ/xHCmnZ8WpHIeMEEn2DdD0yVQJHaOns8WFj1
 14vuZzJRgDjylwzapyi6mJnemEAUcLhzANwyhxM9rcYtGb0V2+8DrHB5Z1WuDiJO85shcgBWGOh
 6UL/EK6tNmGamGDyLPXmb+KY4Y92y1rHzzqoTWjFdLw==
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id
 p14-20020a2e9a8e000000b002b58cfd5236mr2267182lji.17.1687450155866; 
 Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PUI9RE8kTcJcsGtpi7DjRk/Abacp0W+tVcBZjDh9XPq5tuQJut8wknojrAHXz03XIsMl3gQ==
X-Received: by 2002:a2e:9a8e:0:b0:2b5:8cfd:5236 with SMTP id
 p14-20020a2e9a8e000000b002b58cfd5236mr2267154lji.17.1687450155518; 
 Thu, 22 Jun 2023 09:09:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 f13-20020a1709067f8d00b0098d2f91c850sm1026234ejr.89.2023.06.22.09.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:09:14 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:09:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <oxffffaa@gmail.com>
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
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

On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>Hello Bobby!
>
>On 10.06.2023 03:58, Bobby Eshleman wrote:
>> This commit adds support for datagrams over virtio/vsock.
>>
>> Message boundaries are preserved on a per-skb and per-vq entry basis.
>
>I'm a little bit confused about the following case: let vhost sends 4097 bytes
>datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>has two skb in it rx queue, and user in guest wants to read data - does it read
>4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>special marker in header which shows where message ends, and how it works here?

I think the main difference is that DGRAM is not connection-oriented, so
we don't have a stream and we can't split the packet into 2 (maybe we
could, but we have no guarantee that the second one for example will be
not discarded because there is no space).

So I think it is acceptable as a restriction to keep it simple.

My only doubt is, should we make the RX buffer size configurable,
instead of always using 4k?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
