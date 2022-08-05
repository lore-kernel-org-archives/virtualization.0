Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2020C00140
	for <virtualization@archiver.kernel.org>; Fri,  5 Aug 2022 12:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1A6783E80;
	Fri,  5 Aug 2022 12:42:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1A6783E80
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dyk/NYJr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiOsqWflLiGQ; Fri,  5 Aug 2022 12:42:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2BAD83E7A;
	Fri,  5 Aug 2022 12:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2BAD83E7A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 981A7C0032;
	Fri,  5 Aug 2022 12:42:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA93C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 12:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C992341C93
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 12:42:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C992341C93
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dyk/NYJr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cGegc2FxcmoM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 12:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A81C440AE2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A81C440AE2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Aug 2022 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659703366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbNzuUNlONNPGBpeyjfKi2f8mYMJka6a1j60uZitIeU=;
 b=dyk/NYJrRNWrdFm4ZIvFlYQ8ihhmex0RsQd1hhHfpU5nUxm87qNlXN0mtyVuLtxt8pxFzC
 oTQe96/VUEBSTkFT62qd1mKSP3/deAEYikF5iyqLQa4TFsdocIP4tDwPSdJKhcOUQomQ49
 Xrnys8lFctUyKlv44ATaifUj4RS84e0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-aqtDEKyuOGuUHbxqIHM7sw-1; Fri, 05 Aug 2022 08:42:45 -0400
X-MC-Unique: aqtDEKyuOGuUHbxqIHM7sw-1
Received: by mail-wm1-f69.google.com with SMTP id
 18-20020a05600c029200b003a500b612e2so1230806wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Aug 2022 05:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=JbNzuUNlONNPGBpeyjfKi2f8mYMJka6a1j60uZitIeU=;
 b=HcWGM9Sxv1QKBzm8TK3H5YiVa28JXIM51gCmZkaXRYuXb4Ikeay7GybdYJFn9sYAgg
 /sYu0Jd3D4AGwjfgTXrB3Y8AwT3u0ZlI3vnVEvdUHF090OJ8qavA0tSSlRbTpuWpSu8v
 nh0hBL4ehi4j0I33/4v0NK51s71sUin31uNYsulqPQEgA/D+xtEwKxsxtAklm5/AKKxc
 H2Zj+1MkKsfcVHNoQTnXpztfUEleV1Vc1C4UMZ/8YgcuTt7sIIxMxTdXgXZsWLe0yQfJ
 QWSEHxN8rkbFQpOBQra/CSBpQIUofQwDS2kqy0tvFngxEcgdSRUMqToWcOiFuIhgvfHk
 9qBQ==
X-Gm-Message-State: ACgBeo3VfVsrmQz5ZNylpJ3j5OXzLWHPWyD65XYHpDv0OYzvnNeOCLPX
 lCbd2j60fG+Hmp3j16cIiYqD7ShCUzTg3v56jUMCZsERPB/oQv5o/t5TX6y4d3IZ76ttte8x2FH
 PPORt1suzN+RQCBu7GGgT/wPH8trAJnjkuscMBP+e6Q==
X-Received: by 2002:a05:6000:10c3:b0:21f:15aa:1b68 with SMTP id
 b3-20020a05600010c300b0021f15aa1b68mr4285505wrx.693.1659703364148; 
 Fri, 05 Aug 2022 05:42:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4FBixHL1jxLf6cGBv7tQy3XiRqmkIIqWAMrqrcbMs3wyml1Ga267IspwQxC1cUWPEdc4mg6g==
X-Received: by 2002:a05:6000:10c3:b0:21f:15aa:1b68 with SMTP id
 b3-20020a05600010c300b0021f15aa1b68mr4285486wrx.693.1659703363869; 
 Fri, 05 Aug 2022 05:42:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 l3-20020a5d4803000000b0021e42e7c7dbsm3802357wrq.83.2022.08.05.05.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Aug 2022 05:42:43 -0700 (PDT)
Date: Fri, 5 Aug 2022 14:42:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peilin Ye <yepeilin.cs@gmail.com>
Subject: Re: [PATCH RFC net-next] vsock: Reschedule connect_work for
 O_NONBLOCK connect() requests
Message-ID: <20220805124239.iy5lkeytqwjyvn7g@sgarzare-redhat>
References: <20220804020925.32167-1-yepeilin.cs@gmail.com>
 <20220804065923.66bor7cyxwk2bwsf@sgarzare-redhat>
 <20220804234447.GA2294@bytedance>
MIME-Version: 1.0
In-Reply-To: <20220804234447.GA2294@bytedance>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peilin Ye <peilin.ye@bytedance.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Aug 04, 2022 at 04:44:47PM -0700, Peilin Ye wrote:
>Hi Stefano,
>
>On Thu, Aug 04, 2022 at 08:59:23AM +0200, Stefano Garzarella wrote:
>> The last thing I was trying to figure out before sending the patch was
>> whether to set sock->state = SS_UNCONNECTED in vsock_connect_timeout().
>>
>> I think we should do that, otherwise a subsequent to connect() with
>> O_NONBLOCK set would keep returning -EALREADY, even though the timeout has
>> expired.
>>
>> What do you think?
>
>Thanks for bringing this up, after thinking about sock->state, I have 3
>thoughts:
>
>1. I think the root cause of this memleak is, we keep @connect_work
>   pending, even after the 2nd, blocking request times out (or gets
>   interrupted) and sets sock->state back to SS_UNCONNECTED.
>
>   @connect_work is effectively no-op when sk->sk_state is
>   TCP_CLOS{E,ING} anyway, so why not we just cancel @connect_work when
>   blocking requests time out or get interrupted?  Something like:
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..62628af84164 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1402,6 +1402,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>                lock_sock(sk);
>
>                if (signal_pending(current)) {
>+                       if (cancel_delayed_work(&vsk->connect_work))
>+                               sock_put(sk);
>+
>                        err = sock_intr_errno(timeout);
>                        sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>                        sock->state = SS_UNCONNECTED;
>@@ -1409,6 +1412,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>                        vsock_remove_connected(vsk);
>                        goto out_wait;
>                } else if (timeout == 0) {
>+                       if (cancel_delayed_work(&vsk->connect_work))
>+                               sock_put(sk);
>+
>                        err = -ETIMEDOUT;
>                        sk->sk_state = TCP_CLOSE;
>                        sock->state = SS_UNCONNECTED;
>
>   Then no need to worry about rescheduling @connect_work, and the state
>   machine becomes more accurate.  What do you think?  I will ask syzbot
>   to test this.

It could work, but should we set `sk->sk_err` and call sk_error_report() 
to wake up thread waiting on poll()?

Maybe the previous version is simpler.

>
>2. About your suggestion of setting sock->state = SS_UNCONNECTED in
>   vsock_connect_timeout(), I think it makes sense.  Are you going to
>   send a net-next patch for this?

If you have time, feel free to send it.

Since it is a fix, I believe you can use the "net" tree. (Also for this 
patch).

Remember to put the "Fixes" tag that should be the same.

>
>3. After a TCP_SYN_SENT sock receives VIRTIO_VSOCK_OP_RESPONSE in
>   virtio_transport_recv_connecting(), why don't we cancel 
>   @connect_work?
>   Am I missing something?

Because when the timeout will fire, vsock_connect_timeout() will just 
call sock_put() since sk->sk_state is changed.

Of course, we can cancel it if we want, but I think it's not worth it.
In the end, this rescheduling patch should solve all the problems.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
