Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90278C2BB41
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 06:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AE0360F8E;
	Wed, 17 Aug 2022 06:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AE0360F8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVGP9Nqs_F2m; Wed, 17 Aug 2022 06:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9DD160AB0;
	Wed, 17 Aug 2022 06:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9DD160AB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81026C0033;
	Wed, 17 Aug 2022 06:47:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10D9AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1F834198E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1F834198E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pq6yZkSH3XSu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:47:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4487F41981
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4487F41981
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 06:47:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0VMUSyp1_1660718846; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VMUSyp1_1660718846) by smtp.aliyun-inc.com;
 Wed, 17 Aug 2022 14:47:27 +0800
Message-ID: <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
Subject: Re: upstream kernel crashes
Date: Wed, 17 Aug 2022 14:36:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Dmitry Vyukov <dvyukov@google.com>
References: <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
 <20220815170444-mutt-send-email-mst@kernel.org>
 <20220817061359.200970-1-dvyukov@google.com>
In-Reply-To: <20220817061359.200970-1-dvyukov@google.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, mst@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, torvalds@linux-foundation.org,
 edumazet@google.com, netdev@vger.kernel.org, c@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, andres@anarazel.de, davem@davemloft.net, linux@roeck-us.net
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

On Wed, 17 Aug 2022 08:13:59 +0200, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, 15 Aug 2022 17:32:06 -0400, Michael wrote:
> > So if you pass the size parameter for a legacy device it will
> > try to make the ring smaller and that is not legal with
> > legacy at all. But the driver treats legacy and modern
> > the same, it allocates a smaller queue anyway.
> >
> > Lo and behold, I pass disable-modern=on to qemu and it happily
> > corrupts memory exactly the same as GCP does.
>
> Ouch!
>
> I understand that the host does the actual corruption,
> but could you think of any additional debug checking in the guest
> that would caught this in future? Potentially only when KASAN
> is enabled which can verify validity of memory ranges.
> Some kind of additional layer of sanity checking.
>
> This caused a bit of a havoc for syzbot with almost 100 unique
> crash signatures, so would be useful to catch such issues more
> reliably in future.

We can add a check to vring size before calling vp_legacy_set_queue_address().
Checking the memory range directly is a bit cumbersome.

Thanks.

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..0673831f45b6 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -146,6 +146,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
                goto out_del_vq;
        }

+       BUG_ON(num != virtqueue_get_vring_size(vq));
+
        /* activate the queue */
        vp_legacy_set_queue_address(&vp_dev->ldev, index, q_pfn);


>
> Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
