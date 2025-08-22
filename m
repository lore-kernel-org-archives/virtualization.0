Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374F265CC0
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871183; cv=none; b=nxpA8WLNB6rigYDsIw7JmDHLQGrI4W4mYdU0mIgGwB9tGZHygBXL8oTsaWYzJ8xnz3xHPB/NYkEwWFp/cqmIjxMFwQcvyqo6qxVmQXWHFE4So7Jq3Va7fjhh4tD3OT9OyF/66EbTeiaZGkc1j1df9slbAiC6yxMiOht5O3vnTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871183; c=relaxed/simple;
	bh=VF+xLya3ySUvhLm4vDWwokcjvbjrzp6uqdePmBQvo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iCoX21z9gcSqXQ32BzGDXvzVd/uE9S6Q7R7fFKOzPTcJVvhkIwUoM9xYjA8sTdw+s4YNm5/eAiN0NZEQsaTY8Yv0WT6bvqHBd0zeY9kcwyjeFscOD1BoLLROhKW3HkwiJfjJecc90GY7+qOuzWSzfhd2tJUGFJmQB4Qec/lY1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjwZnq2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjwZnq2Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnPvDlcUiGZQU6wBgxu7LXqKZV7ykR+RAYYj3wGlDkc=;
	b=ZjwZnq2Qjhjk39Gz4qc9SdU7qJTRkezlfi7aRlGCpeMYyl/1ktq0XB30LWTqSpFv1oMYJJ
	dxrSkeT3uAN0dQKPL8z4PG8dAl/5OZvfyNJrdVsTOQxlwJwHxHNl8It/xJEO32sPLfLgjz
	O6BV/6gcSMCiqJntzJ0HILLWNUZ8pBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-CNOpfXKiOt-uoqV99OgsuA-1; Fri, 22 Aug 2025 09:59:38 -0400
X-MC-Unique: CNOpfXKiOt-uoqV99OgsuA-1
X-Mimecast-MFC-AGG-ID: CNOpfXKiOt-uoqV99OgsuA_1755871178
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so13067885e9.1
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871177; x=1756475977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnPvDlcUiGZQU6wBgxu7LXqKZV7ykR+RAYYj3wGlDkc=;
        b=eMxxazJH2G1RD1qahFLdIOXsUL1GEysVZlTPwUMFYifQq9gMoTJgfqBVDEt/RR97tb
         NBVQvQmsuN9E/Fc0acuosb6SwwbsPUCCWhqUkVyvKbF6xNdjd6VaDqPO7vXO0auAz35J
         RSMXCop/tMEFgL0SgpRhm5gX8iLPawBUsJzXHY/RT46TFlKD+BgJ3PW7HDwDZknCNf9u
         KAfVtvYzFK02EU+7aMGgtTOE5yvTeVYw+oNwWCKBdt01D+WtEmPyoobJkcHd5eax3Rc9
         FzeKSQTlGWk1jOpzCJcdKaqFRpy9oDS7y/OeSs92sNiS/u8VAnJvC8fZXXEXe4lBBlpx
         zi2g==
X-Gm-Message-State: AOJu0YwcA0Cq0PaMKuaQbk6RFPqDRL2GqLT63GLDqL876+JF8GNx8DOG
	VVdfYVfY+Ou73kPINySakGUfxEtnx8TmYY1kasUHpcpg87WCsh2cAv7qC1cHLtTCp9uhQg5OmIY
	B/OI2rfu/rwaL6ww9oxDsrkduf1BE9WvvjzrchBcjs9FMeWJzm1YsXqlM/roASoU4puZl
X-Gm-Gg: ASbGncuu87jlv+au+1LZj63NE9hr6P4isU5UjLoG1SB6k0ZS+dS94ED8M8klZQQPHew
	IQweZU34u6kHAgRcfH54I4+V9fMpzcoc+5x0qBB6MtF3r4+0x7VTltrCLkubGuvJcEWYeuFknF5
	87eH7iJ1ppQgh/BodcQhkR4UyTwmLaehWSwaNyLiXqnPsZL6lZW2LgiZXEnF7qmB9e9WrEM1K0w
	jv7S6QFypkvz5QjJJPSnxQwJKKL3qFyqmhXbKnkBz9d+8cwqVvwLmUXG8SZhdDjPm4qGsf56eeL
	+yY7XhY3KpCTA94hcD8wdJTtEYCAG0KH
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28171415e9.4.1755871177506;
        Fri, 22 Aug 2025 06:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLtkZ5binTDGJP5H9sQ/FcahKe+0bwWJOvKaUEtMpcaAju5kmaQNlWbm/v3JiCp+8NfvNhfw==
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28171195e9.4.1755871177074;
        Fri, 22 Aug 2025 06:59:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57417f61sm702715e9.4.2025.08.22.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:59:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250822095225-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YLJfHvF_q-vs1ql8obhIQIEfHxIO9wQvy7AZewDP_68_1755871178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 06:34 PM
> > 
> > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 22 August 2025 03:52 PM
> > > >
> > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > removal of
> > > > virtio pci device").
> > > > >
> > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > surprise (aka hot unplug) removal. Drivers historically continued
> > > > > processing and waiting for pending I/O and even continued
> > > > > synchronous device reset during surprise removal. Devices have
> > > > > also continued completing I/Os, doing DMA and allowing device
> > > > > reset after surprise removal to support such drivers.
> > > > >
> > > > > Supporting it correctly would require a new device capability
> > > >
> > > > If a device is removed, it is removed.
> > > This is how it was implemented and none of the virtio drivers supported it.
> > > So vendors had stepped away from such device implementation.
> > > (not just us).
> > 
> > 
> > If the slot does not have a mechanical interlock, I can pull the device out. It's
> > not up to a device implementation.
> 
> Sure yes, stack is not there yet to support it.
> Each of the virtio device drivers are not there yet.
> Lets build that infra, let device indicate it and it will be smooth ride for driver and device.

There is simply no way for the device to "support" for surprise removal,
or lack such support thereof. The support is up to the slot, not the
device.  Any pci compliant device can be placed in a slot that allows
surprise removal and that is all. The user can then remove the device.
Software can then either recover gracefully - it should - or hang or
crash - it does sometimes, now. The patch you are trying to revert
is an attempt to move some use-cases from the 1st to the 2nd category.

But what is going on now, as far as I could tell, is that someone developed
a surprise removal emulation that does not actually remove the device,
and is using that for testing the code in linux that
supports surprise removal.  That weird emulation
seems to lead to all kind of weird issues. You answer is to remove the
existing code and tell your testing team "we do not support surprise removal".

But just go ahead and tell this to them straight away. You do not need
this patch for this.


Or better still, let's fix the issues please.


-- 
MST

