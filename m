Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C529898D
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830952; cv=none; b=UBHTAbrG+u6pQ2KSg0zZinlc8ZeUOrvUXNSNoOLZWNnB3SldONRFGujLUnltqcMGGrvY+KSkVTj2xODU8MCrOkcmY406sWHRXwYWuaOVjeki6oUB7BzctDTemXPOwq1CYYdxO0naLCWLV32t+t2ab/dbMxb34d+X0T1/RdawQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830952; c=relaxed/simple;
	bh=SSEapJw9gIpQvMe/GSbXsIpSF0SV6GSNbc3rYxWdvew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eKzfsozr9RSObwfqqTjqxTPhFDck3wzCLmX6yAUnUpDIhEtU6gDXlD/6ymrFBwx11cvQRauCZJEezNFB3mMTeDsKnN13+M6oQHitT87BBWUXcUjv8TozDq7XvnwMeer45r1rGwHYr07k8+dA6dMdaX3w0kgRucPtAYg6ffEjIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFTrwvz2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFTrwvz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05GlAbbQ3xY778mOKhz9KvpGxfjV14skZVzYZoy7Tmg=;
	b=MFTrwvz2LBJ0aJq1oCL6YgHdcCbkees8alprYkK8aWfc7tePvsjVhKDU+axP3ZBVpx4cVr
	6F9aHIeLltP0pmZ+tE3uat5JkD//YEl8jqJE6ypmoOPFWWb+T17QynCpVDPqbV2uE6NpGi
	lULPrOphC/YBxd6s7TIQbPRZo+mnbb4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-kZUlMNaBNTG2y0XzDhYpvw-1; Fri, 18 Jul 2025 05:29:08 -0400
X-MC-Unique: kZUlMNaBNTG2y0XzDhYpvw-1
X-Mimecast-MFC-AGG-ID: kZUlMNaBNTG2y0XzDhYpvw_1752830947
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so1039260f8f.2
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830947; x=1753435747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05GlAbbQ3xY778mOKhz9KvpGxfjV14skZVzYZoy7Tmg=;
        b=rA3sjlZh4W85ZqB/6VG2qETJbvDyiCUDYRXX2D4PmSCVFQgJt2s2fnfkadtNpgnKZO
         ISqaCla2pks1j/lmk12666bmJ+5A4VUXW8ImcbRRTVNRXJShi3IuWsHgwJhE8SVJ+vrQ
         VpdQfpHZsUBpuOkR7GV1MdztFK2le66HVUWZQ8/wmwUILZ6fIC58VdZcmIQqXSrhpRb1
         k+k1AOZUZOPF+VPkA7K5PCeDZzWpyzbBaCcESDrP9fW/2Enl8ELqMoAPJ7h3i9rSuah1
         uHvQiq8xAnTmToS3JF2tkS+Az3e+WZ85hiScnaUUHjHTZiULSMW4hgnXk/fmShozQJjk
         +b7A==
X-Forwarded-Encrypted: i=1; AJvYcCUs9vfELl39NbtfkzIzO/lu/e9fP5U8PkxXpYEhiAqVNzY3tCIXWzLTaUwInhYuyY2Gm65RZ980lyE1Cr4+eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmNz8BZBcu5g9+lH+sLGZAyN8fU/wW4REqM50NhAXlhPj+CdtP
	lljmtqbhIveaVwFsSFu6PKctz2a9F+lnVWSJBnoYt9iNkPZiE1LMeRmfoPLqqA8IH48H79VjSd0
	HMWdvUXBM1K/FHyDTLRRAe3gi0hnmKHgChG3W0JihInHbSKGZN5pHKxVyjQ+zCvwADS3R
X-Gm-Gg: ASbGnctbYebuYtndFFRlFQOobfqOPxluUCfIqtaMe/7VTESEBguNdAnZ++UHGBEMBM0
	tL3orZaPIBqyR2swQOEvr+LzLQLVl4bBZzSClrm5eyvoLh0ziqmygRVzKqL/E2fFVZFp9vfynRj
	XfIjLVxSwG1ceC7WoTrQvfI3ysAlEW06ZlJ3zpyzqnSGQnapIUGNqN7QasZuVm0mPqf6/YXRXdo
	iv9my3SZ106OqHrE9tCcZRjHMPbsj+QoEQhkUaFc2H6GbR7T701e/Z+EAlxA2NUivUGya9OyD9I
	4PSTX9E1d3u3oJ5+Pwuduj7fWlTkJkzH
X-Received: by 2002:a05:6000:430a:b0:3a5:8cc2:a4a1 with SMTP id ffacd0b85a97d-3b61b220fd5mr1590616f8f.39.1752830947087;
        Fri, 18 Jul 2025 02:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF99Q3CYpAdCQEYHNdwI4F7VEKY9nBiW7NBhJbkG8u6wZyeCRLsebXdo2QPbFIqLY0Zj9jJVw==
X-Received: by 2002:a05:6000:430a:b0:3a5:8cc2:a4a1 with SMTP id ffacd0b85a97d-3b61b220fd5mr1590597f8f.39.1752830946555;
        Fri, 18 Jul 2025 02:29:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm1290245f8f.64.2025.07.18.02.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:29:06 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:29:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250718052747-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
 <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PleA21FRIbwH2kdZ4Kyy9Cm5lXN3cfmNhJ9uSNfIsnk_1752830947
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 11:19:26AM +0200, Paolo Abeni wrote:
> On 7/18/25 4:04 AM, Jason Wang wrote:
> > On Thu, Jul 17, 2025 at 9:52 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 7/17/25 8:01 AM, Jason Wang wrote:
> >>> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> >>>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >>>>>>
> >>>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> >>>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> >>>>>>> feature is designed to improve the performance of the virtio ring by
> >>>>>>> optimizing descriptor processing.
> >>>>>>>
> >>>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
> >>>>>>
> >>>>>> You tagged these as net-next but just to be clear -- these don't apply
> >>>>>> for us in the current form.
> >>>>>>
> >>>>>
> >>>>> Will rebase and send a new version.
> >>>>>
> >>>>> Thanks
> >>>>
> >>>> Indeed these look as if they are for my tree (so I put them in
> >>>> linux-next, without noticing the tag).
> >>>
> >>> I think that's also fine.
> >>>
> >>> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> >>>
> >>> (Note that the reason for the conflict is because net-next gets UDP
> >>> GSO feature merged).
> >>
> >> FTR, I thought that such patches should have been pulled into the vhost
> >> tree, too. Did I miss something?
> > 
> > See: https://www.spinics.net/lists/netdev/msg1108896.html
> 
> I'm sorry I likely was not clear in my previous message. My question is:
> any special reason to not pull the UDP tunnel GSO series into the vhost
> tree, too?
> 
> Thanks,
> 
> Paolo

Paolo I'm likely confused. That series is in net-next, right?
So now it would be work to drop it from there, and invalidate
all the testing it got there, for little benefit -
the merge conflict is easy to resolve.

-- 
MST

