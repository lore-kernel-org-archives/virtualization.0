Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0003C433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 15:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C72040192;
	Fri, 18 Feb 2022 15:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 949sjjv5UErO; Fri, 18 Feb 2022 15:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 754E040110;
	Fri, 18 Feb 2022 15:44:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55397C0011;
	Fri, 18 Feb 2022 15:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55411C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D3A2611A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ih3s_ZivtYUd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:43:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C7C3611A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:43:59 +0000 (UTC)
Received: by mail-vk1-xa36.google.com with SMTP id j9so5069716vkj.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 07:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZlNKOu+PC57cWSc9B8bT89/4L+VjMA7vIqhUEFRfco4=;
 b=A5pZd2CbfalKIrQ8Zz9VDALtD8d0Ppxdsa3oKI8TWnym/Jq71tJqV/zLFLqHw1TCfL
 Jnb30zQNSzXZ520Ak7J0JDNC/yND2NIuEY+vYEYpzNHBAkEi5q7SGZ8gyd9SsseC3DUY
 4+/oN3cZhkbPvFl9P/+iAQVAV5+ACUKiF29y3QzCzJL1zk+CKI/GCDooNzXIfjuuNg0A
 eNm7aEjnd2GPMbwdT0IA4nFSMUGbecguG8fpB25GkrFoZFY0VAbtO6MNcK9k4M/7zksj
 tPQmGRwkwaxPerUdlxUj43PPiQfW7/crp2j6XSzi261L87ckszK0zb24UvQVZAc0WeD8
 sYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlNKOu+PC57cWSc9B8bT89/4L+VjMA7vIqhUEFRfco4=;
 b=UnEf8fyFc30qGCC0VG2Uwip4rrJT5JmlDCkC8U5xbYb5dsVx5nyxl/QUWyJB13fTB1
 xEHW1OqIrh0m5chvZI27A9eiqXKuajFCeZpki2iWux5vz26Z0WGETKMoXkszkvQ2Xd7C
 5psgVynMsOPI81IGJD1IsPZ3IQiSMX02z8P+VqZMxxbq4EAAGByEZjIzxH6Vok81BKyi
 fHiatWjhibV/fKb4VsSGEyeQOCHMym6y7QNKDRORQ2wGM04TRTO7pL3fVMD0Oqy+2yH6
 BvRESAnxBcReZkoKlLcf3NSC+ARJECMders1zY3CQj384QZ5JHDxISjfzxTkKQaSh+37
 /wiw==
X-Gm-Message-State: AOAM530ZecpxggFr2FA5gH2YaPl7LHhaeC8KwYdI4QqYmrpTBPfMTAXw
 qv6K0FJ54puhirghoFniaGkIUALufYc=
X-Google-Smtp-Source: ABdhPJzkZZbp6nea24olbqNK0v2D2mQDfXEE4HGgG8ooeSxvZY43PzJy/Wo4oYpLUKp5o8MC7wceLg==
X-Received: by 2002:a1f:19c2:0:b0:331:5940:6bb0 with SMTP id
 185-20020a1f19c2000000b0033159406bb0mr2888639vkz.9.1645199038074; 
 Fri, 18 Feb 2022 07:43:58 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172])
 by smtp.gmail.com with ESMTPSA id j63sm5199519vkj.24.2022.02.18.07.43.56
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Feb 2022 07:43:57 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id j12so5088886vkr.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 07:43:56 -0800 (PST)
X-Received: by 2002:a05:6122:788:b0:331:2063:3645 with SMTP id
 k8-20020a056122078800b0033120633645mr3858580vkr.10.1645199036123; Fri, 18 Feb
 2022 07:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20220208181510.787069-1-andrew@daynix.com>
 <20220208181510.787069-3-andrew@daynix.com>
 <CA+FuTSfPq-052=D3GzibMjUNXEcHTz=p87vW_3qU0OH9dDHSPQ@mail.gmail.com>
 <CABcq3pFLXUMi3ctr6WyJMaXbPjKregTzQ2fG1fwDU7tvk2uRFg@mail.gmail.com>
 <CA+FuTSfJS6b3ba7eW_u4TAHCq=ctpHDJUrb-Yc3iDwpJHHuBMw@mail.gmail.com>
 <CABcq3pE9ewELP0xW-BxFCjTUPBf9LFzmde4tMf1Szivb8nMp7g@mail.gmail.com>
In-Reply-To: <CABcq3pE9ewELP0xW-BxFCjTUPBf9LFzmde4tMf1Szivb8nMp7g@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 18 Feb 2022 08:43:20 -0700
X-Gmail-Original-Message-ID: <CA+FuTScisEyVdMcK2LJHnT8TTmduPqs20_7SzukkP_OYDEQpwA@mail.gmail.com>
Message-ID: <CA+FuTScisEyVdMcK2LJHnT8TTmduPqs20_7SzukkP_OYDEQpwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drivers/net/virtio_net: Added basic RSS support.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

On Thu, Feb 17, 2022 at 12:05 PM Andrew Melnichenko <andrew@daynix.com> wrote:
>
> Hi all,
>
> On Mon, Feb 14, 2022 at 12:09 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > > > > @@ -3113,13 +3270,14 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >         u16 max_queue_pairs;
> > > > >         int mtu;
> > > > >
> > > > > -       /* Find if host supports multiqueue virtio_net device */
> > > > > -       err = virtio_cread_feature(vdev, VIRTIO_NET_F_MQ,
> > > > > -                                  struct virtio_net_config,
> > > > > -                                  max_virtqueue_pairs, &max_queue_pairs);
> > > > > +       /* Find if host supports multiqueue/rss virtio_net device */
> > > > > +       max_queue_pairs = 1;
> > > > > +       if (virtio_has_feature(vdev, VIRTIO_NET_F_MQ) || virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> > > > > +               max_queue_pairs =
> > > > > +                    virtio_cread16(vdev, offsetof(struct virtio_net_config, max_virtqueue_pairs));
> > > >
> > > > Instead of testing either feature and treating them as somewhat equal,
> > > > shouldn't RSS be dependent on MQ?
> > >
> > > No, RSS is dependent on CTRL_VQ. Technically RSS and MQ are similar features.
> >
> > RSS depends on having multiple queues.
> >
> > What would enabling VIRTIO_NET_F_RSS without VIRTIO_NET_F_MQ do?
>
> RSS would work.

What does that mean, exactly? RSS is load balancing, does that not
require multi-queue?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
