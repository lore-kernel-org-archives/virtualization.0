Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996B38D402
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242889; cv=none; b=mNS7unizOI+tNvCFoWn85tfaicCy+cjpcwlK+xb8QAM51gr+vjsHOfJYZKajVIm3PhG47cKhT6BWzbk5wRnEnTcRSL/h8u0RigDTv1B9nn4VZeHR/wvG6wtbYG4eOqHvWeoHjDw+3E8kpsqymrgRgEpdAobo2yk+aoxbEQAFSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242889; c=relaxed/simple;
	bh=D2ChaHDfvZmhwhjvRFMulLjrdG7KcK4kwhYUmtPbung=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QBXyOMbOR0AiiZTr2g/pIDqGsIeaT/+hFmlDEMLrOSmEoVz6alXfU5OTUAcBlDHdzn9IhjkA/Sx0cIeXKIlXaC06u2iyUpq4fSZbj4yqwR/4mbVGBFwLrVsrJyWXA3m2nGz8nZwoo0f855P6M6ZhdJss3s7doW+LGdYB0lIxHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2Mtr+CE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2Mtr+CE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782242886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufEo9/wdHySq3bUGk+mPJWG9M7FBYrnTov6P95M0vSw=;
	b=F2Mtr+CEuWVyTz9Biia+/jh/kzbgGJosmeBfmawW8E9Y3GfLkDnWdmlZfY6jyDbHa9/t3/
	RqyLSR1mycBPVxkvcAkU+9pDUroOahUbeKsmagQbr+xCys06Q7APqWVmngAEYEd15oMR2G
	reWrEbMC162th6csUTT4VpXGklUcodM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-caMzoGsbOkmW76inMflLMQ-1; Tue, 23 Jun 2026 15:28:05 -0400
X-MC-Unique: caMzoGsbOkmW76inMflLMQ-1
X-Mimecast-MFC-AGG-ID: caMzoGsbOkmW76inMflLMQ_1782242884
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so157879f8f.0
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 12:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242884; x=1782847684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufEo9/wdHySq3bUGk+mPJWG9M7FBYrnTov6P95M0vSw=;
        b=AJAADlw8JrdAddnA0lR4QAjsyzID1+zcvMwj4T+Fqrrq3Y7SxYCPGaY00K34hWSCxL
         J/dGS4DI335QsQGDl00bGgCQR+LgNorOKDa+tEKINaUWTfFxccJib774MnUCnYqK5XG4
         ZV7onmClI/1JF+wZUOVZx/6uFT3m1rMZE9yOJFOQpgBTHYxLCPHFs0vych8Rf+FZhxj4
         vINb4v48gvIZ720EaIntuLw0UAgeuEkb6Aph8oiAS44IeQN3kdj3/nhInT3rQal3GY4O
         WXAEKvMvB3L0O23aDe+VFO2mGkHTQnEekNm6ZAkxSGb+rlxtp3ZSxcmvZcBvkwArcO2p
         GgWw==
X-Forwarded-Encrypted: i=1; AFNElJ/fW6N3GlUwzr3w3O7iE/R+GC5l5tp14DJut7M0A+fAVgsqvShCra59EwxA9s7C5wQxWKI0OYKabOsr2kKSdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YztVjQIuLA5hXZrrwuXVYhkWbABT0YnfJnZcLddcRSoWAF1ab4I
	SdQGowFMjspclQ4g9q42GvSXEh1SMKNka4Sz5522medofjqcns9iVcQ9QMtTdxVRtOS9z2MWtxn
	LGndG0mBfkICoWzXHawoUHUb1MZHZ2jOMBFEi4ZR9LntNYi9u3cn6+HvEpSjIphDDHYdJxhXDPP
	sr
X-Gm-Gg: AfdE7ckhK11ZyXIz2/y1LOE88/cjZayrcLi8xIq9CnvfZFi095FndkaNygCd2z19vze
	eR+dRlYhsayI2PBbdzHtJ2llrGajv+LijIN7mBkUA2XXoZPddh02BaJtMawjulvNhtgRyuRIlTn
	LbVVUs7aYs17EUyuy+e2DcJOd79ZUaeTJ5WEfkEb6EGbsLHGjkizkHXq8Z01DuUnFP0p0DXl8Uw
	+l5BRsVS1TtDlXFHuJKYR9uLNzsimxGPDgeLvbcoZZpPx7mZ+4TTs5DB73ad6OLwWwZIbGQYC2z
	MV9svAt/BrE/xyEFSzbl1KZXdEP7aAykbBlqSx+Ag/fI3PWQJKz7jWFV68SioXGVfjeWMrjNplt
	Rlbpxgm5bLPm7uuLNZSbFgkzBQn9IgZQ5
X-Received: by 2002:a05:600c:4ecc:b0:492:259d:567 with SMTP id 5b1f17b1804b1-4925b379aafmr69873695e9.23.1782242884286;
        Tue, 23 Jun 2026 12:28:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:492:259d:567 with SMTP id 5b1f17b1804b1-4925b379aafmr69873285e9.23.1782242883768;
        Tue, 23 Jun 2026 12:28:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm424966045e9.14.2026.06.23.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:28:03 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_balloon: quiesce balloon work before device
 shutdown
Message-ID: <20260623152729-mutt-send-email-mst@kernel.org>
References: <20260622133715.3707707-1-den@openvz.org>
 <20260622133715.3707707-3-den@openvz.org>
 <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
 <33fba3a4-cebc-4f13-923a-31cb5753222b@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <33fba3a4-cebc-4f13-923a-31cb5753222b@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tgtUnurRNjb4p2DMMfyynryUKSPNgGBjPFMn0bXsHXw_1782242884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 23, 2026 at 09:25:18PM +0200, Denis V. Lunev wrote:
> On 6/22/26 16:38, David Hildenbrand (Arm) wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > On 6/22/26 15:37, Denis V. Lunev wrote:
> >> Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> >> device_shutdown()") added a generic virtio bus .shutdown handler that
> >> breaks and resets every virtio device during device_shutdown(), i.e. on
> >> reboot and kexec.
> >>
> >> virtio_balloon provides no .shutdown of its own, so that generic path
> >> runs while the balloon's asynchronous work is still armed. Once the
> >> device has been broken, virtqueue_add_inbuf() in
> >> virtballoon_free_page_report() returns -EIO and trips its
> >> WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
> >> ordinary reboot, for example a kexec based upgrade, into a fatal panic
> >> in the middle of device_shutdown(), so the machine never reaches the
> >> new kernel.
> >>
> >> Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
> >> inflate/deflate and OOM paths do not warn, they call
> >> wait_event(vb->acked, ...) and would instead block forever on a broken
> >> queue that can no longer complete. The device has to be quiesced, not
> >> just kept quiet.
> > Ah, so
> >
> > 	/* We should always be able to add one buffer to an empty queue. */
> > 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> >
> > is not actually correct.
> >
> > Yeah, quiescing sounds cleaner, although I am thinking whether we should also
> > warn if virtqueue_add_outbuf() fails, similar to what we do in
> > virtballoon_free_page_report().
> Good catch, will do.,

separate patch pls.

> >> Add a .shutdown handler that quiesces the balloon via the shared
> >> virtballoon_quiesce() helper while the device is still alive, and only
> >> then breaks and resets it. The break and reset are repeated here rather
> >> than reused from virtio_dev_shutdown(): drv->shutdown replaces the
> >> generic handler rather than augmenting it, so that drivers such as
> >> virtio-gpu can opt out of the reset. Unlike virtballoon_remove() the
> >> balloon workqueue is not destroyed, as shutdown does not free the
> >> device and cancel_work_sync() together with stop_update already prevent
> >> any further work from being queued.
> >>
> >> Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
> >> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >> ---
> >>  drivers/virtio/virtio_balloon.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> >> index 5b02d9191ac6..e35ada767b4b 100644
> >> --- a/drivers/virtio/virtio_balloon.c
> >> +++ b/drivers/virtio/virtio_balloon.c
> >> @@ -1137,6 +1137,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
> >>  	kfree(vb);
> >>  }
> >>  
> >> +static void virtballoon_shutdown(struct virtio_device *vdev)
> >> +{
> >> +	virtballoon_quiesce(vdev->priv);
> >> +
> >> +	virtio_break_device(vdev);
> >> +	virtio_synchronize_cbs(vdev);
> >> +	vdev->config->reset(vdev);
> > I guess it would be good if we wouldn't have to copy what the default handler
> > does, but could instead just have it in a reusable core function?
> Ok. Sounds great. Will do.
> 
> Thanks for review,
>     Den

