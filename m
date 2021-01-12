Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F58C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:37:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DF222DFA
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DF222DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3BC1920408;
	Tue, 12 Jan 2021 20:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jj2obDyl8qjk; Tue, 12 Jan 2021 20:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C2E172001F;
	Tue, 12 Jan 2021 20:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ABE3C0893;
	Tue, 12 Jan 2021 20:37:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F52BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52C4820408
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2YKYhbszYwyk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by silver.osuosl.org (Postfix) with ESMTPS id 3AFF42001F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:37:25 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id b24so3624687otj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cDLeYHAdyJXom8UBMPXNbz8kfcw4k2SFK/gIDfQI2Mo=;
 b=hACMNd12CHzJhQb2y9E5HlKzNxg6kPOhqWOGaDaCfMGGatsDYO2+ROrP/n8p3QmJ9R
 Rdk4qIA2XPaiz7rMV5Yq7TnzBkrzdOIQP1J2uw7qw1u3vGKh9hXCod3/pmGfQS5Dt25f
 vyp+wLnZz0lEHxrRYpMvHh71rkMyg958RZXm82SuqMjX7KL89fd+7xnyiec+GZPC4IP8
 NmtDu4tDAYXgMLiQuZfRLWMTkj14XB0Exu+9c1n1+6y3gFfPJfUqsHl9vA2/8XBRiwcn
 4C5XOa52DmPlwbBDM9vGa0KGC8WeuCX+prNE1b2aRmnLs7513D4v4q+8CiQXK2/rQcBS
 hMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDLeYHAdyJXom8UBMPXNbz8kfcw4k2SFK/gIDfQI2Mo=;
 b=iguHFv930PF3cKMjv8LW7va2zAQcnSHtolazZoaC8QAnttDXigt0DOhns4oONo5hFf
 kA12cEO1vw006PIHcvzSDAOreDwp2Me7ICavALnN/REPFRz6Crp0yIhaVXYXJ51NN9ii
 Jf6pFXY6r8hr6M1v6/qi4lu551kJ/zt1GpeY0bD3aFi9numq7rz4Yd1DxnYY6DJR5cel
 NsKqb4duwTNSsxu514jZzfqdJHseisEzxobsR1PK1tOedDCGhql9y+K9BtY07LcYOwmM
 QhfcVPrqaxDhGx6H/SQ2uX3yuIN7g7waUux9sdFyKqyIsdwySl7hq+u2r+iSvIbLgWGO
 i1Gw==
X-Gm-Message-State: AOAM53276MgnJNBqGXOPw/jD07YTIoOK+bekQFETtf5B0bt7p8SK4j1D
 fveky4bq5ifmT8klSLuqpPaVFCpL36GEMaFD30nC0hFQfbG3t9sX
X-Google-Smtp-Source: ABdhPJzOPojmT2VBrMxKI3W3V3rQzq5X9DqoVBkUPwMTcVKp+Oj5xQbG7tR8lCWwkKUUfJvuGIFEfrk2Et/qTYvlNvU=
X-Received: by 2002:a4a:98e7:: with SMTP id b36mr550175ooj.3.1610483343593;
 Tue, 12 Jan 2021 12:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
In-Reply-To: <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 12 Jan 2021 22:28:50 +0200
Message-ID: <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, 
 rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com, 
 pablo@netfilter.org, decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, 
 elver@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc: Yan Vugenfirer <yan@daynix.com>
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

On Tue, Jan 12, 2021 at 9:49 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:41 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > Existing TUN module is able to use provided "steering eBPF" to
> > calculate per-packet hash and derive the destination queue to
> > place the packet to. The eBPF uses mapped configuration data
> > containing a key for hash calculation and indirection table
> > with array of queues' indices.
> >
> > This series of patches adds support for virtio-net hash reporting
> > feature as defined in virtio specification. It extends the TUN module
> > and the "steering eBPF" as follows:
> >
> > Extended steering eBPF calculates the hash value and hash type, keeps
> > hash value in the skb->hash and returns index of destination virtqueue
> > and the type of the hash. TUN module keeps returned hash type in
> > (currently unused) field of the skb.
> > skb->__unused renamed to 'hash_report_type'.
> >
> > When TUN module is called later to allocate and fill the virtio-net
> > header and push it to destination virtqueue it populates the hash
> > and the hash type into virtio-net header.
> >
> > VHOST driver is made aware of respective virtio-net feature that
> > extends the virtio-net header to report the hash value and hash report
> > type.
>
> Comment from Willem de Bruijn:
>
> Skbuff fields are in short supply. I don't think we need to add one
> just for this narrow path entirely internal to the tun device.
>

We understand that and try to minimize the impact by using an already
existing unused field of skb.


> Instead, you could just run the flow_dissector in tun_put_user if the
> feature is negotiated. Indeed, the flow dissector seems more apt to me
> than BPF here. Note that the flow dissector internally can be
> overridden by a BPF program if the admin so chooses.
>
When this set of patches is related to hash delivery in the virtio-net
packet in general,
it was prepared in context of RSS feature implementation as defined in
virtio spec [1]
In case of RSS it is not enough to run the flow_dissector in tun_put_user:
in tun_ebpf_select_queue the TUN calls eBPF to calculate the hash,
hash type and queue index
according to the (mapped) parameters (key, hash types, indirection
table) received from the guest.
Our intention is to keep the hash and hash type in the skb to populate them
into a virtio-net header later in tun_put_user.
Note that in this case the type of calculated hash is selected not
only from flow dissections
but also from limitations provided by the guest.
This is already implemented in qemu (for case of vhost=off), see [2]
(virtio_net_process_rss)
For case of vhost=on there are WIP for qemu to load eBPF and attach it to TUN.

Note that exact way of selecting rx virtqueue depends on the guest,
it could be automatic steering (typical for Linux VM), RSS (typical
for Windows VM) or
any other steering mechanism implemented in loadable TUN steering BPF with
or without hash calculation.

[1] https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3740
[2] https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L1591

> This also hits on a deeper point with the choice of hash values, that
> I also noticed in my RFC patchset to implement the inverse [1][2]. It
> is much more detailed than skb->hash + skb->l4_hash currently offers,
> and that can be gotten for free from most hardware.

Unfortunately in the case of RSS we can't get this hash from the hardware as
this requires configuration of the NIC's hardware with key and hash types for
Toeplitz hash calculation.

> In most practical
> cases, that information suffices. I added less specific fields
> VIRTIO_NET_HASH_REPORT_L4, VIRTIO_NET_HASH_REPORT_OTHER that work
> without explicit flow dissection. I understand that the existing
> fields are part of the standard. Just curious, what is their purpose
> beyond 4-tuple based flow hashing?

The hash is used in combination with the indirection table to select
destination rx virtqueue.
The hash and hash type are to be reported in virtio-net header, if requested.
For Windows VM - in case the device does not report the hash (even if
it calculated it to
schedule the packet to a proper queue), the driver must do that for each packet
(this is a certification requirement).

>
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=406859&state=*
> [2] https://github.com/wdebruij/linux/commit/0f77febf22cd6ffc242a575807fa8382a26e511e
> >
> > Yuri Benditovich (7):
> >   skbuff: define field for hash report type
> >   vhost: support for hash report virtio-net feature
> >   tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
> >   tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
> >   tun: add ioctl code TUNSETHASHPOPULATION
> >   tun: populate hash in virtio-net header when needed
> >   tun: report new tun feature IFF_HASH
> >
> >  drivers/net/tun.c           | 43 +++++++++++++++++++++++++++++++------
> >  drivers/vhost/net.c         | 37 ++++++++++++++++++++++++-------
> >  include/linux/skbuff.h      |  7 +++++-
> >  include/uapi/linux/if_tun.h |  2 ++
> >  4 files changed, 74 insertions(+), 15 deletions(-)
> >
> > --
> > 2.17.1
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
