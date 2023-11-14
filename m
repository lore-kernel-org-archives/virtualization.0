Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CDB668
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB9E081F68
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB9E081F68
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEL8iAR_3MLL
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 03:59:09 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4AA7381F66
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AA7381F66
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwNzpiL_1699934341;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwNzpiL_1699934341)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 11:59:02 +0800
Message-ID: <1699934262.516097-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
Date: Tue, 14 Nov 2023 11:57:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
 <1699527528.5637772-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu4toAuAuJdrXF0AJqsHc-ovPg3vi8=My-+BxaMi+TBSw@mail.gmail.com>
 <1699932516.9040368-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv7-U4HNe8UOENx9A+5fj-GJ7wvO=aw8v+axoiG7yhqdA@mail.gmail.com>
In-Reply-To: <CACGkMEv7-U4HNe8UOENx9A+5fj-GJ7wvO=aw8v+axoiG7yhqdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 14 Nov 2023 11:55:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Nov 14, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Tue, 14 Nov 2023 11:26:42 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Nov 9, 2023 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > On Thu, 9 Nov 2023 14:37:38 +0800, Jason Wang <jasowang@redhat.com>=
 wrote:
> > > > > On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > > So the send queue must support premapped mode.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++=
++++----
> > > > > >  drivers/net/virtio/virtio_net.h |  16 ++++
> > > > > >  2 files changed, 163 insertions(+), 16 deletions(-)
> > > > > >
>
> [...]
>
> > > > >
> > > > > I think we need to seek a way to reuse what has been stored by vi=
rtio
> > > > > core. It should be much more efficient.
> > > >
> > > >
> > > > Yes.
> > > >
> > > > But that is for net-next branch.
> > > >
> > > > Can we do that as a fix after that is merged to 6.8?
> > >
> > > We still have time. I would like to do it from the start.
> >
> >
> > I want to finish the job including new AF_XDP ZC feature.
> > Because that this must wait the merge window.
> > Base on that, the optimizing work can be done everytime.
> >
> > If we work from the new virtio prepare, that can be merged to 6.8.
> > And the AF_XDP zc must wait 6.9. right?
>
> It can be part of this series. Or anything I missed?
>
> My understanding is that, since the information is handy, it just
> requires new helpers. So I don't expect it needs a large series.

Now, this is pushing to net-next.

If we add an new virtio-core helper. That must be pushed to virtio branch.
And this patch set must wait that.

Thanks.


>
> Thanks
>
> >
> > Thanks
> >
>
