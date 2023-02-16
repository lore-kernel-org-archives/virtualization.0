Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD913C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 10:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED24600B6;
	Thu, 16 Feb 2023 10:20:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED24600B6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ggonZYh7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtJv7qHqtvCw; Thu, 16 Feb 2023 10:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A93060ABE;
	Thu, 16 Feb 2023 10:20:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A93060ABE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 412C7C0032;
	Thu, 16 Feb 2023 10:20:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29044C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAAB68202D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:20:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAAB68202D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ggonZYh7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJ5ODf7wrBgM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:20:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2120981F87
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2120981F87
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676542835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9d2F3j0rYGNO9oHzYnL7gUMrLwfVFcsHDqpyr29XsFY=;
 b=ggonZYh7lRkJ1eQvYSBxY3mGLz/qQZCsMwU6CvkRVU/+mZNNbwYUAxtKHMdhpzaJNdsxWa
 tDwjvwGQEhs53x5fSX/RqvEFILRM2ei+3OFymyBNu4SU0EJQMegMsyyIzWGHL+OazCCpuS
 t7X5rOPHOX51OgnzkLLN1NlA/WQV+nY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-TZA9EMrvMiSvLPxgMneN-Q-1; Thu, 16 Feb 2023 05:20:33 -0500
X-MC-Unique: TZA9EMrvMiSvLPxgMneN-Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 130-20020a370588000000b0072fcbe20069so885134qkf.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 02:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d2F3j0rYGNO9oHzYnL7gUMrLwfVFcsHDqpyr29XsFY=;
 b=1KIvGvNcBPj5j3LFoYIb/qgOcqYNCXnkUaMV7oLw/YnItDELzuCNhKbD/TUirmg/qk
 c3AcPmRMeOWD4yEG+d/iFjwtUAEBRqwlT1FIQBSLvYqNifcejxg7RVuRpMmHPh7cOJfR
 pzm7bIWSKB8duElqqiR0HilBvaBCnd6dnDpyc42X2SbJ1pjUG9C4XEJBunkzOsOBMIXC
 B9Hu3Bweldr939WiUCZwZRCoXRemrQ/0b5yAZS1OC6w0GhFcELsi26INfZtkEfoRPRr/
 aOWjEocZ3PctYF1B+NNR/2ZlvtG8Dpyi8x1wtQz77+nIT4TyoJeyk7lMZ3JL2S4197La
 Gh9A==
X-Gm-Message-State: AO0yUKVmjccTgDX4p9tSC5OKo9dTDQirZL5HaAMZJksvnaWMufZY3lwq
 7BupeVOi4dmFbUJZj7rZxQiFMy4d4BI4qTwlz+LBkzJgSRaOYfRKD9L9J0wFZDWc5FmES4cLvx9
 n5Ueuym9CI/E4SRYn0L8z6DlDnhLUm7+RtwgBtrYCQA==
X-Received: by 2002:a05:622a:174d:b0:3ab:a047:58ee with SMTP id
 l13-20020a05622a174d00b003aba04758eemr9376187qtk.25.1676542832981; 
 Thu, 16 Feb 2023 02:20:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8WG516tWCWUltiUeGBZdvhUmS/AHWTqFHc3ZJxdL6RnhQL67hG28I/A0hEUzhvBPMCOVbEhw==
X-Received: by 2002:a05:622a:174d:b0:3ab:a047:58ee with SMTP id
 l13-20020a05622a174d00b003aba04758eemr9376145qtk.25.1676542832685; 
 Thu, 16 Feb 2023 02:20:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 a14-20020aed278e000000b003b8238114d9sm986954qtd.12.2023.02.16.02.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 02:20:32 -0800 (PST)
Date: Thu, 16 Feb 2023 11:20:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 0/3] vsock: add support for sockmap
Message-ID: <20230216102023.jplhourjlvupeazy@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, hdanton@sina.com,
 cong.wang@bytedance.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, jakub@cloudflare.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Hao Luo <haoluo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
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

Hi Bobby,
sorry for my late reply, but I have been offline these days.
I came back a few days ago and had to work off some accumulated work :-)

On Mon, Jan 30, 2023 at 08:35:11PM -0800, Bobby Eshleman wrote:
>Add support for sockmap to vsock.
>
>We're testing usage of vsock as a way to redirect guest-local UDS requests to
>the host and this patch series greatly improves the performance of such a
>setup.
>
>Compared to copying packets via userspace, this improves throughput by 121% in
>basic testing.
>
>Tested as follows.
>
>Setup: guest unix dgram sender -> guest vsock redirector -> host vsock server
>Threads: 1
>Payload: 64k
>No sockmap:
>- 76.3 MB/s
>- The guest vsock redirector was
>  "socat VSOCK-CONNECT:2:1234 UNIX-RECV:/path/to/sock"
>Using sockmap (this patch):
>- 168.8 MB/s (+121%)
>- The guest redirector was a simple sockmap echo server,
>  redirecting unix ingress to vsock 2:1234 egress.
>- Same sender and server programs
>
>*Note: these numbers are from RFC v1
>
>Only the virtio transport has been tested. The loopback transport was used in
>writing bpf/selftests, but not thoroughly tested otherwise.
>
>This series requires the skb patch.
>
>Changes in v2:
>- vsock/bpf: rename vsock_dgram_* -> vsock_*
>- vsock/bpf: change sk_psock_{get,put} and {lock,release}_sock() order to
>	     minimize slock hold time
>- vsock/bpf: use "new style" wait
>- vsock/bpf: fix bug in wait log
>- vsock/bpf: add check that recvmsg sk_type is one dgram, seqpacket, or stream.
>	     Return error if not one of the three.
>- virtio/vsock: comment __skb_recv_datagram() usage
>- virtio/vsock: do not init copied in read_skb()
>- vsock/bpf: add ifdef guard around struct proto in dgram_recvmsg()
>- selftests/bpf: add vsock loopback config for aarch64
>- selftests/bpf: add vsock loopback config for s390x
>- selftests/bpf: remove vsock device from vmtest.sh qemu machine
>- selftests/bpf: remove CONFIG_VIRTIO_VSOCKETS=y from config.x86_64
>- vsock/bpf: move transport-related (e.g., if (!vsk->transport)) checks out of
>	     fast path

The series looks in a good shape.
I left some small comments on the first patch, but I think the next
version could be without RFC, so we can receive some feedbacks from
net/bpf maintainers.

Great job!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
