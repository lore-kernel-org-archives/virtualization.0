Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D853AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 11:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EACC84376;
	Thu, 10 Mar 2022 11:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2QPA5fs1eib; Thu, 10 Mar 2022 11:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC29F841FD;
	Thu, 10 Mar 2022 11:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBC83C0012;
	Thu, 10 Mar 2022 11:00:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD216C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 11:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BBDF607F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 11:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cgttv1enxAks
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 11:00:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90E3F606D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646910042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsfeyKqrBgkYuQzWFN//9BncY2nLecQ3kO20U/V6vFk=;
 b=NmnpEnq0YO8KKyQLu8GL2pdKpFXNI6MHcmDfqaruCkAGQTIEwuqs1PjCiE1x9359yg5Ixc
 ieJ8Q312fruBml7C06vQ2UfrbpthRA0BQbr25g/WYxcBnNIhszL71nHpGgHqNbO2K6Bxre
 Eq/bfInyOy0Piay5/SVs4dZLkGoWN3o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-NEVCRkWfO0S9MzfWqnvvJA-1; Thu, 10 Mar 2022 06:00:41 -0500
X-MC-Unique: NEVCRkWfO0S9MzfWqnvvJA-1
Received: by mail-wr1-f71.google.com with SMTP id
 a16-20020adff7d0000000b001f0473a6b25so1560222wrq.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 03:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AsfeyKqrBgkYuQzWFN//9BncY2nLecQ3kO20U/V6vFk=;
 b=plFEdGEQuNLrb2h3BR9OIlCCWYsvbsit6vWsCXiXH++NE/rt8R3FsiyCTElJFEZeHk
 oM440BmNAmArZLbZRqkhPEHnMMBwEJuEU1zVZCfiJLanThsHcXAmDyuoHyxMxMmmIMwI
 zrUx9gbX9hKnia5e63BIHxeNnB2REXD39Vgnz8ux+YvmntsxZTFTcZhuYBb1lG4lDFty
 3IMPkzQgFSAZ+MJM1bMbBxDGkbMe0lOhMww0U+F/7/io+sf+koFfnB50Y3mExhpQUGJy
 XDisomzXQam9BxMdcOQs5banNpk06BFh8uT6VKkQjBh2m5Rq0mP1K5vbxcLjO13U6MvN
 2agQ==
X-Gm-Message-State: AOAM531Rpio/sT35z1lx3wsgWXlXp5P3ZJJnCBGOABDj1L5+ujn35PnY
 BzUn274xekBCu1BAd340bCLbqcjEpEr2uSImIgdW3TuMjByHmhpUlBvL+NOEFUC78atQ/rqa6Uv
 nqMTP9pV6MkKG8BfFNsCpqXqk5/ZA1r3pNpHNgVze7w==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id
 q11-20020a1cf30b000000b0037bb5dec804mr11036410wmq.166.1646910040151; 
 Thu, 10 Mar 2022 03:00:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE//Um8fdzz7IHgiVk+0r92oJeOzoNXJHMsqiiiF0zWaYyYnqN4PdqnWhKpxWaqHo+iNwr5g==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id
 q11-20020a1cf30b000000b0037bb5dec804mr11036389wmq.166.1646910039856; 
 Thu, 10 Mar 2022 03:00:39 -0800 (PST)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm3863935wrv.10.2022.03.10.03.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 03:00:39 -0800 (PST)
Date: Thu, 10 Mar 2022 12:00:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH] vhost/vsock: reset only the h2g connections upon release
Message-ID: <20220310110036.fgy323c4hvk3mziq@sgarzare-redhat>
References: <20220310081854.2487280-1-jiyong@google.com>
 <20220310085931.cpgc2cv4yg7sd4vu@sgarzare-redhat>
 <CALeUXe6heGD9J+5fkLs9TJ7Mn0UT=BSdGNK_wZ4gkor_Ax_SqA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALeUXe6heGD9J+5fkLs9TJ7Mn0UT=BSdGNK_wZ4gkor_Ax_SqA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Thu, Mar 10, 2022 at 07:41:54PM +0900, Jiyong Park wrote:
>Hi Stefano,
>
>On Thu, Mar 10, 2022 at 5:59 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Jiyong,
>>
>> On Thu, Mar 10, 2022 at 05:18:54PM +0900, Jiyong Park wrote:
>> >Filtering non-h2g connections out when determining orphaned connections.
>> >Otherwise, in a nested VM configuration, destroying the nested VM (which
>> >often involves the closing of /dev/vhost-vsock if there was h2g
>> >connections to the nested VM) kills not only the h2g connections, but
>> >also all existing g2h connections to the (outmost) host which are
>> >totally unrelated.
>> >
>> >Tested: Executed the following steps on Cuttlefish (Android running on a
>> >VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>> >connection inside the VM, (2) open and then close /dev/vhost-vsock by
>> >`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>> >session is not reset.
>> >
>> >[1] https://android.googlesource.com/device/google/cuttlefish/
>> >
>> >Signed-off-by: Jiyong Park <jiyong@google.com>
>> >---
>> > drivers/vhost/vsock.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>> >
>> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> >index 37f0b4274113..2f6d5d66f5ed 100644
>> >--- a/drivers/vhost/vsock.c
>> >+++ b/drivers/vhost/vsock.c
>> >@@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>> >        * executing.
>> >        */
>> >
>> >+      /* Only the h2g connections are reset */
>> >+      if (vsk->transport != &vhost_transport.transport)
>> >+              return;
>> >+
>> >       /* If the peer is still valid, no need to reset connection */
>> >       if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>> >               return;
>> >--
>> >2.35.1.723.g4982287a31-goog
>> >
>>
>> Thanks for your patch!
>>
>> Yes, I see the problem and I think I introduced it with the
>> multi-transports support (ooops).
>>
>> So we should add this fixes tag:
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>
>>
>> IIUC the problem is for all transports that should only cycle on their
>> own sockets. Indeed I think there is the same problem if the g2h driver
>> will be unloaded (or a reset event is received after a VM migration), it
>> will close all sockets of the nested h2g.
>>
>> So I suggest a more generic solution, modifying
>> vsock_for_each_connected_socket() like this (not tested):
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 38baeb189d4e..f04abf662ec6 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -334,7 +334,8 @@ void vsock_remove_sock(struct vsock_sock *vsk)
>>   }
>>   EXPORT_SYMBOL_GPL(vsock_remove_sock);
>>
>> -void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
>> +void vsock_for_each_connected_socket(struct vsock_transport *transport,
>> +                                    void (*fn)(struct sock *sk))
>>   {
>>          int i;
>>
>> @@ -343,8 +344,12 @@ void vsock_for_each_connected_socket(void (*fn)(struct sock *sk))
>>          for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
>>                  struct vsock_sock *vsk;
>>                  list_for_each_entry(vsk, &vsock_connected_table[i],
>> -                                   connected_table)
>> +                                   connected_table) {
>> +                       if (vsk->transport != transport)
>> +                               continue;
>> +
>>                          fn(sk_vsock(vsk));
>> +               }
>>          }
>>
>>
>> And all transports that call it.
>>
>> Thanks,
>> Stefano
>>
>
>Thanks for the suggestion, which looks much better. It actually worked well.

Thanks for trying this!

>
>By the way, the suggested change will alter the kernel-module interface (KMI),
>which will make it difficult to land the change on older releases where we'd
>like to keep the KMI stable [1]. Would it be OK if we let the supplied function
>(fn) be responsible for checking the transport? I think that there, in
>the future,
>might be a case where one needs to cycle over all sockets for inspection or so.
>I admit that this would be prone to error, though.
>
>Please let me know what you think. I don't have a strong preference. I will
>submit a revision as you want.

I see your point, and it makes sense to keep KMI on stable branches, but 
mainline I would like to have the proposed approach since all transports 
use it to cycle on their sockets.

So we could do a series with 2 patches:
- Patch 1 fixes the problem in all transports by checking the transport
   in the callback (here we insert the fixes tag so we backport it to the
   stable branches)
- Patch 2 moves the check in vsock_for_each_connected_socket() removing
   it from callbacks so it is less prone to errors and we merge it only
   mainline

What do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
