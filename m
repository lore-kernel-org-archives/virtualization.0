Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9530FC25B06
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 10:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CEE0405A7;
	Tue,  9 Aug 2022 10:04:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CEE0405A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERMnXB6c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dbopX5NZkQC; Tue,  9 Aug 2022 10:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61A3D4059C;
	Tue,  9 Aug 2022 10:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61A3D4059C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F97CC0033;
	Tue,  9 Aug 2022 10:04:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A817AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80A9640918
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:04:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80A9640918
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERMnXB6c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yw122I4jBYTH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:04:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0676140867
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0676140867
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660039447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqwZLW2Fem8FvBOvg9FQMP8N9BRJ6oVlzGNZR0lXrSk=;
 b=ERMnXB6c8Voaiv5uPAkc+qES6jyPa0/U6cRkFgHP0B5/xhLfX0pK3YmNpcUJl7wHfykWwd
 sjSFOHKXhDIyC9Kduup6MA+rmfzg43B/VhQLMRiXYtmZiYHHGLK10S5+7pCeG8pE+gR6vq
 oacnKXYGFw6CA2E0SruVZx9AzZaif4w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-_mwd1iWdNqy2l7aee3ILaA-1; Tue, 09 Aug 2022 06:04:06 -0400
X-MC-Unique: _mwd1iWdNqy2l7aee3ILaA-1
Received: by mail-wm1-f72.google.com with SMTP id
 h65-20020a1c2144000000b003a30cae106cso9687517wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 03:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=tqwZLW2Fem8FvBOvg9FQMP8N9BRJ6oVlzGNZR0lXrSk=;
 b=Q/z7+DQvzFG0e8Dt31OwKZJbbOljOyleK4IJ2+7fnD9YOX4OTFoliQU2iI9J7RjYqb
 PFnCQgP1DbEU9NETUOcytAqBNgeATF7xJLWh6PV7fd/xCpx6lgXmEnN7r61RBqc05rCZ
 HqV898ebgLs2CtRGs6pptFskzK4gkhlh5tTQ8pyGiclaoDeaatKEtvxaOtRfKTGZeNme
 LmydRAGDyO3kVRTgIllWdGoaswnaBOApIXik3qfUUghIce86WhbQ+wEAbtYQvVMy5sd7
 3Xkw2oDR4hEubuUsGTYkHWayad7JYSGixr39BzuJcNtdUrhkRjLMcjhI7nhY/57KoFra
 ShoA==
X-Gm-Message-State: ACgBeo2KOdjEJqVqY1/m6tRdwYjmScIZaiCQ4qkjBz2Z30yiJj7t5fq8
 rEjgwcYYikcpR/OvdTY0ky9weTkQ0HNmajmYso/ItoI3UK6lvbqAGOpnhj+AzvFu8ciSg5cQCGp
 OOwo5Hugb6uDX1RuS66kmj5GOnaJVfWcDMt5lC/NAXA==
X-Received: by 2002:a05:600c:1993:b0:3a4:c0a9:5b6f with SMTP id
 t19-20020a05600c199300b003a4c0a95b6fmr15391388wmq.79.1660039445366; 
 Tue, 09 Aug 2022 03:04:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6taqzhXrMpiY1ysC8UKte8WpDJhOBHgg7RESz57wiGmZKP/VeUv2yUUPkbkdIoRGdGpgbj7g==
X-Received: by 2002:a05:600c:1993:b0:3a4:c0a9:5b6f with SMTP id
 t19-20020a05600c199300b003a4c0a95b6fmr15391348wmq.79.1660039445062; 
 Tue, 09 Aug 2022 03:04:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 ck15-20020a5d5e8f000000b002205f0890eesm13761940wrb.77.2022.08.09.03.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 03:04:03 -0700 (PDT)
Date: Tue, 9 Aug 2022 12:03:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/9] vsock: SO_RCVLOWAT transport set callback
Message-ID: <20220809100358.xnxromtvrehsgpn3@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
 <20220808102335.nkviqobpgcmcaqhn@sgarzare-redhat>
 <CAGxU2F513N+0sB0fEz4EF7+NeELhW9w9Rk6hh5K7QQO+eXRymA@mail.gmail.com>
 <1ea271c1-d492-d7f7-5016-7650a72b6139@sberdevices.ru>
 <d9bd1c16-7096-d267-a0ff-d3742b0dcf56@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <d9bd1c16-7096-d267-a0ff-d3742b0dcf56@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Aug 09, 2022 at 09:45:47AM +0000, Arseniy Krasnov wrote:
>On 09.08.2022 12:37, Arseniy Krasnov wrote:
>> On 08.08.2022 13:30, Stefano Garzarella wrote:
>>> On Mon, Aug 8, 2022 at 12:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>
>>>> On Wed, Aug 03, 2022 at 01:51:05PM +0000, Arseniy Krasnov wrote:
>>>>> This adds transport specific callback for SO_RCVLOWAT, because in some
>>>>> transports it may be difficult to know current available number of bytes
>>>>> ready to read. Thus, when SO_RCVLOWAT is set, transport may reject it.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> include/net/af_vsock.h   |  1 +
>>>>> net/vmw_vsock/af_vsock.c | 25 +++++++++++++++++++++++++
>>>>> 2 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>>>> index f742e50207fb..eae5874bae35 100644
>>>>> --- a/include/net/af_vsock.h
>>>>> +++ b/include/net/af_vsock.h
>>>>> @@ -134,6 +134,7 @@ struct vsock_transport {
>>>>>       u64 (*stream_rcvhiwat)(struct vsock_sock *);
>>>>>       bool (*stream_is_active)(struct vsock_sock *);
>>>>>       bool (*stream_allow)(u32 cid, u32 port);
>>>>> +      int (*set_rcvlowat)(struct vsock_sock *, int);
>>>>
>>>> checkpatch suggests to add identifier names. For some we put them in,
>>>> for others we didn't, but I suggest putting them in for the new ones
>>>> because I think it's clearer too.
>>>>
>>>> WARNING: function definition argument 'struct vsock_sock *' should also
>>>> have an identifier name
>>>> #25: FILE: include/net/af_vsock.h:137:
>>>> +       int (*set_rcvlowat)(struct vsock_sock *, int);
>>>>
>>>> WARNING: function definition argument 'int' should also have an identifier name
>>>> #25: FILE: include/net/af_vsock.h:137:
>>>> +       int (*set_rcvlowat)(struct vsock_sock *, int);
>>>>
>>>> total: 0 errors, 2 warnings, 0 checks, 44 lines checked
>>>>
>>>>>
>>>>>       /* SEQ_PACKET. */
>>>>>       ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index f04abf662ec6..016ad5ff78b7 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -2129,6 +2129,30 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>>>>>       return err;
>>>>> }
>>>>>
>>>>> +static int vsock_set_rcvlowat(struct sock *sk, int val)
>>>>> +{
>>>>> +      const struct vsock_transport *transport;
>>>>> +      struct vsock_sock *vsk;
>>>>> +      int err = 0;
>>>>> +
>>>>> +      vsk = vsock_sk(sk);
>>>>> +
>>>>> +      if (val > vsk->buffer_size)
>>>>> +              return -EINVAL;
>>>>> +
>>>>> +      transport = vsk->transport;
>>>>> +
>>>>> +      if (!transport)
>>>>> +              return -EOPNOTSUPP;
>>>>
>>>> I don't know whether it is better in this case to write it in
>>>> sk->sk_rcvlowat, maybe we can return EOPNOTSUPP only when the trasport
>>>> is assigned and set_rcvlowat is not defined. This is because usually the
>>>> options are set just after creation, when the transport is practically
>>>> unassigned.
>>>>
>>>> I mean something like this:
>>>>
>>>>          if (transport) {
>>>>                  if (transport->set_rcvlowat)
>>>>                          return transport->set_rcvlowat(vsk, val);
>>>>                  else
>>>>                          return -EOPNOTSUPP;
>>>>          }
>>>>
>>>>          WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>>>>
>>>>          return 0;
>>>
>>> Since hv_sock implements `set_rcvlowat` to return EOPNOTSUPP. maybe we
>>> can just do the following:
>>>
>>>         if (transport && transport->set_rcvlowat)
>>>                 return transport->set_rcvlowat(vsk, val);
>>>
>>>         WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>>>         return 0;
>>>
>>> That is, the default behavior is to set sk->sk_rcvlowat, but for
>>> transports that want a different behavior, they need to define
>>> set_rcvlowat() (like hv_sock).
>> Hm ok, i see. I've implemented logic when non-empty transport is required, because hyperv transport
>> forbids to set SO_RCVLOWAT, so user needs to call this setsockopt AFTER transport is assigned(to check
>> that transport allows it. Not after socket creation as You mentioned above). Otherwise there is no sense
>> in such callback - it will be never used. Also in code above - for hyperv we will have different behavior
>> depends on when set_rcvlowat is called: before or after transport assignment. Is it ok?
>sorry, i mean: for hyperv, if user sets sk_rcvlowat before transport is assigned, it sees 0 - success, but in fact
>hyperv transport forbids this option.

I see, but I think it's better to set it and not respect in hyperv (as 
we've practically done until now with all transports) than to prevent 
the setting until we assign a transport.

At most when we use hyperv anyway we get notified per byte, so we should 
just get more notifications than we expect.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
