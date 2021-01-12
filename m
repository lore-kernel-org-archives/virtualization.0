Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E8C433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 23:54:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78B92310F
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 23:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78B92310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7502D85065;
	Tue, 12 Jan 2021 23:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAKH8EbN8GHU; Tue, 12 Jan 2021 23:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7532847D1;
	Tue, 12 Jan 2021 23:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D71C088B;
	Tue, 12 Jan 2021 23:54:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEA7FC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 23:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BFD4984DFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 23:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fwov-ctELcW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 23:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D04BB847D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 23:54:42 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id q4so29165plr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 15:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TRqAJSpYMDEJu/B9agr6xpDyrfe3UAVnQcCi0dRewe4=;
 b=OsWtLSsb4L+fW0+uOPO2F6EmPdCV8LbBB2Vx/5PPNw+ct7lUPcRZpFu9+1zF3VkPUG
 QKkjYJg+d1CMLIKZ3iXNxdG8W/Dkwq2n0lycWiXwhIcEp9sU9hK25Z2WHJ3UlR+S1aB7
 2geAX2+o2OVngfb4ppNS1b/ErxvGpZV9Ck6KiiL8B43c46l+MkYElIkqWqn8aE8yD7q8
 ra5SrXJko/s5LVpxAWe4qVGI2WGS3aVyh9qyUy2DwiUCiW9X73t7Oiu88dp872V2wWio
 jfQO04E3NL2gvn+8sXx3Vom9ct6OD6zbwyrj+HFSVtoUljtThy8Kcj/0w960VtyTRusU
 hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TRqAJSpYMDEJu/B9agr6xpDyrfe3UAVnQcCi0dRewe4=;
 b=GYIOkGD51c51wZYMiiIS5pM6q03wUb9UcoMa31Kteaq0pjCLBcNyRyAxDxs+k9lbiB
 AWcKvKliKQs5uvMC4RV91lBPanfGh95nFrUhGiqncxOgysFb4Q48y94mr8hmuG9edbwu
 LPbNGMyv9P+ajvY32RT1lZxzqOdpMzCGDKnBmqQNkRDsNADQRvaFB7ecmPJK1pKRxCyD
 xpCcnQhnFcHZ8jt0N/29qBahSn4GYPkOzE1Xmw2QVjiU6hSu9FabkSWLsNgfic2puCuY
 Nq0KNMFjP7LgybNcb08yt9h5Yl/8gkTcsRf//kC7Vufct72ijYzwPCg1+PdiD0X1pLMt
 M/3Q==
X-Gm-Message-State: AOAM532MAfUlR26QeppgCSAp1hoI22u5qWkT3eheCvfV30pHj6jaUKsI
 cYoNXdHHYnpfbU5ZXO70vB+DOUZZaHk=
X-Google-Smtp-Source: ABdhPJyTZiXepjR6uoCji47imRMipu6vCmF//GiNsd9AfOtGeEDffTCxYfKXAsxA97CGqYfeoXBkdw==
X-Received: by 2002:a17:90b:8cb:: with SMTP id
 ds11mr155906pjb.208.1610495682007; 
 Tue, 12 Jan 2021 15:54:42 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com.
 [209.85.215.178])
 by smtp.gmail.com with ESMTPSA id o129sm235857pfg.66.2021.01.12.15.54.41
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 15:54:41 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id g15so251604pgu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 15:54:41 -0800 (PST)
X-Received: by 2002:a67:f043:: with SMTP id q3mr2034470vsm.14.1610495269034;
 Tue, 12 Jan 2021 15:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
 <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
 <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
In-Reply-To: <CAOEp5Oc5qif_krU8oC6qhq6X0xRW-9GpWrBzWgPw0WevyhT8Mg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 12 Jan 2021 18:47:12 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
Message-ID: <CA+FuTSfhBZfEf8+LKNUJQpSxt8c5h1wMpARupekqFKuei6YBsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Song Liu <songliubraving@fb.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yan Vugenfirer <yan@daynix.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Borkmann <daniel@iogearbox.net>, decui@microsoft.com,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Marco Elver <elver@google.com>, KP Singh <kpsingh@kernel.org>, cai@lca.pw,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Network Development <netdev@vger.kernel.org>, rdunlap@infradead.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <kafai@fb.com>
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

On Tue, Jan 12, 2021 at 3:29 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:49 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 9:41 PM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > Existing TUN module is able to use provided "steering eBPF" to
> > > calculate per-packet hash and derive the destination queue to
> > > place the packet to. The eBPF uses mapped configuration data
> > > containing a key for hash calculation and indirection table
> > > with array of queues' indices.
> > >
> > > This series of patches adds support for virtio-net hash reporting
> > > feature as defined in virtio specification. It extends the TUN module
> > > and the "steering eBPF" as follows:
> > >
> > > Extended steering eBPF calculates the hash value and hash type, keeps
> > > hash value in the skb->hash and returns index of destination virtqueue
> > > and the type of the hash. TUN module keeps returned hash type in
> > > (currently unused) field of the skb.
> > > skb->__unused renamed to 'hash_report_type'.
> > >
> > > When TUN module is called later to allocate and fill the virtio-net
> > > header and push it to destination virtqueue it populates the hash
> > > and the hash type into virtio-net header.
> > >
> > > VHOST driver is made aware of respective virtio-net feature that
> > > extends the virtio-net header to report the hash value and hash report
> > > type.
> >
> > Comment from Willem de Bruijn:
> >
> > Skbuff fields are in short supply. I don't think we need to add one
> > just for this narrow path entirely internal to the tun device.
> >
>
> We understand that and try to minimize the impact by using an already
> existing unused field of skb.

Not anymore. It was repurposed as a flags field very recently.

This use case is also very narrow in scope. And a very short path from
data producer to consumer. So I don't think it needs to claim scarce
bits in the skb.

tun_ebpf_select_queue stores the field, tun_put_user reads it and
converts it to the virtio_net_hdr in the descriptor.

tun_ebpf_select_queue is called from .ndo_select_queue.  Storing the
field in skb->cb is fragile, as in theory some code could overwrite
that between field between ndo_select_queue and
ndo_start_xmit/tun_net_xmit, from which point it is fully under tun
control again. But in practice, I don't believe anything does.

Alternatively an existing skb field that is used only on disjoint
datapaths, such as ingress-only, could be viable.

> > Instead, you could just run the flow_dissector in tun_put_user if the
> > feature is negotiated. Indeed, the flow dissector seems more apt to me
> > than BPF here. Note that the flow dissector internally can be
> > overridden by a BPF program if the admin so chooses.
> >
> When this set of patches is related to hash delivery in the virtio-net
> packet in general,
> it was prepared in context of RSS feature implementation as defined in
> virtio spec [1]
> In case of RSS it is not enough to run the flow_dissector in tun_put_user:
> in tun_ebpf_select_queue the TUN calls eBPF to calculate the hash,
> hash type and queue index
> according to the (mapped) parameters (key, hash types, indirection
> table) received from the guest.

TUNSETSTEERINGEBPF was added to support more diverse queue selection
than the default in case of multiqueue tun. Not sure what the exact
use cases are.

But RSS is exactly the purpose of the flow dissector. It is used for
that purpose in the software variant RPS. The flow dissector
implements a superset of the RSS spec, and certainly computes a
four-tuple for TCP/IPv6. In the case of RPS, it is skipped if the NIC
has already computed a 4-tuple hash.

What it does not give is a type indication, such as
VIRTIO_NET_HASH_TYPE_TCPv6. I don't understand how this would be used.
In datapaths where the NIC has already computed the four-tuple hash
and stored it in skb->hash --the common case for servers--, That type
field is the only reason to have to compute again.

> Our intention is to keep the hash and hash type in the skb to populate them
> into a virtio-net header later in tun_put_user.
> Note that in this case the type of calculated hash is selected not
> only from flow dissections
> but also from limitations provided by the guest.
>
> This is already implemented in qemu (for case of vhost=off), see [2]
> (virtio_net_process_rss)
> For case of vhost=on there are WIP for qemu to load eBPF and attach it to TUN.

> Note that exact way of selecting rx virtqueue depends on the guest,
> it could be automatic steering (typical for Linux VM), RSS (typical
> for Windows VM) or
> any other steering mechanism implemented in loadable TUN steering BPF with
> or without hash calculation.
>
> [1] https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3740
> [2] https://github.com/qemu/qemu/blob/master/hw/net/virtio-net.c#L1591
>
> > This also hits on a deeper point with the choice of hash values, that
> > I also noticed in my RFC patchset to implement the inverse [1][2]. It
> > is much more detailed than skb->hash + skb->l4_hash currently offers,
> > and that can be gotten for free from most hardware.
>
> Unfortunately in the case of RSS we can't get this hash from the hardware as
> this requires configuration of the NIC's hardware with key and hash types for
> Toeplitz hash calculation.

I don't understand. Toeplitz hash calculation is enabled by default
for multiqueue devices, and many devices will pass the toeplitz hash
along for free to avoid software flow dissection.

> > In most practical
> > cases, that information suffices. I added less specific fields
> > VIRTIO_NET_HASH_REPORT_L4, VIRTIO_NET_HASH_REPORT_OTHER that work
> > without explicit flow dissection. I understand that the existing
> > fields are part of the standard. Just curious, what is their purpose
> > beyond 4-tuple based flow hashing?
>
> The hash is used in combination with the indirection table to select
> destination rx virtqueue.
> The hash and hash type are to be reported in virtio-net header, if requested.
> For Windows VM - in case the device does not report the hash (even if
> it calculated it to
> schedule the packet to a proper queue), the driver must do that for each packet
> (this is a certification requirement).

I understand the basics of RSS. My question is what the hash-type is
intended to be used for by the guest. It is part of the virtio spec,
so this point is somewhat moot: it has to be passed along with the
hash value now.

But it is not entirely moot. If most users are satisfied with knowing
whether a hash is L4 or not, we could add two new types
VIRTIO_NET_HASH_TYPE_L4 and VIRTIO_NET_HASH_TYPE_OTHER. And then pass
the existing skb->hash as is, likely computed by the NIC.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20201228162233.2032571-2-willemdebruijn.kernel@gmail.com/

> >
> > [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=406859&state=*
> > [2] https://github.com/wdebruij/linux/commit/0f77febf22cd6ffc242a575807fa8382a26e511e
> > >
> > > Yuri Benditovich (7):
> > >   skbuff: define field for hash report type
> > >   vhost: support for hash report virtio-net feature
> > >   tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
> > >   tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
> > >   tun: add ioctl code TUNSETHASHPOPULATION
> > >   tun: populate hash in virtio-net header when needed
> > >   tun: report new tun feature IFF_HASH
> > >
> > >  drivers/net/tun.c           | 43 +++++++++++++++++++++++++++++++------
> > >  drivers/vhost/net.c         | 37 ++++++++++++++++++++++++-------
> > >  include/linux/skbuff.h      |  7 +++++-
> > >  include/uapi/linux/if_tun.h |  2 ++
> > >  4 files changed, 74 insertions(+), 15 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
