Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2327FEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 15:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CE6C80E8B;
	Mon, 26 Jun 2023 15:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CE6C80E8B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HHS7UQfo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ak68t3PvR1Un; Mon, 26 Jun 2023 15:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C53B680E60;
	Mon, 26 Jun 2023 15:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C53B680E60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7379C007A;
	Mon, 26 Jun 2023 15:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BF9C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23ACF41586
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23ACF41586
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HHS7UQfo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdzxZIyvTMaf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D35D41584
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D35D41584
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687791808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ub/VWsuBNP1d/wVrp0FxrBklvO4kjHuqLjqpHpTQ37c=;
 b=HHS7UQfoM73Li6CeZxfrT//qOUwaChIwBuJgHGjHnBuyQ0GbO1LTLUkDIw3U0T/SRkh+lR
 ENzBuSkECUBBKxydNf57RZpDGOHHJeQDS+m3ICy51uMpvNBHQpBY1SuxPRlLetNZgOaYbF
 0JOhePkAkP/YYuOTqST8VlonbVmRZ/c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-8miM-phRNFisVqaFJSS3Uw-1; Mon, 26 Jun 2023 11:03:26 -0400
X-MC-Unique: 8miM-phRNFisVqaFJSS3Uw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765a632f342so123141485a.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687791805; x=1690383805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub/VWsuBNP1d/wVrp0FxrBklvO4kjHuqLjqpHpTQ37c=;
 b=THWkKPBN3xKuBFGbU7nQWduYxNdOCEvMbDqH5z0oqWOMoefZPZOG5RBDhfkz1OGFDV
 zz8Oa7fN87UHzq7E4mq/YBTOsgw//KXnewJUuLImrGJR1FcwDFFFz1NlZ96Qk8dM9Jae
 Sut7r5o0d98Jm4GyW1r/kZmiwJu6X/ZjwZg6XNQy1+DyNWvlAVjcWp6WxK+4exnQMc1V
 yJaspm2gsefUTgE5EjM/vrwp5BC8Vq7vDexPZkMGCyZ/3FaLHQVroOvhZiKAjHNPGoQ2
 OEitaHxVIXeAMlDGcZ3Fmhd09VhOlm3gwg+VBzS+6eOIIhWPaCt2EqtYworcp7vr1luA
 H2gA==
X-Gm-Message-State: AC+VfDz3Eoug90rYykCPxXsFKsq1cYrhnAIKIzEwPkXpSL2VYtRBwUno
 d4S9zPclTlz6Ug1pJBs13e5z2ME4R08s2RjuhaTZBNr/mUluEndGEwChLUd8djfnUV2Ci0mbKfK
 +tQzpi1ltPQBgtulRVc9BHirZAx2iWcf1eEHPd9pBMw==
X-Received: by 2002:a05:620a:2448:b0:765:5ba6:a5d8 with SMTP id
 h8-20020a05620a244800b007655ba6a5d8mr7093254qkn.56.1687791805415; 
 Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kkeJTxwkOuRgwOYiRhgUk3L+mBLGI2Low73pEvZAsI+uLzLMyBVcad67r2Cc4Q8w+k8KCrA==
X-Received: by 2002:a05:620a:2448:b0:765:5ba6:a5d8 with SMTP id
 h8-20020a05620a244800b007655ba6a5d8mr7093213qkn.56.1687791805149; 
 Mon, 26 Jun 2023 08:03:25 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 y26-20020a37e31a000000b00765a7843382sm1194049qki.74.2023.06.26.08.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:03:24 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:03:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <d53tgo4igvz34pycgs36xikjosrncejlzuvh47bszk55milq52@whcyextsxfka>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
 <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
 <ZJUho6NbpCgGatap@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZJUho6NbpCgGatap@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Arseniy Krasnov <oxffffaa@gmail.com>,
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

On Fri, Jun 23, 2023 at 04:37:55AM +0000, Bobby Eshleman wrote:
>On Thu, Jun 22, 2023 at 06:09:12PM +0200, Stefano Garzarella wrote:
>> On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>> > Hello Bobby!
>> >
>> > On 10.06.2023 03:58, Bobby Eshleman wrote:
>> > > This commit adds support for datagrams over virtio/vsock.
>> > >
>> > > Message boundaries are preserved on a per-skb and per-vq entry basis.
>> >
>> > I'm a little bit confused about the following case: let vhost sends 4097 bytes
>> > datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>> > buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>> > buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>> > has two skb in it rx queue, and user in guest wants to read data - does it read
>> > 4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>> > special marker in header which shows where message ends, and how it works here?
>>
>> I think the main difference is that DGRAM is not connection-oriented, so
>> we don't have a stream and we can't split the packet into 2 (maybe we
>> could, but we have no guarantee that the second one for example will be
>> not discarded because there is no space).
>>
>> So I think it is acceptable as a restriction to keep it simple.
>>
>> My only doubt is, should we make the RX buffer size configurable,
>> instead of always using 4k?
>>
>I think that is a really good idea. What mechanism do you imagine?

Some parameter in sysfs?

>
>For sendmsg() with buflen > VQ_BUF_SIZE, I think I'd like -ENOBUFS

For the guest it should be easy since it allocates the buffers, but for
the host?

Maybe we should add a field in the configuration space that reports some
sort of MTU.

Something in addition to what Laura had proposed here:
https://markmail.org/message/ymhz7wllutdxji3e

>returned even though it is uncharacteristic of Linux sockets.
>Alternatively, silently dropping is okay... but seems needlessly
>unhelpful.

UDP takes advantage of IP fragmentation, right?
But what happens if a fragment is lost?

We should try to behave in a similar way.

>
>FYI, this patch is broken for h2g because it requeues partially sent
>skbs, so probably doesn't need much code review until we decided on the
>policy.

Got it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
