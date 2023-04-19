Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9B8C6FD18
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 10:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92AE7429DF;
	Wed, 19 Apr 2023 10:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92AE7429DF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QI0NcmW4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Sil2KvQXvqQ; Wed, 19 Apr 2023 10:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8FEB41D65;
	Wed, 19 Apr 2023 10:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8FEB41D65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2BA5C0037;
	Wed, 19 Apr 2023 10:00:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC471C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 10:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79CFD82017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 10:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79CFD82017
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QI0NcmW4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F9dLAhU2Lp-z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 10:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E4A281F59
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E4A281F59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681898430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XQ6sCjmuWnVFb8UpDGaTI+MOdoOd+qfctALNM5m0k+g=;
 b=QI0NcmW4+z2PZcHNNvoFmxdbJdRGqIrYGzulwKk5xmwQFOFP73akBhtOzagIlcSMawn7Yd
 +rLdpiJTUqVhYoaYACtjCkYCk1qd4tbhyHIcKe77pofGRyxAxOh+z9qgmbfsg9r87hX/wl
 nXrPJdiz7VFSGMFN7mrMmM1s2asDZq8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--hljqnksP0qNT-iTFEpABA-1; Wed, 19 Apr 2023 06:00:28 -0400
X-MC-Unique: -hljqnksP0qNT-iTFEpABA-1
Received: by mail-qv1-f70.google.com with SMTP id
 h6-20020a0cd806000000b005a33510e95aso13902811qvj.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 03:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681898425; x=1684490425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQ6sCjmuWnVFb8UpDGaTI+MOdoOd+qfctALNM5m0k+g=;
 b=ZKXfvw3wEgIkksdFdbM7kj6+3wX1Rycq4j6Lk1Pnm3SLTcXMlF9VNSzGLtHH9ZGlIA
 gAcYRD3xkSSuNPUkhELqTDB9FtwcId4lvi/hYJ4xRSoag50r15a5ZdfpJRqy2eIJdkQC
 tP2hUdlDbwUJoGXgpSLxsTHsAdnOjQeDqrwXczpLEK+AdSEXrRkUnNgFb0KmFB0DSpyy
 XnvZquRP2CESA2j42TRT/5egPQINO+xadFM/7eF07V/X8FgI7o1eulbk3sv3sTLByJ/D
 h0V0l+ofcjwAr9lmD5SJQrpR+tkWLwtb/djWcvkZWmupb7W5cY+Ou9b72s4euyhDCmZ/
 xfCg==
X-Gm-Message-State: AAQBX9eGAvSwCHJcA+J7sbsz5bAXAagmx3D7qGCpbCkBfTOZOq87LX/z
 wcZB31+5QeF2iLvf/NaMFsstUHEWgqGTIbecf2re7wduK3Oo7T+5vYC79m5+bF4HJQP7iT/PH4/
 XABWOH9c61KBeoZNdzOd0b8eZU99nyKswcQic2gLiLw==
X-Received: by 2002:a05:622a:44e:b0:3ef:437e:c828 with SMTP id
 o14-20020a05622a044e00b003ef437ec828mr1647529qtx.54.1681898424518; 
 Wed, 19 Apr 2023 03:00:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bx/DlObVliHPvUfPOoqrhYKHpZuPyTlGGGIslCUKrTunefbYRtBDLkw2QCfpHp8ro/QNbCag==
X-Received: by 2002:a05:622a:44e:b0:3ef:437e:c828 with SMTP id
 o14-20020a05622a044e00b003ef437ec828mr1647485qtx.54.1681898424062; 
 Wed, 19 Apr 2023 03:00:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 bq16-20020a05620a469000b007484d284cdasm4564029qkb.93.2023.04.19.03.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Apr 2023 03:00:23 -0700 (PDT)
Date: Wed, 19 Apr 2023 12:00:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v2 0/4] virtio/vsock: support datagrams
Message-ID: <r6oxanmhwlonb7lcrrowpitlgobivzp7pcwk7snqvfnzudi6pb@4rnio5wef3qu>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <ZDk2kOVnUvyLMLKE@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDk2kOVnUvyLMLKE@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vishnu Dasa <vdasa@vmware.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Hi Bobby,

On Fri, Apr 14, 2023 at 11:18:40AM +0000, Bobby Eshleman wrote:
>CC'ing Cong.
>
>On Fri, Apr 14, 2023 at 12:25:56AM +0000, Bobby Eshleman wrote:
>> Hey all!
>>
>> This series introduces support for datagrams to virtio/vsock.

Great! Thanks for restarting this work!

>>
>> It is a spin-off (and smaller version) of this series from the summer:
>>   https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/
>>
>> Please note that this is an RFC and should not be merged until
>> associated changes are made to the virtio specification, which will
>> follow after discussion from this series.
>>
>> This series first supports datagrams in a basic form for virtio, and
>> then optimizes the sendpath for all transports.
>>
>> The result is a very fast datagram communication protocol that
>> outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
>> of multi-threaded workload samples.
>>
>> For those that are curious, some summary data comparing UDP and VSOCK
>> DGRAM (N=5):
>>
>> 	vCPUS: 16
>> 	virtio-net queues: 16
>> 	payload size: 4KB
>> 	Setup: bare metal + vm (non-nested)
>>
>> 	UDP: 287.59 MB/s
>> 	VSOCK DGRAM: 509.2 MB/s
>>
>> Some notes about the implementation...
>>
>> This datagram implementation forces datagrams to self-throttle according
>> to the threshold set by sk_sndbuf. It behaves similar to the credits
>> used by streams in its effect on throughput and memory consumption, but
>> it is not influenced by the receiving socket as credits are.

So, sk_sndbuf influece the sender and sk_rcvbuf the receiver, right?

We should check if VMCI behaves the same.

>>
>> The device drops packets silently. There is room for improvement by
>> building into the device and driver some intelligence around how to
>> reduce frequency of kicking the virtqueue when packet loss is high. I
>> think there is a good discussion to be had on this.

Can you elaborate a bit here?

Do you mean some mechanism to report to the sender that a destination
(cid, port) is full so the packet will be dropped?

Can we adapt the credit mechanism?

>>
>> In this series I am also proposing that fairness be reexamined as an
>> issue separate from datagrams, which differs from my previous series
>> that coupled these issues. After further testing and reflection on the
>> design, I do not believe that these need to be coupled and I do not
>> believe this implementation introduces additional unfairness or
>> exacerbates pre-existing unfairness.

I see.

>>
>> I attempted to characterize vsock fairness by using a pool of processes
>> to stress test the shared resources while measuring the performance of a
>> lone stream socket. Given unfair preference for datagrams, we would
>> assume that a lone stream socket would degrade much more when a pool of
>> datagram sockets was stressing the system than when a pool of stream
>> sockets are stressing the system. The result, however, showed no
>> significant difference between the degradation of throughput of the lone
>> stream socket when using a pool of datagrams to stress the queue over
>> using a pool of streams. The absolute difference in throughput actually
>> favored datagrams as interfering least as the mean difference was +16%
>> compared to using streams to stress test (N=7), but it was not
>> statistically significant. Workloads were matched for payload size and
>> buffer size (to approximate memory consumption) and process count, and
>> stress workloads were configured to start before and last long after the
>> lifetime of the "lone" stream socket flow to ensure that competing flows
>> were continuously hot.
>>
>> Given the above data, I propose that vsock fairness be addressed
>> independent of datagrams and to defer its implementation to a future
>> series.

Makes sense to me.

I left some preliminary comments, anyway now it seems reasonable to use
the same virtqueues, so we can go head with the spec proposal.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
