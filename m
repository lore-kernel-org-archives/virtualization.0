Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53332C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 10:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE63A42120;
	Fri, 28 Apr 2023 10:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE63A42120
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=inyg7TUH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55ABhKJzBmTL; Fri, 28 Apr 2023 10:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8247F4211C;
	Fri, 28 Apr 2023 10:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8247F4211C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62B26C0036;
	Fri, 28 Apr 2023 10:43:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE388C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 10:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B42924211C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 10:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B42924211C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrB2uT5lj5fC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 10:43:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17FEF4211E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17FEF4211E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682678608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQVmdT90OhXDpcSpwDoh82Tvt4g5mLAfat632QKI2HE=;
 b=inyg7TUHs0GV98cYEok/euY3riEOp1cUcaF/fA9hVqz/8ymeYlMeu1b0TRpqGubvgtdC0/
 QGM6b121D0b794xhLUcaojQmRv+xSnLGVLVSkpnT57MBoEeIOCFR/0/tIOtewTrPPKBmZf
 8vUztaWMfAlwVYQJ8sQeLGKIH1+l4gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-IW5V9s3dMMGojjfDAzSYRQ-1; Fri, 28 Apr 2023 06:43:27 -0400
X-MC-Unique: IW5V9s3dMMGojjfDAzSYRQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f17b8d24bbso62333735e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 03:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682678604; x=1685270604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQVmdT90OhXDpcSpwDoh82Tvt4g5mLAfat632QKI2HE=;
 b=MxypCw5+Yr2CSRA1WMnIb2rUAQyDp2qMexAMMzmZHOipDIhWcAIfDDWHfJdd7or8Ts
 SwY/ZfQGPmEryi8FSu9eHuFZXefM0vtOKkCpNU1FSHJ4qxj8EmCOTX7dsdZ48TtJHQxp
 yop82XxXKbo/pKbK4zVDdQN5MYAhY5FO5sQW6ayQLyFe6HapDVGf9KLc3Y1XR26ElPHN
 3wp+idfHkiStx+xRf2wjpu98XJUn2oZDlM4cyuoongtCsYeZhlvNYW7G32rMECAyyd6I
 2dKT6OJWkD0AwfCUnany48O3p0ode2f/RKnc20slwhCvpHqlNzZj7QEdKhszkrrMcNNO
 MwwQ==
X-Gm-Message-State: AC+VfDwVfGZXFWip+1LXciakBXl9xg7SOV89uAFos4OdoADSG7kVBCLI
 K+g+0OT/HEpxKmsJ2MvNsIaB+ivRG/zG5GmbBaPp2SuEnAeFNl5ZqWim+k67SCwLXPdHzUPgo8f
 ChZLU5NtQtirQfd098MVEXCek+iVIVg7JRJYB0vIHLg==
X-Received: by 2002:a5d:63cd:0:b0:2f4:e580:a72f with SMTP id
 c13-20020a5d63cd000000b002f4e580a72fmr3575483wrw.45.1682678604406; 
 Fri, 28 Apr 2023 03:43:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sbbM9Zn4cTetz42fXKk9Z9F040Hk4rnRdGv4o6qnjbgUiSUoCwpa/D62xpuyoNmY1khznig==
X-Received: by 2002:a5d:63cd:0:b0:2f4:e580:a72f with SMTP id
 c13-20020a5d63cd000000b002f4e580a72fmr3575451wrw.45.1682678604022; 
 Fri, 28 Apr 2023 03:43:24 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.71.231])
 by smtp.gmail.com with ESMTPSA id
 s4-20020adfeb04000000b003047f7a7ad1sm11442270wrn.71.2023.04.28.03.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Apr 2023 03:43:23 -0700 (PDT)
Date: Fri, 28 Apr 2023 12:43:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v2 0/4] virtio/vsock: support datagrams
Message-ID: <yeu57zqwzcx33sylp565xgw7yv72qyczohkmukyex27rcdh6mr@w4x6t4enx6iu>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <ZDk2kOVnUvyLMLKE@bullseye>
 <r6oxanmhwlonb7lcrrowpitlgobivzp7pcwk7snqvfnzudi6pb@4rnio5wef3qu>
 <ZDpOq0ACuMYIUbb1@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDpOq0ACuMYIUbb1@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, virtio-dev@lists.oasis-open.org,
 linux-hyperv@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, virtualization@lists.linux-foundation.org,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 Jiang Wang <jiang.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
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

On Sat, Apr 15, 2023 at 07:13:47AM +0000, Bobby Eshleman wrote:
>CC'ing virtio-dev@lists.oasis-open.org because this thread is starting
>to touch the spec.
>
>On Wed, Apr 19, 2023 at 12:00:17PM +0200, Stefano Garzarella wrote:
>> Hi Bobby,
>>
>> On Fri, Apr 14, 2023 at 11:18:40AM +0000, Bobby Eshleman wrote:
>> > CC'ing Cong.
>> >
>> > On Fri, Apr 14, 2023 at 12:25:56AM +0000, Bobby Eshleman wrote:
>> > > Hey all!
>> > >
>> > > This series introduces support for datagrams to virtio/vsock.
>>
>> Great! Thanks for restarting this work!
>>
>
>No problem!
>
>> > >
>> > > It is a spin-off (and smaller version) of this series from the summer:
>> > >   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>> > >
>> > > Please note that this is an RFC and should not be merged until
>> > > associated changes are made to the virtio specification, which will
>> > > follow after discussion from this series.
>> > >
>> > > This series first supports datagrams in a basic form for virtio, and
>> > > then optimizes the sendpath for all transports.
>> > >
>> > > The result is a very fast datagram communication protocol that
>> > > outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>> > > of multi-threaded workload samples.
>> > >
>> > > For those that are curious, some summary data comparing UDP and VSOCK
>> > > DGRAM (N=5):
>> > >
>> > > 	vCPUS: 16
>> > > 	virtio-net queues: 16
>> > > 	payload size: 4KB
>> > > 	Setup: bare metal + vm (non-nested)
>> > >
>> > > 	UDP: 287.59 MB/s
>> > > 	VSOCK DGRAM: 509.2 MB/s
>> > >
>> > > Some notes about the implementation...
>> > >
>> > > This datagram implementation forces datagrams to self-throttle according
>> > > to the threshold set by sk_sndbuf. It behaves similar to the credits
>> > > used by streams in its effect on throughput and memory consumption, but
>> > > it is not influenced by the receiving socket as credits are.
>>
>> So, sk_sndbuf influece the sender and sk_rcvbuf the receiver, right?
>>
>
>Correct.
>
>> We should check if VMCI behaves the same.
>>
>> > >
>> > > The device drops packets silently. There is room for improvement by
>> > > building into the device and driver some intelligence around how to
>> > > reduce frequency of kicking the virtqueue when packet loss is high. I
>> > > think there is a good discussion to be had on this.
>>
>> Can you elaborate a bit here?
>>
>> Do you mean some mechanism to report to the sender that a destination
>> (cid, port) is full so the packet will be dropped?
>>
>
>Correct. There is also the case of there being no receiver at all for
>this address since this case isn't rejected upon connect(). Ideally,
>such a socket (which will have 100% packet loss) will be throttled
>aggressively.
>
>Before we go down too far on this path, I also want to clarify that
>using UDP over vhost/virtio-net also has this property... this can be
>observed by using tcpdump to dump the UDP packets on the bridge network
>your VM is using. UDP packets sent to a garbage address can be seen on
>the host bridge (this is the nature of UDP, how is the host supposed to
>know the address eventually goes nowhere). I mention the above because I
>think it is possible for vsock to avoid this cost, given that it
>benefits from being point-to-point and g2h/h2g.
>
>If we're okay with vsock being on par, then the current series does
>that. I propose something below that can be added later and maybe
>negotiated as a feature bit too.

I see and I agree on that, let's do it step by step.
If we can do it in the first phase is great, but I think is fine to add
this feature later.

>
>> Can we adapt the credit mechanism?
>>
>
>I've thought about this a lot because the attraction of the approach for
>me would be that we could get the wait/buffer-limiting logic for free
>and without big changes to the protocol, but the problem is that the
>unreliable nature of datagrams means that the source's free-running
>tx_cnt will become out-of-sync with the destination's fwd_cnt upon
>packet loss.

We need to understand where the packet can be lost.
If the packet always reaches the destination (vsock driver or device),
we can discard it, but also update the counters.

>
>Imagine a source that initializes and starts sending packets before a
>destination socket even is created, the source's self-throttling will be
>dysfunctional because its tx_cnt will always far exceed the
>destination's fwd_cnt.

Right, the other problem I see is that the socket aren't connected, so
we have 1-N relationship.

>
>We could play tricks with the meaning of the CREDIT_UPDATE message and
>fwd_cnt/buf_alloc fields, but I don't think we want to go down that
>path.
>
>I think that the best and simplest approach introduces a congestion
>notification (VIRTIO_VSOCK_OP_CN?). When a packet is dropped, the
>destination sends this notification. At a given repeated time period T,
>the source can check if it has received any notifications in the last T.
>If so, it halves its buffer allocation. If not, it doubles its buffer
>allocation unless it is already at its max or original value.
>
>An "invalid" socket which never has any receiver will converge towards a
>rate limit of one packet per time T * log2(average pkt size). That is, a
>socket with 100% packet loss will only be able to send 16 bytes every
>4T. A default send buffer of MAX_UINT32 and T=5ms would hit zero within
>160ms given at least one packet sent per 5ms. I have no idea if that is
>a reasonable default T for vsock, I just pulled it out of a hat for the
>sake of the example.
>
>"Normal" sockets will be responsive to high loss and rebalance during
>low loss. The source is trying to guess and converge on the actual
>buffer state of the destination.
>
>This would reuse the already-existing throttling mechanisms that
>throttle based upon buffer allocation. The usage of sk_sndbuf would have
>to be re-worked. The application using sendmsg() will see EAGAIN when
>throttled, or just sleep if !MSG_DONTWAIT.

I see, it looks interesting, but I think we need to share that
information between multiple sockets, since the same destination
(cid, port), can be reached by multiple sockets.

Another approach could be to have both congestion notification and
decongestion, but maybe it produces double traffic.

>
>I looked at alternative schemes (like the Datagram Congestion Control
>Protocol), but I do not think the added complexity is necessary in the
>case of vsock (DCCP requires congestion windows, sequence numbers, batch
>acknowledgements, etc...). I also looked at UDP-based application
>protocols like TFTP, DHCP, and SIP over UDP which use a delay-based
>backoff mechanism, but seem to require acknowledgement for those packet
>types, which trigger the retries and backoffs. I think we can get away
>with the simpler approach and not have to potentially kill performance
>with per-packet acknowledgements.

Yep I agree. I think our advantage is that the channel (virtqueues),
can't lose packets.

>
>> > >
>> > > In this series I am also proposing that fairness be reexamined as an
>> > > issue separate from datagrams, which differs from my previous series
>> > > that coupled these issues. After further testing and reflection on the
>> > > design, I do not believe that these need to be coupled and I do not
>> > > believe this implementation introduces additional unfairness or
>> > > exacerbates pre-existing unfairness.
>>
>> I see.
>>
>> > >
>> > > I attempted to characterize vsock fairness by using a pool of processes
>> > > to stress test the shared resources while measuring the performance of a
>> > > lone stream socket. Given unfair preference for datagrams, we would
>> > > assume that a lone stream socket would degrade much more when a pool of
>> > > datagram sockets was stressing the system than when a pool of stream
>> > > sockets are stressing the system. The result, however, showed no
>> > > significant difference between the degradation of throughput of the lone
>> > > stream socket when using a pool of datagrams to stress the queue over
>> > > using a pool of streams. The absolute difference in throughput actually
>> > > favored datagrams as interfering least as the mean difference was +16%
>> > > compared to using streams to stress test (N=7), but it was not
>> > > statistically significant. Workloads were matched for payload size and
>> > > buffer size (to approximate memory consumption) and process count, and
>> > > stress workloads were configured to start before and last long after the
>> > > lifetime of the "lone" stream socket flow to ensure that competing flows
>> > > were continuously hot.
>> > >
>> > > Given the above data, I propose that vsock fairness be addressed
>> > > independent of datagrams and to defer its implementation to a future
>> > > series.
>>
>> Makes sense to me.
>>
>> I left some preliminary comments, anyway now it seems reasonable to use
>> the same virtqueues, so we can go head with the spec proposal.
>>
>> Thanks,
>> Stefano
>>
>
>Thanks for the review!

You're welcome!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
