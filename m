Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFEC433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 15:35:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909E610C8
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 15:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0909E610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1E8383027;
	Mon, 18 Oct 2021 15:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmzDqkuxJT2S; Mon, 18 Oct 2021 15:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A80D8267F;
	Mon, 18 Oct 2021 15:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089ADC000F;
	Mon, 18 Oct 2021 15:35:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40123C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E3B740427
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nSJf-5EMWOx4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D902C40426
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634571301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSDVw663rgR4LnzvWfNb/swIWuQxbUZSWle1d9fqt9E=;
 b=XXCE6ixbCC8lVRx9QFtgjVhwe7QbDRIt6hnViDC2XY4DvjduJcky2Nuc11LJqEKIi8957H
 8eYnAZCPyiVnQ/nh+NSwitpOl0S0bW2xatsGza4bKVusMbGIY1c6Tjj3/PEjHTNrG9GIg4
 mFG5iMKq26N69i0Etv0X68FmOhRdt3M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-RQyciMd1M2aDQvsms3J59g-1; Mon, 18 Oct 2021 11:35:00 -0400
X-MC-Unique: RQyciMd1M2aDQvsms3J59g-1
Received: by mail-wr1-f71.google.com with SMTP id
 h99-20020adf906c000000b001644add8925so5794878wrh.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 08:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iSDVw663rgR4LnzvWfNb/swIWuQxbUZSWle1d9fqt9E=;
 b=mElZfGbyGK3wHazT4shSB1Ib7Bof1f+lIi7f/k8P9MN+V0jETjcVS+xHYTs2yDaD9x
 UTUSqNXedQ/K08kIck/ztN55+IhkLThBDRPzc+QJCi4/Yn2l80gK7SEhreAxdnMdde8A
 zQzZxPzT8ln2UadkXiP4UGc5pRUfdytYhd86wa0Wy/kG81sY8+q3gLo597RM6MOOrcUv
 4olfvwmnbYjimiK+HjPRwvMitT8V7QkMKiIWxGFJRDzKqkctUjFDTsntlU/CFeUq9GPW
 ryyNRde52l8+7ZPzGQOJmBsocu1VYKQIdQdMwsFxn71VB2JA7tx1fc7YWzY4UV2n6Rlz
 QJlg==
X-Gm-Message-State: AOAM532WfVMyTY+uv2A4z6o+afO3nMGiW6krR0gyK9XLwL2X8S5Fvxt5
 +1km1Ja784N0BWd0xOrbea+fsgix44CUXyUTXjL3rXYsdIO6gpI81RXoLQf7j3zUS4u5xuAsleM
 PRIPv1CNR4SF1GTe1ZYFHwS+tbbLSdLt72QDQisQkYw==
X-Received: by 2002:a05:600c:b41:: with SMTP id
 k1mr45294850wmr.4.1634571299463; 
 Mon, 18 Oct 2021 08:34:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp1c/YzLtcUsPiieZpADt9GBmdqu5mTsMTmWQr/eYys3EZH98EritaGRfzaaeNAJgS8/UEXw==
X-Received: by 2002:a05:600c:b41:: with SMTP id
 k1mr45294812wmr.4.1634571299153; 
 Mon, 18 Oct 2021 08:34:59 -0700 (PDT)
Received: from redhat.com ([2.55.19.190])
 by smtp.gmail.com with ESMTPSA id g33sm11700734wmp.45.2021.10.18.08.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 08:34:58 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:34:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <20211018113237-mutt-send-email-mst@kernel.org>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW2RfXJwAxFYOYzs@myrica>
MIME-Version: 1.0
In-Reply-To: <YW2RfXJwAxFYOYzs@myrica>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "joro@8bytes.org" <joro@8bytes.org>,
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

On Mon, Oct 18, 2021 at 04:23:41PM +0100, Jean-Philippe Brucker wrote:
> On Thu, Oct 14, 2021 at 03:00:38AM +0000, Tian, Kevin wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Wednesday, October 13, 2021 8:11 PM
> > > 
> > > Support identity domains, allowing to only enable IOMMU protection for a
> > > subset of endpoints (those assigned to userspace, for example). Users
> > > may enable identity domains at compile time
> > > (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> > > (iommu.passthrough=1) or
> > > runtime (/sys/kernel/iommu_groups/*/type = identity).
> > 
> > Do we want to use consistent terms between spec (bypass domain) 
> > and code (identity domain)? 
> 
> I don't think we have to. Linux uses "identity" domains and "passthrough"
> IOMMU. The old virtio-iommu feature was "bypass" so we should keep that
> for the new one, to be consistent. And then I've used "bypass" for domains
> as well, in the spec, because it would look strange to use a different
> term for the same concept. I find that it sort of falls into place: Linux'
> identity domains can be implemented either with bypass or identity-mapped
> virtio-iommu domains.
> 
> > > 
> > > Patches 1-2 support identity domains using the optional
> > > VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> > > spec, see [1] for the latest proposal.
> > > 
> > > Patches 3-5 add a fallback to identity mappings, when the feature is not
> > > supported.
> > > 
> > > Note that this series doesn't touch the global bypass bit added by
> > > VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU
> > > should
> > > be attached to a domain, so global bypass isn't in use after endpoints
> > 
> > I saw a concept of deferred attach in iommu core. See iommu_is_
> > attach_deferred(). Currently this is vendor specific and I haven't
> > looked into the exact reason why some vendor sets it now. Just
> > be curious whether the same reason might be applied to virtio-iommu.
> > 
> > > are probed. Before that, the global bypass policy is decided by the
> > > hypervisor and firmware. So I don't think Linux needs to touch the
> > 
> > This reminds me one thing. The spec says that the global bypass
> > bit is sticky and not affected by reset.
> 
> The spec talks about *device* reset, triggered by software writing 0 to
> the status register, but it doesn't mention system reset. Would be good to
> clarify that. Something like:
> 
>     If the device offers the VIRTIO_IOMMU_F_BYPASS_CONFIG feature, it MAY
>     initialize the \field{bypass} field to 1. Field \field{bypass} SHOULD
>     NOT change on device reset, but SHOULD be restored to its initial
>     value on system reset.
> 
> > This implies that in the case
> > of rebooting the VM into a different OS, the previous OS actually
> > has the right to override this setting for the next OS. Is it a right
> > design? Even the firmware itself is unable to identify the original
> > setting enforced by the hypervisor after reboot. I feel the hypervisor
> > setting should be recovered after reset since it reflects the 
> > security measure enforced by the virtual platform?
> 
> So I think clarifying system reset should address your questions.
> I believe we should leave bypass sticky across device reset, so a FW->OS
> transition, where the OS resets the device, does not open a vulnerability
> (if bypass was enabled at boot and then left disabled by FW.)
> 
> It's still a good idea for the OS to restore on shutdown the bypass value
> it was booted with. So it can kexec into an OS that doesn't support
> virtio-iommu, for example.
> 
> Thanks,
> Jean

Is this stickiness really important? Can't this be addressed just by
hypervisor disabling bypass at boot?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
