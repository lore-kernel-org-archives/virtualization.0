Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A539CCE9
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345555; cv=none; b=ccX3PHNQgfoRziaA5sZDDcZoCy/kxOttSbtyCnaX7tlePkcn+8J316IQwhqEp6BCuV5/hevwfuJxBw3y6/Eu0e21i1qAroNqFIJ3Fm7HkcOvl4Qczye07KBnXIahYDNeeuzMJumBIu+50GwRxaewcBcb136ZraG/lz0YN0UjMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345555; c=relaxed/simple;
	bh=KiYTJr6ciY41S0faZ/K7ky6D53SOLmHv6iAAKkbh7HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MW/okTylgLpuMp31KHwG7L50Xc2FgJBxO7w7mr0GTR+PoipUJqno1QfEMf63q9f4vfLbWbYQ75UGNYctSedCDvQ+SHCEx/CmN7ZziG49IBHiNzipI4XXqiGDdaYGdmOshtLSzSx3wqScFLREep1JmabzPO5Mg7Shj2P0Urtd2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=he/wr1Cu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="he/wr1Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786345553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr3vIYuq7lla3+ZHZmoYb7uvd3kFa0mXYvvwO+akg2g=;
	b=he/wr1CuC4TL9D0W5teddTTuPh/0gADFFzReWtVd0juNwj+d/ns7iDSzqharv9zO0u5tMC
	RPkw5m20S4N22mUw/MdTsJd9dLumN6MGxR/eYwabLgATRHudXUUs2YI2ybW33AY+wPc8Fv
	LPrr8mACpsCSqBZoOm7tF6auPZ5AStI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-0eC_AxUtMPiJfpHvK1LGag-1; Mon, 10 Aug 2026 03:05:51 -0400
X-MC-Unique: 0eC_AxUtMPiJfpHvK1LGag-1
X-Mimecast-MFC-AGG-ID: 0eC_AxUtMPiJfpHvK1LGag_1786345550
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso10540645e9.0
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 00:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345550; x=1786950350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vr3vIYuq7lla3+ZHZmoYb7uvd3kFa0mXYvvwO+akg2g=;
        b=jway51nlLptTfKdrBF94mwk5QonfJ12/8Ot4dY2jFczC9SIx8p0KB2xYXQFZtDYhdv
         0zXJXd+NgehhJPVdTI/w3Z6Lz2rSl5qVhG82CRqcIxjLGr3dlQQ5X+Za+0BWVa4Ni8DV
         IeTFHesrheDIwgHtVZzmrmljNKQK7xeVfyRXTobbzz+ysRa/J7VNB0aUfUkAZUfHicrB
         PXoORv6onBDF00wIiXUQnDLFiqnL20UexuGZZvu1WRjYoJ6IpKonbZWZuRDL1LKGGwP2
         XzH8IBbhg0tLk/1Iw5+U66hmyY+sgcgW+00VyUfK/E6ns8IM66AYp/2JwMeffUdXHtZu
         V71w==
X-Forwarded-Encrypted: i=1; AHgh+RqrLJKyDHvZJzJeBI7iL9JHzyJhEdMRLqxMN9IveDUsyIAP5Frn6Djn4TUNMvuved/j0YzA1TAPoJFKVCbisQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUBGlK3C1njg4gYjHffiPwG5idPBoiajLPjPsPWBcYrIUTZ0tp
	H9H6zxvx8i449MzZ0p8XXAcLuaSbN711HJTPduu9ycnPvatknjQof9zFYOZM3ojgK2KZdCzt6N5
	oQbI9peD6nOuectUYguNhTAjLBPkGIhYpeH/YpYMla3t0ZRCCaHVfhQNiQjzSior/YAqy
X-Gm-Gg: AR+sD10diKYloAd6IJHdrMOzMukGeAm5ZgRUqrwqLgrNYZRhs+hkf2k9/ycc+5HVLJZ
	2cXQeMCWL7rOtwma1UtQyvPX+ODK6J5LPKTB3LMTdPcrKsR5jTgXNmDzuS7PlS/Sr7XHVBk4D10
	JsMsi/IKjPTeMm+AwCANu3afTSLk2u6kryhm7kk7j0s0QVZQCkrbXdcvGwt+lmBmOkVCSk6ZxVw
	JkCRwpxufFjK29jTA7TWq9qaZWEft4XLh1QiHw0jispp1deJEPtl70O5p6xWunD4UbPFaSLqnVM
	8K8cGAaNJ13FaPEwnSpfPSfnxiDB+dimoxnf5bUQ6CFVNIiUXR0NGJKdE3/C9RlDmYOu1T2nwTn
	AD7dcqaN8dI7Qf21q/q9pkA==
X-Received: by 2002:a05:600c:3b88:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4996194e24bmr260255005e9.1.1786345550228;
        Mon, 10 Aug 2026 00:05:50 -0700 (PDT)
X-Received: by 2002:a05:600c:3b88:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4996194e24bmr260254165e9.1.1786345549684;
        Mon, 10 Aug 2026 00:05:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm395892805e9.3.2026.08.10.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:05:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:05:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hari Mishal <harimishal1@gmail.com>, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20260810030400-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
 <alfPcWKMGL-S9BRl@google.com>
 <CAMmC+=DXS=xs0CZyf+N-71NT8D51xQYatBv=dfVQC1aBohDdmA@mail.gmail.com>
 <alkTnRb9qhgcMGGi@google.com>
 <alkU66ViqO8pnjQQ@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <alkU66ViqO8pnjQQ@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s8R7U-6YCicTGudxoMT6osuuuD_fbAz8YOSee9BKsDc_1786345550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 10:33:04AM -0700, Dmitry Torokhov wrote:
> [ Just realized that CC was dropped in the email I was replying to, so
>   restoring and resending... ]
> 
> On Thu, Jul 16, 2026 at 10:28:36AM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 16, 2026 at 12:34:57PM +0200, Hari Mishal wrote:
> > > > What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
> > > > kernel crash? And if this can cause crash then we should fix
> > > > input_mt_init_slots() to reject requests for 0 slots with -EINVAL.
> > > >
> > > 
> > > No, it doesn't crash. I think every place in the input core that touches
> > > dev->mt guards against it being NULL: input_handle_abs_event() and
> > > the mt_slots check in input.c, and evdev's EVIOCGMTSLOTS ioctl
> > > handler all explicitly check for NULL and degrade cleanly instead of
> > > dereferencing. From my understanding, the worst case is what the
> > > original commit message already covers: the device advertises
> > > multitouch support it can't back.
> > 
> > So what? I still do not see the problem. Let's say I have a device that
> > properly supports multitouch and has slots, but then never sends any
> > events because firmware is buggy. How would that affect anything?
> > 
> > If there is no crash that I would leave the driver alone.
> > 
> > And we need to remember that we are dealing with a hypervisor here that
> > normally had higher level of trust than the VM. If it messes up we do
> > not have to clean up after it. This scenario is different from user
> > attaching a malicious USB device to their system and getting owned.


This last part isn't always true, while hypervisors are generally
more trusted than a random usb device, the level of trust isn't
always higher level than the VM.

Still if it's a theoretical misconfiguration that leads to
nothing bad, not worth special casing it.


> > Thanks.
> > 
> 
> -- 
> Dmitry

