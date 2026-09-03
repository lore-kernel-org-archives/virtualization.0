Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6049DB88
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436699; cv=none; b=AOlhdwefPcIHP3ewE9dLcsWDJVbQ6sLPmoPc+VQtkA4Mkqi52fmzCELgRf3B12EwlQZa0ia/C5NjMZwmodKwgofMWkhbqCpH9lbrIA5aCafOGAQUlkr76JYag7OSrA4G+JrfMlT5Sk6Rxfmhwf40P3VhN4kWUd4nU5ff4J/KYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436699; c=relaxed/simple;
	bh=tjJoksxTvSLbsKZmff396bp3cikpK+RKhQh5gNozOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QbU+ZVxiD8X9PH/Og9IYXmCN8h3b7HVWNbZ3BEFrYjvyEjhTYwxovCcvPBqH+GNXw0mSqMjuOqmWlp+ucLVb5SAMMsJlyXMqvV9kUrXMawBuMW9Rk4s2XmloTAelShgN2enq4doU5kVBzfLEIY1Bgq2uiRYxxgyPtH78uy17N1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYUL7wiA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYUL7wiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6plMdGLtlll1T0+Y+lYtkLC4Mp1xA8NIwqcOehU8CJo=;
	b=bYUL7wiAHMID0z/eZqBat+0NAA3vnAmA8yFj23QzstY3Y7paS13+YHFxm6pZfYF0ZSH0Hi
	w4idjX0MvLgCqJa5iE6USbMGSN1YWuqYQB536Y8VtfsWvJl4opCEjwc8glKF4/Wrk/s/bP
	WsA1UL21zQQGUEzfTwlAwNjpygJeH0M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aAepwQvhMbeuz4ec0cAaIw-1; Thu, 03 Sep 2026 07:58:09 -0400
X-MC-Unique: aAepwQvhMbeuz4ec0cAaIw-1
X-Mimecast-MFC-AGG-ID: aAepwQvhMbeuz4ec0cAaIw_1788436688
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso15736145e9.0
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 04:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436688; x=1789041488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6plMdGLtlll1T0+Y+lYtkLC4Mp1xA8NIwqcOehU8CJo=;
        b=KmDOOWnTrOpcxTMt5tw02xbiVwd0IKfeFDMwy286AzPxRI9kLlZmPmP7uz2WJ8adys
         90aVViPqCg/ixhCNzhW6FagT1JrPQH/Mcd9fcD/MKHUVdj+Rb78q9jEru6ZBsbJGec9a
         RiEACJcMiO0C0CHk7CCl1bbugsdiJvJnE/bu7OFf0c6gPT6DsU2rtflyPl/d0H70lxme
         sLudrKpHUlvEfsIWsCNdY6pLJW5vCn5/1SwY82C2okGwjzW9BCVyobD85H3zv/8SuBer
         6LG9lZHMmGDoehbe0kvc27twsEmJSP6W1g50B2PzS8BoVKj/NFA1MmkW6/0NPG6BX5HU
         nXSw==
X-Forwarded-Encrypted: i=1; AKwUvBw+OFKy8ySDQSH9dyabah0ux5mCG0jqdZheDToR4uIsr6mWkRfp1RJ3yQkq5JMRQnmpjFkV74zDKFc6gmE4Lw==@lists.linux.dev
X-Gm-Message-State: AFuF++ljoMcXtX5GtwnwiJTPRwSYtLChxDPG8BpX5JspIQq2SxQdL+CA
	AMxiGka2vfnnSmQCIMcoWB6RsqDerFHG7S6vt8yLmrwYs3Qy5e3OGXlj0Kx1HozkGyosJCVJXot
	+SER1VKLVUexBLwxUmeSJr4VibnnDDA21wMXuEfgDAOa455914qh5N5BONR669pwvBM4s/YPFVa
	8W
X-Gm-Gg: AYBFou1LHzf4jMFb+JVyPbwp/RcXhoUI/ehI46ryZB8UdP6PWUCnk2el3Ao3tDcwXun
	qUkToZ2lcnaO2pq+ADePRVb1T+bpwYN3hcjRZsOVV3kAv54GooAFBVrKREZhSO69mKOcxs3uKQc
	bl4YlgO3IgeqCSNniIlkgwMC2jwv3DGZOjbcub8DKaGBaDosC6TtiMKGF0sFNvyXvDYe3BL4EbE
	jkdzY/WP5jTvq1gMjX7DPt1nlArXMC26G4P/tn5plITO6q0R7LUZiLJZciX8UCk86E5bf49lsuY
	v2O2gqCwRexuLue0848FmE+S/Hx2Xj5hGY2UGDWqPQDvGP17Obr0EXEdTKitebP6F0rYZrVbBqS
	HgxZSCT+CHojzpmHumDx4k9U=
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr182266585e9.6.1788436687892;
        Thu, 03 Sep 2026 04:58:07 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr182265495e9.6.1788436687320;
        Thu, 03 Sep 2026 04:58:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm11621446f8f.21.2026.09.03.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:58:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:58:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio: synchronize callbacks during device reset
Message-ID: <20260903075709-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6qpSk1aYVS5ZwYK9fGXJOo_exjTx28A6ykvBAsHGvy8_1788436688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 06:04:31AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() documents that vq callbacks are not in progress
> once it returns. virtio-pci delivers that by ending vp_reset() with
> vp_synchronize_vectors(), virtio-mmio does not, and a driver that frees
> state its callback uses then hits a use after free.
> 
> Patch 1 brings virtio-mmio in line with virtio-pci.
> 
> Patch 2 makes virtio_input reset before unregistering its input device
> and stop its callback once teardown has begun.
> 
> Together these patches fix the use after free on virtio-pci and
> virtio-mmio. Classic virtio-ccw and other transports still
> do not provide the documented guarantee.


so with my proposal virtio-ccw will be fixed automagically.

other transports will need synchronize_cbs callback - pls add that as patch 3.


> The use-after-free was reproduced under KASAN with the race window
> artificially widened.
> 
> Callback synchronization was tested in an arm64 QEMU guest with a
> virtio-input device over virtio-mmio and four vCPUs. The event callback
> used a busy delay, not a sleep, and an in-progress counter tracked
> overlap with unbind.
> 
> The driver was unbound and rebound 120 times under continuous input.
> With patch 2 alone, virtio_reset_device() returned before the callback
> finished in all 109 races, each in under 1 ms. With both patches,
> vm_reset() waited for the callback in all 111 races, taking 24 to 86 ms.
> 
> Karl Mehltretter (2):
>   virtio-mmio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
> 
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  drivers/virtio/virtio_mmio.c  | 6 ++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
> -- 
> 2.53.0

