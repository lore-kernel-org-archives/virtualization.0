Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21E37C0FC
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595233; cv=none; b=G0Pjfm7wlPfkOxF0RAQx6lM5+zWryq+ZmR+VtwnD3IqDma205Jf3QPNJ9afr1Mrv6P71hHwclxNauPFjVhgeklCs7UdDgPycgmdEFpfblew3TjVZu35SdgGJ42HbU7An+fWhQrHrLaH9/mnpc5EqtdL2v8rK6E7/QZ0nnFQkSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595233; c=relaxed/simple;
	bh=Ee/qHfXFW2asDHH+jIUGNSMPEwStCg2EFYapaMnIKEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AsxvdfAWSQ/1bY3JMDOZH3Zj+uZ2EP3LiG4wWnJPWQ9hpFf2kNeb0zEJipM36i5r016RnavBJU0oB5wL/fqAPrAQGB93Dwu3qOX7oeHx9Few019QSX7fWC5JPJZI40Jp75W9OauppIVzTq4nbqUG/OPfo/P1f+Sgf9p/rPT2BiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGIz2O/Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGIz2O/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775595231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG6m9UgTxPVqPxu1271c7bScRWR6Q9hAy8QpFk3TXFA=;
	b=bGIz2O/QP99/hYaEs+jmrjOMJpSlMW5+tIEhKghC+f5VzaRJhyafmyBe/HkMK9ytK/UdBF
	jklhBdPYEx11QARcAcpqLrH2PXY+RKANeEP0x6z3FkouWCR1BY5SPN5G0e2cSDF6MuS+Ob
	u8ZZJ7FuHtPln2u2XqmeLgfTPXHURK4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-XCX_xpxvPSuEI-tZJNPW_w-1; Tue, 07 Apr 2026 16:53:49 -0400
X-MC-Unique: XCX_xpxvPSuEI-tZJNPW_w-1
X-Mimecast-MFC-AGG-ID: XCX_xpxvPSuEI-tZJNPW_w_1775595229
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb52a9c0eeso1934554485a.2
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 13:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595229; x=1776200029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG6m9UgTxPVqPxu1271c7bScRWR6Q9hAy8QpFk3TXFA=;
        b=D0mG8C3lyX6V9OesQjb+fSrOfTgy7ioZrE+xcth9DBN1crvMrwIXT6CvGwhVa0BYXo
         NTqMhDRc+Z7E/t2ztD7HAMTDuqeiohNVNrhJBhUWy0Tbp49hjXP70oBngQ4E8KjKnVLb
         dT7yUbbj2P+aAUePDYZiI8ruh06GjY7WP0ehrQwS1y4kbDi/F+UZWbV8MBHqQjqtB3Lu
         XJX3dxJrunY+KnEv2Te6M08krJZdoUOAeSOLHoUcY8xM2I2SXp3UiMBbTHWkf6ODYmAp
         AANX/XPYsPx/ykaZQIsRpYdgGd+LZfvLrKd8DNWWJcs6X9pNAVLpn0GihRw8yj9eEEdP
         U2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVuIaFsbu9YKeqIvYsC4Y8I+Uuv+DgHX0U2VwSswUHsa70LEpzTGZYd7NhcDDF9CqVcBNEwHxQ8/VwlhhFww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAXKkaHg6MPHGx6LtHDOCuOSp6u9ejh3uluf9LC9tbrD+4+H0E
	DkZdkMycZQW1OUgJEQyLVpcHko+gBmVJD6b+s8r8jE7vZyUAqiZnsfGnhCVfu2tr8NNi1OFmVFP
	JiXoI++WyCqdGmXYJ7R8EyyoWNglSuTQlFz4MDLI7HguX6tHsKJx6uhB8HZeL/Yb7owxU
X-Gm-Gg: AeBDiev0VjV5gZiBWC5IIovD86CfzDxudmiNvYRYdU+ktlxcoLfgnqyeDg8YUp88Bzy
	yTfxXzsl10e0v7+2dvicuyrqvH1J6vAXhJ08Jw5rWcf/BXGyu9wvYs2S2/E28qBhOHlzdrXks5u
	tbxC/vB36dFQPNdH3hyxeKp4oipxhCZNJOUJ+oiX26KGpL0gs7w6VP+ysoCc4dauC60yUI4EzVu
	V55lOiBkVEwp9v/fQEzEsYfLMPmPzMogCU3x4jRpWTqy99YhQNslOWxVIVqfDQxO+72yENz2RnR
	NaVfXba7APrHAsL9rmFGKY5U719oE95+CAeUw/aMh4z2FiS8AJoe7jTg505ax/Urdc5FPu0Tek5
	LjmnGj0X45a+B
X-Received: by 2002:a05:620a:4892:b0:8cd:94a5:2f22 with SMTP id af79cd13be357-8d4195747a1mr2575819185a.20.1775595229105;
        Tue, 07 Apr 2026 13:53:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4892:b0:8cd:94a5:2f22 with SMTP id af79cd13be357-8d4195747a1mr2575817185a.20.1775595228577;
        Tue, 07 Apr 2026 13:53:48 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8c29f17sm1418649385a.42.2026.04.07.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:53:48 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:53:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 3/4] virtio-pci: return IRQ_HANDLED for config-change
 interrupts
Message-ID: <20260407165323-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-4-astellman@stellman-greene.com>
 <20260407121906-mutt-send-email-mst@kernel.org>
 <CAChPuV9iGu6o5yJz87DEo6=gfr2P7m_jM=-auFuZevrr-HoYNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAChPuV9iGu6o5yJz87DEo6=gfr2P7m_jM=-auFuZevrr-HoYNw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ENFnoB187CtAfkRebzZGJiGe0gHkWpMbwpADa3TUh0w_1775595229
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 01:35:26PM -0400, Andrew Stellman wrote:
> Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
> 
> Should I resend as v2 with the tag included, or is adding it on your end
> easier?


how was this tested? I don't think a unit test is sufficient here, FYI.


> On Tue, Apr 7, 2026 at 12:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Apr 07, 2026 at 08:39:03AM -0400, Andrew Stellman wrote:
>     > vp_interrupt() unconditionally returns the result of
>     > vp_vring_interrupt(). When a config-change interrupt fires but no vring
>     > activity is pending, vp_vring_interrupt() returns IRQ_NONE — even
>     > though the interrupt was legitimately handled by vp_config_changed().
>     > Over time this causes the IRQ subsystem to flag the line as spurious.
>     >
>     > Track the return value explicitly: set ret to IRQ_HANDLED when the
>     > config-change bit is set, OR it with the vring result, and return the
>     > combined value.
>     >
>     > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> 
>     Fixes tag?
> 
>     > ---
>     >  drivers/virtio/virtio_pci_common.c | 10 ++++++++--
>     >  1 file changed, 8 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
>     virtio_pci_common.c
>     > index 0b9d66b..1d1ab02 100644
>     > --- a/drivers/virtio/virtio_pci_common.c
>     > +++ b/drivers/virtio/virtio_pci_common.c
>     > @@ -106,6 +106,7 @@ static irqreturn_t vp_vring_interrupt(int irq, void
>     *opaque)
>     >  static irqreturn_t vp_interrupt(int irq, void *opaque)
>     >  {
>     >       struct virtio_pci_device *vp_dev = opaque;
>     > +     irqreturn_t ret = IRQ_NONE;
>     >       u8 isr;
>     > 
>     >       /* reading the ISR has the effect of also clearing it so it's very
>     > @@ -117,10 +118,15 @@ static irqreturn_t vp_interrupt(int irq, void
>     *opaque)
>     >               return IRQ_NONE;
>     > 
>     >       /* Configuration change?  Tell driver if it wants to know. */
>     > -     if (isr & VIRTIO_PCI_ISR_CONFIG)
>     > +     if (isr & VIRTIO_PCI_ISR_CONFIG) {
>     >               vp_config_changed(irq, opaque);
>     > +             ret = IRQ_HANDLED;
>     > +     }
>     > 
>     > -     return vp_vring_interrupt(irq, opaque);
>     > +     if (vp_vring_interrupt(irq, opaque) == IRQ_HANDLED)
>     > +             ret = IRQ_HANDLED;
>     > +
>     > +     return ret;
>     >  }
>     > 
>     >  static int vp_request_msix_vectors(struct virtio_device *vdev, int
>     nvectors,
>     > --
>     > 2.34.1
> 
> 

