Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF842C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F3961154
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 15:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75F3961154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4914960BFF;
	Tue, 19 Oct 2021 15:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9awi2GDiWJeC; Tue, 19 Oct 2021 15:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED95560C01;
	Tue, 19 Oct 2021 15:31:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D699FC0011;
	Tue, 19 Oct 2021 15:31:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBF9EC0022
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2C5B401E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 15:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAtm1zAgru98
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 15:31:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87BF940146
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 15:31:51 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 67-20020a1c1946000000b0030d4c90fa87so3615662wmz.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ahyIg8IXbPMyXbPLTmiCDlAfPsNcwBHd3znqPzuBKqo=;
 b=tD8/Ui0VOLFB+QsqZDNEIiSk/TpeD42xZaRnIW1xDxShBJrWHlUKopOsDvHIcwc8Pq
 AOBw2hWypue34RBfF8WtRK0cx8mcmrkeaGAMSPls5rtGKJYdsTRqtkd4f6buSVVqxQg5
 T+VFoppoHgQECGetLRmx0l1zTqNLX8D/8CMK6aQPKi+gstYUF2wgvAxv65mHPTeSNcs7
 fFlvfTqRY9UhN1oxhB83rBXgpqJOhvCKhgyDeGa1Rh83P15gbRIRzUr1iUvlKcSOHGqV
 GaL2/AyTIbE4t+atMRdbmzNUTsroe+T6bEykru98nQU3PCOV8q2Zrs9jPlb+pBuvGilu
 Jxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ahyIg8IXbPMyXbPLTmiCDlAfPsNcwBHd3znqPzuBKqo=;
 b=mfeKqt/RWMhXjeYwUY/y2KziSt9ITLsJ6iWC5vHRxBGlpfueKf1JjhTAburydCwxuS
 o/kxUmdfpaUJtyNDAdo9H7xzHw/wyLzywOwqPyUtfnIp+ZrdUp5zB9rrx47y2lNFdRjC
 KyhxypniTrXxmk4pBocETBi0XKM/NrlnJw1VHA6BP6DYZSh85fug2oiUuPIwTzU4bclx
 Ja1BU9vsOebqOt2XUeAI5D28eTnQX2WuhzDi3KUsGNcECqqXrGKher2iT7kG5luesoFw
 TWKrFmwtO3VjUMqFTTNcGuP9KYmIyS0eEP6Bs9hAeDkmBhEBP9mRDfWhiIPY6bZbT1Ij
 QAgw==
X-Gm-Message-State: AOAM531NT2De5ulLOZ6rriZ7ZhO+YaZTqNNHx6MaSsBBLIBCRZHaNWWX
 uxKqz1lrvk4gKtz3qJeiZM5gew==
X-Google-Smtp-Source: ABdhPJwm0+YKImJfZsVs1yBP6XntaugFO7fd3tS2pFtn2Irj9kJxrmGBbC5MtCnBaR35OpDvGBq6qg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr43901799wrc.209.1634657509428; 
 Tue, 19 Oct 2021 08:31:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id i13sm2943270wmq.41.2021.10.19.08.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 08:31:48 -0700 (PDT)
Date: Tue, 19 Oct 2021 16:31:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/5] iommu/virtio: Add identity domains
Message-ID: <YW7kz8MG9SBEyCim@myrica>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <BN9PR11MB5433EFF47E5FABC1D7D95F6F8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YW2RfXJwAxFYOYzs@myrica>
 <20211018113237-mutt-send-email-mst@kernel.org>
 <CACGkMEuJrQcPSMdRJ9wmc3riLK_3Q6t9596b5ida-j00Yf7+WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEuJrQcPSMdRJ9wmc3riLK_3Q6t9596b5ida-j00Yf7+WQ@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>,
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

On Tue, Oct 19, 2021 at 09:22:13AM +0800, Jason Wang wrote:
> > > So I think clarifying system reset should address your questions.
> > > I believe we should leave bypass sticky across device reset, so a FW->OS
> > > transition, where the OS resets the device, does not open a vulnerability
> > > (if bypass was enabled at boot and then left disabled by FW.)
> > >
> > > It's still a good idea for the OS to restore on shutdown the bypass value
> > > it was booted with. So it can kexec into an OS that doesn't support
> > > virtio-iommu, for example.
> > >
> > > Thanks,
> > > Jean
> >
> > Is this stickiness really important?

It is important when FW has to hand the IOMMU over to the OS while keeping
DMA disabled for all endpoints. For example DMA was globally disabled on
boot through some external mechanism (e.g. Bus Master Enable in PCI
bridges), and FW disables IOMMU bypass before enabling Bus Master, and
there are some untrusted endpoints in the system that should never be
allowed to perform arbitrary DMA. If a side effect of resetting the IOMMU
is to enable bypass, then the OS opens a vulnerability without knowing it.
That's a real problem on hardware platforms, but maybe too far fetched on
virtual ones.

> > Can't this be addressed just by hypervisor disabling bypass at boot?

Yes I suppose we have that option. If we make bypass non-sticky, we're
preventing FW from working around vulnerable device implementations, but
fixing the implementation itself is much easier in virtualization than in
hardware.

> And I'm not sure if sticky can survive transport reset.

I thought "device reset" includes transport reset as well?  There seems to
be a precedent with virtio-mem which keeps state across device reset. And
PCI allows sticky registers across FLR (RWS registers)

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
