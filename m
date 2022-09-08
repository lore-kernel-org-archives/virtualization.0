Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A7C54EE9
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 20:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A3904015F;
	Thu,  8 Sep 2022 20:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A3904015F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=BOSQ+7TV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBD_ojtwxLZl; Thu,  8 Sep 2022 20:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3E08400B9;
	Thu,  8 Sep 2022 20:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3E08400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C2DC0032;
	Thu,  8 Sep 2022 20:22:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 824EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4484D410B4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4484D410B4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=BOSQ+7TV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9vpDUDBkLbs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:22:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 618E9410B7
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 618E9410B7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 20:22:43 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1225219ee46so47549395fac.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=RX8VIBrkIrN+uaJDyGYK1oayYALRo341SLY9FJGeLKg=;
 b=BOSQ+7TVFALXbxC/myMu5Chncu9V3l4sSSxY4m0Bx02D2bgLEFpAbb5BltskTSr+5F
 F70VCqtvBpr3Q4AFCBsDmpLukbkEYUhpmykaTpNj12w37og7JsupiMmJKnsVhnBNAbdJ
 hAhMAUzA1kQlQmqsKZ/GOKRml0/zJTsu2tPGYflD2YKqBQuBWqCz2Ipf8dbhnqCxz/Z3
 rCsguQKWgB3xbFyTgY/FoqIJ69KBVkn0ktWbgK+gfzDaVhmOc84RzmawuiGIbSZPF06g
 /Qb0TXYcSI7c8gutf7cwJsaoPMP5cQ3oy2G3bklXfmkKos4jtJhiBNaRVkg+RACOz7Bz
 tM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=RX8VIBrkIrN+uaJDyGYK1oayYALRo341SLY9FJGeLKg=;
 b=jJoiwi/UnmLUms+2/S4pvLg1K/5QqyY8rzJZysOIhcNJjUQpoClcA6SH8oCG/4/OFX
 ealy0pE1I3pgVT+4V6WV3VzrbH8ikVw+BC+myDnulJA/dap//o0bRBRR/Cu0WaLyINEV
 /+KCOnP10aPBQjQp+p7WZSfPO+pKq6o+Sy6SHFPfrO+coAKCOJno8slUR/RWLy3DGtAU
 y+LYdnLe73FcvgNNOURCetz3MY8DZ6RJltNK/8d+i1xfPOpuDvg9+b/yysquLIhiF1zR
 NdeQYTJS6bpdVKkDqSomvrgOnx/qZFgAtu4Tk7wRgTWorYWxwvRTaupiJXPOUQlanr92
 Z6mQ==
X-Gm-Message-State: ACgBeo1fK/UQ0JSs8yutuUAN8TpKaB1kcWtYSn95J4rWmXEKYIgls/0e
 SNvWYUC0YJy3wQdIb9GSyqUtVfVjESfvPT9GkW/E5w==
X-Google-Smtp-Source: AA6agR49XRbIMolMgRxwv8qrnpTs2QgNkLEpVvZTqKvSQ7ilNqc92R6DLRt+yLI0hlnLZ5GHBBBhLlWXrjDL36m0UZg=
X-Received: by 2002:a05:6808:2382:b0:344:90f9:b79 with SMTP id
 bp2-20020a056808238200b0034490f90b79mr2264444oib.137.1662668561813; Thu, 08
 Sep 2022 13:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220907125048.396126-1-andrew@daynix.com>
 <e1e6519f-2e77-05c1-697c-56b174addc6e@kernel.org>
In-Reply-To: <e1e6519f-2e77-05c1-697c-56b174addc6e@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Thu, 8 Sep 2022 23:09:24 +0300
Message-ID: <CABcq3pFbKB26x2yCAxMFTU02uAkQrRCRvY1YNYRcx6zHbG54Kg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] TUN/VirtioNet USO features support.
To: David Ahern <dsahern@kernel.org>
Cc: mst@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 yuri.benditovich@daynix.com, edumazet@google.com, yan@daynix.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Hi all,

On Thu, Sep 8, 2022 at 3:44 AM David Ahern <dsahern@kernel.org> wrote:
>
> On 9/7/22 6:50 AM, Andrew Melnychenko wrote:
> > Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> > Technically they enable NETIF_F_GSO_UDP_L4
> > (and only if USO4 & USO6 are set simultaneously).
> > It allows the transmission of large UDP packets.
>
> Please spell out USO at least once in the cover letter to make sure the
> acronym is clear.

USO - UDP Segmentation Offload. Ability to split UDP packets into
several segments.
Allows sending/receiving big UDP packets. At some point, it looks like
UFO(fragmentation),
but each segment contains a UDP header.

>
> >
> > Different features USO4 and USO6 are required for qemu where Windows guests can
> > enable disable USO receives for IPv4 and IPv6 separately.
> > On the other side, Linux can't really differentiate USO4 and USO6, for now.
>
> Why is that and what is needed for Linux to differentiate between the 2
> protocols?

Well, this feature requires for Windows VM guest interaction. Windows may have
a separate configuration for USO4/USO6. Currently, we support Windows guests
with enabled USO4 and USO6 simultaneously.
To implement this on Linux host, will require at least one additional
netdev feature
and changes in Linux network stack. Discussion about that will be in
the future after
some research.

>
> > For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> > In the future, there would be a mechanism to control UDP_L4 GSO separately.
> >
> > New types for virtio-net already in virtio-net specification:
> > https://github.com/oasis-tcs/virtio-spec/issues/120
> >
> > Test it WIP Qemu https://github.com/daynix/qemu/tree/USOv3
> >
> > Andrew (5):
> >   uapi/linux/if_tun.h: Added new offload types for USO4/6.
> >   driver/net/tun: Added features for USO.
> >   uapi/linux/virtio_net.h: Added USO types.
> >   linux/virtio_net.h: Support USO offload in vnet header.
> >   drivers/net/virtio_net.c: Added USO support.
> >
> > Andrew Melnychenko (1):
> >   udp: allow header check for dodgy GSO_UDP_L4 packets.
> >
> >  drivers/net/tap.c               | 10 ++++++++--
> >  drivers/net/tun.c               |  8 +++++++-
> >  drivers/net/virtio_net.c        | 19 +++++++++++++++----
> >  include/linux/virtio_net.h      |  9 +++++++++
> >  include/uapi/linux/if_tun.h     |  2 ++
> >  include/uapi/linux/virtio_net.h |  5 +++++
> >  net/ipv4/udp_offload.c          |  2 +-
> >  7 files changed, 47 insertions(+), 8 deletions(-)
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
