Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2A3C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Jun 2022 11:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246184197D;
	Thu, 16 Jun 2022 11:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sVaLyMjJVaJX; Thu, 16 Jun 2022 11:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70CDA41991;
	Thu, 16 Jun 2022 11:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32C52C0032;
	Thu, 16 Jun 2022 11:59:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 316CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B91260ABA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kRtpaYn6N5wj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:59:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3422860AA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:59:40 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id i25so1596572oii.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tKhLhAU1VwnhstyxXFD1uOF/c3hqPPQcj1y5Vx8V8sI=;
 b=FPNp7AlEq73YPzIn+VQs0w+sTCDNSZtdGNK6FPZOOnRz6tQLqIUmO8x3K13QLdj6Z5
 0p5nDdLps78jmHX/rEKQ7uQv7kMSIlNmcnauti/kss8KH/eL6uo7WLnbNJAAhDkzVC6k
 Z6eQ1ZtGu6YoTrh2Wwr5cHKM3Wu6Gjujtq4ikFRqAGxPQnwA5i0s6UxRT6KyBosqZXQC
 IOGwceh2lXzSbYZASloqNUkNauKwA2/slJXb0K+7SyIRe4MRHNOTrxBwCmX4YK79bueL
 rwm3FIwM0OINR1dWM8TM1rAUk4YIKvYzrj0kg5SwkVuIW2piinJhFupsSiIQA8wVodOg
 ekxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tKhLhAU1VwnhstyxXFD1uOF/c3hqPPQcj1y5Vx8V8sI=;
 b=QBI9bF8QxxmaRJaUGFNKQcUpDQ7ftbgws+nct55OVmo/elFKo5SH7PDPH/owcQchT7
 aSaEBdEL7LAQb4CZRIwgfI9SjCz5mznezVvGwxv5P01VNiYJhC71CeV0MUgkeQexICq4
 uid92OeDdKH3mI31PQKE9+J3viS3dr9BxJKO8/Z7uKGmqwN4cpYE70HaDnl4/mAHvNXO
 GqS7TBpgiHZngbWY3ybSLxT6fxzR4u4AONK4k11yfVtAI0IqVa8aelLZneUl9HRTEQg/
 bz2lFwwIaB1XtoKItGu9xIPXqwtTZD/PSmJchAxTTNh4/NwyVwtZKFmMxxSMiKqVUW8M
 omQg==
X-Gm-Message-State: AJIora+IY/1pX/WphnT9exSDHnEfUspuaZpYBwiH2pueZnd56TMpRxSB
 ivgrMqVbaQJtT6apZCY5M0lOMGU04eejl9ClF8M1qA==
X-Google-Smtp-Source: AGRyM1t7lM8G2J40rKKfaP+sqAb2CfdR7uixK9NuYWauryhEjnCDAH/meWhs+RFb3oju1l6Qg41d5r4eVixvaBXv190=
X-Received: by 2002:a05:6808:10c1:b0:331:39ca:a500 with SMTP id
 s1-20020a05680810c100b0033139caa500mr2341417ois.137.1655380779203; Thu, 16
 Jun 2022 04:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112347.18717-1-andrew@daynix.com>
 <CACGkMEvH1yE0CZYdstAK32DkEucejNO+V7PEAZD_641+rp2aKA@mail.gmail.com>
 <CABcq3pFJcsoj+dDf6tirT_hfTB6rj9+f6KNFafwg+usqYwTdDA@mail.gmail.com>
 <CACGkMEtaigzuwy25rE-7N40TQGvXVmJVQivavmuwrCuw0Z=LUQ@mail.gmail.com>
 <CABcq3pFzzSHA3pqbKFEsLaFg7FkFZkdxs+N_ET_n_XLBaWVnHA@mail.gmail.com>
In-Reply-To: <CABcq3pFzzSHA3pqbKFEsLaFg7FkFZkdxs+N_ET_n_XLBaWVnHA@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 16 Jun 2022 14:59:28 +0300
Message-ID: <CABcq3pHkqxunsaZ8qt=FicL1361D0EktxZhqib+MGDJ=DVB6FA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] TUN/VirtioNet USO features support.
To: Jason Wang <jasowang@redhat.com>
Cc: mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Dumazet <edumazet@google.com>, Yan Vugenfirer <yan@daynix.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 davem <davem@davemloft.net>
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

Hi, Jason
Apparently, your patch should work.
For now, I have an issue where segmentation between two guests on one
host still occurs.
Neither previous "hack" nor your patch helps.
Now I'm looking what the issue may be.
If you have some suggestions on where may I look, it would be helpful, thanks!

On Thu, May 26, 2022 at 3:18 PM Andrew Melnichenko <andrew@daynix.com> wrote:
>
> I'll check it, thank you!
>
> On Thu, May 26, 2022 at 9:56 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, May 24, 2022 at 7:07 PM Andrew Melnichenko <andrew@daynix.com> wrote:
> > >
> > > Hi all,
> > >
> > > The issue is that host segments packets between guests on the same host.
> > > Tests show that it happens because SKB_GSO_DODGY skb offload in
> > > virtio_net_hdr_from_skb().
> > > To do segmentation you need to remove SKB_GSO_DODGY or add SKB_GSO_PARTIAL
> > > The solution with DODGY/PARTIAL offload looks like a dirty hack, so
> > > for now, I've lived it as it is for further investigation.
> >
> > Ok, I managed to find the previous discussion. It looks to me the
> > reason is that __udp_gso_segment will segment dodgy packets
> > unconditionally.
> >
> > I wonder if the attached patch works? (compile test only).
> >
> > Thanks
> >
> > >
> > >
> > > On Tue, May 17, 2022 at 9:32 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, May 12, 2022 at 7:33 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> > > > >
> > > > > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > > > > Technically they enable NETIF_F_GSO_UDP_L4
> > > > > (and only if USO4 & USO6 are set simultaneously).
> > > > > It allows to transmission of large UDP packets.
> > > > >
> > > > > Different features USO4 and USO6 are required for qemu where Windows guests can
> > > > > enable disable USO receives for IPv4 and IPv6 separately.
> > > > > On the other side, Linux can't really differentiate USO4 and USO6, for now.
> > > > > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > > > > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> > > > >
> > > > > Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
> > > > >
> > > > > New types for VirtioNet already on mailing:
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html
> > > > >
> > > > > Also, there is a known issue with transmitting packages between two guests.
> > > >
> > > > Could you explain this more? It looks like a bug. (Or any pointer to
> > > > the discussion)
> > > >
> > > > Thanks
> > > >
> > > > > Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
> > > > >
> > > > > Andrew (5):
> > > > >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> > > > >   driver/net/tun: Added features for USO.
> > > > >   uapi/linux/virtio_net.h: Added USO types.
> > > > >   linux/virtio_net.h: Support USO offload in vnet header.
> > > > >   drivers/net/virtio_net.c: Added USO support.
> > > > >
> > > > >  drivers/net/tap.c               | 10 ++++++++--
> > > > >  drivers/net/tun.c               |  8 +++++++-
> > > > >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> > > > >  include/linux/virtio_net.h      |  9 +++++++++
> > > > >  include/uapi/linux/if_tun.h     |  2 ++
> > > > >  include/uapi/linux/virtio_net.h |  4 ++++
> > > > >  6 files changed, 45 insertions(+), 7 deletions(-)
> > > > >
> > > > > --
> > > > > 2.35.1
> > > > >
> > > >
> > >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
