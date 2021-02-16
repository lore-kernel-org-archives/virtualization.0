Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B941BC433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 04:51:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F4764DE0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 04:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F4764DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD2CE86FC9;
	Tue, 16 Feb 2021 04:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uK8IMXjq+E8w; Tue, 16 Feb 2021 04:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3174086F7E;
	Tue, 16 Feb 2021 04:51:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F3FDC0893;
	Tue, 16 Feb 2021 04:51:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 194B7C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 04:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14D6D8543A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 04:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmWRc3-rEpOv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 04:50:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 54C2C850E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 04:50:48 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id e4so7990908ote.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Em9BQnPldALMKRsOOvbk00I2ZUcqV1PxPk9bvHmQyqM=;
 b=wj1CJbv4q5MZXY6WvZUs3DDKKuqAXWG0m60/eLcolefDaufpmGGXU1cNrFD9R64SEJ
 5+pjrDBNeHj8AMmnsnmlFwKHZleR4DBEc3MaLh6eXtInLjzakbUe1kA/AXLa3tJamzcH
 KSqnDhfSOnhe4vUPhrqPPNBfZUmYTsUvnVOxIBzgl6RN3cWb6TQAnromSIYWSU13huLI
 2lp5IMJr+GmQ+3SMWy74LUpaUq3YveZc1WrTL/beyPityWaYnECW9HUluAglPINyGXXl
 didye1KvlwWGfvEAgOAfP+PKo7BR/Oxa4MV46ScxBBXoiVdS1SHH6Tcih5Vnx2AyIjGW
 pqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Em9BQnPldALMKRsOOvbk00I2ZUcqV1PxPk9bvHmQyqM=;
 b=pukHE27L1xuKVPOPlzriEtQpDQAQGToniH6/NnRF+reA9ckzt4HaKHBruxDgCeVIbL
 CPt5zgkqgEMXTkZZeE7LC8ezByw0of3TlR8l9onHts7vzAzwvGyU+6hXqHXZtVQNLjf9
 kR5M5ao7i/xiq/kYeUdqFOV2KwPSAOQTcTdohe1AbPCMXJ1lyb2zTlJL3bIQ0vY7fRDi
 5Ac4P9nHgxPX9E2ciIjcPezAp1OCR42oplYrOcesu3wTGEZcmSCpHnE1U7Fpte9K72vh
 LGev6qHLph3zU14633P4Y3H1745xO/UO0wfrl8JRekdlUAkozthcW4NOli1BgeLg+QVj
 mhHw==
X-Gm-Message-State: AOAM533Rxa6Fffad87JCDhDVbxL2CDtoo8TpvnqKwVJcT4SsvfHw/rRu
 t+uvgnSKsGIvGwWgwa5iTm2snNgJ9MqZ4W0NKYf0IQ==
X-Google-Smtp-Source: ABdhPJx09vYkxz1VK26K+UfnnUPGDd5dgLTv2poUxG4qTGMDNwm7nvVh2VTnHMBa27lVYHcQpEbGRhNNT1qJsJWw7nA=
X-Received: by 2002:a9d:151:: with SMTP id 75mr12568475otu.279.1613451047283; 
 Mon, 15 Feb 2021 20:50:47 -0800 (PST)
MIME-Version: 1.0
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <CAP_N_Z-4Af_5jE7x5kSi8u=KUVUsbfDTtuD_7numL+vnkisMgQ@mail.gmail.com>
 <20210215083110.xb4cyekutlmlvetg@steredhat>
In-Reply-To: <20210215083110.xb4cyekutlmlvetg@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 15 Feb 2021 20:50:36 -0800
Message-ID: <CAP_N_Z9T5nJ37k9Rgoba_SzN9RQrBn7jCKwxO9TLyddzb+jsJQ@mail.gmail.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 mst@redhat.com, imbrenda@linux.vnet.ibm.com, xieyongji@bytedance.com,
 stefanha@redhat.com, asias@redhat.com,
 virtualization@lists.linux-foundation.org,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 15, 2021 at 12:31 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, Feb 13, 2021 at 03:26:18PM -0800, Jiang Wang . wrote:
> >On Fri, Feb 12, 2021 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> Hi Jiang,
> >>
> >> CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
> >> [1].
> >>
> >> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> >> >Hi guys,
> >> >
> >> >I am working on supporting DGRAM type for virtio/vhost vsock. I
> >> >already did some work and a draft code is here (which passed my tests,
> >> >but still need some cleanup and only works from host to guest as of
> >> >now, will add host to guest soon):
> >> >https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> >> >qemu changes are here:
> >> >https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> >> >
> >> >Today, I just noticed that the Asias had an old version of virtio
> >> >which had both dgram and stream support, see this link:
> >> >https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> >> >
> >> >But somehow, the dgram part seems never merged to upstream linux (the
> >> >stream part is merged). If so, does anyone know what is the reason for
> >> >this? Did we drop dgram support for some specific reason or the code
> >> >needs some improvement?
> >>
> >> I wasn't involved yet in virtio-vsock development when Asias posted that
> >> patches, so I don't know the exact reason.
> >>
> >> Maybe could be related on how to handle the credit mechanism for a
> >> connection-less sockets and how to manage the packet queue, if for
> >> example no one is listening.
> >>
> >
> >I see. thanks.
> >
> >> >
> >> >My current code differs from Asias' code in some ways. It does not use
> >> >credit and does not support fragmentation.  It basically adds two virt
> >>
> >> If you don't use credit, do you have some threshold when you start to
> >> drop packets on the RX side?
> >>
> >
> >As of now, I don't have any threshold to drop packets on RX side. In my
> >view, DGRAM is like UDP and is a best effort service. If the virtual
> >queue
> >is full on TX (or the available buffer size is less than the packet size),
> >I drop the packets on the TX side.
>
> I have to check the code, my concern is we should have a limit for the
> allocation, for example if the user space doesn't consume RX packets.
>

I think we already have a limit for the allocation. If a DGRAM client
sends packets while no socket is bound on the server side ,
the packet will be dropped when looking for the socket. If the socket is
bound on the server side, but the server program somehow does not
call recv or similar functions, the packets will be dropped when the
buffer is full as in your previous patch at here:
https://lore.kernel.org/patchwork/patch/1141083/
If there are still other cases that we don't have protection, let me know and
I can add some threshold.

> >
> >> >queues and re-uses the existing functions for tx and rx ( there is
> >>
> >> This make sense, some time ago I was thinking about this and also came
> >> to the conclusion that 2 new virtqueues were needed to handle DGRAM
> >> traffic.
> >>
> >Good to know.
> >
> >> >somewhat duplicate code for now, but I will try to make common
> >> >functions to reduce it). If we still want to support dgram in upstream
> >> >linux, which way do you guys recommend? If necessary, I can try to
> >> >base on Asias' old code and continue working on it. If there is
> >> >anything unclear, just let me know. Thanks.
> >>
> >> A problem I see is how to handle multiple transports to support nested
> >> VMs. Since the sockets are not connected, we can't assign them to a
> >> single transport.
> >>
> >
> >I did not consider the nested VMs when I started working on this. I
> >just checked your
> >nested VM support patch, and I agree it is harder to support it for DGRAM. One
> >idea is that we can also prepare two transport layers for DGRAM (
> >similar to STREAM)
>
> Yeah, or just remove the VSOCK_TRANSPORT_F_DGRAM and use the same flags
> used for STREAM also for DGRAM. If the transport does not support DGRAM,
> we return an error.
>
> >and assign transport for every DGRAM packet. The downside is that it
> >will
> >introduce some overhead. I will think about it more.
>
> I agree that maybe we should check the right transport for every DGRAM
> packet.
>
> >
> >> Arseny is working on SOCK_SEQPACKET [1], it's similar to DGRAM, but it
> >> is connection oriented, so we can reuse most of the STREAM stuff and
> >> also the credit mechanism.
> >>
> >> Maybe you can reuse some of the Arseny's stuff to handle the
> >> fragmentation.
> >
> >Sure. I will check Arseny's patch.
> >
> >> For the channel type (lossless) I think SEQPACKET makes more sense, but
> >> if you have any use-cases for DGRAM and want to support it, you are
> >> welcome to send patches and I will be happy to review them.
> >>
> >Got it. Thanks. We have some use cases for DGRAM. Basically, we send some
> >kind of non-critical logging data from guest to the host. It is one way
> >communication and does not require reliable delivery.  I will continue
> >working on the patch and send it out for review when it is ready.
> >Thanks again for all the inputs.
>
> I see, in fact DGRAM might make sense when we have a single receiver
> (host) and many transmitters (guests).
>
> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
