Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8D10A25
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42F4282835
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42F4282835
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZIyFf73b7FG
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 07:46:33 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 106E682560
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 106E682560
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vxx8ynw_1701848787;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vxx8ynw_1701848787)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 15:46:28 +0800
Message-ID: <1701848771.9471674-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce virtqueue_detach_unused_buf_premapped
Date: Wed, 6 Dec 2023 15:46:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
 <20231204072331.73776-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEuayLkkZ-6rs3k_WfJAF_yXcWjA-vGiS+Zcgcdaz86geA@mail.gmail.com>
In-Reply-To: <CACGkMEuayLkkZ-6rs3k_WfJAF_yXcWjA-vGiS+Zcgcdaz86geA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 5 Dec 2023 15:12:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > introduce virtqueue_detach_unused_buf_premapped() to collect the dma
> > info when get buf from virtio core for premapped mode.
>
> For consistency, shouldn't we call it detach_unused_buf_dma()?

Will fix.

Thanks.

>
> Thanks
>
