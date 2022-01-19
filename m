Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD16FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64DF660EA0;
	Wed, 19 Jan 2022 06:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ShnQqysBf_QD; Wed, 19 Jan 2022 06:33:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3B9B60E97;
	Wed, 19 Jan 2022 06:33:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB59C0039;
	Wed, 19 Jan 2022 06:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40592C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10F72403B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBca9V8TtbS6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6D9840183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:33:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2FlKph_1642573972; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2FlKph_1642573972) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 14:32:52 +0800
MIME-Version: 1.0
message-id: <1642573910.0102613-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 1/6] virtio: pci: struct virtio_pci_common_cfg add
 queue_notify_data
date: Wed, 19 Jan 2022 14:31:50 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEtbfRrUde8-d-yY9fk3CQdK2uCE_mrpO_eEk3JRU1XahA@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, 19 Jan 2022 14:00:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > here https://github.com/oasis-tcs/virtio-spec/issues/89
> >
> > Since I want to add queue_reset after it, I submitted this patch first.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/uapi/linux/virtio_pci.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > index 3a86f36d7e3d..492c89f56c6a 100644
> > --- a/include/uapi/linux/virtio_pci.h
> > +++ b/include/uapi/linux/virtio_pci.h
> > @@ -164,6 +164,7 @@ struct virtio_pci_common_cfg {
> >         __le32 queue_avail_hi;          /* read-write */
> >         __le32 queue_used_lo;           /* read-write */
> >         __le32 queue_used_hi;           /* read-write */
> > +       __le16 queue_notify_data;       /* read-write */
> >  };
>
> Since it's uAPI, do we need another which embed virtio_pci_common_cfg?

If I'm not mistaken, the struct virtio_pci_common_cfg used by
virtio_pci_modern_dev.c is indeed this.

Thanks.

>
> Thanks
>
> >
> >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
