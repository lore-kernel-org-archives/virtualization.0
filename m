Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4523B615
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211600; cv=none; b=HH+10mvipVln52VQEmfpy87wAAq6AodaCUzbXWKbZhINZ52+bPiG0W6mWDdK1FjdKCui1W6DrOyTc9V7CoZEzl4Fgc1wqTDPR9b3cZ7MVzWfxBMadDtJNyqkj47FbPSOywJJnSrJfGcHuP7kJgP6gZlUIVlU0TxkgwpMWVUzlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211600; c=relaxed/simple;
	bh=P+Wmf0yqfouH3Oi06gJJiikblIWfpXgZcHs/2usguFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nT81dbmaPztRJ65n8tr7FWgFsSxCaXA5BEPO6qLFQh+QmKRFwYSHGHVw5C2zBloYPqJWhmpy9AifBzvxBtNdhelHeWownV5xfwkbTUi6AoS+0OBfLCaCe8/oPgFHWjp7NtJ6QUf1PsUGdMG7EqTOyLOpaD5eeUUME+VeMLIF+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IG4pwe58; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG4pwe58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
	b=IG4pwe5890UhSMVh8eKMNvPwYKV7DfxT9iNyQ+8nlEQ1LJKoEPr67Zjq/udp0TnuSa3mNz
	IBFCkq04U4VCqyPYjzmKeIYQ7C2LuYeqemHP6m/88zZLihR/PJLn9NMzEtqmLBKxqXx4lr
	WX13UFcOA/cv9rscD+15Qb2zrmS2Mu0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-9Z9Ff8szMyegPpt5tH2uZQ-1; Thu, 18 Sep 2025 12:06:36 -0400
X-MC-Unique: 9Z9Ff8szMyegPpt5tH2uZQ-1
X-Mimecast-MFC-AGG-ID: 9Z9Ff8szMyegPpt5tH2uZQ_1758211595
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb2c65e0d6so856310f8f.3
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211595; x=1758816395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
        b=vRs8NUySDbJIKEzGNkMyfu1AU3nICQv2AzHETEHx+kelt4j3y7VJ1X367MDF7zfWCS
         +7bDc+CiRBl8qGrNP4QhtQbViOelFk7GCwFEIxGN6pu5NCxY24c7fgZIUVxDtgiJfVr2
         5/RPOTLoaqoQkdcYHlWgU5fCOjrTpeGf6dlBqP8+NqV64CnzLOx8hTPEVbl1TcMdjGbH
         Moi3l3ja4061se8h1FoRiu2TTmY5IIwioKgR40Lmuy3h3/edBThmtF5XivjDmjpDPyQG
         sGiECSs0zW/d0NeiuagDOoxXy1yl9LSWiufkVAUfsMgYqHn+o2LVlONeLCGyhp1rBjA8
         wYIA==
X-Forwarded-Encrypted: i=1; AJvYcCUnoPG9QXSilQU1sgXz1r98QCS1C4tKweZi2TC2bEXWbx78z5IlKgxC3GoksUV3VfABGMi73YxqXrESQgL1Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww4tcYUqk4Y/YGQ90biyPb5IB9m828JGDZNVPd7bXIBQCkHU94
	QCqCbgIWHvRmdRfHS+b5lI7dW6jMfaLZZOg/+djQRQ2z68yUDjANQeXfFvH7dBQ//Iq0psrjIZP
	tNmSLE2KWPYfStiQAilnYMEN4l2GyCOeoFxxNCzG9nA710TocKAMN3iHXUv9DFA1Lla9N
X-Gm-Gg: ASbGncs/1rJheaodllU9k38QURWm10OM8+C4QUq7h+HBeJiNWV4xXV3XOwi0NZ3HyMC
	upaamZUQoFZsm0xkd3yd6dZHPmx+hFSzHyl8Lp8SAEXIoy+UfXgC9IBtcbQXUKnIbjuTWJ5esjL
	MaAaUv+IYXT6w0tX4eWvu08tkmSZcFvNkuZrwyCv3srCXr2J3vHfxa2wpFPu/4+Nn+V5TSD96P3
	wV//4X7aodijHGX4Z7UJNYXLDj47QAT0dkcJ1eIT+LraMgpOEDLVMFHUxhxCSqFNDq5zxDdWLLK
	+glBXugMoR3hqOypdXEaIVuWhNiibL7K8L0=
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207938f8f.40.1758211595341;
        Thu, 18 Sep 2025 09:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk3vFxLumDhq+BR9Bo4nIsWcXRAcKMyNyvcVzS+eyg8tV4+vQBxrdk3o5AQ7UyoiyFo7QtNw==
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207900f8f.40.1758211594963;
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7300sm4062735f8f.34.2025.09.18.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:06:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120607-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250918154826.oUc0cW0Y@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: as0VRPU1Pk-B0MFEar3_F4vM2U30MnxfbR79PjfnQAU_1758211595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 05:48:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > So how about switching to this approach then?
> > Instead of piling up fixes like we seem to do now ...
> > Sean?
> 
> Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Sebastian

Yes please, if Sean can ack it.

-- 
MST

