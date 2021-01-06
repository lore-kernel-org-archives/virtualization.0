Return-Path: <SRS0=bDZb=GJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4EC433E0
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 20:33:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC9523132
	for <virtualization@archiver.kernel.org>; Wed,  6 Jan 2021 20:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC9523132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4102686DC0;
	Wed,  6 Jan 2021 20:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WVMTt2hvI4t; Wed,  6 Jan 2021 20:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22EF086C0E;
	Wed,  6 Jan 2021 20:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03EDEC0891;
	Wed,  6 Jan 2021 20:33:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32876C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 20:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 199D5873D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 20:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVyfEpmpUk8x
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 20:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 13964873CE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 20:33:28 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id p22so5548295edu.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jan 2021 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xgy3DNQexECKB+SL5FKqq5xsmsJH3tjYPP1oRbD9jII=;
 b=NiqSAmNXeWDM4T6nGCpMwGLt8Be0VxkzXj0Bxth1MPWCPkb6xoHrW3lDueQl8dlSAD
 PPng7wf42XRIjlaLiabH2ddUkvRpvufHvHlWv0IClmDgjr8hlXgG3jNduAXEpS7Gj0J0
 VbokGxt7VJpHaIRX3u0PSufeo4BX6A0rS/Nt6U5bSNXNHGy7zW9YOQt8oKS9izdPnia3
 o8elmGDfxV3OJFkOuI3FUHRWf6lFaBHDTV6LfzlBQXyEqk7uf3IIDDJ7h95YviKwbO0g
 set+YvtysdfavWJoGw8nldnNz7t8AwnV5Q44SPVNNwSwd0k2vpFKJ6iwMtgi1mAMMiMf
 9vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xgy3DNQexECKB+SL5FKqq5xsmsJH3tjYPP1oRbD9jII=;
 b=o+GwHLBtyC3JyR4GV4FYLloQNDJSRYWIa0U0BjzUO24WcJE73zFxZTaBkc/qJipP1n
 LSd5THOM4hJs5OThbc0p/6AxEhY2LM2i+DgPqnbv6BWYg01q3/vQusNUqepD1vWVG7kU
 Ok4wWE/la+3MKCKK5BlR6oww2Ue9eO9VloqQRFSAf7pUDaKL/qUNQMZIAEgBjsTx13v1
 +3ID012gPvml+JQGDkMKuu4OBGnWZEUEmlX0jtfBxFQ6fzRhmnGtdJCQUa3p3VlOvhbY
 +J7iAN14OaXWU1OFSorSyKL5iIgbCrQmLRtl5PuzkGTRSEF7FuTaCi3cEggM8dS7PRaR
 H+Dg==
X-Gm-Message-State: AOAM5324+y9C5rQZ7cmzqeTyyLsz7zBqc7diaceDi7mVgwEuaFttNNnp
 jW/Ym4k77Vn8dTsPalcixnKDC4iE8HMYyWh7SxSNyyo0Ifc=
X-Google-Smtp-Source: ABdhPJyTPhYfvO6fTENOiywBZ+EY93uQ0G8gs2t6CeI71eeiWAWzNReR9wfka39pPjXTLEkyaX0wGmht+sdzd5Opqiw=
X-Received: by 2002:a05:6402:350:: with SMTP id
 r16mr5025422edw.176.1609965206530; 
 Wed, 06 Jan 2021 12:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228122911-mutt-send-email-mst@kernel.org>
 <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
 <20201228163809-mutt-send-email-mst@kernel.org>
 <CA+FuTSdEqk8gxptnOSpNnm6YPSJv=62wKHqe4GbVAiKQRUfmXQ@mail.gmail.com>
In-Reply-To: <CA+FuTSdEqk8gxptnOSpNnm6YPSJv=62wKHqe4GbVAiKQRUfmXQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Jan 2021 15:32:51 -0500
Message-ID: <CAF=yD-Lcad6Sw6zkQGrCqck+s3rit-m6FLL6th9=G2pZOr=1Gw@mail.gmail.com>
Subject: Re: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 8:15 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Dec 28, 2020 at 7:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 02:51:09PM -0500, Willem de Bruijn wrote:
> > > On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 28, 2020 at 11:22:30AM -0500, Willem de Bruijn wrote:
> > > > > From: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > RFC for three new features to the virtio network device:
> > > > >
> > > > > 1. pass tx flow hash and state to host, for routing + telemetry
> > > > > 2. pass rx tstamp to guest, for better RTT estimation
> > > > > 3. pass tx tstamp to host, for accurate pacing
> > > > >
> > > > > All three would introduce an extension to the virtio spec.
> > > > > I assume this would require opening three ballots against v1.2 at
> > > > > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> > > > >
> > > > > This RFC is to informally discuss the proposals first.
> > > > >
> > > > > The patchset is against v5.10. Evaluation additionally requires
> > > > > changes to qemu and at least one back-end. I implemented preliminary
> > > > > support in Linux vhost-net. Both patches available through github at
> > > > >
> > > > > https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
> > > > > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1
> > > >
> > > > Any data on what the benefits are?
> > >
> > > For the general method, yes. For this specific implementation, not  yet.
> > >
> > > Swift congestion control is delay based. It won the best paper award
> > > at SIGCOMM this year. That paper has a lot of data:
> > > https://dl.acm.org/doi/pdf/10.1145/3387514.3406591 . Section 3.1 talks
> > > about the different components that contribute to delay and how to
> > > isolate them.
> >
> > And for the hashing part?
>
> A few concrete examples of error conditions that can be resolved are
> mentioned in the commits that add sk_rethink_txhash calls. Such as
> commit 7788174e8726 ("tcp: change IPv6 flow-label upon receiving
> spurious retransmission"):
>
> "
>     Currently a Linux IPv6 TCP sender will change the flow label upon
>     timeouts to potentially steer away from a data path that has gone
>     bad. However this does not help if the problem is on the ACK path
>     and the data path is healthy. In this case the receiver is likely
>     to receive repeated spurious retransmission because the sender
>     couldn't get the ACKs in time and has recurring timeouts.
>
>     This patch adds another feature to mitigate this problem. It
>     leverages the DSACK states in the receiver to change the flow
>     label of the ACKs to speculatively re-route the ACK packets.
>     In order to allow triggering on the second consecutive spurious
>     RTO, the receiver changes the flow label upon sending a second
>     consecutive DSACK for a sequence number below RCV.NXT.
> "
>
> I don't have quantitative data on the efficacy at scale at hand. Let
> me see what I can find. This will probably take some time, at least
> until people are back after the holidays. I didn't want to delay the
> patch, as the merge window was a nice time for RFC. But agreed that it
> deserves stronger justification.

The practical results mirror what the theory suggests: that in the
presence of multiple paths, of which one goes bad, this method
maintains connectivity where otherwise it would disconnect.

When IPv6 FlowLabel was included in path selection (e.g., LAG/ECMP),
flowlabel rotation on TCP timeout avoided the vast majority of TCP
disconnections that would otherwise have occurred during to link
failures in long-haul backbones, when an alternative path was
available.

So it's not a matter of percentages, just the existence of an
alternative healthy path on which the packets will eventually land
quite deterministically as it rotates the txhash on each timeout.

This method can be deployed based on a variety of "bad connection"
signals. Besides timeouts, the aforementioned spurious retransmits,
for one. This TCP connection-level information can independent of
flowlabel rotation be valuable information to the cloud provider to
detect and pinpoint network issues. As mentioned before, ideally we
can pass along such details of the type of signal along with the hash.
But that also requires passing that state in the guest from the TCP
layer to the virtio-net device. So left for separate later work. For
now we just have the reserved space in the header.

Michael, what is the best way to proceed with this? Send the patches
for review to net-next, or should I start by opening ballots to
https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
first? Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
