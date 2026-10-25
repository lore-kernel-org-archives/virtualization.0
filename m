Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972646;
	b=HsqNTgDpUM5zJMIRSBsGg/y9uSfyPJXOS3Gjd8yfb/550Z0MCDcH+AGbFP01h4hVzpTx
	 npv53BzyV3C6fTLI1OLgJqPYiTtXxbH+EK+0y5rkUbcSeS48Uj15vFxrZGMwKqlqiuYWP
	 iXHke3jVkfr+KtpZyzGL93ZVVnEQdK0Y8BB4WXbnnrU18HXxIZRLDVpUdK2oD4SK7kxkQ
	 aHS5Bq2Dz6SRDYkroiN+tR28u8/Sg5jUjBsz1tyWx0qWcy69PGDptjFPdGqt9WCPhapib
	 0uah2R2ol1oulZ/U+O08mX72puZVYvU2lSHmkmQTWq5bk9uOzuOYHhY6sGCEMhjh5Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972646;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=oPNnQJuAXpVjRJV3/dEa6LasHj8wpKSqCglF6Ora69k=;
	b=C2w76klSIByw6z1wWyJIBgeGpbdAaCP0QNzbbeyuzamt1zbl2zSxFk3sVW+qyVl2w8LD
	 oeDo5A8R/M9kACDHLvmLlFwckby/W//xTvlhL53T6Q39/xmzO8mmEiDvJeOt9zEJO137b
	 H2kd9ShTCw0BVgIOw8U019npvKRFn0C2muU1As8Vb1MPlj4Hj/gL1GRXdKOywW/ryEBep
	 KLXL6SvI90yxlDiQZxFCwSx0gtCBxur3XCAYs6eHfG8zvyV6jNO6bLcdUA8QGwdhZMvnC
	 OidQ0ZRu1MBuyK7VJyjkxZetw9HbpqW9W3mTT7sobtfPq1qD23P1FGHBOCxCn+aOUWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JYw3VHbt;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CF606A31A;
	Sun, 25 Oct 2026 23:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JYw3VHbt
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69PNeM0V541501;
	Sun, 25 Oct 2026 16:57:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=oPNnQJuAXpVjRJV3/dEa6LasHj8wpKSqCglF6
	Ora69k=; b=JYw3VHbtjFoha8HdQAz7heeWHdWu4OhjjC9qUJs+bcA6pt5qcUFeU
	nTGEuSMUoYzp3fjF+U2vQnVuMpTi6p2Ob2UmqSFoYXrOqzLK0ZZXLqUXQh6kHpPL
	kKy/Y2htT4+3/3ajWDihgKtem8n1ldorUqSZdXJjXJlRMxlWoe595mdqRNbjUP//
	nhgSoc7mqep22XzW+33VwuJgE8TdKDrGPgLe47XMVv4Pxv4GVlY0mo4qdJYqPaVU
	j3Gqpc4FDrSVDfu2YdEHqjI6uW0P2pHfgPVZA32ilcjiypbmOshs88pJR1sSPH2X
	n1N0hOuVbR1CzVkGch4u0Btbbn05jcylg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hgrbbx8vy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Oct 2026 16:57:08 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sun, 25 Oct
 2026 23:56:52 +0000
From: Ruben Hakobyan <hruben@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: David Hildenbrand <david@kernel.org>, Breno Leitao <leitao@debian.org>,
        Atish Patra <atishp@meta.com>, Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>,
        Alexander Duyck
	<alexander.h.duyck@linux.intel.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <virtio-comment@lists.linux.dev>
Subject: Re: [PATCH] virtio_balloon: batch large descriptor chains for page reporting
Date: Sun, 25 Oct 2026 16:56:41 -0700
Message-ID: <20261025235641.601299-1-hruben@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023042737-mutt-send-email-mst@kernel.org>
References: <20261023042737-mutt-send-email-mst@kernel.org>
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
X-Proofpoint-ORIG-GUID: si-3CfBR3tWIpYQXQJjFx0lUmYqvGcdU
X-Proofpoint-GUID: si-3CfBR3tWIpYQXQJjFx0lUmYqvGcdU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDA5NSBTYWx0ZWRfX+rc1q0HqoDQl
 dPsJqZkc/iIHyTx5oggwSKazeyC7OJWiEL64dCoRHBo7fDbU7M6OYkcVTPOmEqv+Y2AyamMpuGA
 JTCYCu1d4mfrOjbfy5pVOD4OulqDlYY=
X-Authority-Analysis: v=2.4 cv=R6GWitRX c=1 sm=1 tr=0 ts=6ade9754 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=Ob1JMaaCdSkY7rSgWrAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDA5NSBTYWx0ZWRfX4sU6XoJ2bQVN
 H/LRMV73sKGqkBsHJhCvZ476nJkoaOsVAmktIloPobykH7aIo545IEcIszXoEKvaxRbLfN11v57
 Aj5cHuiuWokDtxKDzyveOrnGwQUUA3Fa8r0PvH1KlA/+Y1VkUNubFHyQCs4J8GuwnttjhU/lWvm
 pgsFgTW5MsTKcRLv1pR7WsuSn3K5QNH0HfE8rI3mKNYumzeHjG54FKuXXt/bTnBv8auBcmI9E0T
 CHNMr71fXG9JdtztXJnWVR3NUQSaAyfCm9OtofITYJVEO8MpzxfOkX5KAhVhjVHp8brF/cuo/wz
 cK4lMhL2pjqUXeNFcJ3dXL29Gt6JlKU7djonD3gPPGqAzKIGkAMQ+bU02vBaZY3iB/ffe2HPwF5
 F5a4xXcb31nCdqDdzF3AgzsErkMgGxeHVrr++t0a18jQ0Q4/xL7Xx/h9R91CuTXoD0IOg21sEdj
 h15AycLtjnCj5yHZ+dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_06,2026-10-21_02,2025-10-01_01

On Fri, Oct 23, 2026 at 11:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Great patch, thanks!
>
> On Fri, Oct 23, 2026 at 01:19:19AM -0700, Ruben Hakobyan wrote:
> > The virtio_balloon driver reports a scatter-gather list of free pages
> > to the VMM so it may discard unused pages.
...
>
> It's not just a question of convenient, is it?
> Rust is buggy wrt to spec as it allows only U32_MAX.
> So it is also to make it work.
> So should we maybe fix Rust to be spec compliant and allow 2^32 too?
>
> I think we should definitely recommend U32_MAX in the spec
> because otherwise it can not fit in the used length.
>

Thanks for the review!

Sounds good to me, I will CC virtio-comment@lists.linux.dev as
per your recommendation.

Agreed that Rust-VMM should also be fixed in case 2^32 needs to
stay the hard limit. I think here for the driver, we can be more
conservative as long as we stay below 2^32.

...

> > ---
> > The wording in the spec is a bit ambiguous because it uses "chain
> > length" for both descriptor counts and the total size of the memory
> > ranges referenced by the descriptors. My read is that the byte limit
> > applies to the sum of descriptor lengths, which is also what rust-vmm
> > checks.
>
>
> quote what you are referring to please, also in the commit log
> not after ---.

I will update with quotes in v2, thanks.

>
> I would also CC virtio-comment@lists.linux.dev - spec should recommend
> U32_MAX.
>
> >
> > Another option I considered was to limit reporting capacity based
> > on the largest possible block. E.g. for 64 KiB pages, the largest
> > block is 512 MiB, so limit the reporting capacity to 7 to stay
> > below 4GiB. Although simpler, I found that the time to reclaim
> > was quite a bit longer.
>
>
>
> So I was going to apply this actually:
>
> https://lore.kernel.org/all/b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com/
>
> which makes the question completely moot.
>
> Does this have any effect on performance?
>
> Thanks!

Thanks for sharing this. Yes, this would also make sure we stay below
the limit. Regarding performance, I tested this on QEMU and it calls
virtio_notify() after each completion. Using one chain per entry
creates more chains, so QEMU can use more CPU time to reclaim the same
amount of memory.

If we go with this, I think a QEMU patch to batch notifications
could reduce the overhead. Alternatively, I think we could create
larger chains here but make sure they stay within the 2^32 limit,
and keeping your approach of queuing them all before kicking.

I am happy to share a patch with my thinking here.

...

> > -     if (WARN_ON_ONCE(err))
> > -             return err;
> > +             /*
> > +              * Virtio spec 2.7.5.2
>
> Please add spec version and chapter title, and quote the
> spec text in question verbatim.

Will update, thanks for the note.

>
> > limits the total buffer length of a
> > +              * descriptor chain to 2^32 bytes (4 GiB), so split larger
> > +              * reports into batches no bigger than that size.
> > +              */
> > +             while (batch_nents < nents &&
> > +                    sg->length <= U32_MAX - batch_len) {
>
> here you actually limit to U32_MAX which is 2^32 - 1 as commit log says.

I will update the comment above to be more explicit about this.
...

