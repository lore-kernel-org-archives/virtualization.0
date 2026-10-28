Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199990;
	b=Dy3FpKUELLZRKSRT+fcI2qUK8Wbyk2qZzwEaMoUouUmsCJJnw96kkixvY9TrH7rMIZYi
	 tWmEKZD3lVm5AXL4DUNxd7b0SGgDUQ5tJcrX/tgPVYgrJFdwlHGP4LcP+KKtj7MQ+NIH0
	 zeYNReEtz7YWZ5cKtj3xnUO/bYqnWfvbYzMH6wOl/7frrsp/o+q/LoO/flf54SMCglLH3
	 h4lysSPf9oILH0U4WQOd/cBDSFRjSdARvD6XxUSbIdOKIDNFoQz7on7+P19BCXlTFjPVE
	 21hVeXGvxM5sXVY1gAreCnAGtpqnYSh0dQH3pGzNIsYDHn2J7q4LR76R4vA94G4syMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version;
	bh=n/akRagARDR+fJNDGCNVlhTugTuQn/VjpXfX2Yd9MwA=;
	b=MkOY8zPhGdLMhFkN+TiTFjt3c9SlcU8E0PoAnT/H67V/4agsGJ+3Dt++Bf5f8Q+n9rcL
	 akWM+4Hao3iEWa9uOHERAfm2lspebxFlYwZ3KvD+IPgFJnNLoVinzpOpbGKut6r/9lDgu
	 zqVHy4/zVM9c+UCrkdC0cwKc2VVXU2YW/9akEB8MEWotIFMxMMd2XxDDx3z6b7uBh6c+/
	 HfDUg/s6Q5+Av5/senf6s+PymyE3selV8TOHsw2Dpm/BW6LwS3sPl90QOjxHCZ609OhLj
	 dr3GB9uIibB0ORn190F2zWVKRE4q4etELIeYDZMUyx32X8QV098SapL05c1qsS0ns1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=VdMneMI8;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92E606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A92E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=VdMneMI8
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBdEXx271934;
	Wed, 28 Oct 2026 08:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=n/akRagARDR+fJNDGCNVlhTugTuQn/VjpXfX2
	Yd9MwA=; b=VdMneMI8O6wlNE0BYQWv2NoN0sywdAR3S3qF8UBQ8uoKgjLfzXI36
	RMZoTPIpxHlgSe6OFVIofncfkaP6dZg/yjYK+MHsXD9WsedwgWQsgbiUgX/Fx8PR
	qLZHqFn8ZseF9U+0o/daa6VpHQbi6IRGKq00BWh8A0tlTUGbn0arN/jSorQdkR4e
	yyNWRof6oFLsVTSYAOG9elDCeBd2Mu2fsBvPhQbT24uswO4mzB+LjIZMOBHtWJFX
	aPIw7LPrE/wCSUg4UEXrkJNKyLCqxM7GTBVm2z8UJTrCOEzqzZjhohl43rFyap+B
	vBTE/TFyyrgyySC4gpZbsk2RDm8SU0WYw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjtuxtajc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Oct 2026 08:06:14 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 28 Oct
 2026 15:06:13 +0000
From: Ruben Hakobyan <hruben@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        <virtualization@lists.linux.dev>,
        Alexander Duyck
	<alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=
	<bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas
 Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] virtio_balloon: submit reported pages as individual buffers
Date: Wed, 28 Oct 2026 08:06:04 -0700
Message-ID: <20261028150604.201665-1-hruben@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027151329-mutt-send-email-mst@kernel.org>
References: <20261027151329-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZfxisLPKC3cRY4cfMcbSSv6NtTSdYeJP
X-Proofpoint-ORIG-GUID: ZfxisLPKC3cRY4cfMcbSSv6NtTSdYeJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX3uw6g7EPuwTM
 DibcRf8vVekPYTCzK4F1FwprinlUAm2GvLCsElTH9/XLSPG76R1GpMh9dqJMzeKzG13H734fbyK
 cdgB5LvW5bK3FGvBO7w1K+oDLVN64AnUFIydsatNvMejfQn89d6vFGdCWFE5g4ibvNnwzSBRx+s
 4rihRJuV5LVx21l+s+z/w8dDR4vPznXi5VyrZmbWBEnD6FRFtN/K3sBZHdqSpRu1JdWgDoIl7Rn
 gB8rJg7ZMM0EwHJ6X08zQmvftSozabHDdCfdy0b2jD97rWVQGfIXrQFQjnhXyjWMIVns7i9Rixa
 YC/URyFdURSsyrY/2XsShIEF2npHlQB8vLiT3jQpuDsu3ZwNZT9gd8URJsD14ejifRJk3C8K4Hd
 KT7kIVJQQzB43NAjWK2n+oIQz0M7WC61UNDDLCQkbnAoOeZv5czGcu9BEtoRVq/GbNrP4oTfx7l
 UlkmkQaACkJQuuh+Zeg==
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ae20f66 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8
 a=phoES-eJUOR2wqcIftMA:9 a=zY0JdQc1-4EAyPf5TuXT:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX2yMZgPBxzOCj
 mzZQH+ps0TPtroxNBzRJXHfpA529N1imxSDKw8IIWlYm8hu0fgoGAaSevkp9noOq9P8X+jxaP2A
 eYzBB2S6JV1g34zNFsbiVhxf3LlXoxM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01

On Tue, Oct 27, 2026 at 7:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Oct 27, 2026 at 07:39:57AM -0700, Ruben Hakobyan wrote:
> > On Tue, Oct 27, 2026 at 12:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Tue, Oct 27, 2026 at 05:32:04AM -0700, Ruben Hakobyan wrote:
> > > > On Tue, Oct 27, 2026 at 10:35 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Tue, Oct 27, 2026 at 02:26:33AM -0700, Ruben Hakobyan wrote:
> > > > > > On Mon, Oct 26, 2026 at 11:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > > > > > to the VMM so it may discard unused pages.
> > > > > > >
> > > > > > > For an arm64 kernel with 64 KiB pages, the default reporting and
> > > > > > > allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> > > > > > > report contains a sufficient number of large entries, we will end up
> > > > > > > with a descriptor chain that represents over 4 GiB of memory. This
> > > > > > > violates virtio spec, which says:
> > > > > > >         Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> > > > > > >
> > > > > > > Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> > > > > > >
> > > > > > > Submit each reported page as a separate virtqueue buffer instead of one
> > > > > > > buffer with an sg list of all pages.  This also avoids indirect
> > > > > > > descriptor allocation (kmalloc in the reporting path).
> > > > > > >
> > > > > > > To avoid multiple buffers causing interrupt storms, keep callbacks
> > > > > > > disabled while we wait for an event.
> > > > > > >
> > > > > > > TODO: as an alternative, keep using virtqueue_enable_cb_delayed
> > > > > > > but add buffers after there's space in the ring.
> > > > > > >
> > > > > > > Note: if the virtqueue is broken, wait_event on
> > > > > > > virtqueue_get_buf hangs.  This is a pre-existing issue:
> > > > > > > the old single-buffer code had the same hang.
> > > > > > >
> > > > > > > Reported-by: Ruben Hakobyan <hruben@meta.com>
> > > > > > > Cc: Ruben Hakobyan <hruben@meta.com>
> > > > > > > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > > > > > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes (changelog):
> > > > > > >     changes since v1:
> > > > > > >         keep callbacks disabled while draining: get_buf re-arms the used
> > > > > > >         event for the next buffer, reintroducing an interrupt per page.
> > > > > > >         Disable the reporting vq callbacks at probe, and only arm the
> > > > > > >         delayed callback to wait.
> > > > > > >
> > > > > >
> > > > > > Thanks for the patches! I think sashiko-bot found some issues on broken
> > > > > > queues in the first patch that are worth looking into for correctness.
> > > > >
> > > > > Surprise removal of the balloon? Nope, it's a pre-existing issue that
> > > > > it's broken.  Besides it's not really practical, no one removes
> > > > > the balloon - no need.
> > > >
> > > > Fair point about that. But I meant the broken queue check.
> > > > In virtqueue_enable_cb_delayed() there is:
> > > > ```
> > > > /*
> > > >  * When the device is broken there is no point in polling used->idx,
> > > >  * the backend will never update it. Return true to let callers
> > > >  * exit their cleanup loops instead of spinning forever.
> > > >  */
> > > > if (unlikely(vq->broken))
> > > >     return true;
> > > > ```
> > > >
> > > > But virtqueue_enable_cb_delayed_max() doesn't have this. So I was just
> > > > thinking the same reasoning should apply here?
> > >
> > > It's broken there, too.  E.g. what is the "cleanup loop" in balloon?
> >
> > The loop in virtballoon_free_page_report():
> > ```
> > wait_event(vb->acked, ({
> >     for (;;) {
> >         virtqueue_disable_cb(vq);
> >         while (virtqueue_get_buf(vq, &unused))
> >             i++;
> >
> >         /* Stop waiting if device used all that we added. */
> >         if (i >= nents)
> >             break;
> >
> >         if (virtqueue_enable_cb_delayed_max(vq))
> >             break;
> >     }
> >     i >= nents;
> > }));
> > ```
> >
> > For a broken queue, you could exit the for loop early and avoid busy looping.
> > It still hangs, but I think it can sleep rather than busy loop?
> >
> > Anyway, I'm not sure how practical a broken queue is, so I don't have a
> > strong opinion.
>
> Maybe add the broken queue check explicitly then, then it does
> not need to hang:
>
> if (virtqueue_is_broken(vq))
>         i = nents;
>

Ah yeah, indeed that would avoid the hang on the broken queue.

>
> but the issue is what if queue gets broken while we are waiting.
>

Hmm, yeah I see. I guess that's already outside of scope here.

>
> > >
> > > > >
> > > > > > Other than that, I tested the "normal path" on QEMU and Cloud Hypervisor,
> > > > > > both on 4 KiB and 64 KiB guests, and this works correctly.
> > > > >
> > > > > Thanks a lot! Can you pls confirm whether the performance is about the
> > > > > same/better/worse?
> > > >
> > > > >From my tests on QEMU, CPU time was about the same as my original patch
> > > > and unmodified Linux.
> > > >
> > > > To bring a concrete example, with these patches it took ~437 ms of CPU to
> > > > reclaim a whole 8 GiB with 4 KiB pages (vs ~434 ms on unmodified Linux).
> > >
> > > OK so that's just noise, there's no difference.
> > >
> > > >
> > > > With 64 KiB pages, it averaged 121 ms CPU (vs ~112 ms with my original
> > > > patch).
> > >
> > > Is this measurable, or also noise?
> > >
> > > >
> > > > (I tested this on Nvidia Grace)
> > >
> > >
> > > Thanks!
> >
> > Thanks, yeah I agree and my point was that performance looks on par.
> > I just wanted to share some concrete numbers of what I've tested.
>
> Thanks a lot!

Thanks again for the patches and for looking into this!

>
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >

