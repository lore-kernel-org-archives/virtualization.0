Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04F416CE3
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599014; cv=none; b=kQnktGSbrLitAbZPHBH1xfNI1dA2qMNdGCF5B2RAznjOgJW41oiPgZq5a1fhibSRSn6Gyh2XtUf5wsFum58a/ojXsWQ/4omvMyBYHz2qmw7nOP+9oRF6P6rB+ASlPHOv4JTWFJvkTApmNYUDpBbnGrldh605pvmQpoz4wNXudFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599014; c=relaxed/simple;
	bh=FwTAhF0JYkOHxkz13m2r40n+x4FyPRy0WvVPbgp+ExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tNUol7CS2KPrHGNPOCcS4qwitVn2jIe4VUt1S6o/BqXThHWCxPRlGRY9xlISqc38Sur/obWmeMbeTUl1fA4Egj2/kqW2SjaUXDgEZta6Um5Tap7senb7HMzfDD0SOTuVb+nRB5uIgGbmhuOwfFYCHABGJb5m0JEYJz3tW7fP/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xnt4ysDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xnt4ysDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781599012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+g/POHWh6E6oKv6JZbkNinsYGjBRuvScxGF7a7jfc8=;
	b=Xnt4ysDaanakPe0NXdSezpKrh1bq53sWL7ThFLgTwzPck6zRD9hcrG2T/88UIl5/BcXRJt
	98Lye6PuZL0S3j1uYzlQoDfPuQtynug32XuG+iu/wN8OxrY/POHAy7qH31JIVljc5VPZMq
	JBnzFhKzb2m4HhM1/KeS+tFX5iBXSYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-YnEBA7xrN0Ood8cvnjrhFQ-1; Tue, 16 Jun 2026 04:36:50 -0400
X-MC-Unique: YnEBA7xrN0Ood8cvnjrhFQ-1
X-Mimecast-MFC-AGG-ID: YnEBA7xrN0Ood8cvnjrhFQ_1781599009
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef63d1214so2724730f8f.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 01:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781599009; x=1782203809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+g/POHWh6E6oKv6JZbkNinsYGjBRuvScxGF7a7jfc8=;
        b=J5le0zJPZMf5Hi9R7bfKxWtg7Z5bPZ+bCwO9o4vaAJBh+T98HiLjAo72sT/nPczcQS
         sABu2hdE6rdsCR+biMioWGcSPJ9PMPckYiFGIuQ39UdNR9QrRJBpgKmCOoe9GbSPB+VJ
         BVG7xvzmtzCCiLpgrVX0oI4qeiv6b1XvsRp5tTewPsozEiOKZcDzwu3T/YCSKsBHuEvZ
         DAa/pteS3N/WMD5W/5YZmmzKGrbrvF2dFxSCi/pB+f9EBiB5a9Gmt5hCjGDCBFQu0tYC
         VZErjyQZ/hbbkX83LDK/52Di574s4vRYIlMG0GIv7GEAt9uNQdOMQOlizRWlTYym+msI
         nmvw==
X-Forwarded-Encrypted: i=1; AFNElJ+fW63iQXeO9Yltvu0X8dAscDHf0wyjEKkzZsFpemT6q4Ueb3xISSxkmEGPIZFcBFjKUrssxBjSik3A8jmTyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhAdDyFYZxC6RQROnLLSTpBGgONLHx+/CvFEucbkyf6UN7qqZy
	Iu7WcK7v56kRKpNACJtbe/jA4wEY0qjzJ2gfP7/q55+pnURHxWS1j0JBa6fDs+NIM0MQWTC+35q
	wVRnwalKll3+P/OQwVDH2HVck5ynhCjR6f+WOMv37Ca9RPEWh8Tc89e3uqSnFJBMUlktI
X-Gm-Gg: Acq92OHck2hO2mzsTJPiALeIhnQqIde1gMjAc+jRVT8lntxU2ss4qVqtaSDwlaYJepz
	6lgbvFFdNz+ItJn+xe147/byctpOcMq8jLvr0rCjIrjKrnc37t7YmNKrai4ghhQqCuocVpgMSqD
	Ui2YpxpDoV3LqalzjdN7hff/SddMpg1YrU5h4hUHp+gl26TV/9rw9c7f+UFeITN1tnolMlWZPBS
	b0tWePROoKEZBG4D+ZhTWvj0E8Uavkdwq8h3x93MJMcfCr9ZdTAAXJdO39Lal/BQr10V/rCHeog
	CX/rXYuOKTr8+hF9e0lma9qg75d50ffTvKIZP//4Z3F0AEB7DyBlItP9nX/PDm7sTP5pj0EuHnY
	wllifCfpm/HdYUDYLytgo8idSmMjNzQ1oRzBgCc/ezgIa5eU6E3lkUiudEG7u1zE8GXB8gLg=
X-Received: by 2002:a5d:59ab:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-4619f3b9ea7mr3616216f8f.36.1781599009352;
        Tue, 16 Jun 2026 01:36:49 -0700 (PDT)
X-Received: by 2002:a5d:59ab:0:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-4619f3b9ea7mr3616166f8f.36.1781599008675;
        Tue, 16 Jun 2026 01:36:48 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm40648506f8f.31.2026.06.16.01.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:36:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:36:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	kuba@kernel.org, leonardi@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <CAGxU2F6PDqHKLsW97qLUg+7hWq=iYk5qDAGUuxWSbdkyEDmsQw@mail.gmail.com>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
 <ajD_FBEak8hKNdIK@sgarzare-redhat>
 <2026061607-risotto-getaway-c57f@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026061607-risotto-getaway-c57f@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mc80Yqhke1IOpj3On8rJWmO7QCDH95XR06aLRem48N4_1781599009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 16 Jun 2026 at 10:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 16, 2026 at 09:52:32AM +0200, Stefano Garzarella wrote:
> > On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
> > > On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
> > > > On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
> > > > > > > What's the status of that fix?
> > > > > >
> > > > > > Stefano posted v3 and is working on v4.
> > > > > >
> > > > > > >  Should it be reverted elsewhere?
> > > > > >
> > > > > > Donnu. With the change we have no DoS but the socket gets silently
> > > > > > broken.  Eric felt given the brokenness is upstream already it's better
> > > > > > to work on a fix on top, not revert.
> > > > >
> > > > > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
> > > > > follow-up once it lands upstream.
> > > >
> > > > FYI v4 is now merged in the net tree, so I guess they will land upstream
> > > > soon. I CCed stable on both patches:
> > > >
> > > > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > > > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
> > > > buf_alloc")
> > > >
> > > > Both are related, but the second is the main fix of this patch.
> > >
> > > THe second one doesn't apply at all :(
> > >
> >
> > The second one is the fix of the patch originally added to stable queue by
> > this thread, so should be applied on top of it (commit 059b7dbd20a6
> > ("vsock/virtio: fix potential unbounded skb queue")).
> >
> > I'm working on improving memory management, but for now I think it makes
> > sense to backport all three to the stable branches.
> >
> > So, in summary:
> > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
> > c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")
>
> Again, this last one fails to apply everywhere :(

Again, c6087c5aaad6 depends on 059b7dbd20a6 (as also indicated by the 
Fixes tag in the patch description).

I don't know what you meant with "everywhere", but I just run `git 
cherry-pick 059b7dbd20a6 c6087c5aaad6` on linux-6.12.y, linux-6.18.y, 
and linux-7.0.y without any issue.

On linux-6.6.y it's failing because we are missing zero-copy support in 
AF_VSOCK. So, I guess we didn't backport commit 45ca7e9f0730 
("vsock/virtio: fix `rx_bytes` accounting for stream sockets") because 
there were conflicts.  That patch is needed to apply commit 059b7dbd20a6 
("vsock/virtio: fix potential unbounded skb queue") cleanly.

Stefano

