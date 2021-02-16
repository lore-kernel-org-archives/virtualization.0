Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386AC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 08:50:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1A264D9A
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 08:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1A264D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EFB8387066;
	Tue, 16 Feb 2021 08:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTeuvTAoQ4bA; Tue, 16 Feb 2021 08:50:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C967287031;
	Tue, 16 Feb 2021 08:50:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A10AEC0174;
	Tue, 16 Feb 2021 08:50:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61633C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 473E087031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GxSdgPr7JmAZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 21CED8701D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613465424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lq4OJIt+1hBfq6LVyBDp1zK6SBdjdC6nF1SJXpgZdBI=;
 b=SfiVKI4s/TUfJAIoLTK7kOF16/s5/bQG7wq3Zi9tgASDrchQyg+NRAQ00aNywK4SYlEP9m
 vEsJ+HmoI++G9LJE1X9oesqJgiSAlk/P3RSj2YuZQYblwNFpe7uf8IHWEGtCVGYfsHwcbS
 2vtE+64I4ncnisAAt1KhWHYIVQ1/Gs4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-rPhp9ALiOgaYCDexMTStUQ-1; Tue, 16 Feb 2021 03:50:21 -0500
X-MC-Unique: rPhp9ALiOgaYCDexMTStUQ-1
Received: by mail-wm1-f69.google.com with SMTP id c125so9613163wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 00:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lq4OJIt+1hBfq6LVyBDp1zK6SBdjdC6nF1SJXpgZdBI=;
 b=J0WhS7WBROzGrnn0STuoAg7B+bW4GvXQmpaLPTKaF4AkDCxzaqrYymwAHv8utVMZRb
 wtdX7puTBW0yRkBgJHiW1ImOZJXr8PvI1Zz+abd7EN9Ad/dHQrcZesvYwRnoKXs4SJnM
 ddz6M0EhGCWAUjuvugUwrK04Qk7eYbJrc3vBpu1IvZFTaXFjcX7zLY6lS2z0BDhG+iTO
 GkuXxOdP+Ijqz+qXUMz2JRiU3JSXiOrsF3nVVAWFZQdhoc3mIhJZz12FuyozntZpva+H
 5J9PfrGeTHFh8XovY2F8eUxXb4JtbvI7NYsuwDOU8RjN5I3nPPWJudImAEI1Wb7Mo04k
 5joQ==
X-Gm-Message-State: AOAM532zJ4nUvujrwqRToClDAQSfubi32z4XDKI+6nU3M4bfmmn08TdX
 rcuFsm5JuZs+8OmQWyvStbIt2puLxm1OzR//HV3eGi/W4NI9qVJnM/bLtu2seFebWLbxWD3rNBF
 mM2ITWQUnE2CTF+VCzvuWThn/+kk4+vQB5v0POfBeoQ==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr22789477wra.204.1613465420302; 
 Tue, 16 Feb 2021 00:50:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybQWdSglfk5X0HYzhMkRRka7HqRDb5PwMSozTeJ4PyuS4M46bkm5SpbtQPu7W/G83ozKljvw==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr22789461wra.204.1613465420036; 
 Tue, 16 Feb 2021 00:50:20 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l83sm2511032wmf.4.2021.02.16.00.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 00:50:19 -0800 (PST)
Date: Tue, 16 Feb 2021 09:50:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
Message-ID: <20210216085017.gqpvencdz4ewq7zw@steredhat>
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <CAP_N_Z-4Af_5jE7x5kSi8u=KUVUsbfDTtuD_7numL+vnkisMgQ@mail.gmail.com>
 <20210215083110.xb4cyekutlmlvetg@steredhat>
 <CAP_N_Z9T5nJ37k9Rgoba_SzN9RQrBn7jCKwxO9TLyddzb+jsJQ@mail.gmail.com>
 <20210216080911.lgw7cgo4rvxzaehx@steredhat>
 <CAP_N_Z9yYXqd_j9_Dj94mc-P0Azwos4jhJ3uDSUhuzVuAAnQDA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9yYXqd_j9_Dj94mc-P0Azwos4jhJ3uDSUhuzVuAAnQDA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 16, 2021 at 12:23:19AM -0800, Jiang Wang . wrote:
>On Tue, Feb 16, 2021 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Mon, Feb 15, 2021 at 08:50:36PM -0800, Jiang Wang . wrote:
>> >On Mon, Feb 15, 2021 at 12:31 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> On Sat, Feb 13, 2021 at 03:26:18PM -0800, Jiang Wang . wrote:
>> >> >On Fri, Feb 12, 2021 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >>
>> >> >> Hi Jiang,
>> >> >>
>> >> >> CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
>> >> >> [1].
>> >> >>
>> >> >> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
>> >> >> >Hi guys,
>> >> >> >
>> >> >> >I am working on supporting DGRAM type for virtio/vhost vsock. I
>> >> >> >already did some work and a draft code is here (which passed my tests,
>> >> >> >but still need some cleanup and only works from host to guest as of
>> >> >> >now, will add host to guest soon):
>> >> >> >https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
>> >> >> >qemu changes are here:
>> >> >> >https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
>> >> >> >
>> >> >> >Today, I just noticed that the Asias had an old version of virtio
>> >> >> >which had both dgram and stream support, see this link:
>> >> >> >https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
>> >> >> >
>> >> >> >But somehow, the dgram part seems never merged to upstream linux (the
>> >> >> >stream part is merged). If so, does anyone know what is the reason for
>> >> >> >this? Did we drop dgram support for some specific reason or the code
>> >> >> >needs some improvement?
>> >> >>
>> >> >> I wasn't involved yet in virtio-vsock development when Asias posted that
>> >> >> patches, so I don't know the exact reason.
>> >> >>
>> >> >> Maybe could be related on how to handle the credit mechanism for a
>> >> >> connection-less sockets and how to manage the packet queue, if for
>> >> >> example no one is listening.
>> >> >>
>> >> >
>> >> >I see. thanks.
>> >> >
>> >> >> >
>> >> >> >My current code differs from Asias' code in some ways. It does not use
>> >> >> >credit and does not support fragmentation.  It basically adds two virt
>> >> >>
>> >> >> If you don't use credit, do you have some threshold when you start to
>> >> >> drop packets on the RX side?
>> >> >>
>> >> >
>> >> >As of now, I don't have any threshold to drop packets on RX side. In my
>> >> >view, DGRAM is like UDP and is a best effort service. If the virtual
>> >> >queue
>> >> >is full on TX (or the available buffer size is less than the 
>> >> >packet size),
>> >> >I drop the packets on the TX side.
>> >>
>> >> I have to check the code, my concern is we should have a limit for the
>> >> allocation, for example if the user space doesn't consume RX packets.
>> >>
>> >
>> >I think we already have a limit for the allocation. If a DGRAM client
>> >sends packets while no socket is bound on the server side ,
>> >the packet will be dropped when looking for the socket. If the socket is
>> >bound on the server side, but the server program somehow does not
>> >call recv or similar functions, the packets will be dropped when the
>> >buffer is full as in your previous patch at here:
>> >https://lore.kernel.org/patchwork/patch/1141083/
>> >If there are still other cases that we don't have protection, let me know and
>> >I can add some threshold.
>>
>> Maybe I misunderstood, but I thought you didn't use credit for DGRAM
>> messages.
>>
>I don't use credit for DGRAM. But the dropping code I mentioned does not
>rely on credit too. Just to make it clear, following is one part of code that
>I referred to:
>
>static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>struct virtio_vsock_pkt *pkt)
>{
>if (vvs->rx_bytes + pkt->len > vvs->buf_alloc)
>return false;
>
>vvs->rx_bytes += pkt->len;
>return true;
>}

Okay, now it's clear. The transmitter doesn't care about the receiver's 
credit, but the receiver uses that part of the credit mechanism to 
discard packets.

I think that's fine, but when you send the patches, explain it well in 
the cover letter/commit message.

>
>
>> If you use it to limit buffer occupancy, then it should be okay, but
>> again, I still have to look at the code :-)
>
>Sure. I think you mean you need to look at my final patches. I will
>send it later.  Just a friendly reminder, if you just want to get some
>idea of my patches, you could check this link :
>https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d

It's my fault because I didn't have time, I saw the link. :-)

Remember that we should also plan changes to the VIRTIO spec for the 
DGRAM support.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
