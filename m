Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A503128CC
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082577; cv=none; b=ITyjlyVEkMLC25hfFzynfSfRZQpD65f7Pgp1S5tUnVnr1J1jCvOpAO7JxbG7jdBfvn2EhUYEn4ot6+0s2qf86NKWFK55lZLfb/oysNBF1qsfRqZ+AH65BAZgfs0mLWVSDKlt0ec6SDQGOmT82PT6QKVIpyaop3gTDDBYOvbNAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082577; c=relaxed/simple;
	bh=OFk6u9sPQNb/lVBSlnQi4dTa2C8rYPWBoQllv2zqLfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LN0c/FDAt842HU+L6vtxOS9i6ikv/I5H+sIu69/H+ROWYPcv2ccC52jmuPa2SfO12FpKKyfX450+scmb2vXaOF2QFcPV6Am/I8YEnkXhG9txN94CxHy89SY533gn9zK8B8qRdeF73DjCuv/R8i0ZnRWpC2qGy14EpiXYozra1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORO2XKsQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORO2XKsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778082572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
	b=ORO2XKsQuuQriSQZBiMjoFNX1aeNgoXNVWTlPmmW0EvOpbccJ3DwTrI8zTVTull9nkJI/d
	KALWBopG50ljQKAjMfCgLv4Ag9GxwOIo6tCaAtVv2aEkZZGJYu8grLUMKKFUcFxM05ORzk
	W4zTxielVcHxx9HP1tZQd8HZX49qSCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-S_jdzEjVNuaMOzTipmpQ5g-1; Wed, 06 May 2026 11:49:29 -0400
X-MC-Unique: S_jdzEjVNuaMOzTipmpQ5g-1
X-Mimecast-MFC-AGG-ID: S_jdzEjVNuaMOzTipmpQ5g_1778082563
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a3aee3813so2837390f8f.3
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082563; x=1778687363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQK7jK9fWfmI6EGpDkjX16iWpfsGamzwE3Vp7aLO0Yw=;
        b=VybvAjElFn1oveJLxFpmSGmp+OFPc519ajpIO/knpsM8RmWey8O8zJ21PP0tRGiu41
         RNeS9TG3tnBftJNuTV1uQ/l1xUVKsDLbJq3AjgEJZ6fhNvJKeQpWy9rk3pUewx4H9H4p
         7ZmGqT3/5MIZU6zXdThZ7QKgyfXp3uHawD7YsNjeDMhl7YyRTJaiz26Uo6VQoTkMHh0F
         YNntTaiiF31Cy1bqi+0JpyNjJNIip1v/EPTijYgzl5VSaimliM2tD7FDcUv0VrtaTFBR
         FOQI/GvjubfJtT0hdHQXOfsLGBUG5goVmtsD0LISPfCD2CIomIBWh7b69DS4B/82gK0q
         fR/A==
X-Forwarded-Encrypted: i=1; AFNElJ/h0oU4nYtEvq9j7Xe3RHYAl+26CLXk9+Grvw6GbvQg6KtOeyFD7vFQ3z4J9JTHWzhDYO3ltz0YX2U/zIMFgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzge/8xBh1CZ1JRAmoK5RnlZGdnEan6/b3IBYftPp4TIAQaswQt
	lU1I7LgDgrpsfkWNRb/90rG9SXGzTDIezkE9YuONGQOrv//0pK81uSWZyzYqykkQK68YWrv/fOo
	SCnwBSswHK0ePDnDhvy4z5ZbAO5V5dKm5gGGuJ14p2L+9lG1Nt3Uho2g67XX8inqbaf2T
X-Gm-Gg: AeBDieswwQ+Lx727FaSK4OGgavPVjlMzXZryYTtzbD4b5QjtCHu/X/9anH3eapuP86+
	oWVNea9Pqdh4+UZxHZY2cWDIzRIrZAinH/Tto5Mfyj6HzCgHfeGrOJAVLDIxpYu0iAmftxt153T
	5bDAgsO3vep1132VBF2dtM2/rRnTDifSDFVMWay5f/TKSoYJg/VfY9cr2c/p3KPFikwwVhFcLVf
	qCotgjnstyYO+KAnG+l19y07peYLLZJx7cpcpsWq7+FdTpLm0ywbdTaM8/ZddkGBKbNcR51dzrx
	emtTCfufloumjI9J7u1G7kkJSlc2HLaKw399Tp2KHiryLfTbFSx84jQq4Ni1IsdGBYnrHvh5Nh6
	OZt1FNXhCYsVinoajxTl7M86f4Nl/J5L7KoF1Kp5zmYUc2im7RZ4=
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975725e9.15.1778082563129;
        Wed, 06 May 2026 08:49:23 -0700 (PDT)
X-Received: by 2002:a05:600c:b8a:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48e51f2f91cmr68975055e9.15.1778082562568;
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5d299sm31638085e9.0.2026.05.06.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:49:22 -0700 (PDT)
Date: Wed, 6 May 2026 11:49:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506114213-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <20260506111507-mutt-send-email-mst@kernel.org>
 <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANn89iKWhJp2N-60FC4JpX2Dw0sK8-vk2WrHkDOnkgC_c8nbHA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6_4Eg9GsHxK6a4Qj-MT4PNpDPAQLkmoQmbosbotBYHw_1778082563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 06, 2026 at 08:38:39AM -0700, Eric Dumazet wrote:
> On Wed, May 6, 2026 at 8:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > There is always a discrepancy between skb->len and skb->truesize.
> > > You will not be able to announce a 1MB window, and accept one milliion
> > > skb of 1-byte each.
> >
> > We can if we copy.
> 
> You mean, ignore VIRTIO_VSOCK_SEQ_EOM?

No I mean saving it in a compact form.
If packet boundaries are the only concern, the overhead
needn't exceed 50% even for 1 byte messages. asn.1 ber, for
an over-engineered example?

