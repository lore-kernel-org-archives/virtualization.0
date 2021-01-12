Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D02C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:11:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F6922B4B
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F6922B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 117C885116;
	Tue, 12 Jan 2021 20:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJLEWFC84Tr6; Tue, 12 Jan 2021 20:11:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AC0185190;
	Tue, 12 Jan 2021 20:11:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58A32C0893;
	Tue, 12 Jan 2021 20:11:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F1F1C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9AE2A85B3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OASWYrEl7HAP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:54 +0000 (UTC)
X-Greylist: delayed 00:22:19 by SQLgrey-1.7.6
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9444F85B1D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:54 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id d20so3540648otl.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O7/M6B7YqTGHi7NnZLBVw1iJEATx9VM5xn4jowTooqg=;
 b=UmdCnOd9p7HTDUpn111xjpsZhlH9Wyagx3fH8hlscE+sSrJz429k6OC+NnvRnFQwpl
 jqkR0s7AEDLjTJ0tq6hZBObi6DFBJPrI8K29WbKXWEX8kB539YWrgpGJqfy0ojTAcqlX
 A/8M+eXo7DG43n0QaITT1ZzZkFVJHA1wCZsMP/csUGUiOcYrjXPxCNQbVGHYFk8eZMml
 PQCZdfIhK5Q8tqATIShbwSMJx30AKk7x9Yiz8gp1FLSc6TkC1TzXRxLv7QIpuV8ow32m
 QHlWmBmHegqCq8m2hkfA2+d81qT2yKRdtWfqAGHKLt6uQt4tjNbi71loXt7+hIyfFEF8
 ILCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O7/M6B7YqTGHi7NnZLBVw1iJEATx9VM5xn4jowTooqg=;
 b=MMYOk7hLGpkE2MT0Boqc41fdJL/vkj0WtkWofJ/RgxGVdSm0xRBT1oc1ExqWI/Dv4S
 P49/NmplPFcUwAmNTBbEURU9T5HaQpgaz2hh+8f+mtoGzut/TrlenALzwiCfuikC8L9g
 h5hoIMPOmDuFe8CLFb3MTyiNXlZq0+d33UWKK4ZfOMXMnfrzCoSXamUF5PCASwzFG8Io
 HZA2UVCqpJGfkXYGXmEA+kb0IHS/YNJgLfrJlZevcLJDavcwRUMoRx/Wrlw9YbVsnMBR
 EBVylx95fJSflfVH3a5slOCiAiquFEX7rgYSHSph/M0QXsC1azCz8OI0CjiptaxpAHZn
 b0fw==
X-Gm-Message-State: AOAM532/lQLdUVHL66xP9T+DhnZbQQRqI88Fq7FEXADzfGuOvEr4J46G
 TR1GJA5ORHVjuOlyIB4PWfcLv1GY1Lon3rWcw26ugwZ7n+iRIZjk
X-Google-Smtp-Source: ABdhPJzHurposwP0CkbMCdsJQYlpBWAqy5u0b6+ShjXQt+hgxjTlD6eu4NfdkCl4yEwTKKUdzPdbCNayYxSsoybE50Y=
X-Received: by 2002:a9d:4715:: with SMTP id a21mr734506otf.220.1610480974332; 
 Tue, 12 Jan 2021 11:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 12 Jan 2021 21:49:21 +0200
Message-ID: <CAOEp5OejaX4ZETThrj4-n8_yZoeTZs56CBPHbQqNsR2oni8dWw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Support for virtio-net hash reporting
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, 
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, 
 rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com, nogikh@google.com, 
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

On Tue, Jan 12, 2021 at 9:41 PM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Existing TUN module is able to use provided "steering eBPF" to
> calculate per-packet hash and derive the destination queue to
> place the packet to. The eBPF uses mapped configuration data
> containing a key for hash calculation and indirection table
> with array of queues' indices.
>
> This series of patches adds support for virtio-net hash reporting
> feature as defined in virtio specification. It extends the TUN module
> and the "steering eBPF" as follows:
>
> Extended steering eBPF calculates the hash value and hash type, keeps
> hash value in the skb->hash and returns index of destination virtqueue
> and the type of the hash. TUN module keeps returned hash type in
> (currently unused) field of the skb.
> skb->__unused renamed to 'hash_report_type'.
>
> When TUN module is called later to allocate and fill the virtio-net
> header and push it to destination virtqueue it populates the hash
> and the hash type into virtio-net header.
>
> VHOST driver is made aware of respective virtio-net feature that
> extends the virtio-net header to report the hash value and hash report
> type.

Comment from Willem de Bruijn:

Skbuff fields are in short supply. I don't think we need to add one
just for this narrow path entirely internal to the tun device.

Instead, you could just run the flow_dissector in tun_put_user if the
feature is negotiated. Indeed, the flow dissector seems more apt to me
than BPF here. Note that the flow dissector internally can be
overridden by a BPF program if the admin so chooses.

This also hits on a deeper point with the choice of hash values, that
I also noticed in my RFC patchset to implement the inverse [1][2]. It
is much more detailed than skb->hash + skb->l4_hash currently offers,
and that can be gotten for free from most hardware. In most practical
cases, that information suffices. I added less specific fields
VIRTIO_NET_HASH_REPORT_L4, VIRTIO_NET_HASH_REPORT_OTHER that work
without explicit flow dissection. I understand that the existing
fields are part of the standard. Just curious, what is their purpose
beyond 4-tuple based flow hashing?

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=406859&state=*
[2] https://github.com/wdebruij/linux/commit/0f77febf22cd6ffc242a575807fa8382a26e511e
>
> Yuri Benditovich (7):
>   skbuff: define field for hash report type
>   vhost: support for hash report virtio-net feature
>   tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
>   tun: free bpf_program by bpf_prog_put instead of bpf_prog_destroy
>   tun: add ioctl code TUNSETHASHPOPULATION
>   tun: populate hash in virtio-net header when needed
>   tun: report new tun feature IFF_HASH
>
>  drivers/net/tun.c           | 43 +++++++++++++++++++++++++++++++------
>  drivers/vhost/net.c         | 37 ++++++++++++++++++++++++-------
>  include/linux/skbuff.h      |  7 +++++-
>  include/uapi/linux/if_tun.h |  2 ++
>  4 files changed, 74 insertions(+), 15 deletions(-)
>
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
