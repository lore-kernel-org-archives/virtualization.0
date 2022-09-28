Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEA2C04A95
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 10:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE95B4058D;
	Wed, 28 Sep 2022 10:03:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE95B4058D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTKEVzp/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRHJWtdcmrgO; Wed, 28 Sep 2022 10:03:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B188404B2;
	Wed, 28 Sep 2022 10:03:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B188404B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AEADC0033;
	Wed, 28 Sep 2022 10:03:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60077C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2658482A2D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2658482A2D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTKEVzp/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hnye-d68eGLf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B0368175F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B0368175F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664359395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
 b=ZTKEVzp/8jt+gc7YokwfQkqJfgY3CUCb5I85vlViXoLUKueXNKO7YClZesZcHpGhNeH7E3
 /H1vO3dcos/dWokBOe1g30vB8tiILV7AIs+CNHk0ihm8JUYYvmj74J7EueGMUO0PuVucXc
 kEMIbqXgbWg1uGiFpKVNiYXyYX6uiu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-F2Eep0x7MrKPTGfTSjLleg-1; Wed, 28 Sep 2022 06:03:13 -0400
X-MC-Unique: F2Eep0x7MrKPTGfTSjLleg-1
Received: by mail-wm1-f71.google.com with SMTP id
 r128-20020a1c4486000000b003b3309435a9so189184wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=uGN/gn+YJZ4VIu5yaP7PXBIwmM0Ss1jImh/D5mV3zS0=;
 b=ryEUCpIjjvbrIpZ1xWx2e+wccfmHFBhvs1LU1JBFd7nwfe255Q4ffVTJI+kQbi/Y6h
 lxTmwC1UkM6QkYyousMRBgiVPYzoA0dh3H2CBhX+KmiSE4c/5fkohK7Y5w+sM3O2cy6n
 mIhT7DVlt8b3F77XMXGpp25t4qIY4/ABMsuGYbPlYSu5KwRXAJepgIw7ooqDxPVosk/s
 aK8DakZqJkmPo1WwHBhDMFsFBAK9qU6ohIqAs+VKT3efpOvRwBta6tVKab0xZAJOYL0G
 4EMRVme3/SYd9GU3v7FjfnrWkSzbI+kG+f29qK5g/WBfbUQgfHgTExT2jVjaN4KKmZai
 aK4Q==
X-Gm-Message-State: ACrzQf39TDshqqDk3y7E0lSsyBix0EhgWtGmt8quIm5ZnqW3wpcqtar+
 r0KrCsFo0Js89TXXdV7Du5Iz190Mr+8/OMD8ysYGOIYbaJCUTv63IOoDjPDu7VgYp84QAQHGEfT
 LVPq4YNQdgc4cl0cvT4NvM3Bqwie6Ryn4Hlnfq+lcRQ==
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id
 c5-20020a056000184500b0022a4b7a6f55mr19857122wri.288.1664359392581; 
 Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DD+7gws/rgYCF8YbDNblzEgE00DKcFR13//n9kKka+r2jpPDo/QMjf3VuTYnwOCnvOIKbew==
X-Received: by 2002:a05:6000:1845:b0:22a:4b7a:6f55 with SMTP id
 c5-20020a056000184500b0022a4b7a6f55mr19857103wri.288.1664359392370; 
 Wed, 28 Sep 2022 03:03:12 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfcd90000000b0022cbf4cda62sm4051657wrj.27.2022.09.28.03.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 03:03:11 -0700 (PDT)
Date: Wed, 28 Sep 2022 06:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20220928055718-mutt-send-email-mst@kernel.org>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
 <20220927163723-mutt-send-email-mst@kernel.org>
 <20220928094545.GA19646@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220928094545.GA19646@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 Liming Wu <liming.wu@jaguarmicro.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, Angus Chen <angus.chen@jaguarmicro.com>,
 pbonzini@redhat.com, tglx@linutronix.de
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

On Wed, Sep 28, 2022 at 11:45:45AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 04:47:20PM -0400, Michael S. Tsirkin wrote:
> > > The log :
> > > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > > was print because of the irq 0 is used by timer exclusive,and when
> > > vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> > > call vp_find_vqs_intx for the last try.
> > > Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> > > flag IRQF_SHARED.
> > 
> > First this is a bug. We can fix that so it will fail more cleanly.
> > 
> > We should check pci_dev->pin and if 0 do not try to use INT#x
> > at all.
> > It will still fail, just with a nicer backtrace.
> 
> How do we end up with a pci_dev without a valid PIN?

This patch is broken but there's no v3 which looks right,
and includes an explanation.

>  Btw, that whole
> vp_find_* code looks extremely fucked up to me.  The whole point of
> pci_alloc_irq_vectors* API is that it keeps drivers from poling into
> details of MSI-X v MSI vs INTX.

Poking? I think that code predates that, a minimal change was
made to support affinity... but again, it does not look like the
main issue has anything to do with that. Or maybe I'm wrong ...

> > - because of auto affinity, we try to reserve an interrupt on all CPUs
> > - as there are 512 devices with a single vector per VQ we would
> >   have no issue as they would be spread between CPUs,
> >   but allocating on all CPUs fails.
> > 
> > 
> > I don't think the issue should be fixed at blk level - it is not
> > blk specifix - but yes this looks like a problem.
> > Christoph, any idea?
> 
> I think this goes into the low-level interrupt vector allocator.  I think
> Thomas is still the expert on it.

syzbot is also telling us there's an issue in next (and not due to
virtio changes - I intentionally removed most of them for a while
and the issue was there) but I could not figure it out.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
