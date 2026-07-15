Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E23ADB97
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131881; cv=none; b=uYL2gqX/6J1Hq3qmtaOEMbx9Bcy9EfbUjjIVp60qngwKHLzwoGSsEkiB4g5yWoXUD1yWbq94Nk/9ynnw5eNTbwtRmQnjwseb+xeNHJGhUGYZcQhgosKApQbXFNnTMH9bTzd3/8dibpqrlzqE011MQbOdqOwBFeSnuV9owutGeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131881; c=relaxed/simple;
	bh=CgCDTCWRSJkLOMyNqmIyUWLC21lERecNvLqhW68S8k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AHtJ9Qm1pmBeYNnJybYltxiN3XRnRjAuhlcgnThTpTYBwW5RYiNeweAnz44tZOIK15tAAbrZZHBk3Gnwg0b3WB9jq9MFNSnLcv04cY6C/I2FBU5341WUSGEARCcwDBU2wysftG/BBq9Gd69T4kXmAqONUjgpHUUbXDLVuHMUKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj+rKdVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj+rKdVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784131879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u018p3vyJrvV+UM2lycGYWrJgbwr8WQB52QeOVOHYUg=;
	b=Cj+rKdVCdt8S8mBSQLEdUpqV+Un3E6e4v5glE+RHesTwIhrEUgd1ZIiY6cxJA41q8TJ6Tw
	OqZTjkOQhXHyLeyUdlqRNH0Zyx+TUOmULIkjyqcbHipDO3+NpakxEFDRZAMQHvcpsSY27s
	SvasW25mOIcuLeWJt9Zp6GDebTpWDVs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-1BFDgMHSNf-tgKgN0DIcEw-1; Wed, 15 Jul 2026 12:11:17 -0400
X-MC-Unique: 1BFDgMHSNf-tgKgN0DIcEw-1
X-Mimecast-MFC-AGG-ID: 1BFDgMHSNf-tgKgN0DIcEw_1784131877
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so80396215e9.2
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131876; x=1784736676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u018p3vyJrvV+UM2lycGYWrJgbwr8WQB52QeOVOHYUg=;
        b=feCfHhTcxAdXqDyKp13Xk+Ldqggdxd8qM/G1W0sT7n/V45v0j3qJ67/USF0NegpzMi
         KSVKRJhA7iG5wisD1JyI6m+6URuNNhcHcsyhzrloI/HPKJy73N6sieNev/r4ziO4EEMp
         19dcKwFKnZ8qteGyQTBmrEGEActXz305SqPbtEF37oslqgtm4ZHUqNoAxeCEUMmQurqc
         IbARevLTMda2+IqClQOfvCAequA3HLX2nosabppPHyf8J3LYLP5KmW6SNC8lYiRxWO9Q
         chJfCkNx3/kD771q3VEJ0jPM9QVpZSpcRcVEBACSqKDxAWcvsQHl4LEprJpBzeenGpvZ
         LLbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvPofZLJJLrWnamqL82Y4qvZfMSLWp8LOJ/nrfqKQaxGiEDC03qwItU+8lZiMZCHuOsejWaf9NgvmcFqSnXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3yjkO+T/RqXp5kwsY50M3cDU9ALGx0aZjCzhAPmjq20/cFyPg
	7J6JdQnCKENVQEjJpQIC73Z+GIjhANSFG4MbJcw6WuWx/uYhP+HaLfF33FkwwaXSNLULrrbOzgx
	UWf7eXTJoSF7fLtQeBs0mB25lJ4g/Y2PUPfJSlQPeMpsWYZK71nQwYATOznbA1+sYmJOK
X-Gm-Gg: AfdE7cmRAUj/bfjYdTbVTiaVksjGCRptsJ+irQ4GEEpJs0rglvfFnp8Oxxl4iUa+da+
	lKqZTb26bbccFTp4yDBNn+tsizg6wqFfLwR17Rp+wjKh6PzYwIQCmG6CYh4p9YcJXa8V54MHlcd
	x/f/fldMovXk4MboZZuim1y6WOtJLc95dpEje8tN6fomujLOpIxQB59NXLkCt0XX3QEFqZ1fKCd
	s/5/O//G6ZsqRzp7K+t5o0mwaWdhhLXKrhogtgPxJ8CyRj0qOpfD4SrYlUDWdKWbyFffIFSLOYn
	53wzbkrVMKCJLdzrXaevYVZMPELphIBpjzfBLy7IFm9v8ha9/ixPQpVR4IqlcZSpbRiiplbcvko
	q0t6IEuKHzVYJo/08QZmRKyufgF2VDfgVVsk=
X-Received: by 2002:a05:600c:6207:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-495389731b5mr84415815e9.0.1784131876367;
        Wed, 15 Jul 2026 09:11:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6207:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-495389731b5mr84415185e9.0.1784131875797;
        Wed, 15 Jul 2026 09:11:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm39394605e9.2.2026.07.15.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:11:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:11:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <20260715120911-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6j3bEXT7UsdNBsmy33tOMYxUTISb9eQ2pRMJP8vDeXE_1784131877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 06:07:56PM +0200, Hari Mishal wrote:
> On Wed, Jul 15, 2026 at 5:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > > virtio device. A device could report a bogus maximum (e.g. -1)
> > > making nslots = 0, which input_mt_init_slots() does not reject;
> > > it returns success without allocating any slot storage, silently
> > > leaving the device registered as multitouch capable with no
> > > backing state.
> >
> > So let's disable multitouch instead?
> >
> 
> So rather than failing the whole probe, just warn and clear
> ABS_MT_SLOT from absbit in that case, so the rest of the device
> still registers? I took my lead from input_mt_init_slots(), which
> has its own internal cap and returns -EINVAL when the device
> reports more than 1024 slots.
> Shall I modify that case to get the same "warn and disable
> multitouch" for consistency, or is a hard failure better there since
> it's a different type of bad device data?

I don't really know enough for sure but generally if the device can
kinda work it's better than not working, and adding
a capability to a device that driver can't use should
generally just ignore the capability, not fail probe.

> Happy to fix it either way! Just want to confirm before sending V2.
> 
> Cheers,
> Hari

