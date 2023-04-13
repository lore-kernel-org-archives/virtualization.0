Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D425C77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 10:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B6AF61381;
	Thu, 13 Apr 2023 10:40:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B6AF61381
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vgr124Bo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBfwjkpPgQ6j; Thu, 13 Apr 2023 10:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F09F661140;
	Thu, 13 Apr 2023 10:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F09F661140
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2690C0037;
	Thu, 13 Apr 2023 10:40:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADD9FC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 10:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 749D3417D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 10:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 749D3417D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vgr124Bo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBF28zI2weXA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 10:40:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE0D141DF1
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE0D141DF1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 10:40:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id v27so4529308wra.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681382445; x=1683974445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wt8QYWYgXcWDb0H4PzSCSB86AxQEfmL5GXKTxvwufWc=;
 b=vgr124BoHwdFxO+8XR7kdg8rVvjTn0NVgvqh2IRic5l3kYQUOHhoQTaVNENat3MtFT
 m04F+OZzwB9jdXFcnIsy4aWQ3aKr0ztkHTOY6lQZ0EIMXvg5dVLnUFVklSWIiXyUg4so
 TPyVIYoQ1qePdYzwdUatim3ab6+GMl+0NJj8xfSvKLwJQnSK51k2RUJ7jcnHU8E/hRB/
 BKNyh1LoGZg8FGwx9Hl1BU7tjqrmd6G8BpbRurNdgS7Iv9KFU3t9Z9C/31kJSRwapfUb
 Cgvxo+ND0LV1gCZDa3V6SUHKfqXrfdHaqn3DoKaK9742YoxMJDoe4T2PQI3CKdzzH6ru
 7PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681382445; x=1683974445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wt8QYWYgXcWDb0H4PzSCSB86AxQEfmL5GXKTxvwufWc=;
 b=RVSFFA+z8HnXcERTTomKHxUhQUhDwYlixx/nK8eddi3rkM8u8yfS6yeqiDUx29Ly/G
 WEoYhODLB0t/+4e9+JGFJXoM3haKXkuO44OL6XSVzur935nuDhuC5zQNn0W5zDsRrljS
 j0iFBJzkYlltrP7AUGdf+1fyktNbXvTSVHjO6pSVT8iE7SNR28KG46/vx+5uU7V+o2xT
 Ad/1xCx/2xVUnWKYtkU49FAFL0IhnnGEpep8JfdO1vD8B2z46UeaItcawILMVeJPgVYp
 sO/98uY+cpjJe74RYvPFFXm4n+Ro+vm4nVTrY41mycSUizbs5IJxzJamblfGdJLmNT7C
 p35A==
X-Gm-Message-State: AAQBX9dwcm0VNC5Xg4FlREskFf40Q8ERvM1qvyOu2ywtoCmwARtBJemr
 9cZzXxPYD4B7KR4gSvxKgDBtzw==
X-Google-Smtp-Source: AKy350ZKTDVRuGJL5YYI5HJoiDXvklp7EVihRfgojTs66okpvLm6QBr1zfRfZkA+Oait71i9Hok2BQ==
X-Received: by 2002:adf:e352:0:b0:2ef:b1bd:786 with SMTP id
 n18-20020adfe352000000b002efb1bd0786mr1002307wrj.13.1681382444786; 
 Thu, 13 Apr 2023 03:40:44 -0700 (PDT)
Received: from myrica ([5.69.146.176]) by smtp.gmail.com with ESMTPSA id
 z1-20020a5d4d01000000b002e5f6f8fc4fsm990119wrt.100.2023.04.13.03.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 03:40:44 -0700 (PDT)
Date: Thu, 13 Apr 2023 11:40:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: virtio-iommu hotplug issue
Message-ID: <20230413104041.GA3295191@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
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

Hello,

On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
> Hi,
> 
> Recently I encountered a problem with the combination of Linux's
> virtio-iommu driver and QEMU when a SR-IOV virtual function gets disabled.
> I'd like to ask you what kind of solution is appropriate here and implement
> the solution if possible.
> 
> A PCIe device implementing the SR-IOV specification exports a virtual
> function, and the guest can enable or disable it at runtime by writing to a
> configuration register. This effectively looks like a PCI device is
> hotplugged for the guest.

Just so I understand this better: the guest gets a whole PCIe device PF
that implements SR-IOV, and so the guest can dynamically create VFs?  Out
of curiosity, is that a hardware device assigned to the guest with VFIO,
or a device emulated by QEMU?

> In such a case, the kernel assumes the endpoint is
> detached from the virtio-iommu domain, but QEMU actually does not detach it.
> 
> This inconsistent view of the removed device sometimes prevents the VM from
> correctly performing the following procedure, for example:
> 1. Enable a VF.
> 2. Disable the VF.
> 3. Open a vfio container.
> 4. Open the group which the PF belongs to.
> 5. Add the group to the vfio container.
> 6. Map some memory region.
> 7. Close the group.
> 8. Close the vfio container.
> 9. Repeat 3-8
> 
> When the VF gets disabled, the kernel assumes the endpoint is detached from
> the IOMMU domain, but QEMU actually doesn't detach it. Later, the domain
> will be reused in step 3-8.
> 
> In step 7, the PF will be detached, and the kernel thinks there is no
> endpoint attached and the mapping the domain holds is cleared, but the VF
> endpoint is still attached and the mapping is kept intact.
> 
> In step 9, the same domain will be reused again, and the kernel requests to
> create a new mapping, but it will conflict with the existing mapping and
> result in -EINVAL.
> 
> This problem can be fixed by either of:
> - requesting the detachment of the endpoint from the guest when the PCI
> device is unplugged (the VF is disabled)

Yes, I think this is an issue in the virtio-iommu driver, which should be
sending a DETACH request when the VF is disabled, likely from
viommu_release_device(). I'll work on a fix unless you would like to do it

> - detecting that the PCI device is gone and automatically detach it on
> QEMU-side.
> 
> It is not completely clear for me which solution is more appropriate as the
> virtio-iommu specification is written in a way independent of the endpoint
> mechanism and does not say what should be done when a PCI device is
> unplugged.

Yes, I'm not sure it's in scope for the specification, it's more about
software guidance

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
