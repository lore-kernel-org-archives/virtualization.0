Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973972;
	b=ino1AYYqwEl/GhQlHtnlumeD7nPDOCmIJuVjszgOqpfnMfnNXj2u9I2wVD/TRoTnmK/P
	 CSOP0y4gxFBiiojEV/tNKyvrYVxTCqfcnreevPxHqEEoa7M0qTmoaKh6vdZGDkmf4ZcNx
	 YEhnCwXfJueDy4BWqueD4yTw58PbrkjyiG5Z1uV25OgKaECTeeiY9LpO41w4XVz7g7pHY
	 +wS2Dz3Y6318MzvtfWh+jsmApKM2lMnK35pI9aWkguH1tAqXEmKXK5DIZYbEQ56/Uj3LO
	 xXfWV8vbh61PxzhVEYM6vnwdTMAxhEhX0jwdsHeBwbU5TyMjeRzTRsM8I2ad2rQeB+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973972;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=UuDZU2l0/plv8oJ7vGm49nlGR3QZROefBx4Sih+ejb8=;
	b=wrvQPATkb/WSC0eMd2nad3LqHkPaMmjC9QOLhRza6tdmu+8AxykdwfTrKBB2N8kdqU6k
	 lkzoumdKPRGnTBRmcfteLv0VvQ8OoYAY4blu185+ba4ygCleLXeytOglQKlrjuI7OJvWO
	 hGtfsVXHMxL4+/W5Rz2kBXfLbmMA8a9hPkd+7aLK4iABwpjkc7GD+CAC0vrJszNUDm4LS
	 yDlfzpIU9fdqiuVU2ph7FS2d6xGsQSivqDvDDIw3Mpm1X/4GRfkOU4iyJw8xuvqN2bfe5
	 RxrGp7G3Nx/MiqitMoGBytvOiQz956eCqS6oBVb5LItvGNeAZv+VrVid0Xy+z+olvGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUprbMG0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB687606A31B
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 00:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB687606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUprbMG0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792973971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UuDZU2l0/plv8oJ7vGm49nlGR3QZROefBx4Sih+ejb8=;
	b=fUprbMG0UeaQu5CprnNzzazA+oaTsyC09Bdj+nij9auf/Y+ny8C8OaBOUv8n4vcq6RT/Xy
	/HXAoe2umF9kpcfhZYh4yklBhpdZ3hvjh+PQBXkJaKSi2Dw4AHT0oFMY7R8LEqQKUtB8o3
	aYShxE3qJkJ0PA2RhG4aZBI1KbgwapE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-PJx2fVi_NpiWnKYcRm15Yg-1; Sun, 25 Oct 2026 20:19:29 -0400
X-MC-Unique: PJx2fVi_NpiWnKYcRm15Yg-1
X-Mimecast-MFC-AGG-ID: PJx2fVi_NpiWnKYcRm15Yg_1792973968
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so16026425e9.1
        for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 17:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792973968; x=1793578768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UuDZU2l0/plv8oJ7vGm49nlGR3QZROefBx4Sih+ejb8=;
        b=ZFS50pPoiBgIqBf1rFrMZje+NrezlWThY+aIyUFuthaH88tgDYmPPn9XTD/U6yqrep
         klL/246HEQvmhUyRK81judOdwBbVFJBq1ctYfST8qxfPpDiJc/gStW624z4yC98E4B8W
         w24PXkUEyseEb9gVJiZl04RlFaFypS5rmz6GI27U2wG4BedIpTNwmmxWdlELIsVviTTV
         r3EXn3/F7wSVxxwpyfZcLGwqG2xWn7xXbs/NfOoZxc1XYBQfyd6eiJ1P1uoSxfnzB8sM
         /KtMhcCiXnwmyQrnmjlhFJ4rB76hII+g80bPIwqNZ5piHjlDOa+NOzRnh4sA9ecv5ZOu
         5ydA==
X-Forwarded-Encrypted: i=1; AKwUvBxRvHcJB+Fh4/vBTEujPTBSWw+NPZJiqCxgRpLVdL1+5eiojmlPX167okxrNaCyJ6inmGe8xUUkWgKMjS2nTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI47onuNRU3vzY3OEk8fBzICAOEWR9awwW13OSYRYzncCnDpSxt
	uaISRX/6ucz8BSW+RkKnHo5zRYiVRWmvdaCgiXqVP2pdx5gkN5syZIhFSRU9aXQdJxo3NJ/P0h4
	zkFWVJLtrEVSJhEFvW52JsAOkM+CxDB5OAHP1H57cV0EhqonLb4MAfJfsuCwVmhL3FH4l
X-Gm-Gg: AYBFou0ptuJti6pC58+MUMT8jDhNhu5p73ZvS9iGinVYYa2TDF1NMM1cDUr/qE6il0U
	712JnUMdSJG/rjdqEQYD7IjevSCAlpVslo2cW2YAVRLEzG+lI+LyxBVaWlEtqgm5Cw+dH6EHdac
	O3dbXE+rfNorTV276GnBPpCsPDQWGNm6nytixXwb6QZVcr3yitIpBJqbn34uPsnshuin3U6BXR1
	SNRtbWlTTXnMcSrxuK7nYgOH8tWW7U/ZA3rT3aWoaoMBZtw+Las/BUqqPJUPlPrtqPVJKdXuhJI
	zC2XimQwsHNj0EJMawpEentE/boGtgtCaaO9VdNVax9JT2Srvd+0DKpaXEuy/6nQDHw=
X-Received: by 2002:a05:600c:8184:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4a35aca6b82mr83802845e9.26.1792973968271;
        Sun, 25 Oct 2026 17:19:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:4a1:ac66:6059 with SMTP id 5b1f17b1804b1-4a35aca6b82mr83802215e9.26.1792973967640;
        Sun, 25 Oct 2026 17:19:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4be6sm11667327f8f.37.2026.10.25.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:19:26 -0700 (PDT)
Date: Sun, 25 Oct 2026 20:19:22 -0400
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
Message-ID: <20261025200808-mutt-send-email-mst@kernel.org>
References: <20261023042737-mutt-send-email-mst@kernel.org>
 <20261025235641.601299-1-hruben@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261025235641.601299-1-hruben@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S4YRyqXrxBU8PH2agbBKoo3fQn83aQas3pQjMjrYQsM_1792973968
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 25, 2026 at 04:56:41PM -0700, Ruben Hakobyan wrote:
> On Fri, Oct 23, 2026 at 11:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Great patch, thanks!
> >
> > On Fri, Oct 23, 2026 at 01:19:19AM -0700, Ruben Hakobyan wrote:
> > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > to the VMM so it may discard unused pages.
> ...
> >
> > It's not just a question of convenient, is it?
> > Rust is buggy wrt to spec as it allows only U32_MAX.
> > So it is also to make it work.
> > So should we maybe fix Rust to be spec compliant and allow 2^32 too?
> >
> > I think we should definitely recommend U32_MAX in the spec
> > because otherwise it can not fit in the used length.
> >
> 
> Thanks for the review!
> 
> Sounds good to me, I will CC virtio-comment@lists.linux.dev as
> per your recommendation.
> 
> Agreed that Rust-VMM should also be fixed in case 2^32 needs to
> stay the hard limit. I think here for the driver, we can be more
> conservative as long as we stay below 2^32.
> 
> ...
> 
> > > ---
> > > The wording in the spec is a bit ambiguous because it uses "chain
> > > length" for both descriptor counts and the total size of the memory
> > > ranges referenced by the descriptors. My read is that the byte limit
> > > applies to the sum of descriptor lengths, which is also what rust-vmm
> > > checks.
> >
> >
> > quote what you are referring to please, also in the commit log
> > not after ---.
> 
> I will update with quotes in v2, thanks.
> 
> >
> > I would also CC virtio-comment@lists.linux.dev - spec should recommend
> > U32_MAX.
> >
> > >
> > > Another option I considered was to limit reporting capacity based
> > > on the largest possible block. E.g. for 64 KiB pages, the largest
> > > block is 512 MiB, so limit the reporting capacity to 7 to stay
> > > below 4GiB. Although simpler, I found that the time to reclaim
> > > was quite a bit longer.
> >
> >
> >
> > So I was going to apply this actually:
> >
> > https://lore.kernel.org/all/b541ff170218bd5d45b551b5132e7cf2c490d761.1780906288.git.mst@redhat.com/
> >
> > which makes the question completely moot.
> >
> > Does this have any effect on performance?
> >
> > Thanks!
> 
> Thanks for sharing this. Yes, this would also make sure we stay below
> the limit. Regarding performance, I tested this on QEMU and it calls
> virtio_notify() after each completion.

Who, QEMU does?

> Using one chain per entry
> creates more chains, so QEMU can use more CPU time to reclaim the same
> amount of memory.
> 
> If we go with this, I think a QEMU patch to batch notifications
> could reduce the overhead. Alternatively, I think we could create
> larger chains here but make sure they stay within the 2^32 limit,
> and keeping your approach of queuing them all before kicking.
> 
> I am happy to share a patch with my thinking here.
> 
> ...

Oh. It's just the driver being silly and never disabling
callbacks.

pls just add virtqueue_enable_cb_delayed and this will fix it.

