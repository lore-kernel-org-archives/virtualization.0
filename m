Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AA14A9D
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05F3281D0C
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 04:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05F3281D0C
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-wMxdVV2KGN
	for <virtualization@lists.linux-foundation.org>;
	Tue, 21 Nov 2023 04:11:21 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 184F781447
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 04:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 184F781447
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vwr40tm_1700539874;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vwr40tm_1700539874)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 12:11:15 +0800
Message-ID: <1700539804.2826052-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC 2/4] virtio_ring: virtqueue_disable_and_recycle let the callback detach bufs
Date: Tue, 21 Nov 2023 12:10:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
 <20231114113104.33994-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvb1wsmfMh_r8x3FFTCjTx1HXz=-ZZxK9aFMo1ZD6QUDw@mail.gmail.com>
In-Reply-To: <CACGkMEvb1wsmfMh_r8x3FFTCjTx1HXz=-ZZxK9aFMo1ZD6QUDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 16 Nov 2023 16:11:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, inside virtqueue_disable_and_recycle, the recycle() just has two
> > parameters(vq, buf) after detach operate.
> >
> > But if we are in premapped mode, we may need to get some dma info when
> > detach buf like virtqueue_get_buf_ctx_dma().
> >
> > So we call recycle directly, this callback detaches bufs self. It should
> > complete the work of detaching all the unused buffers.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c    | 31 ++++++++++++++++++++++---------
>
> Btw, is it better to do this before the restructure, or anything I missed?


#1 is for get_buf from virtio core.
This is for the next pacth. (get unused buf)

So this is #2.

Thanks.

>
> Thanks
>
