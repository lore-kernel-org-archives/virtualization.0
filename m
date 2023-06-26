Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ADAEB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 09:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B7D8817EB;
	Mon, 26 Jun 2023 09:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B7D8817EB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FqHsMQ5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cwD5CEI_zPkp; Mon, 26 Jun 2023 09:51:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A673818C4;
	Mon, 26 Jun 2023 09:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A673818C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36D19C0037;
	Mon, 26 Jun 2023 09:51:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F049C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE705410CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:51:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE705410CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=FqHsMQ5v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDa6encP7E0R
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:51:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A64A240A02
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A64A240A02
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:51:52 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b69e6cce7dso14440801fa.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687773110; x=1690365110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ggM1N3+w7ImiNtAZHXArGd84Z6U6HJ8t/slQ492qkA=;
 b=FqHsMQ5vsBUDTg8Qu45FvgnX3xqTLM97k8uX6dT/yu2Eb3hdcwpsoETC22q1iX2xjI
 fdRw4/PINKAYt0ptvLnXp8jq3UXTYTqk2hePWziqEWMDUpQ9ZL94UKNH5uYuleyzC/E0
 WQ4YJVsU1d9unRENNAHKCjlXBr24hGZ1ZgGFMvJcHD0JDn0611kKx0hHNFhKOXALI+go
 iEdWMF5DbOsUA476EvEUvA6sEu+NtNHD+XLeq4+UAwclbBkkMCW2fX8wi5gShPXUTayH
 iShaJjMDyqVrAsSbcbwWrtHlvR3MkGOf7N5/MZguV3gX8fs9AFBigPXxMjNo8xmmIux4
 pfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773110; x=1690365110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ggM1N3+w7ImiNtAZHXArGd84Z6U6HJ8t/slQ492qkA=;
 b=OEOe8imxByaBS+/EAHa/5kFolsnnFFfmDp2X3WbvZM6xCbQsGjXZBwjpDCbMWt14zb
 Cr+GZ5DsPrOvx42FDO+/W+i8CAaZnbAYOnGiI0eDZ9vFIDXAl3PaHhkyNXMqTCedb+rt
 nlXu0b/uNfMmPtG3I1JWXEZQ7dbwZpppG3jL/GAhFKACbxEyRelQqH1wqzRhpLur2dLM
 CMBSwHbLQ12mkaZWR2nQg2CIpdb5/8zmo78eCqkUsvvyaAJR1Zn6ewyA47Q3AIcJEYOC
 fFtNhk9ca5WdMLzT3AZBBPS5nLHsvcnMSPfye9JNNsygRvNMavDK7FL+L5oB1Nu23Th1
 J60g==
X-Gm-Message-State: AC+VfDzC7F71L2Gljbm8CI8tPo1PVMtJ9MsV3nwFIRRdHPBu7r6OBOQ8
 mrQYp4d8ANCeU0sFZKbpW8ihgQ==
X-Google-Smtp-Source: ACHHUZ6z1CFWIkB585T4AsGvxgWrYm0aA3bqu065Ypw3q/WfLWUkxYhOjK8FkfMVQVPSogtwBbHaIQ==
X-Received: by 2002:a2e:948b:0:b0:2b4:491d:8d53 with SMTP id
 c11-20020a2e948b000000b002b4491d8d53mr17150106ljh.45.1687773110465; 
 Mon, 26 Jun 2023 02:51:50 -0700 (PDT)
Received: from larix ([2a02:8428:1671:f801:5eff:2156:7b9f:50c2])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a0560001b0400b00307a86a4bcesm6879642wrz.35.2023.06.26.02.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 02:51:50 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:51:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJlftJF9ufnBMjHi@larix>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <20230616113232.GA84678@myrica>
 <bc963573-f4d3-1467-daaf-2d85f6befe3f@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc963573-f4d3-1467-daaf-2d85f6befe3f@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>,
 iommu@lists.linux.dev, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-kselftest@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

On Mon, Jun 19, 2023 at 11:35:50AM +0800, Baolu Lu wrote:
> > Another outstanding issue was what to do for PASID stop. When the guest
> > device driver stops using a PASID it issues a PASID stop request to the
> > device (a device-specific mechanism). If the device is not using PRI stop
> > markers it waits for pending PRs to complete and we're fine. Otherwise it
> > sends a stop marker which is flushed to the PRI queue, but does not wait
> > for pending PRs.
> > 
> > Handling stop markers is annoying. If the device issues one, then the PRI
> > queue contains stale faults, a stop marker, followed by valid faults for
> > the next address space bound to this PASID. The next address space will
> > get all the spurious faults because the fault handler doesn't know that
> > there is a stop marker coming. Linux is probably alright with spurious
> > faults, though maybe not in all cases, and other guests may not support
> > them at all.
> > 
> > We might need to revisit supporting stop markers: request that each device
> > driver declares whether their device uses stop markers on unbind() ("This
> > mechanism must indicate that a Stop Marker Message will be generated."
> > says the spec, but doesn't say if the function always uses one or the
> > other mechanism so it's per-unbind). Then we still have to synchronize
> > unbind() with the fault handler to deal with the pending stop marker,
> > which might have already gone through or be generated later.
> 
> I don't quite follow here. Once a PASID is unbound from the device, the
> device driver should be free to release the PASID. The PASID could then
> be used for any other purpose. The device driver has no idea when the
> pending page requests are flushed after unbind(), so it cannot decide
> how long should the PASID be delayed for reuse. Therefore, I understand
> that a successful return from the unbind() function denotes that all
> pending page requests have been flushed and the PASID is viable for
> other use.

Yes that's the contract for unbind() at the moment

> 
> > 
> > Currently we ignore all that and just flush the PRI queue, followed by the
> > IOPF queue, to get rid of any stale fault before reassigning the PASID. A
> > guest however would also need to first flush the HW PRI queue, but doesn't
> > have a direct way to do that. If we want to support guests that don't deal
> > with stop markers, the host needs to flush the PRI queue when a PASID is
> > detached. I guess on Intel detaching the PASID goes through the host which
> > can flush the host queue. On Arm we'll probably need to flush the queue
> > when receiving a PASID cache invalidation, which the guest issues after
> > clearing a PASID table entry.
> 
> The Intel VT-d driver follows below steps to drain pending page requests
> when a PASID is unbound from a device.
> 
> - Tear down the device's pasid table entry for the stopped pasid.
>   This ensures that ATS/PRI will stop putting more page requests for the
>   pasid in VT-d PRQ.

Oh that's interesting, I didn't know about the implicit TLB invalidations
on page requests for VT-d.

For Arm SMMU, clearing the PASID table entry does cause ATS Translation
Requests to return with Completer Abort, but does not affect PRI. The SMMU
pushes page requests directly into the PRI queue without reading any table
(unless the queue overflows).

We're counting on the device driver to perform the PASID stop request
before calling unbind(), described in PCIe 6.20.1 (Managing PASID Usage)
and 10.4.1.2 (Managing PASID Usage on PRG Requests). This ensures that
when unbind() is called, no more page request for the PASID is pushed into
the PRI queue. But some may still be in the queue if the device uses stop
markers.

> - Sync with the PRQ handling thread until all related page requests in
>   PRQ have been delivered.

This is what I'm concerned about. For VT-d this happens in the host which
is in charge of modifying the PASID table. For SMMU, the guest writes the
PASID table. It flushes its virtual PRI queue, but not the physical queue
that is managed by the host.

One synchronization point where the host could flush the physical PRI
queue is the PASID config invalidation (CMD_CFGI_CD). As Jason pointed out
the host may not be able to observe those if a command queue is assigned
directly to the guest (a theoretical SMMU extension), though in that case
the guest may also have direct access to a PRI queue (like the AMD vIOMMU
extension) and be able to flush the queue directly.

But we can just wait for PRI implementations and see what the drivers
need. Maybe no device will implement stop markers.

Thanks,
Jean

> - Flush the iopf queue with iopf_queue_flush_dev().
> - Follow the steps defined in VT-d spec section 7.10 to drain all page
>   requests and responses between VT-d and the endpoint device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
