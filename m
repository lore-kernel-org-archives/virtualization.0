Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81135C433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 01:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7CE61356
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 01:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D7CE61356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77E5C83BE9;
	Tue, 19 Oct 2021 01:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PZk0PpcdHwta; Tue, 19 Oct 2021 01:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF74A83BEB;
	Tue, 19 Oct 2021 01:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7990CC0020;
	Tue, 19 Oct 2021 01:22:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0155AC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8636406AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BqB336gftIe1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A490A406AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 01:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634606548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAWMrVJYLpXAoOvCUd/tM5Gm44xehWjfXcNdmzTezCc=;
 b=eOE42G7nv4RZyuieKssCzYHUXckoLp29MkpHYXSO6p1vjWF4XjJV8YhGl4rCsHwR5BhBdo
 I0SsRjhftBcNhpb9rjpOu1HpK4rRgcdV6HxLVeWeHESmKSapG3zbswd4P47E8NyazEk9Kg
 zzz2kULpH7DZgSjlN8x+4zl9Aqz6bsI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-R20oU8j-MJ20lt_HPjrLfA-1; Mon, 18 Oct 2021 21:22:27 -0400
X-MC-Unique: R20oU8j-MJ20lt_HPjrLfA-1
Received: by mail-lf1-f69.google.com with SMTP id
 k18-20020a05651210d200b003fd86616d39so767414lfg.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 18:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PAWMrVJYLpXAoOvCUd/tM5Gm44xehWjfXcNdmzTezCc=;
 b=Jxsv9Vax45H5JlK5ho5UD1UeM8rANbPUQjaZXLzdqhkKJaMpjKT9YGbNzjmgo3ickp
 Xl4vAxuSNkxOMj1UPJ2fNXosY3yaDOyKWRns+gZu6mFa3FWN34bLMHaPJr6YsmJzEoGu
 UmOGvrITRtasYOg7FRmDyGXiX5LmSLQcdXXqa4DGufT678hRkBDs5wqEC9a3abfiZQdj
 qe/Whd+evmT0CQrHM+tXX8DDRVrDQLDlWjS0Xf+aSPilRXGkOZyc2tUV9oIP3L2c/Meo
 wri7RoVBdsVWmabZNDz/f9YjqDuMVEzxbpWEaJ2lNwRCOVxjlzFPfHe2vhNdYeLwLWOv
 VhOg==
X-Gm-Message-State: AOAM533b6sCVirftkaJ2GBVbwry1Pzqc9S9cwrIdll6qqFnoJP0teJoc
 OhNCHFUOYYfV5PGLt4lH7cbWn7B0uEhOmOqK8ucI5zKq4vWjaocJU7o4iyUihL/MUhJV7Ot1o4J
 XEpKizA5CoO9mPDmJqV3pBRw/7p0TOTtHKmxXhvysmccDkxyBZ4fUaJSGVA==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr3438900ljd.362.1634606545711; 
 Mon, 18 Oct 2021 18:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx2VZpO94ATTLdLFfRE+4QfWp6/JFORuL5M9U6kAQ0JTPA55qnbYtwgWI3nfmFfTLzmXBBmOcvD4FuX2UkHI0=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr3438859ljd.362.1634606545252; 
 Mon, 18 Oct 2021 18:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW2RfXJwAxFYOYzs@myrica> <20211018113237-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211018113237-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Oct 2021 09:22:13 +0800
Message-ID: <CACGkMEuJrQcPSMdRJ9wmc3riLK_3Q6t9596b5ida-j00Yf7+WQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "will@kernel.org" <will@kernel.org>
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

On Mon, Oct 18, 2021 at 11:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 18, 2021 at 04:23:41PM +0100, Jean-Philippe Brucker wrote:
> > On Thu, Oct 14, 2021 at 03:00:38AM +0000, Tian, Kevin wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Sent: Wednesday, October 13, 2021 8:11 PM
> > > >
> > > > Support identity domains, allowing to only enable IOMMU protection for a
> > > > subset of endpoints (those assigned to userspace, for example). Users
> > > > may enable identity domains at compile time
> > > > (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> > > > (iommu.passthrough=1) or
> > > > runtime (/sys/kernel/iommu_groups/*/type = identity).
> > >
> > > Do we want to use consistent terms between spec (bypass domain)
> > > and code (identity domain)?
> >
> > I don't think we have to. Linux uses "identity" domains and "passthrough"
> > IOMMU. The old virtio-iommu feature was "bypass" so we should keep that
> > for the new one, to be consistent. And then I've used "bypass" for domains
> > as well, in the spec, because it would look strange to use a different
> > term for the same concept. I find that it sort of falls into place: Linux'
> > identity domains can be implemented either with bypass or identity-mapped
> > virtio-iommu domains.
> >
> > > >
> > > > Patches 1-2 support identity domains using the optional
> > > > VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> > > > spec, see [1] for the latest proposal.
> > > >
> > > > Patches 3-5 add a fallback to identity mappings, when the feature is not
> > > > supported.
> > > >
> > > > Note that this series doesn't touch the global bypass bit added by
> > > > VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU
> > > > should
> > > > be attached to a domain, so global bypass isn't in use after endpoints
> > >
> > > I saw a concept of deferred attach in iommu core. See iommu_is_
> > > attach_deferred(). Currently this is vendor specific and I haven't
> > > looked into the exact reason why some vendor sets it now. Just
> > > be curious whether the same reason might be applied to virtio-iommu.
> > >
> > > > are probed. Before that, the global bypass policy is decided by the
> > > > hypervisor and firmware. So I don't think Linux needs to touch the
> > >
> > > This reminds me one thing. The spec says that the global bypass
> > > bit is sticky and not affected by reset.
> >
> > The spec talks about *device* reset, triggered by software writing 0 to
> > the status register, but it doesn't mention system reset. Would be good to
> > clarify that. Something like:
> >
> >     If the device offers the VIRTIO_IOMMU_F_BYPASS_CONFIG feature, it MAY
> >     initialize the \field{bypass} field to 1. Field \field{bypass} SHOULD
> >     NOT change on device reset, but SHOULD be restored to its initial
> >     value on system reset.
> >
> > > This implies that in the case
> > > of rebooting the VM into a different OS, the previous OS actually
> > > has the right to override this setting for the next OS. Is it a right
> > > design? Even the firmware itself is unable to identify the original
> > > setting enforced by the hypervisor after reboot. I feel the hypervisor
> > > setting should be recovered after reset since it reflects the
> > > security measure enforced by the virtual platform?
> >
> > So I think clarifying system reset should address your questions.
> > I believe we should leave bypass sticky across device reset, so a FW->OS
> > transition, where the OS resets the device, does not open a vulnerability
> > (if bypass was enabled at boot and then left disabled by FW.)
> >
> > It's still a good idea for the OS to restore on shutdown the bypass value
> > it was booted with. So it can kexec into an OS that doesn't support
> > virtio-iommu, for example.
> >
> > Thanks,
> > Jean
>
> Is this stickiness really important? Can't this be addressed just by
> hypervisor disabling bypass at boot?

And I'm not sure if sticky can survive transport reset.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
