Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022245;
	b=OxuPa7Rv792l/SwHl7uONb1hygaLRqqm98DNwk+OZejbJVzBueF3M24leIDZDj2r7L67
	 omRywDa5xXCnpk5McsPOYCawRK+0CDBSdt/oyHQlc0055LcCDggBHjx0C5XLt10/vkZjb
	 2LVBnlvfSUARc4SO21OE7ymSgHRBbo2TzDmPQ2t9nIJn2KZZYQuly9iDDWNuIcPxJtvgV
	 w1xiAxt6/sutcVUSKnTzpafndiH16lVMtLDyVVMoG0kP3KNDWFfCC3lVCCCJbzUt4/LiE
	 BKNuAeuKC6Jx5ZxrGfOCNi27JFnKhkJqLF4DzLUriN4ALyUs7ssMhxIhQBwlQKwu6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022245;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=1jtJReYRyqdsrFZjdueNFI4v0PWkzXe673TTWmiTniM=;
	b=a+b32GFRaO/E+t9psM+P9rsCP7rUOdGg8xrVm3+J8B1qxD6UavgcAkikneO9m9QCQMXl
	 UeDaLPIATx4NmDM5nT/fuOn4C+cDBn4YibYLhi1SKq4GnKcwAoDExBTwCGQquwwYI5ilT
	 PgLQWCrSElfvGhSsVQZ/lQSpxp7szCpMm5Xmdh6asAF2nNvo5L4Mc6Nck9YVlL6N0b4aI
	 JKkh8wprTjVcHxH8cMR2uYGME6uS//ArSs4ujwkF4AThLuKi3selo07iGSZ5W/scO4t9V
	 eSflUXH0mu2g6HNrwrukX2r8lwgSufofWZINbe/6G5usLPM25frYv1/H8oHe0XpZsaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVT8GEel;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A226606A31F
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A226606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVT8GEel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793022243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jtJReYRyqdsrFZjdueNFI4v0PWkzXe673TTWmiTniM=;
	b=LVT8GEelHpvXBQwCdF8Xs4rGJKyFp2zNciFh74zbIyI7NroYbH5j8azNMnHHPnOHqmvjdo
	k2y+QXmHsZl6BpyQ8gNb7rizpLz5b5xv11MfkRiMDb1ycyvLTcJERlGBEPE0x/AHRfsPsl
	Z6eug57q9OJ2qo98byx96Olu9+F5BZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-jfckREfDOxKpndZ9cWr2Dw-1; Mon, 26 Oct 2026 09:44:01 -0400
X-MC-Unique: jfckREfDOxKpndZ9cWr2Dw-1
X-Mimecast-MFC-AGG-ID: jfckREfDOxKpndZ9cWr2Dw_1793022240
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so28603795e9.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 06:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022240; x=1793627040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jtJReYRyqdsrFZjdueNFI4v0PWkzXe673TTWmiTniM=;
        b=R5RkqD8hGLe7ftRUjrsspMU8stb+Maq+rFFdb2hLGr5DRCK93rW2xEb2v/i/wpkvXb
         T08p7e8ludYFOJVYt1EZowx3lzjZUY84nz0e0w7AxqV2VWqfNrrjWtfGxccwBBhSDydb
         V3ylNtiDznfi35+dNryXYSxSYPPDwZK1xzuW0EkkXQ3W7b37zvuaQM4XWHKY1Th6EQxa
         R+lk2HS4E5niZAUHFXL2bSrGY89SPhsTPgH7U0AxGTPjE7wxN5QWnY80Xklh2fsnq1yz
         UlnTuemI6vflUpO7mgGf4wn/e1qOm6N6YNnc2F5CRcxq/nxTIwNi93RrgQnENOCvUsNG
         ZSIg==
X-Forwarded-Encrypted: i=1; AKwUvBxxRzB9oU/2T+KYgpKryNI8Hq49szolZgfvA7feTODEDPRjrgFl4qna//ZHIDhNp6pz/UuJ5cOoH7z66dn84Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLW1cds8sjsKjRipHi41SNlqXfeZGM+7djfcUIcuTxi3lCP1gsl
	d3RdBfbmzLPnYGWT6JbAJ7teT9WDS/Xt1JQf3ly42rEhBnohnnv14HmHQVAJD3CDwkcAWn//hgD
	L1apRmu24QjwiRPqdyxPa9Od1G7vXG/CbgemY/2IuwAzxjzXaOzFvlYiow6iEU+n8tNP6
X-Gm-Gg: AYBFou1O/o63C8gj/XeOO6VeolTXHRuxgMUCzl0zfVJe/Tyopvi2RLn1h9QGYmZxR3J
	ELCQ3XLE1i5woYR0XrBFTU+89F+iiu3JUCUtISslPnu0kBXg0shaPml3LTF24N4ybKwMuFXnptv
	eHAVyYrYTPNXwkwfo5s/yPusMkd1EuCd8qCI1cV1VKjcKljovheFYURrczGyRzI+NgGbqalMdU6
	PWJ9sdrlG4RxZywuTTiQTvsxNAbA2x3xqWs4oR5ZxfItembI+8GZbMCPlVG9PeCsDbGeLs4aL9e
	r23rDahKGSzB2sfk2tgBhvqaUZqVNvY5RjF8XMEbe+Ky4dlqLc5D0JG2IiUilul+mjU=
X-Received: by 2002:a05:600c:840e:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a35acafc84mr115422235e9.10.1793022239683;
        Mon, 26 Oct 2026 06:43:59 -0700 (PDT)
X-Received: by 2002:a05:600c:840e:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a35acafc84mr115421575e9.10.1793022239010;
        Mon, 26 Oct 2026 06:43:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm245511405e9.4.2026.10.26.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:43:57 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:43:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ruben Hakobyan <hruben@meta.com>
Cc: David Hildenbrand <david@kernel.org>, Breno Leitao <leitao@debian.org>,
	Atish Patra <atishp@meta.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtio-comment@lists.linux.dev
Subject: Re: [PATCH] virtio_balloon: batch large descriptor chains for page
 reporting
Message-ID: <20261026093445-mutt-send-email-mst@kernel.org>
References: <20261025200808-mutt-send-email-mst@kernel.org>
 <20261026125911.753798-1-hruben@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261026125911.753798-1-hruben@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z7QykM60ncqdXZSEdpx61H1snx6qYdPMefOcAwTI02g_1793022240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2026 at 05:59:11AM -0700, Ruben Hakobyan wrote:
> Sorry, I just realised the other reply went on to the wrong thread, so just
> reposting it here.
> 
> On Mon, Oct 26, 2026 at 12:19 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Sun, Oct 25, 2026 at 04:56:41PM -0700, Ruben Hakobyan wrote:
> > > On Fri, Oct 23, 2026 at 11:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > Great patch, thanks!
> > > >
> > > > On Fri, Oct 23, 2026 at 01:19:19AM -0700, Ruben Hakobyan wrote:
> > > > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > > > to the VMM so it may discard unused pages.
> > > ...
> > > >
> > > > It's not just a question of convenient, is it?
> > > > Rust is buggy wrt to spec as it allows only U32_MAX.
> > > > So it is also to make it work.
> > > > So should we maybe fix Rust to be spec compliant and allow 2^32 too?
> > > >
> > > > I think we should definitely recommend U32_MAX in the spec
> > > > because otherwise it can not fit in the used length.
> > > >
> > >
> > > Thanks for the review!
> > >
> > > Sounds good to me, I will CC virtio-comment@lists.linux.dev as
> > > per your recommendation.
> > >
> > > Agreed that Rust-VMM should also be fixed in case 2^32 needs to
> > > stay the hard limit. I think here for the driver, we can be more
> > > conservative as long as we stay below 2^32.
> > >
> > > ...
> > >
> > > > > ---
> > > > > The wording in the spec is a bit ambiguous because it uses "chain
> > > > > length" for both descriptor counts and the total size of the memory
> > > > > ranges referenced by the descriptors. My read is that the byte limit
> > > > > applies to the sum of descriptor lengths, which is also what rust-vmm
> > > > > checks.
> > > >
> > > >
> > > > quote what you are referring to please, also in the commit log
> > > > not after ---.
> > >
> > > I will update with quotes in v2, thanks.
> > >
> > > >
> > > > I would also CC virtio-comment@lists.linux.dev - spec should recommend
> > > > U32_MAX.
> > > >
> > > > >
> > > > > Another option I considered was to limit reporting capacity based
> > > > > on the largest possible block. E.g. for 64 KiB pages, the largest
> > > > > block is 512 MiB, so limit the reporting capacity to 7 to stay
> > > > > below 4GiB. Although simpler, I found that the time to reclaim
> > > > > was quite a bit longer.
> > > >
> > > >
> > > >
> > > > So I was going to apply this actually:
> > > >
> > > > https://lore.kernel.org/all/b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com/
> > > >
> > > > which makes the question completely moot.
> > > >
> > > > Does this have any effect on performance?
> > > >
> > > > Thanks!
> > >
> > > Thanks for sharing this. Yes, this would also make sure we stay below
> > > the limit. Regarding performance, I tested this on QEMU and it calls
> > > virtio_notify() after each completion.
> >
> > Who, QEMU does?
> 
> Yes QEMU, sorry for the ambiguous wording.
> 
> >
> > > Using one chain per entry
> > > creates more chains, so QEMU can use more CPU time to reclaim the same
> > > amount of memory.
> > >
> > > If we go with this, I think a QEMU patch to batch notifications
> > > could reduce the overhead. Alternatively, I think we could create
> > > larger chains here but make sure they stay within the 2^32 limit,
> > > and keeping your approach of queuing them all before kicking.
> > >
> > > I am happy to share a patch with my thinking here.
> > >
> > > ...
> >
> > Oh. It's just the driver being silly and never disabling
> > callbacks.
> >
> > pls just add virtqueue_enable_cb_delayed and this will fix it.
> >
> 
> Ah great, I tried with virtqueue_enable_cb_delayed() and yeah it
> largely fixed it.
> 
> So regarding the patch in
> https://lore.kernel.org/all/b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com/
> 
> I see it's in a larger series, so just wanted to check if you're
> planning to send this patch separately? Or let me know if you'd
> like me to do it. Thanks!

Yes please do send it separately. That work stalled, the mm guys said
they will have someone look into it, then never did.

Or maybe even simpler, as below. BTW we might want
virtqueue_enable_cb_last, instead of delayed will be more efficient for
event_idx.

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 799b575a3828..dc94b417b14c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -246,22 +246,23 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	if (nents) {
 		virtqueue_kick(vq);
 
 		/* When host has read buffer, this completes via balloon_ack */
 		for (i = 0; i < nents; i++) {
 			struct scatterlist *entry;
 			unsigned int used_len;
 
 			virtqueue_enable_cb_delayed(vq);
 			wait_event(vb->acked,
 				   (entry = virtqueue_get_buf(vq, &used_len)));
 			virtqueue_disable_cb(vq);
 			if (used_len == entry->length)
 				set_bit(entry - sg,
 					pr_dev_info->zeroed_bitmap);
 		}
 	}
 
 	return err;


-- 
MST

