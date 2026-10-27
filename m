Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112024;
	b=R/WnNO8iornZmQvVYryeKgLTmDzwXHqrnPALpL+7XBWbKmo3o4C9gAPEM0YjRnh9aFKh
	 OaxRphmQGCSUS/vTxopTh6wbqLtXlBL1xmeT3n86I++XKdo0l5Bh4wHz00/itfmYd5wt9
	 wGfjGa89EnRGWBgTNW1/CaxkGGtlThIpb74dD4XFxEk3kkoQLT4HzFnwIloGnPVs6bJsD
	 XlhG1F1DXPttDPiGr9uAfy2McQU5qdEbUWibw84OkfTby/yYNR8fNV52s+nEGLBO1dutv
	 yd7Wp5dwU0qWxrDAlqosS8mss/iRWecvKy72eLyqmaJFr1btVQZYi/NyNoFporQ0JBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112024;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=oij5R9u5jwh4/DBYefjYkHwJnTbmfc7uF771cLDBnu4=;
	b=yQXiizUfVeb+OVeemyszCFOD7Hp/K0ArZxijei3EwnIax/CiRcywgLyoqoWlejAQbxkT
	 3UFi16vTww0+dt/vqymoPPCOxyr8Z7QPdX7cLDOTy9qJAKpEz4PwtlFn5FVkFfSyqPCwn
	 LWWArNDkX39P/oNyCpMhO6vYwXZmguHdlpzIuh6r12YtH05Z0zFWJU52bZNI8ecppZkXq
	 ANhtWL0OGPo38popVK1Wi0oN8IxQWJWPxXp6riR7FBkDRXAmyWIuldDzaN0zxjUVCUt9D
	 vi3dxV/rQio+soZ7RxeEJj0N2m9C+qHoNhaGo2bfIjOo399yFzOIb4OIbiyKeNY1ORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=a0yTAHFU;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEC606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 14:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EEC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=a0yTAHFU
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDn3T82963327;
	Tue, 27 Oct 2026 07:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=oij5R9u5jwh4/DBYefjYkHwJnTbmfc7uF771c
	LDBnu4=; b=a0yTAHFU2WIeU4w0eMtmQlZGWCQZ0NDOsvBhYVi399UhhDULN3U9r
	FYTBjDqdvzoKpC12IomKzon0D8mzqJNQQo1H+JLYFFkGpqQF8n/LNlQd0faTfGlR
	+Yb3gl25aAONMIuwL8NnjXOeOXfweNlQ9AKY08fZuLqucBWe33W+W16/4TeUsXuJ
	K2GSVNFv/cMn84f6IdQY2loTlF4PI1VJdIGKyYaWcqu/S2wrYHsFCRcA54lciY3u
	1z/olW8Oo7tYuRNqbmuZOeaJLVdIh6E3DpkUPdwAuAIFjq4Puz1y+YxCCKaa0jbu
	m7tiU0aRwIB3BQJu27qwXwUKmZEz7VKFg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjs1fhuf0-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 27 Oct 2026 07:40:05 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 27 Oct
 2026 14:40:04 +0000
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
Date: Tue, 27 Oct 2026 07:39:57 -0700
Message-ID: <20261027143957.630549-1-hruben@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027083627-mutt-send-email-mst@kernel.org>
References: <20261027083627-mutt-send-email-mst@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXy11384covHi8
 or6arLng9iheIEjyQYhhphMe4iHnefCyQjy1zi4g1Gm+wxP4pPDw2RQb1TjgmwW8rxE9pzsG2Ht
 tKilFpwrzrc/bxmrcx4mnyGODY2VwEf6Qyj1QhhW8isKJHhTLn2IxyNSOqPBbH0UzJgD1xze/r6
 9C45yIMxHbyCwy6+GsDtx8XIelW5amVz3O+DKRF9t89oLlaDQ8I8YqSRt/BDF0isUEXFSxWxban
 nl3sgn0/iZVo580yfPR2fBu72/ToGBXMz+g8r5uSOgt/O2V/dEF8OZNVL7+YtMefuBlUzeN0B9H
 UuXcCjO50kuTRcAuBPXjtAmUolkrweugEw3WO2fG5cODIbuy3k5EBs1GJ2oZ+ndZCc/8S+MRlKa
 QfOhxbRQfcBvs7WCTqebTBoQTcgoSXoLjcV/FStBgePr+T6qe/16HJgpJK3Dc6fCfpvL2jrFl5E
 jSJI+DYKkqcPX5WgnQQ==
X-Proofpoint-GUID: 8eGS3lxKv7CyX1l3giyNomw5nlk8hF2I
X-Proofpoint-ORIG-GUID: 8eGS3lxKv7CyX1l3giyNomw5nlk8hF2I
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6ae0b7c5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8
 a=nzaXTY8-YBXO8wDHTwIA:9 a=zY0JdQc1-4EAyPf5TuXT:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX8iJJWI4MREEk
 DsNjOoQl2iD0gzYmsAM34/ZZuuBpRNOBYgz1nGnCsR+Yi2gRGiTf/71SKB2FsGJ8IvAARCiuDrF
 CxaxTO14cL9dTuc3sjTPhc8z12Z2lAE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01

On Tue, Oct 27, 2026 at 12:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Oct 27, 2026 at 05:32:04AM -0700, Ruben Hakobyan wrote:
> > On Tue, Oct 27, 2026 at 10:35 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Tue, Oct 27, 2026 at 02:26:33AM -0700, Ruben Hakobyan wrote:
> > > > On Mon, Oct 26, 2026 at 11:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > > > to the VMM so it may discard unused pages.
> > > > >
> > > > > For an arm64 kernel with 64 KiB pages, the default reporting and
> > > > > allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> > > > > report contains a sufficient number of large entries, we will end up
> > > > > with a descriptor chain that represents over 4 GiB of memory. This
> > > > > violates virtio spec, which says:
> > > > >         Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> > > > >
> > > > > Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> > > > >
> > > > > Submit each reported page as a separate virtqueue buffer instead of one
> > > > > buffer with an sg list of all pages.  This also avoids indirect
> > > > > descriptor allocation (kmalloc in the reporting path).
> > > > >
> > > > > To avoid multiple buffers causing interrupt storms, keep callbacks
> > > > > disabled while we wait for an event.
> > > > >
> > > > > TODO: as an alternative, keep using virtqueue_enable_cb_delayed
> > > > > but add buffers after there's space in the ring.
> > > > >
> > > > > Note: if the virtqueue is broken, wait_event on
> > > > > virtqueue_get_buf hangs.  This is a pre-existing issue:
> > > > > the old single-buffer code had the same hang.
> > > > >
> > > > > Reported-by: Ruben Hakobyan <hruben@meta.com>
> > > > > Cc: Ruben Hakobyan <hruben@meta.com>
> > > > > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > > > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >
> > > > > Notes (changelog):
> > > > >     changes since v1:
> > > > >         keep callbacks disabled while draining: get_buf re-arms the used
> > > > >         event for the next buffer, reintroducing an interrupt per page.
> > > > >         Disable the reporting vq callbacks at probe, and only arm the
> > > > >         delayed callback to wait.
> > > > >
> > > >
> > > > Thanks for the patches! I think sashiko-bot found some issues on broken
> > > > queues in the first patch that are worth looking into for correctness.
> > >
> > > Surprise removal of the balloon? Nope, it's a pre-existing issue that
> > > it's broken.  Besides it's not really practical, no one removes
> > > the balloon - no need.
> >
> > Fair point about that. But I meant the broken queue check.
> > In virtqueue_enable_cb_delayed() there is:
> > ```
> > /*
> >  * When the device is broken there is no point in polling used->idx,
> >  * the backend will never update it. Return true to let callers
> >  * exit their cleanup loops instead of spinning forever.
> >  */
> > if (unlikely(vq->broken))
> >     return true;
> > ```
> >
> > But virtqueue_enable_cb_delayed_max() doesn't have this. So I was just
> > thinking the same reasoning should apply here?
>
> It's broken there, too.  E.g. what is the "cleanup loop" in balloon?

The loop in virtballoon_free_page_report():
```
wait_event(vb->acked, ({
    for (;;) {
        virtqueue_disable_cb(vq);
        while (virtqueue_get_buf(vq, &unused))
            i++;

        /* Stop waiting if device used all that we added. */
        if (i >= nents)
            break;

        if (virtqueue_enable_cb_delayed_max(vq))
            break;
    }
    i >= nents;
}));
```

For a broken queue, you could exit the for loop early and avoid busy looping.
It still hangs, but I think it can sleep rather than busy loop?

Anyway, I'm not sure how practical a broken queue is, so I don't have a
strong opinion.

>
> > >
> > > > Other than that, I tested the "normal path" on QEMU and Cloud Hypervisor,
> > > > both on 4 KiB and 64 KiB guests, and this works correctly.
> > >
> > > Thanks a lot! Can you pls confirm whether the performance is about the
> > > same/better/worse?
> >
> > >From my tests on QEMU, CPU time was about the same as my original patch
> > and unmodified Linux.
> >
> > To bring a concrete example, with these patches it took ~437 ms of CPU to
> > reclaim a whole 8 GiB with 4 KiB pages (vs ~434 ms on unmodified Linux).
>
> OK so that's just noise, there's no difference.
>
> >
> > With 64 KiB pages, it averaged 121 ms CPU (vs ~112 ms with my original
> > patch).
>
> Is this measurable, or also noise?
>
> >
> > (I tested this on Nvidia Grace)
>
>
> Thanks!

Thanks, yeah I agree and my point was that performance looks on par.
I just wanted to share some concrete numbers of what I've tested.

>
> > >
> > > --
> > > MST
> > >
>

