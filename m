Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C4C433DF
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 14:50:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BF02078E
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCV3RSk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BF02078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A19EF87F44;
	Tue, 11 Aug 2020 14:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BM2EuNpXNsx4; Tue, 11 Aug 2020 14:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FA68875B2;
	Tue, 11 Aug 2020 14:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1C8BC07FF;
	Tue, 11 Aug 2020 14:50:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44A34C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 14:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 243822010C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 14:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2ZbDMGCmvKK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 14:50:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id EC0F51FD90
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597157398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mcR0YSpNfzoCNOfoOspUyIDAzLMStXOEsUjhKacxpw=;
 b=hCV3RSk2fEYfahzB6kLbhrJeQW0K1kYe03qbMPD6e1uOq9PAum5y5cn88PgDQ10ZSfzjCC
 Zf+xHgNMAql1GDPpx4z08XSWi0Dyc7qQC+g8ZRp2s/zZ1pDXISTM7ibeF8Er7r4uO+TlNy
 EWeyIihoubHpqum7f/Dn+8Wy7gVjAwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-mpr7WmvqPw6Sx7q50Ohs7w-1; Tue, 11 Aug 2020 10:49:57 -0400
X-MC-Unique: mpr7WmvqPw6Sx7q50Ohs7w-1
Received: by mail-wm1-f69.google.com with SMTP id k204so831583wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+mcR0YSpNfzoCNOfoOspUyIDAzLMStXOEsUjhKacxpw=;
 b=PERG4D8BFIGS/KzZz3cE9cAhlmuTdR/nEZC49sFsaPdlxRX2/bo3tmw/6l3JxPg94h
 dgf9+JTxhu5vS36NV2CpRyqionzw2ocy8lu+4G/wmek1qN4Yk4mTqdVxNkCF3Vhj2Vsp
 Ofiys0ODZcQ7bSJIXiz2o+JRgQjEjZt0BASZXi5pmWRXH7/dihw47O/ghmuQCs0udZSD
 /CtcIfKEjGFiJyoYAGn1cupH+7u6X8zD7us7YfXIblzTrA+MtQbrJA5DpqY4wb2+X2GC
 IDRs+H3QYw9AJ2rAdIrQG7GEHZ77tjtQdVp0QgEe4+XqAh10/QS2S/6+Feqxvwrcf68w
 KDrA==
X-Gm-Message-State: AOAM5313nJvBEGsWNvt/s9NzLtFmEZHjMHlf7w7npRfhsNjxc1tAUPLw
 k7wXui8zgcYn/tLnb7f1T7pj3tfX7+FZExqJKJYZw6F2VD5EP7yOlzd5/YaGwGWUryaXyKqbWgo
 6AD9nEL0WyAM/MxDkLIHYuzpv9wqy2QsosnNGSAJFxg==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4226028wmc.26.1597157395920;
 Tue, 11 Aug 2020 07:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwESjUvg3ZtGmR8tFEYPDG2mdGUWbhxJ9k0v2hx/wvji6m8VXP/4+bTLX6P8xSWtD7zlvVjAA==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4226008wmc.26.1597157395678;
 Tue, 11 Aug 2020 07:49:55 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id o2sm5196412wmh.5.2020.08.11.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 07:49:54 -0700 (PDT)
Date: Tue, 11 Aug 2020 10:49:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811104756-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
 <7affb721-9686-1262-b7cf-d9681646b602@redhat.com>
 <810451cf80032d131d5d3feb4fc8300549516f3d.camel@suse.com>
 <b764a4bb-b81f-b14f-9b7f-d6d087a8b1ea@redhat.com>
 <b8b19be7fd9b3fab629506eb30d9f0c820aa57d2.camel@suse.com>
 <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
 <20200811090814-mutt-send-email-mst@kernel.org>
 <a9179d2b-35fb-26ab-1afd-9952cc3ae008@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a9179d2b-35fb-26ab-1afd-9952cc3ae008@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Martin Wilck <mwilck@suse.com>
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

On Tue, Aug 11, 2020 at 03:53:54PM +0200, Laurent Vivier wrote:
> On 11/08/2020 15:14, Michael S. Tsirkin wrote:
> > On Tue, Aug 11, 2020 at 03:00:14PM +0200, Laurent Vivier wrote:
> >> No problem. This code is tricky and it took me several months to really
> >> start to understand it ...
> > 
> > Oh great, we actually have someone who understands the code!
> > Maybe you can help me understand: virtio_read
> > takes the buf pointer and puts it in the vq.
> > It can then return to caller (e.g. on a signal).
> > Device can meanwhile write into the buffer.
> > 
> > It looks like if another call then happens, and that
> > other call uses a different buffer, virtio rng
> > will happily return the data written into the
> > original buf pointer, confusing the caller.
> > 
> > Is that right?
> > 
> 
> Yes.
> 
> hw_random core uses two bufers:
> 
> - rng_fillbuf that is used with a blocking access and protected by the
> reading_mutex. I think this cannot be interrupted by a kill because it's
> in  hwrng_fillfn() and it's kthread.
> 
> - rng_buffer that is used in rng_dev_read() and can be interrupted (it
> is also protected by reading_mutex)
> 
> But if rng_dev_read() is called with O_NONBLOCK or interrupted and then
> rng_fillbuf starts they can be mixed.
> 
> We have also the first use of rng_buffer in add_early_randomness() that
> use a different size than in rng_dev_read() with the same buffer (and
> this size is 16 whereas the hwrng read API says it must be at least 32...).
> 
> The problem here is core has been developped with synchronicity in mind,
> whereas virtio is asynchronous by definition.
> 
> I think we should add some internal buffers in virtio-rng backend. This
> would improve performance (we are at 1 MB/s, I sent a patch to improve
> that, but this doesn't fix the problems above), and allows hw_random
> core to use memory that doesn't need to be compatible with virt_to_page().
> 
> Thanks,
> Laurent

OK so just add a bunch of 32 bit buffers and pass them to hardware,
as they data gets consumed pass them to hardware again?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
