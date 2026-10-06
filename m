Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A0288C2D
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280104; cv=none; b=eVUnTbsi256Ct/Ch0YX2JEYCg2Q/33S22wQ+PNnHQpyk1mAi1TL6gOUB8IPcYX4PFzc3LfZd0kRHqEmX73ZbdU5dVwyTmtQM5OgF7ElhhbCooF2NzvqKw+OCwd35u3jvsHomKPMo61/Bn4qMW3dNIS2BFFi+qJVmqK0rGemHyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280104; c=relaxed/simple;
	bh=LTfnRIxmZLiA97Yqm4g77Ig3nE2ngmtX6QJ2VVpUxZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rTnXPMQAj17KfStKaUM2uhY9dVWTsSS1UiPRAFNJEixejh3cbyIkmET4H4LkBx4KpNgoi1Hz+RSJKN3pDRfzZpnfkDe+0mYj891OU2rNgoGXPhfC1fZXVEZ7IUOV+RoS8R7vh8f8d7nV5T6v2are9cSDAnn7LD6znzzR+HrVDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT8avO2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT8avO2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791280101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEUBtVB0GKLMw4VmTZSa2mBzg8QXaeyd4RAsEGILX0s=;
	b=VT8avO2YTFIUSJVLoYM0pIPLjkWp2kp8I/AZraYeRmP2NFRb1GBzAsmVWxQ49NinXVJflh
	OfUCKJqsahqqZQAFY9sNFW0hOib/Gz6HQ5kcyZ/inAZB/DHN1jgpjeJcP1s82oNT3sh5Fb
	KPLr+PpKmNoF/n76Bsxyx1zEXwDj1Hc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-8DOM7qxfPdurc6j44N86QQ-1; Tue, 06 Oct 2026 05:48:20 -0400
X-MC-Unique: 8DOM7qxfPdurc6j44N86QQ-1
X-Mimecast-MFC-AGG-ID: 8DOM7qxfPdurc6j44N86QQ_1791280099
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b02d63407so2014658f8f.0
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 02:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280099; x=1791884899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lEUBtVB0GKLMw4VmTZSa2mBzg8QXaeyd4RAsEGILX0s=;
        b=r+COEOZe8JC5yXxZbUiEJfKFoMVLfDY8HR2YuuVf1g7n+Lkr8UXz2R6HUIIBgpEMoG
         u/mbkKzqgnH4VCbC0ZByi+68+/yoNWc3rGIA4ehujsIPrqGB8WvGPTgKOX2uvhSyRlZq
         Ol90U4Kwn5w/TQREupKs7zzjG8Yjmed6Nx1O2lTCf8nF/KzzzKxv9I4+YwQxlMSYitGz
         AH0xwF3iPyn/z4mBGdnhDG306n6gNpec3yYSnicMWgzl8TOnth22trUVvDp6xf6QLut7
         llEWuCIrmJWteSsPb2HBPQOjieW1fpcVdfjP9+l+8ap1IzwnXJyzXCF/FltjtU15PaNg
         lIrA==
X-Forwarded-Encrypted: i=1; AKwUvBwtRfsxjTvd+lwF0wC6m7mw84cuMZ1X3QO3sStdF/GQvGbEY9Po+MfFTSoOezYd07mV8li7ocASKtdGBfwR6A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGoqhzcA5W7TU4sa7WuuyoJqB3/k2rPmIbEELGSar9SIvEyRtF
	7hDkgRL4w5kSz9PFAIqQYlnj4D3KqXe0fbD0Bk8IXqBg3Z5vz+0hPw2h7CeNXSYCJEGFONCvuPa
	XZkQknf1gbKYDNyMk/D7Yyl3QZ1lSGXSruT3SXTaqPHtGYL5Xo2osBYnai83WJglPNi1i
X-Gm-Gg: AYBFou13XtLJUOko4Jw13RwL4Bk0IvQcGI2RNZF1FuyFWbksJt+dtxQvp7wzi3YO2wb
	BY0cWeJofo1xoZ9WV1fSi3QdD/1Uj90CBelZsDbBkQe6bV6G20EDRU/0x6WINB3lml1mM4cqkup
	HdxvQSx9drExNRm/G12ja+/W75+jHVqzfeXdwg81cDtUJEo/8g45ph5R4BE5HXBrpk6Y9adn9l8
	RJXk5wreYmIOsg0OcBMJv8ZvN2h+5jkwZqiNsCmPMvbOUdTnnOdf4tctMRoUILsFb01bmlGR5VM
	M/LM6tmsrxGYz0ibawemaeKSdVFsIC1z/efQcZPsaxToit3dk/T/Xsva0cxwlZaKiaT1NSk=
X-Received: by 2002:a5d:64e7:0:b0:487:81c:183f with SMTP id ffacd0b85a97d-48c6d1a1639mr1490112f8f.10.1791280099330;
        Tue, 06 Oct 2026 02:48:19 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:487:81c:183f with SMTP id ffacd0b85a97d-48c6d1a1639mr1490068f8f.10.1791280098487;
        Tue, 06 Oct 2026 02:48:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62270968sm8900455f8f.8.2026.10.06.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:48:17 -0700 (PDT)
Date: Tue, 6 Oct 2026 05:48:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?7ISx67OR7LCs?= <tjdqudcks0424@naver.com>
Cc: Jason Wang <jasowangio@gmail.com>, Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] virtio_ring: VDUSE backend can corrupt split-ring free list
Message-ID: <20261006054441-mutt-send-email-mst@kernel.org>
References: <20261006091210.828229-1-tjdqudcks0424@naver.com>
 <20261006052105-mutt-send-email-mst@kernel.org>
 <2b6ae98573123157c0d5aca458dd4d1@cweb009.nm>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2b6ae98573123157c0d5aca458dd4d1@cweb009.nm>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7uQIiVgRWhcgMiyn-qNxlyejhc1J_JHi1iRKUGOL9Nk_1791280099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 06:39:23PM +0900, 성병찬 wrote:
> Yes, the backend causes the driver to corrupt its own virtqueue
> free-list accounting.
> 
> My concern was that, after privileged VDUSE setup, a delegated
> unprivileged backend can trigger this by modifying a published
> descriptor. However, my current reproducer demonstrates duplicate
> descriptor allocation only. It does not demonstrate a host
> memory-safety violation, cross-device impact, information disclosure,
> or privilege escalation.
> 
> I therefore agree that the current evidence supports a robustness
> issue rather than a confirmed security vulnerability.
> 
> Would a patch using the driver-owned desc_extra flags during detach
> still be considered worthwhile, or is protection against this backend
> behavior outside the intended threat model?
> 
> Regards,
> sungbyeongchan

It's outside a threat model but if the rest of data is coming from
desc_extra I don't see a good reason to read flags from the descriptor.
Will likely be better for cache, too.

