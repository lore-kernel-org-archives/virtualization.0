Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8130C74A5B
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 06:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D835615AD;
	Thu, 30 Mar 2023 06:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D835615AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PBnPeMjRWwbu; Thu, 30 Mar 2023 06:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D3A6C60B9C;
	Thu, 30 Mar 2023 06:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3A6C60B9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA5EDC0037;
	Thu, 30 Mar 2023 06:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A967EC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 787214010D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:01:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 787214010D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6v4ajikupkJ0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E03A3404AA
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E03A3404AA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:01:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VezRvjN_1680156065; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VezRvjN_1680156065) by smtp.aliyun-inc.com;
 Thu, 30 Mar 2023 14:01:06 +0800
Message-ID: <1680156056.4424767-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 16/16] virtio_net: separating the virtio code
Date: Thu, 30 Mar 2023 14:00:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230328092847.91643-17-xuanzhuo@linux.alibaba.com>
 <20230329211552.27efa412@kernel.org>
In-Reply-To: <20230329211552.27efa412@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S.  Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 29 Mar 2023 21:15:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 Mar 2023 17:28:47 +0800 Xuan Zhuo wrote:
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __VIRTNET_VIRTIO_H__
> > +#define __VIRTNET_VIRTIO_H__
> > +
> > +int virtnet_register_virtio_driver(void);
> > +void virtnet_unregister_virtio_driver(void);
> > +#endif
>
> nit: this header needs to be added in the previous patch,
> otherwise there is a transient build warning there.

Will fix.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
