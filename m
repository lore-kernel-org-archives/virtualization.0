Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11CBEB64D9
	for <virtualization@archiver.kernel.org>; Thu, 29 Jun 2023 12:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBDEE418CA;
	Thu, 29 Jun 2023 12:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBDEE418CA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYUxJRx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Obv5DkzCOY9P; Thu, 29 Jun 2023 12:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1655E417A2;
	Thu, 29 Jun 2023 12:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1655E417A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB18AC0DD4;
	Thu, 29 Jun 2023 12:30:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36C09C0037
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11AEF81F5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11AEF81F5D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYUxJRx0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e29zt3gFKBkg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:30:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4E3F81A99
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4E3F81A99
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688041842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxNJCuGafLKSPeJQnzjiGq0TjYezzEm7bsw6nf+e1Ec=;
 b=hYUxJRx0z990fK0XftX5fLtHJp0nE6X4x7Zi4GPTLZ2G42tC4SSXm8ExQtgcjw1/lqHBZh
 SfAd0ufn6UEI09CiEkeguA6xS04TrrPHU1OMPStSs3C3WOm812XP8yitZ7vU9bx/GaNZgQ
 P+aHZ6TNOJ9VsW2JWgr7gqJ8X9o1fVY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-4xRD-l9zOnecic3MFwaUBg-1; Thu, 29 Jun 2023 08:30:41 -0400
X-MC-Unique: 4xRD-l9zOnecic3MFwaUBg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313e65772d8so941510f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 05:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688041840; x=1690633840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxNJCuGafLKSPeJQnzjiGq0TjYezzEm7bsw6nf+e1Ec=;
 b=EVY3kMRTFjzHtmR3K4TbTrdGEDp6RGd7tyKd42gpCETiXQU8rEFfLC9QsF4EItUrLb
 JmcQB/DLcB0/52yBh278D/IvNVOmbLkKftE1oVeWt7dwAVS9uO7Sdhp3nj+m5bHUsWSA
 NfgkgCJsF18qvLxzNWLzNkw7zZJ3p+/Gs4Ysf7WU8vpSdCnX7KJFho44zOIgJurxb6FN
 KgBI3KNtnvkXS4nmOROT4y/hWJ9fS5yuVsxE+lXzb2JtCG16Ve2Fvv59T+v/SUWxmaNE
 E3nMAexpNZjZLaiT8bS6jyFe9qMErYB8VmIwQ+s1riVQh6wijxiIzLVPlg4/bdgKu6E+
 Nkyw==
X-Gm-Message-State: AC+VfDzs1znQU+VC59tVQkJKwBJNjXpZzw3pqWQlasWLixZd5vjAwtJa
 MgiKehyhi1aC1QsQFhT/6QaalDjKHz5oR8BJEqH7t0UesJDlSuKqPodRbAtnLGI8voCybjhxvVP
 hAtl3/MLlfHqjps80yg3BZzt4H5eK08eL/3Ar2nS6Dw==
X-Received: by 2002:adf:ed8c:0:b0:313:e922:3941 with SMTP id
 c12-20020adfed8c000000b00313e9223941mr17813886wro.46.1688041840073; 
 Thu, 29 Jun 2023 05:30:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6kHN46tOVkCu1gvmqDPPPR5I5tNgGXFZ/EvKTkOoxsRLh+54YIckn5gW3VqlVkVhLtJAP1ow==
X-Received: by 2002:adf:ed8c:0:b0:313:e922:3941 with SMTP id
 c12-20020adfed8c000000b00313e9223941mr17813849wro.46.1688041839681; 
 Thu, 29 Jun 2023 05:30:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 q17-20020a5d6591000000b0030796e103a1sm15964532wru.5.2023.06.29.05.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 05:30:38 -0700 (PDT)
Date: Thu, 29 Jun 2023 14:30:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams
Message-ID: <yzxr4hdhac33gxpaelovlshdywdci2dqbt7fbellldy3zhc24e@hgrfvycmc7h6>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-6-0cebbb2ae899@bytedance.com>
 <92b3a6df-ded3-6470-39d1-fe0939441abc@gmail.com>
 <ppx75eomyyb354knfkwbwin3il2ot7hf5cefwrt6ztpcbc3pps@q736cq5v4bdh>
 <ZJUho6NbpCgGatap@bullseye>
 <d53tgo4igvz34pycgs36xikjosrncejlzuvh47bszk55milq52@whcyextsxfka>
 <ZJo5L+IM1P3kFAhe@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZJo5L+IM1P3kFAhe@bullseye>
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

On Tue, Jun 27, 2023 at 01:19:43AM +0000, Bobby Eshleman wrote:
>On Mon, Jun 26, 2023 at 05:03:15PM +0200, Stefano Garzarella wrote:
>> On Fri, Jun 23, 2023 at 04:37:55AM +0000, Bobby Eshleman wrote:
>> > On Thu, Jun 22, 2023 at 06:09:12PM +0200, Stefano Garzarella wrote:
>> > > On Sun, Jun 11, 2023 at 11:49:02PM +0300, Arseniy Krasnov wrote:
>> > > > Hello Bobby!
>> > > >
>> > > > On 10.06.2023 03:58, Bobby Eshleman wrote:
>> > > > > This commit adds support for datagrams over virtio/vsock.
>> > > > >
>> > > > > Message boundaries are preserved on a per-skb and per-vq entry basis.
>> > > >
>> > > > I'm a little bit confused about the following case: let vhost sends 4097 bytes
>> > > > datagram to the guest. Guest uses 4096 RX buffers in it's virtio queue, each
>> > > > buffer has attached empty skb to it. Vhost places first 4096 bytes to the first
>> > > > buffer of guests RX queue, and 1 last byte to the second buffer. Now IIUC guest
>> > > > has two skb in it rx queue, and user in guest wants to read data - does it read
>> > > > 4097 bytes, while guest has two skb - 4096 bytes and 1 bytes? In seqpacket there is
>> > > > special marker in header which shows where message ends, and how it works here?
>> > >
>> > > I think the main difference is that DGRAM is not connection-oriented, so
>> > > we don't have a stream and we can't split the packet into 2 (maybe we
>> > > could, but we have no guarantee that the second one for example will be
>> > > not discarded because there is no space).
>> > >
>> > > So I think it is acceptable as a restriction to keep it simple.
>> > >
>> > > My only doubt is, should we make the RX buffer size configurable,
>> > > instead of always using 4k?
>> > >
>> > I think that is a really good idea. What mechanism do you imagine?
>>
>> Some parameter in sysfs?
>>
>
>I comment more on this below.
>
>> >
>> > For sendmsg() with buflen > VQ_BUF_SIZE, I think I'd like -ENOBUFS
>>
>> For the guest it should be easy since it allocates the buffers, but for
>> the host?
>>
>> Maybe we should add a field in the configuration space that reports some
>> sort of MTU.
>>
>> Something in addition to what Laura had proposed here:
>> https://markmail.org/message/ymhz7wllutdxji3e
>>
>
>That sounds good to me.
>
>IIUC vhost exposes the limit via the configuration space, and the guest
>can configure the RX buffer size up to that limit via sysfs?
>
>> > returned even though it is uncharacteristic of Linux sockets.
>> > Alternatively, silently dropping is okay... but seems needlessly
>> > unhelpful.
>>
>> UDP takes advantage of IP fragmentation, right?
>> But what happens if a fragment is lost?
>>
>> We should try to behave in a similar way.
>>
>
>AFAICT in UDP the sending socket will see EHOSTUNREACH on its error
>queue and the packet will be dropped.
>
>For more details:
>- the IP defragmenter will emit an ICMP_TIME_EXCEEDED from ip_expire()
>  if the fragment queue is not completed within time.
>- Upon seeing ICMP_TIME_EXCEEDED, the sending stack will then add
>  EHOSTUNREACH to the socket's error queue, as seen in __udp4_lib_err().
>
>Given some updated man pages I think enqueuing EHOSTUNREACH is okay for
>vsock too. This also reserves ENOBUFS/ENOMEM only for shortage on local
>buffers / mem.
>
>What do you think?

Yep, makes sense to me!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
