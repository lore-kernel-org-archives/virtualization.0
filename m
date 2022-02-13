Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9BFC433FE
	for <virtualization@archiver.kernel.org>; Sun, 13 Feb 2022 17:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BFDC813F9;
	Sun, 13 Feb 2022 17:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DNCT6a-1BS4; Sun, 13 Feb 2022 17:22:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16D2C813A7;
	Sun, 13 Feb 2022 17:22:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA5D3C0011;
	Sun, 13 Feb 2022 17:22:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB67C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AD3A40231
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AnfO-3AgSvoH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:22:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A24254022F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 17:22:34 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 r15-20020a4ae5cf000000b002edba1d3349so16844591oov.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Feb 2022 09:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6gOn1TOfNbMYLyYypKWqKuyTET7LgcArVblqVE8rQPA=;
 b=wgN6IGSEI7Z4WyUQRMYo3hg1Eyj/7D3v4ndCYWxXPMwiHyQZtx39kgmrd7M08chLQO
 PGzPMjzgGOW8PpSkd3QmwcMGwokLOdrLGojEodkXUWfu+VC50pFR/rOq/vJt27Sye2ua
 WaPRpO054M0tMgT/sw7OV2Jp00U0LeObVrh4ccCUiIM+Nsi09tJdWxmdD0wCTxtWKoYR
 +2XHEEeGa50aM7Q2xzixvYE6ZzRUAglEJbbYavQ+bozoD3ZhBU1HB2Ulztd619xGhGvh
 xJFTcNVbPfrZHmmPLXh/C42UwAKgnB0kAu91fXHo5fqvX9V2nkio5+dSO5fKMS2I2Xrl
 3IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6gOn1TOfNbMYLyYypKWqKuyTET7LgcArVblqVE8rQPA=;
 b=TulTr/pGvMvm+Ydjv8KMx2MLDQcewdw+pNpujl8IToT+qAMw3aapKxYhENKhXmlPLa
 TAE6m1TWIUkJT1c8GK3xyVJxwDsgwS3l5uvKg3zHPKHV4DmlNRjfrmaYl3gYDoBqqAKD
 YTN1RAEDjTvY7GPluAytN2nAPms61cIuxZg35tUkb9ZtzosEix/cdIcHUm68KKgeOytv
 lT8Zn0PcIf7cRBk5I4Urw1XWnvjVJqNd13yT8Qd751g81zZcq8GRhm0AEDLbXQNUDQQ7
 ZtF2O8wNupopUYqXuCV3TotBZPIEzkZhkLZskdwAUlfBoycmvbnqL4u+/aVfS6Taa2pA
 TcHg==
X-Gm-Message-State: AOAM531Y+NgXATdbDIHrN5OLNHnyNnpgLSoXHGuie9NIc08pHpnN+4E4
 eLq/fjy3GpUKtonmUxvACKFNMMkfJx1xgiSikmbE+Q==
X-Google-Smtp-Source: ABdhPJz82meVOYuliKCNgF06zpRUPtI5pe4EBPzRa1KfIkD9BUZy/9+Lxm8YzJocRT68c/rZijNBZ1CgcHQ7P689+Vg=
X-Received: by 2002:a05:6870:7687:: with SMTP id
 dx7mr1469694oab.327.1644772953668; 
 Sun, 13 Feb 2022 09:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-5-andrew@daynix.com>
 <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
In-Reply-To: <CA+FuTScRp5hhkvETuVRsUxMRCZVU0wVrmd5_=a5UoKNLDv4LnA@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Sun, 13 Feb 2022 19:22:22 +0200
Message-ID: <CABcq3pGQkw7uyQc+nfK0OZ5ejh3+7ws+cj41zyW99+3FsKW0og@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drivers/net/virtio_net: Added RSS hash report
 control.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi all,


On Tue, Feb 8, 2022 at 10:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Feb 8, 2022 at 1:19 PM Andrew Melnychenko <andrew@daynix.com> wrote:
> >
> > Now it's possible to control supported hashflows.
> > Added hashflow set/get callbacks.
> > Also, disabling RXH_IP_SRC/DST for TCP would disable then for UDP.
>
> I don't follow this comment. Can you elaborate?

I'll rephrase it in next version of patches.
The idea is that VirtioNet RSS doesn't distinguish IP hashes between
TCP and UDP.
For TCP and UDP it's possible to set IP+PORT hashes.
But disabling IP hashes will disable them for TCP and UDP simultaneously.
It's possible to set IP+PORT for TCP and IP for everything else(UDP, ICMP etc.)

>
> > TCP and UDP supports only:
> > ethtool -U eth0 rx-flow-hash tcp4 sd
> >     RXH_IP_SRC + RXH_IP_DST
> > ethtool -U eth0 rx-flow-hash tcp4 sdfn
> >     RXH_IP_SRC + RXH_IP_DST + RXH_L4_B_0_1 + RXH_L4_B_2_3
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  drivers/net/virtio_net.c | 141 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 140 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 543da2fbdd2d..88759d5e693c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -231,6 +231,7 @@ struct virtnet_info {
> >         u8 rss_key_size;
> >         u16 rss_indir_table_size;
> >         u32 rss_hash_types_supported;
> > +       u32 rss_hash_types_saved;
>
> hash_types_active?

I think "hash_types_saved" is more suitable for the current field.
Idea is that the user may disable RSS/HASH and we need to save
what hash type configurations previously were enabled.
So, we can restore it when the user will enable RSS/HASH back.

>
> > +static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *info)
> > +{
> > +       u32 new_hashtypes = vi->rss_hash_types_saved;
> > +       bool is_disable = info->data & RXH_DISCARD;
> > +       bool is_l4 = info->data == (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3);
> > +
> > +       /* supports only 'sd', 'sdfn' and 'r' */
> > +       if (!((info->data == (RXH_IP_SRC | RXH_IP_DST)) | is_l4 | is_disable))
>
> maybe add an is_l3

There used to be "is_l3", but that variable was used only in that
condition statement.
So I've decided to inplace it.

>
> > +               return false;
> > +
> > +       switch (info->flow_type) {
> > +       case TCP_V4_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_TCPv4);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv4 : 0);
> > +               break;
> > +       case UDP_V4_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv4 | VIRTIO_NET_RSS_HASH_TYPE_UDPv4);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv4
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv4 : 0);
> > +               break;
> > +       case IPV4_FLOW:
> > +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +               if (!is_disable)
> > +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv4;
> > +               break;
> > +       case TCP_V6_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_TCPv6);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_TCPv6 : 0);
> > +               break;
> > +       case UDP_V6_FLOW:
> > +               new_hashtypes &= ~(VIRTIO_NET_RSS_HASH_TYPE_IPv6 | VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
> > +               if (!is_disable)
> > +                       new_hashtypes |= VIRTIO_NET_RSS_HASH_TYPE_IPv6
> > +                               | (is_l4 ? VIRTIO_NET_RSS_HASH_TYPE_UDPv6 : 0);
> > +               break;
> > +       case IPV6_FLOW:
> > +               new_hashtypes &= ~VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +               if (!is_disable)
> > +                       new_hashtypes = VIRTIO_NET_RSS_HASH_TYPE_IPv6;
> > +               break;
> > +       default:
> > +               /* unsupported flow */
> > +               return false;
> > +       }
> > +
> > +       /* if unsupported hashtype was set */
> > +       if (new_hashtypes != (new_hashtypes & vi->rss_hash_types_supported))
> > +               return false;
> > +
> > +       if (new_hashtypes != vi->rss_hash_types_saved) {
> > +               vi->rss_hash_types_saved = new_hashtypes;
>
> should only be updated if the commit function returned success?

Not really, we already made all checks against "supported" hash types.
Also, the commit function may not be called if RSS is disabled by the user.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
