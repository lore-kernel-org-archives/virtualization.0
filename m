Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692548;
	b=TOdk9mnpb/fpasCsb7zDQy4uFnO+f75DHsV+CrT5/Pam3YMEfMkiRipkqaWgR6ez5Qdb
	 aEPByxRN023NqKawz/3tCZxIf6nOAO19UGJpu9pPvFcv+QM5L9ioIvhniCO3HSOZpRA3B
	 NZmAz+UVnNS/RlASSaadfFRzpA4HOhrQit5mRuu7+f8Flm0Uw/DLPwV4hJU/Y4vi2pHeK
	 DprkV2yLHoS43UYyderzYH6rmulIHyIpDxBGTbt+Ik0kz+UOwVUCnZNubQKYs+28wS9lU
	 Ppl3MotbkGPYiWkwlGwmfmK1Oa7wiQGLSqanjBsM52ImsWZyzPuukhnqTYyOZxJxGHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692548;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=1M9V2KH3EPa94mupqMpLFIXTzWcWHTU8vyvugCUAgqY=;
	b=DlL1qQQ5E2TwXWaCKKZNEvhvuekZzxwl6hxLKwxASYgbw9keqj/cjCF8BRyVKTaJaHgn
	 K11ozUcc93MkwXec2BJH7yAYSDsNzJ+j54e1r1opQCbjCA1L7Vfpd7gp8PR1MdcMTV4Vd
	 E0ueNsuSp978aIEwJcqva+wGUozhi7T2RN63wu/d+CuMGOLllPGSN0ezoNNr2mU38xHKP
	 +qjfrq0EQUiMaAaiUwmrThrOUvKBtH+t5auKxNold6Gvd3jObeQ79e2ANbfehib1JjAHk
	 1ypyoWHx8Pz5siCniMHrn7YQDw369H18E08q4oc0bsxBn0aQwpBT04AJpBDd/7vEa1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kmn2YbZ+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7075606A332
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 11:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7075606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kmn2YbZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795692546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1M9V2KH3EPa94mupqMpLFIXTzWcWHTU8vyvugCUAgqY=;
	b=Kmn2YbZ+AuCRLEF08a8b9bRgSjhxlf7oRP8nbAyZYbfZoWSIOp0Kdl18URpCj06kxhXaAd
	BdyLbgc2ktaBVuJArN9MBHt5rWUIRjj79+YEqC010sJsVDwXJLYa8RYEEzY1u8Hwff7/Au
	E8KOS/TcpBQ71pBwA3K1X4oUSLxRA10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-fQ3SZRDpO6qcdrw8dmONTA-1; Thu, 26 Nov 2026 11:29:04 +0000
X-MC-Unique: fQ3SZRDpO6qcdrw8dmONTA-1
X-Mimecast-MFC-AGG-ID: fQ3SZRDpO6qcdrw8dmONTA_1795692543
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so48054115e9.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 03:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692543; x=1796297343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1M9V2KH3EPa94mupqMpLFIXTzWcWHTU8vyvugCUAgqY=;
        b=LxmEAh2PfcjB+9UspABjM4Ki7NxTg7EuNOZNcoj11DGySjHrITZZjw3sQG1vvt/iKP
         eMyXU7NgqegoZmTvAzHNtFsTO70GjDDLUY+lgnM5j8M474nrXjlgFLYum9dzq1x/qGpa
         3LTC2Sf/KmLn6Grkdyhry11jTJSSgxbK0G2Cc3qeqRPvkKX0JCykilBypOiHl9qWXkUb
         qwfIeSmX95wcNKhkJ3TmqCStnfI12u3RNo75BkFEQScNQ3fr1cCL9LnX2G8mzveiZfG2
         d8wWkv6FMt3WNHwlStzI4hzkATAUwaN2R7vdJwgWAHtOdccpS8jWJpsrzwTxaztqOjB3
         TUoQ==
X-Forwarded-Encrypted: i=1; AL+hErFMvZnYDPYHtJGDHf5MOkFaJ1IDvORGFYahVY78cRWfAF52dqVWO5H2oGsn9ML3fucL8BKdo/cbOnqv/Jy2Ag==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uE4o6y1slKlRkb6xb2f+q01/RIbzx/kQhjrg3RhQebWxzeT0f
	eh/LTlPBmY9+07J7FfSHgHHdAjB17MbHosBhdR/t1au8VMuBfZr/ntsxXly+3qREvJJhjfwqFX1
	skGleiaTcqcNi7cdynCMFG/qIONd0ZXOsQN4vYmP1lowocgzPid3v0CFP0IAdYLaJQm80
X-Gm-Gg: AZFdTZc5nAMGDWTtbT79O4UgFzQo2/dUYNblLD3eicKu5JZFkCX2hmwdB6ycOB8iMZ7
	5/lbMk5z08pEUUZZESKtcRn4NI7hE/vn9TqrZUSiLBpsEg0JvnHqTXjPwWdy9nfLuSmRR4zJrA6
	er7mNMEfauvbTvT7O+ijLkeMagqTq1T2svQRxftaIbqZL3OEa1P+s1z5GKY4ThOfyeQTcA1eli2
	NyuUz1w5XxUtgot7PxAHvpiU8ACcdIu9xnU5e6rcBiX+4aS0NU3z/ac7dCSdGMZSkyTu8rnDoM7
	P7MUQR8hZEK0oT4RTYSTPHPEvJ4E06CDF5ZmL5i9J/gRi5W9CeQ1QO39BGVnXzcqk//ZpUTZa6G
	9PkPyw9zLE+4UCvLGZI31/etMNCm8VE5DmDUdqPpm9cI=
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr482478975e9.28.1795692542703;
        Thu, 26 Nov 2026 03:29:02 -0800 (PST)
X-Received: by 2002:a05:600c:3b83:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb88822242mr482478295e9.28.1795692542165;
        Thu, 26 Nov 2026 03:29:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1529:2e00:86ec:bef7:c309:ba1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm663670405e9.3.2026.11.26.03.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:29:01 -0800 (PST)
Date: Thu, 26 Nov 2026 06:28:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Seojin An <love09010224@uos.ac.kr>, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, security@kernel.org
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Message-ID: <20261126062833-mutt-send-email-mst@kernel.org>
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
 <CAJaqyWdLXzosXuFs8iafx0x1moGsOZuWuAQCJqCQUrOt++FCBQ@mail.gmail.com>
 <20261126032258-mutt-send-email-mst@kernel.org>
 <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cfKVPx0D39TK5NGk4bV0LW3N-l62Q46sqRdZNIMkUug_1795692543
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 09:41:31AM +0100, Eugenio Perez Martin wrote:
> On Thu, Nov 26, 2026 at 9:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 26, 2026 at 09:14:36AM +0100, Eugenio Perez Martin wrote:
> > > On Thu, Nov 26, 2026 at 9:02 AM Seojin An <love09010224@uos.ac.kr> wrote:
> > > >
> > > > Split descriptors store the next index as u16. alloc_indirect_split() can
> > > > allocate a larger table, but virtqueue_add_split() feeds the truncated next
> > > > value back into its construction index. With more than 65,536 SG entries,
> > > > the index wraps and later entries replace descriptors at the start of the
> > > > table. The device then consumes a chain different from the caller's SG
> > > > sequence.
> > > >
> > > > Reject split indirect tables whose entry count exceeds the representable
> > > > index range. Keep the existing compatibility policy that permits
> > > > representable indirect chains longer than Queue Size, and leave packed
> > > > indirect descriptors unchanged.
> > > >
> > > > A virtio-gpu render client can reach this condition with a vmalloc-backed
> > > > EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
> > > > substitution provided guest physical read/write and initial-namespace
> > > > uid/euid 0. The virtio-gpu producer needs its own Queue-Size check because
> > > > its current queue error path warns about an add failure but advances
> > > > pending state and reports success.
> > > >
> > > > AI tools assisted the source audit, reproducer construction and patch
> > > > drafting.
> > > >
> > > > Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_INDIRECT_DESC)")
> > > > Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> > > > Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Seojin An <love09010224@uos.ac.kr>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 14 ++++++++++++--
> > > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index f683a2d6a2002..ad9e52584fb52 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
> > > >
> > > >         head = vq->free_head;
> > > >
> > > > -       if (virtqueue_use_indirect(vq, total_sg))
> > > > +       if (virtqueue_use_indirect(vq, total_sg)) {
> > > > +               /*
> > > > +                * The core historically permits an indirect chain to exceed the
> > > > +                * queue size.  Preserve that policy, but do not let its 16-bit
> > > > +                * split descriptor links wrap within the allocated table.
> > > > +                */
> > >
> > > Seems like the same code path in the packed vqs also needs this check?
> > >
> > > Also, a question for everybody: is it really too late to forbid
> > > indirect tables bigger than the queue size? It is not guaranteed that
> > > the device will be able to handle it anyway, should we just add a if
> > > (total_sg > vq.split.vring.num) return -E2BIG?
> >
> > It's not too late in that the spec forbids it.  But a bunch of drivers
> > are broken, so for now the best place for this check is in the driver.
> >
> 
> Doesn't it make sense to add in virtio_ring as hardening? Fewer places
> where we can miss the check.


We can't because we don't know what will break.


> 
> > > > +               if (unlikely(total_sg > (1U << 16))) {
> > > > +                       END_USE(vq);
> > > > +                       return -E2BIG;
> > > > +               }
> > > > +
> > > >                 desc = alloc_indirect_split(vq, total_sg, gfp);
> > > > -       else {
> > > > +       } else {
> > > >                 desc = NULL;
> > > >                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > > >         }
> > > >
> > > > base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
> > > > --
> > > > 2.43.0
> > > >
> >

