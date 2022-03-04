Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E7C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 13:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE89C415F4;
	Fri,  4 Mar 2022 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BpG5ncEcrjc; Fri,  4 Mar 2022 13:16:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50F8A415CD;
	Fri,  4 Mar 2022 13:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15E18C001D;
	Fri,  4 Mar 2022 13:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66F04C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53227401DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V21hl8O4Ymrh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:16:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DD9B40140
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:16:45 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 40-20020a9d032b000000b005b02923e2e6so7416289otv.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Mar 2022 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c9/jSKEYWvjLYNnnhLPXkny4KyJtY1E3bTqXKWbpe38=;
 b=Jtoc93twUP7xt3r79Uyv6rhXGAGErLwtgbpDV0TdhEQLZukQFNjpRDFDC/bJ3XS64t
 Qya/0WpS5ZGuoPxfr6xXDfYrQK4PkM6ukAxxg/9Hb0JnTX+wmPVE+D/XqOTL2GrmI6qe
 LO4Qgwe3oa4I9Wr5CYJ7nf+FNizvb0WCsCQOLQ2pnOOpe57bQ/ck3w8uTo6LlxdAAMrf
 9cDNTJb7heD08la654ZqIdA3m4wqVwkE2TfSzZk0hdWrqIGtsB3Qm5AvHAHSh9xUX+5y
 48zipgUTasJF4JXa9uW/2YjQgag6duDl3fn4LeEN8AOrirH0Peq/Nq+1t6ltkdRAlJYM
 nV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c9/jSKEYWvjLYNnnhLPXkny4KyJtY1E3bTqXKWbpe38=;
 b=E1ENNxgB4ge7YBgbu2iPMHnEVbEf89acweCYyvnYs/PK5bPaMbsbnH9fsYyCfND/Vi
 JuPvzShpgOHjB4wOlY8BjQCoGJ57zixlizXlyeLc2iLtaNDZxd2GbKkTH9w7sAs8F00B
 9nLnHD0/XyfSSbcOx2ntZtaCtNqKQa0Eqtd7difPSwWR6TkbkHBUihik0+OXOfxFFgxX
 tG6rJo+Phs7w0sylFA0d2bcntgxR2zUHhbAkby0Gf9x6BaKUjfL31umnd6+GvJQj6aeG
 qwksm3BdlhVnQrw01R4GMsSuG6fhp/Yub+ysxLKmRYwV8ObNzzVS4GgYLwf1rMiOycd6
 CXnw==
X-Gm-Message-State: AOAM530ODmiEB/Om7aL5sDNN2Gh3TlKfcEv4ibBR/5EjW6XHNqirZiMw
 j6T1RRxxiHcwYVGLEblfdlUws+pOYU/JnMh2m1wUJg==
X-Google-Smtp-Source: ABdhPJyEyS19l/rBk/OtEhxkYjWkowMwfjtY+zPzabBZVyeCZ2VNTvSFAtUJyFOigXbcTktkrJa6rpE3ZN3Azh4mQq8=
X-Received: by 2002:a9d:6e09:0:b0:5ad:1fcd:bfd0 with SMTP id
 e9-20020a9d6e09000000b005ad1fcdbfd0mr22496944otr.312.1646399804477; Fri, 04
 Mar 2022 05:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20220222120054.400208-4-andrew@daynix.com>
 <202202230342.HPYe6dHA-lkp@intel.com>
 <20220304030742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220304030742-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Fri, 4 Mar 2022 15:09:02 +0200
Message-ID: <CABcq3pF9566uzh2oQF1u8EF_LgFQ0azhzD+2xX4CfqB=MhKCOQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drivers/net/virtio_net: Added RSS hash report.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
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
Yes, I'll prepare a new commit later.

On Fri, Mar 4, 2022 at 10:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 03:15:28AM +0800, kernel test robot wrote:
> > Hi Andrew,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on mst-vhost/linux-next]
> > [also build test WARNING on net/master horms-ipvs/master net-next/master linus/master v5.17-rc5 next-20220217]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
>
>
> Andrew,
> do you plan to fix this?
>
> > url:    https://github.com/0day-ci/linux/commits/Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> > config: i386-randconfig-s002-20220221 (https://download.01.org/0day-ci/archive/20220223/202202230342.HPYe6dHA-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://github.com/0day-ci/linux/commit/4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Andrew-Melnychenko/RSS-support-for-VirtioNet/20220222-200334
> >         git checkout 4fda71c17afd24d8afb675baa0bb14dbbc6cd23c
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> >    drivers/net/virtio_net.c:1160:25: sparse: sparse: restricted __le16 degrades to integer
> > >> drivers/net/virtio_net.c:1178:35: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] hash @@     got restricted __le32 const [usertype] hash_value @@
> >    drivers/net/virtio_net.c:1178:35: sparse:     expected unsigned int [usertype] hash
> >    drivers/net/virtio_net.c:1178:35: sparse:     got restricted __le32 const [usertype] hash_value
> >
> > vim +1178 drivers/net/virtio_net.c
> >
> >   1151
> >   1152        static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >   1153                                        struct sk_buff *skb)
> >   1154        {
> >   1155                enum pkt_hash_types rss_hash_type;
> >   1156
> >   1157                if (!hdr_hash || !skb)
> >   1158                        return;
> >   1159
> >   1160                switch (hdr_hash->hash_report) {
> >   1161                case VIRTIO_NET_HASH_REPORT_TCPv4:
> >   1162                case VIRTIO_NET_HASH_REPORT_UDPv4:
> >   1163                case VIRTIO_NET_HASH_REPORT_TCPv6:
> >   1164                case VIRTIO_NET_HASH_REPORT_UDPv6:
> >   1165                case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> >   1166                case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> >   1167                        rss_hash_type = PKT_HASH_TYPE_L4;
> >   1168                        break;
> >   1169                case VIRTIO_NET_HASH_REPORT_IPv4:
> >   1170                case VIRTIO_NET_HASH_REPORT_IPv6:
> >   1171                case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> >   1172                        rss_hash_type = PKT_HASH_TYPE_L3;
> >   1173                        break;
> >   1174                case VIRTIO_NET_HASH_REPORT_NONE:
> >   1175                default:
> >   1176                        rss_hash_type = PKT_HASH_TYPE_NONE;
> >   1177                }
> > > 1178                skb_set_hash(skb, hdr_hash->hash_value, rss_hash_type);
> >   1179        }
> >   1180
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
