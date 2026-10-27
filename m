Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104390;
	b=cpD4D8w7E9x0DLhNHZQrM72hy57Ua9N5O/b7SSx3oP2ZOljDHLHUgkQoIk/bOOUcW0/h
	 zmYatgBUKOnO0xYBVEcf1jIxv6UM15kBEZgtuRhjEXGtGegrNck2Kg5PH4Op6sV4g6T83
	 B2ynd9ij8DLXHrgzE0IkK007chyG8nXMdhm30k6pJ+iHzu0k+3tghwRCC/2XEGyh+4R4/
	 IzVmY5m6OqKDwdxyAWeQkwAcZBaVf4+nDNUWaTeYqRcNnyjJ6P+oxnt8IxPgcoPIFaGAP
	 DEtV3NASymLJbybErMfbg8P6M+ATAnJ/DJtj0sZyO3D1icmkpEerDWvZEAS83zHaRGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=cpvnpqyqWElW+pe7rciAPazzagEVJT2rta85kTwUfmM=;
	b=oMj46ccFR/ddcz9/c0APrpJsq/aVXxJlqVOAGpmntSfFOepZ/0tPdpzJpauXxRVuTTI7
	 7zodvcMXx/ebnLVQucGnA9ZN/Xjc5eiBhgB1KLeyt/JTOYsnVlACrSdLRnKpMR01Bugbj
	 i3HK6lS10hOMGihN8LdPmeHFbWjULElM2lDlCiIig1BnPAr8J/SB1FzUC1zDr6J3Z2tbz
	 nYP6wEdIngeb0G0O+GBDWyHdLmDHaNSrNN8d1SS1OAag7sjnGZX9aNXjMVqA4e3kjkF8k
	 8sBbf3b2JRlX07syDJTxILuuK5UA0iC7oNPB7bp5KXcOxusTltOUy3sogCNL1tlN42w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ghY3ujiJ;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6C606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 12:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ghY3ujiJ
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R97FVm2395709;
	Tue, 27 Oct 2026 05:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=cpvnpqyqWElW+pe7rciAPazzagEVJT2rta85k
	TwUfmM=; b=ghY3ujiJrCaCpoDlLItJuX81X94pueDAUzUAr1wjWxHzzhB3bz6jf
	okyyabXRHMZ/SfC9pmefOoRTi9pUiEBm1eh2rnST/FvfAJrKpal84iic0L57/Y4Z
	lJWMAR3gHLdqGOV5sO4HiAgr/CD00cCIsSN48CKQayYxKvAeWgXvQN4/jzsVoJWP
	VGzOLqa88XQe5uxQ50zEnTLEINhDfB1lkGQ1wxnyAV0R3CH0gNvLcI8WlQn4Bsmc
	m6ia5W5+hoMZuwWfxHrCox0zWf8im1PiUS6aBJUmf2NRRWO8fOa8hh7e3AgEqtqe
	lhMRnP73gMqDUvlcXKILVFdkHnlRim9EQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjs1fgyta-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 27 Oct 2026 05:32:53 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 27 Oct
 2026 12:32:53 +0000
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
Date: Tue, 27 Oct 2026 05:32:04 -0700
Message-ID: <20261027123204.2671561-1-hruben@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027063247-mutt-send-email-mst@kernel.org>
References: <20261027063247-mutt-send-email-mst@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0OSBTYWx0ZWRfX6tGjoFZHoaPi
 Hs6GtVGcptmpDYZQueo1ZXM/XKtWzoBf4Dl72QrgavsdjME2Som8fBIrtgcmuGkMiWBqyl+Q7el
 aanA2fb+gh5IxtjLV6Qc6o8vQCzN9hpQeDTmwFFv6vopNyFYfxDtPT9SNwGghfHzMLCmysYMPVq
 xgaYBmNYDDydCJlg1HRQI9ysziwmj4WDMWBr9Tzt5WWmY8kPgonrbQ6XFEzlDJkQT3NRxORxnaX
 0W0+7thNmYGo6gnKyXLcikKuD3Ykl/ehCy9RFuZURGod+j9g1Ri2SGXrNCLvkDSJIwcgpV8a2No
 FbSU+QF8b4FKM5KIf+rBJ4nVL4Rc/s2P554B62hZ5Q0fviMIYzSZSCl+JgQAc2x6N5bqo66A37O
 ArOOGYDxsGPIgPcz4auBqpZ8vKDB/2Jq+o53wo2M01IaiRPNHJPC5Okpa74vo3xmigfL+6E8Ncr
 fxPNSm9wp//rX1+Wd5A==
X-Proofpoint-GUID: DFY0SqyqjgnoUS4yXiTYVjlXGdWqz5Ie
X-Proofpoint-ORIG-GUID: DFY0SqyqjgnoUS4yXiTYVjlXGdWqz5Ie
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6ae099f5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8
 a=URxAJj9iRMZYw-DfRNEA:9 a=zY0JdQc1-4EAyPf5TuXT:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0OSBTYWx0ZWRfX3DsCFrgzN+gx
 kFMiXG0WBN7iw4wooJlhpiyuHl7M+wOyMFhYYDXccwkI5hrVlJxqhMk5bo+jjm+CapWMs2XuEC+
 LZjnkQ5g2htqoNna8u1d5cjnGhIxXUI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01

On Tue, Oct 27, 2026 at 10:35 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Oct 27, 2026 at 02:26:33AM -0700, Ruben Hakobyan wrote:
> > On Mon, Oct 26, 2026 at 11:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > to the VMM so it may discard unused pages.
> > >
> > > For an arm64 kernel with 64 KiB pages, the default reporting and
> > > allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> > > report contains a sufficient number of large entries, we will end up
> > > with a descriptor chain that represents over 4 GiB of memory. This
> > > violates virtio spec, which says:
> > >         Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> > >
> > > Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> > >
> > > Submit each reported page as a separate virtqueue buffer instead of one
> > > buffer with an sg list of all pages.  This also avoids indirect
> > > descriptor allocation (kmalloc in the reporting path).
> > >
> > > To avoid multiple buffers causing interrupt storms, keep callbacks
> > > disabled while we wait for an event.
> > >
> > > TODO: as an alternative, keep using virtqueue_enable_cb_delayed
> > > but add buffers after there's space in the ring.
> > >
> > > Note: if the virtqueue is broken, wait_event on
> > > virtqueue_get_buf hangs.  This is a pre-existing issue:
> > > the old single-buffer code had the same hang.
> > >
> > > Reported-by: Ruben Hakobyan <hruben@meta.com>
> > > Cc: Ruben Hakobyan <hruben@meta.com>
> > > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >
> > > Notes (changelog):
> > >     changes since v1:
> > >         keep callbacks disabled while draining: get_buf re-arms the used
> > >         event for the next buffer, reintroducing an interrupt per page.
> > >         Disable the reporting vq callbacks at probe, and only arm the
> > >         delayed callback to wait.
> > >
> >
> > Thanks for the patches! I think sashiko-bot found some issues on broken
> > queues in the first patch that are worth looking into for correctness.
>
> Surprise removal of the balloon? Nope, it's a pre-existing issue that
> it's broken.  Besides it's not really practical, no one removes
> the balloon - no need.

Fair point about that. But I meant the broken queue check.
In virtqueue_enable_cb_delayed() there is:
```
/*
 * When the device is broken there is no point in polling used->idx,
 * the backend will never update it. Return true to let callers
 * exit their cleanup loops instead of spinning forever.
 */
if (unlikely(vq->broken))
    return true;
```

But virtqueue_enable_cb_delayed_max() doesn't have this. So I was just
thinking the same reasoning should apply here?

>
> > Other than that, I tested the "normal path" on QEMU and Cloud Hypervisor,
> > both on 4 KiB and 64 KiB guests, and this works correctly.
>
> Thanks a lot! Can you pls confirm whether the performance is about the
> same/better/worse?

From my tests on QEMU, CPU time was about the same as my original patch
and unmodified Linux.

To bring a concrete example, with these patches it took ~437 ms of CPU to
reclaim a whole 8 GiB with 4 KiB pages (vs ~434 ms on unmodified Linux).

With 64 KiB pages, it averaged 121 ms CPU (vs ~112 ms with my original
patch).

(I tested this on Nvidia Grace)

>
> --
> MST
>

