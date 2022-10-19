Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59645C43217
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 05:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E156E813C6;
	Wed, 19 Oct 2022 05:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E156E813C6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Voh8+8or
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CbpUxGhttjOM; Wed, 19 Oct 2022 05:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BABB813D0;
	Wed, 19 Oct 2022 05:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BABB813D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB49C0032;
	Wed, 19 Oct 2022 05:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A78EEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6662060A6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6662060A6F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Voh8+8or
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLr0dvPd_p-B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2176E605C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2176E605C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 05:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666159116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqNgzDPaWWHyoLaC733Qdl7ljuE8EbGh7ekgiNrTuhE=;
 b=Voh8+8or4jLl6HHFsY37sjm0b2zLp6TWy7O3WFs+2xXsDSwNkwSCm8XuEOFoSN+syQFz7B
 XbARAMWyodMf18DQnnwtTHPoKBXe+ohINBzcqw43HUViINWaESL9pBEkJSor9tKLmMHzdt
 hap7bFsBxgJFWd9JBUhhi28qj7WpBs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-308-QGz4jf5LMkGMW5AuPpxfnA-1; Wed, 19 Oct 2022 01:58:35 -0400
X-MC-Unique: QGz4jf5LMkGMW5AuPpxfnA-1
Received: by mail-wr1-f70.google.com with SMTP id
 t12-20020adfa2cc000000b0022adcbb248bso5168910wra.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 22:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqNgzDPaWWHyoLaC733Qdl7ljuE8EbGh7ekgiNrTuhE=;
 b=SyJsWREx4we632G1B7g7nXv+F4kA3CRM0hjNJQhgJu23sTmcpXWwACSozQAsnL2hWS
 pzbmeNxPoy1EcbwQ0rXHhUs0wVtrVRzjYcSHnZq0lntiInZUPA+yC0zJ4ZTkdtecASzS
 SpGOekUb6oIUcYvQSAZrTlaZF+i7JJRxP6UbmbfPqqUfSl824w1urpnRuBZXiqpqTBds
 NbgcJQKuIjeEONjn+2TwofQAFGWDRk1Fu6YP3pKcTX+WUkbyq/3oktBL2hgdiiiQBTn6
 6LxyHtDcw6We/CCrblwnhEha+cJM/7EVz7n+VtKhtTgps0UHH1RoElKtT4RAht5HuGVs
 YjGQ==
X-Gm-Message-State: ACrzQf1TPFq0gqCNTIVY5Ug0OKFfUcsFSJbTA54eW+SUihZEFWwsugTw
 bdmGVGL6fCnYP6wohLpLBmI9BB9BilWvF6QtQ2+FT1V/ykd7Ff3kM1I//AcCaJ8efjcQ292Eb58
 UGRG5T6L68A8/eZ049sUtKvYVE24a6hKRsHeuxz9YLA==
X-Received: by 2002:a5d:410c:0:b0:22e:632a:9bc0 with SMTP id
 l12-20020a5d410c000000b0022e632a9bc0mr3969819wrp.696.1666159113923; 
 Tue, 18 Oct 2022 22:58:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ydgSy7J+rRd/x5USsw37lsUYGP8h1BG06y3ia3UhlbPnNx/Sat2sTQ4QAGd4xLnHJpGbqQw==
X-Received: by 2002:a5d:410c:0:b0:22e:632a:9bc0 with SMTP id
 l12-20020a5d410c000000b0022e632a9bc0mr3969806wrp.696.1666159113695; 
 Tue, 18 Oct 2022 22:58:33 -0700 (PDT)
Received: from redhat.com ([2.54.191.184]) by smtp.gmail.com with ESMTPSA id
 i29-20020a1c541d000000b003c41144b3cfsm20704885wmb.20.2022.10.18.22.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 22:58:33 -0700 (PDT)
Date: Wed, 19 Oct 2022 01:58:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH AUTOSEL 4.9 8/8] virtio_pci: don't try to use intxif pin
 is zero
Message-ID: <20221019015706-mutt-send-email-mst@kernel.org>
References: <20221018001202.2732458-1-sashal@kernel.org>
 <20221018001202.2732458-8-sashal@kernel.org>
 <TY2PR06MB3424671C418DAEF5E1B7E57C852B9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB3424671C418DAEF5E1B7E57C852B9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Sasha Levin <sashal@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Wed, Oct 19, 2022 at 12:27:46AM +0000, Angus Chen wrote:
> Hi sasha
> 
> > -----Original Message-----
> > From: Sasha Levin <sashal@kernel.org>
> > Sent: Tuesday, October 18, 2022 8:12 AM
> > To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Cc: Angus Chen <angus.chen@jaguarmicro.com>; Michael S . Tsirkin
> > <mst@redhat.com>; Sasha Levin <sashal@kernel.org>; jasowang@redhat.com;
> > virtualization@lists.linux-foundation.org
> > Subject: [PATCH AUTOSEL 4.9 8/8] virtio_pci: don't try to use intxif pin is zero
> > 
> > From: Angus Chen <angus.chen@jaguarmicro.com>
> > 
> > [ Upstream commit 71491c54eafa318fdd24a1f26a1c82b28e1ac21d ]
> > 
> > The background is that we use dpu in cloud computing,the arch is x86,80
> > cores. We will have a lots of virtio devices,like 512 or more.
> > When we probe about 200 virtio_blk devices,it will fail and
> > the stack is printed as follows:
> > 
> > [25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
> > [25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00
> > (timer)
> > [25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted:
> > G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
> > [25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS
> > 4.1.21 08/25/2021
> > [25338.523881] Workqueue: events work_for_cpu_fn
> > [25338.528235] Call Trace:
> > [25338.530687]  dump_stack+0x5c/0x80
> > [25338.534000]  __setup_irq.cold.53+0x7c/0xd3
> > [25338.538098]  request_threaded_irq+0xf5/0x160
> > [25338.542371]  vp_find_vqs+0xc7/0x190
> > [25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
> > [25338.550223]  ? ncpus_cmp_func+0x10/0x10
> > [25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
> > [25338.558846]  virtio_dev_probe+0x158/0x1f0
> > [25338.562861]  really_probe+0x255/0x4a0
> > [25338.566524]  ? __driver_attach_async_helper+0x90/0x90
> > [25338.571567]  driver_probe_device+0x49/0xc0
> > [25338.575660]  bus_for_each_drv+0x79/0xc0
> > [25338.579499]  __device_attach+0xdc/0x160
> > [25338.583337]  bus_probe_device+0x9d/0xb0
> > [25338.587167]  device_add+0x418/0x780
> > [25338.590654]  register_virtio_device+0x9e/0xe0
> > [25338.595011]  virtio_pci_probe+0xb3/0x140
> > [25338.598941]  local_pci_probe+0x41/0x90
> > [25338.602689]  work_for_cpu_fn+0x16/0x20
> > [25338.606443]  process_one_work+0x1a7/0x360
> > [25338.610456]  ? create_worker+0x1a0/0x1a0
> > [25338.614381]  worker_thread+0x1cf/0x390
> > [25338.618132]  ? create_worker+0x1a0/0x1a0
> > [25338.622051]  kthread+0x116/0x130
> > [25338.625283]  ? kthread_flush_work_fn+0x10/0x10
> > [25338.629731]  ret_from_fork+0x1f/0x40
> > [25338.633395] virtio_blk: probe of virtio418 failed with error -16
> > 
> > The log :
> > "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> > was printed because of the irq 0 is used by timer exclusive,and when
> > vp_find_vqs call vp_find_vqs_msix and returns false twice (for
> > whatever reason), then it will call vp_find_vqs_intx as a fallback.
> > Because vp_dev->pci_dev->irq is zero, we request irq 0 with
> > flag IRQF_SHARED, and get a backtrace like above.
> > 
> > According to PCI spec about "Interrupt Pin" Register (Offset 3Dh):
> > "The Interrupt Pin register is a read-only register that identifies the
> >  legacy interrupt Message(s) the Function uses. Valid values are 01h, 02h,
> >  03h, and 04h that map to legacy interrupt Messages for INTA,
> >  INTB, INTC, and INTD respectively. A value of 00h indicates that the
> >  Function uses no legacy interrupt Message(s)."
> > 
> > So if vp_dev->pci_dev->pin is zero, we should not request legacy
> > interrupt.
> > 
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20220930000915.548-1-angus.chen@jaguarmicro.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c
> > b/drivers/virtio/virtio_pci_common.c
> > index 37e3ba5dadf6..d634eb926a2f 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -389,6 +389,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned
> > nvqs,
> >  				 true, false);
> >  	if (!err)
> >  		return 0;
> > +	/* Is there an interrupt pin? If not give up. */
> > +	if (!(to_vp_device(vdev)->pci_dev->pin))
> > +		return err;
> >  	/* Finally fall back to regular interrupts. */
> >  	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> >  				  false, false);
> > --
> > 2.35.1
> 
> the patch 71491c54eafa31 has been fixed by 2145ab513e3b3,
> It is report by Michael Ellerman <mpe@ellerman.id.au> and suggested by linus.
> If it is merged in the stable git repo, I worry about powerpc arch.
> Thans.

Yes, please either pick up both this and the fixup or none, and
same for all other stable trees where this was autoselected.

It looks like autoselection basically picks up everything that
has a Fixes tag in it yes?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
