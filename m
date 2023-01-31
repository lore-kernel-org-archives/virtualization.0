Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF03C61DA4
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 03:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3E2F400D1;
	Tue, 31 Jan 2023 03:23:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3E2F400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IT/TaXZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bL3oS8Jc9r7X; Tue, 31 Jan 2023 03:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A835400B8;
	Tue, 31 Jan 2023 03:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A835400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14929C0032;
	Tue, 31 Jan 2023 03:23:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 779EBC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4321840913
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:23:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4321840913
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IT/TaXZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4rFmMK4HTfhB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C8594090E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C8594090E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675135392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ltkBGnwECMJmhbD7vrl7YLMiwdLoKe7LIr5e2nHG3PQ=;
 b=IT/TaXZZZKYCy7F4nufb6I8iLeHMIjgwb5hvf8zEAsWROv/Rd6JJ3z+oC5OOwsimU1f3D8
 vpNmNcKWosALB9hJxaBA78DGkgcKMRgpV+SeVkYbTwNeNcLTiTJJOi/vKtXDAkGFEkwLPD
 tNhnY6/tGuovF+IGKesloRupkiHAdwE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-2C5vC4W8Ov2_BvRqCLsKkQ-1; Mon, 30 Jan 2023 22:23:10 -0500
X-MC-Unique: 2C5vC4W8Ov2_BvRqCLsKkQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 a26-20020a9d6e9a000000b0068be36dbc0bso36030otr.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ltkBGnwECMJmhbD7vrl7YLMiwdLoKe7LIr5e2nHG3PQ=;
 b=I6DPQQoQiOo/C8+7UNE66xVp3P5lRlblOSjkIjM2uJzSPISYJDKyt9dGePhE964iY1
 C/EvIN81LC4JQp6pTau41xyKgG0kD/XG9NDU6U97kNTC5MsD2LdXca4QAsAR4F+mp+60
 nntl0ajdUMp28TbkQZjA72wobtNe4Fftr930Dhzd7wyxb1/CFrvCpRoOXifSVYKc4Zdv
 ihDrXbShkymHI0xhfKFrbSo9JwkiVXxI5DxqVfLEpqxD6CZnmceSYU0F8l6Oi6puCQjF
 paAkEI6daWusO6479WB9YUqLKsdOI/x+wERrmDIsWmS7lyms+rLeLJwHa7wEsuqDk5yg
 BnbQ==
X-Gm-Message-State: AO0yUKUS6qjpyhk8HdsGaFyGK8lZaoZCS1sHU2Chj3Tax5b20eor5XlL
 qaw/3hKpPKgNe+xY1wC3UK2Iltysvs41I1Q98uGzGRFtetBzVF67duhLRZodUzG8ou3pR/e29RT
 mslkj7bwyH31i94+g5oiXRBWld5AwGuXf2BqrRzEABcEQOMqeqoogJ5R59Q==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr567823oao.35.1675135387508; 
 Mon, 30 Jan 2023 19:23:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9Hu2HFEDPiDGXCaNnCjpBr1M/3mkKYHDHH6RsQ5EtesD62XsOTK7GEj1aXmBl8gjJeRQSyQJytKuQEUWxkdJU=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr567795oao.35.1675135387309; Mon, 30 Jan
 2023 19:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-10-hch@lst.de>
 <20230130101747-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230130101747-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 11:22:56 +0800
Message-ID: <CACGkMEuoqJP4S+jz8Tt5K72i-w5qBhuheTiCWaRLxUBfYS_jQg@mail.gmail.com>
Subject: Re: [PATCH 09/23] virtio_blk: use bvec_set_virt to initialize
 special_vec
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>,
 target-devel@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, linux-afs@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 30, 2023 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jan 30, 2023 at 10:21:43AM +0100, Christoph Hellwig wrote:
> > Use the bvec_set_virt helper to initialize the special_vec.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>
> > ---
> >  drivers/block/virtio_blk.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6a77fa91742880..dc6e9b989910b0 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -170,9 +170,7 @@ static int virtblk_setup_discard_write_zeroes_erase(struct request *req, bool un
> >
> >       WARN_ON_ONCE(n != segments);
> >
> > -     req->special_vec.bv_page = virt_to_page(range);
> > -     req->special_vec.bv_offset = offset_in_page(range);
> > -     req->special_vec.bv_len = sizeof(*range) * segments;
> > +     bvec_set_virt(&req->special_vec, range, sizeof(*range) * segments);
> >       req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> >
> >       return 0;
> > --
> > 2.39.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
