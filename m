Return-Path: <SRS0=Ae13=GB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D5C433E0
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:15:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F160216C4
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 01:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F160216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D7C53203E2;
	Tue, 29 Dec 2020 01:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkDSEFAaOFjc; Tue, 29 Dec 2020 01:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 73CC12010A;
	Tue, 29 Dec 2020 01:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40162C1D9C;
	Tue, 29 Dec 2020 01:15:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE2FC0174
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0648B87215
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCcs7q5Z2Ar0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 32A74871F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 01:15:06 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id 17so3891698uaq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbqLbRke1/tZuT48N3REwNxRIKEJD5OV/xAoIFM8zPA=;
 b=APQZkNtmSnxPxncNFX+uV5nTlgaL27xMv+FNab7qQutiv+XT6IDinNb0ibB7l2gTjH
 FlQ6Nm0s6n+LR4ehsY1qNSgiRjuZ0KbPOiE4NWHixilX4rvCLoqQezvQ7PAf2VPTuAgG
 l2RuOScZF+TIv/WW7ACCvADR+MEcRjVIfqNgIZwVpyRWRL9eJiEtnOfR3rnq2XZpE2aS
 1nxvS7lAGBH+n7XPZxr1Sy1tBedh0PBw5vOvQCz4cUjDQw7fxlc8sVxFNapyl17G5hxt
 oaakEi1Dutovh9YK7j4BlVRElK6yT0lK/i11CYbBZasovMIlNXoy2zSv1yTHdHkzteY9
 eSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbqLbRke1/tZuT48N3REwNxRIKEJD5OV/xAoIFM8zPA=;
 b=l31MVwDn75KPvIIJqDd33sQ3cbMQyuU9gf04vtftT0yIOxAaplVclHldqedmrmJ9+E
 6BrDrE/KC4u5p85Qr8n9yAmOqa/GQJKonThvxzwZiQ09+K7XZFr8mYicVVakP4CmCx47
 im4+Q6VDja5ZSXSor/LcOzA7XqHkhjfew1+jcm8w4AaiBiT3vNDzsMQlJhrKvaWSbVl5
 JnK20oOTmFO/k7Qu2UbFt/ihd+XSncYTDV9Dkq6df2onVYi1B3+z2hL9WCAG/HzYDIie
 iIcLVn+6tftai5Q2naWqDkbCE+ws2MkPEBWkuvO5wVaezXWySlTNhs3PqlejNw9bMjXy
 pX1A==
X-Gm-Message-State: AOAM531l1fmzTRf9ZHEDZdk8Qv13lJs1R7Is/KJMUcjoiU5s5rbwQhNS
 2sTX0J5vsZx6hCliAu3kmra0H1hBR4I=
X-Google-Smtp-Source: ABdhPJz/HdsRauRlN2qg1n21e+XK1jLpnSgDjZtuR0BzMIT5XwVb7KtrOWQ+W5Fg/6yvicFlj/VnHA==
X-Received: by 2002:a9f:240a:: with SMTP id 10mr29014392uaq.124.1609204504699; 
 Mon, 28 Dec 2020 17:15:04 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com.
 [209.85.222.54])
 by smtp.gmail.com with ESMTPSA id 64sm2876823vkx.36.2020.12.28.17.15.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 17:15:03 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id t15so3888261ual.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:15:03 -0800 (PST)
X-Received: by 2002:a9f:2356:: with SMTP id 80mr29925448uae.92.1609204503328; 
 Mon, 28 Dec 2020 17:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228122911-mutt-send-email-mst@kernel.org>
 <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
 <20201228163809-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228163809-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 20:14:26 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdEqk8gxptnOSpNnm6YPSJv=62wKHqe4GbVAiKQRUfmXQ@mail.gmail.com>
Message-ID: <CA+FuTSdEqk8gxptnOSpNnm6YPSJv=62wKHqe4GbVAiKQRUfmXQ@mail.gmail.com>
Subject: Re: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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

On Mon, Dec 28, 2020 at 7:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 02:51:09PM -0500, Willem de Bruijn wrote:
> > On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 11:22:30AM -0500, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > RFC for three new features to the virtio network device:
> > > >
> > > > 1. pass tx flow hash and state to host, for routing + telemetry
> > > > 2. pass rx tstamp to guest, for better RTT estimation
> > > > 3. pass tx tstamp to host, for accurate pacing
> > > >
> > > > All three would introduce an extension to the virtio spec.
> > > > I assume this would require opening three ballots against v1.2 at
> > > > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> > > >
> > > > This RFC is to informally discuss the proposals first.
> > > >
> > > > The patchset is against v5.10. Evaluation additionally requires
> > > > changes to qemu and at least one back-end. I implemented preliminary
> > > > support in Linux vhost-net. Both patches available through github at
> > > >
> > > > https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
> > > > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1
> > >
> > > Any data on what the benefits are?
> >
> > For the general method, yes. For this specific implementation, not  yet.
> >
> > Swift congestion control is delay based. It won the best paper award
> > at SIGCOMM this year. That paper has a lot of data:
> > https://dl.acm.org/doi/pdf/10.1145/3387514.3406591 . Section 3.1 talks
> > about the different components that contribute to delay and how to
> > isolate them.
>
> And for the hashing part?

A few concrete examples of error conditions that can be resolved are
mentioned in the commits that add sk_rethink_txhash calls. Such as
commit 7788174e8726 ("tcp: change IPv6 flow-label upon receiving
spurious retransmission"):

"
    Currently a Linux IPv6 TCP sender will change the flow label upon
    timeouts to potentially steer away from a data path that has gone
    bad. However this does not help if the problem is on the ACK path
    and the data path is healthy. In this case the receiver is likely
    to receive repeated spurious retransmission because the sender
    couldn't get the ACKs in time and has recurring timeouts.

    This patch adds another feature to mitigate this problem. It
    leverages the DSACK states in the receiver to change the flow
    label of the ACKs to speculatively re-route the ACK packets.
    In order to allow triggering on the second consecutive spurious
    RTO, the receiver changes the flow label upon sending a second
    consecutive DSACK for a sequence number below RCV.NXT.
"

I don't have quantitative data on the efficacy at scale at hand. Let
me see what I can find. This will probably take some time, at least
until people are back after the holidays. I didn't want to delay the
patch, as the merge window was a nice time for RFC. But agreed that it
deserves stronger justification.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
