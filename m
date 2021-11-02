Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26917C433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 08:21:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA6D61050
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 08:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCA6D61050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 908CA60727;
	Tue,  2 Nov 2021 08:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIqbwD9mWxWQ; Tue,  2 Nov 2021 08:21:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 512956067B;
	Tue,  2 Nov 2021 08:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28A4FC0012;
	Tue,  2 Nov 2021 08:21:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 170D8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05B924024D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0UssZ1R4FVb5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:21:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BF304023D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:21:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uuj7dJC_1635841264; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Uuj7dJC_1635841264) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 02 Nov 2021 16:21:04 +0800
MIME-Version: 1.0
message-id: <1635840699.2088509-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v2 1/3] virtio: cache indirect desc for split
date: Tue, 02 Nov 2021 16:11:39 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <1635834939.2225456-2-xuanzhuo@linux.alibaba.com>
x-mailing-list: netdev@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

On Tue, 02 Nov 2021 14:35:39 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Sun, 31 Oct 2021 10:46:12 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Oct 28, 2021 at 06:49:17PM +0800, Xuan Zhuo wrote:
> > > In the case of using indirect, indirect desc must be allocated and
> > > released each time, which increases a lot of cpu overhead.
> > >
> > > Here, a cache is added for indirect. If the number of indirect desc to be
> > > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > What bothers me here is what happens if cache gets
> > filled on one numa node, then used on another?
>
> Well, this is a good question, I didn't think about it before.
>
> In this way, I feel that using kmem_cache_alloc's series of functions is a good
> solution. But when I tested it before, there was no improvement. I want to study
> the reasons for this, and hope to solve this problem.
>
> In addition, regarding the use of the kmem_cache_alloc_bulk function you
> mentioned, I will also try to see it.


I'm thinking about another question, how did the cross-numa appear here, and
virtio desc queue also has the problem of cross-numa. So is it necessary for us
to deal with the cross-numa scene?

Indirect desc is used as virtio desc, so as long as it is in the same numa as
virito desc. So we can allocate indirect desc cache at the same time when
allocating virtio desc queue.

Of course, we need to solve the problem that rx does not need indirect desc
cache. So it is necessary to set whether to use indirect desc cache based on
pre-queue.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
