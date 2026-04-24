Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7D3D3CF6
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036022; cv=none; b=uTvVwQAmeVOypmmUCc1gxEyLJ0qa6yNmAI775/t+dazxjOq4WuEX2XDIpIgMW4S/A0WwjjoK27FpVGaeCQVL6TUwR8w8iI3z9ATfK8KX+TWLC+B2/ErXZv9Ke3QAvoy/VvapAL5bP1NWrM0jxJbIhnFAp87S4SQe9c8pz0MAshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036022; c=relaxed/simple;
	bh=HYrObwUGONel2KVyTugEPEgHF0BBAak+YhOMa3x2Rx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EF/eVawRkBlvfjWbscDLQiP+3ZuFb90pqEg//tiFXyPCuRhR0l4/Ny7flvUDABABNj5Ty9whIT7YhpGJRwsW/7Zu3UMYjKjKIHlWDyolaer4a2As1BKcz8wlXS4jFK3syoN0pAeNq6ODUQ90/Ak99OCAS1+BV8ZWJYWG/sU9RW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlbCeT6v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlbCeT6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777036016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBZypVOsotvD3+IMpNvRN0vVXxcrH58VGXlMFrXewCc=;
	b=FlbCeT6vjHvRVDD6HU3QDguY54mlPuNNPGp6OcO+WOisTiTsYUelNf4LME+uXZJo7vdcLH
	Ghd8NTsT7QQOw5RkdILtjnaskXJMwfqrkPCGHZMFMIZnzeD0IB2QO1UKWzIMGpbQVpqrwv
	BDqHgLam7RZ6YvX8yJ/+Hmjn06AACzs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-ZW1QEQwaN9m8CLLAUr6tIQ-1; Fri, 24 Apr 2026 09:06:53 -0400
X-MC-Unique: ZW1QEQwaN9m8CLLAUr6tIQ-1
X-Mimecast-MFC-AGG-ID: ZW1QEQwaN9m8CLLAUr6tIQ_1777036012
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-441243ba35fso3286914f8f.0
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 06:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036012; x=1777640812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBZypVOsotvD3+IMpNvRN0vVXxcrH58VGXlMFrXewCc=;
        b=BX9OyMh7z8Lnx82ItWLUmn41wvu7TDb+qGx59Q60BMc4qUb2bz6nKds/dVYssxt3TY
         vu/H3lRJjveWhBLv3HpaVqq/f4dCmf/u2+g3Bm1Vhbvpd/NIeMa0GMwa7BUhgzOs5uHa
         JLAW8k2vS6h+aSwQrbQT6kB+TDmCSTvxKlw4OYkAG1v3V01pSCTY8WvS9ha17sc6g/YB
         Uj/KRRcAeqEdKEhv1PiY6+/gdN0e4w7UnZjjy9ZCNAhm2G/MXFIGozvW6kdiiFt5KFjh
         h3X/urZ85R699wTMtsm/MhYT59z6t7VcSZ2SW5BsM7xwlkmKayv4DOEbSLukQEuJ1FpA
         8Rmg==
X-Forwarded-Encrypted: i=1; AFNElJ8NVOrMKO9/OZ/LomT0FagYElTx8etbSvwWnCGiyEeombK2xzsea8alALOE4WUb+UmQT3LM7Tgz+Zc4SqlJsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK0Ffw2gGSScakFl4Tdb7xCEsrSeHdby2wNhXa/kzJ5Wf7ohrV
	A4XQYeo8QJgYPRChCMNkywFdCW4NPaTwmCoyWCHU+1NT878ecBG+H4gYFCr22acXKOBRyBhmAcS
	gW/kAQpPaXcWOkfYkBTLmbxO6KbdTRQqZ5ZDolnNaYiaD0Vr0oLeaBMyt3TJH/BajX2wj
X-Gm-Gg: AeBDies7522QEYF1TA/X3f9U+GMvOgpTTgrNQXGm7bOybqpd/sRDR3JgT8+ZPvfDZlh
	WdYAvjupojShDzPFla0DYIE9qvcrcncOkyi+u5flEAGWW9HgpFYzou3yqUYRldL14Cmpo434+SV
	t8y4bX/kHORpDDQyBDz6jNMrIvOclMKUWIQ+FfeO124QiCmQ79vHh8bRZeNd5fgcXnnRA6aJilQ
	S+kP6Rw6hKevzcecUo/igYRQCyqJO2MhYqCos955GfQgc9lGb2puUypc3N+R85V6Iy/y3QlKIPm
	lhqhIV+EoRIUrqv2coGumwKRfGV6jSQmIfBNgtpr/Ut+4rHIJp3ANpX8f84CUPueHcbJQSXL3b0
	yqLBlXSuC72b8XNybvcwkDd3jlNQmHHfr42nSubLNEQvgpkT6Aem1dg==
X-Received: by 2002:a05:6000:250f:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-43fe3dd397dmr50865194f8f.21.1777036011851;
        Fri, 24 Apr 2026 06:06:51 -0700 (PDT)
X-Received: by 2002:a05:6000:250f:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-43fe3dd397dmr50865137f8f.21.1777036011334;
        Fri, 24 Apr 2026 06:06:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm58374248f8f.33.2026.04.24.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:06:50 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:06:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	gnurou@gmail.com
Subject: Re: [PATCH] virtio: Add ID for virtio media
Message-ID: <20260424090616-mutt-send-email-mst@kernel.org>
References: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
 <CADSE00+VyDf6hMAB79wP2koSQ3FznO_OJuGCZ6zN8zuCrwtZMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADSE00+VyDf6hMAB79wP2koSQ3FznO_OJuGCZ6zN8zuCrwtZMg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MWcIJ313inQb4pGiILr9E-xOA1tDPhGkurLeXWJ9bXI_1777036012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> Hi,
> 
> 
> On Tue, Mar 10, 2026 at 9:41 AM Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Add VIRTIO_ID_MEDIA definition for virtio-media.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> 
> Are there any thoughts on this patch, or any actions I need to take?
> 
> Thanks,
> Albert

Create a github issue and request a vote as documented in README.md

> > ---
> > While the Linux driver for virtio media is currently under active
> > development and review [1], the VirtIO v1.4 specification has
> > already been published and oficially defines the media device type [2].
> >
> > Adding the device ID now allows other components and tools to reference it
> > before the driver lands, and ensures the kernel headers stay aligned
> > with the specification.
> >
> > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97dc94c18398@gmail.com/
> > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-82200022
> > ---
> >  include/uapi/linux/virtio_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> > index 6c12db16faa3a..f9056af0c6223 100644
> > --- a/include/uapi/linux/virtio_ids.h
> > +++ b/include/uapi/linux/virtio_ids.h
> > @@ -69,6 +69,7 @@
> >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
> >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > +#define VIRTIO_ID_MEDIA                        48 /* virtio media */
> >
> >  /*
> >   * Virtio Transitional IDs
> >
> > ---
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > change-id: 20260310-virtio-media-id-b31179fcdc44
> >
> > Best regards,
> > --
> > Albert Esteve <aesteve@redhat.com>
> >

