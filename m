Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C72FFDF0
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254697; cv=none; b=U0BzDwlSJLRrzqoX6KP6aKQXRClEqZp6khT54KQ/aYajrMXiJY8R98vEkjFKTzp9oRr4bbrDU3hfMsRzlaEfoljLiVxQsjF3sPUspLBhYlszF3hzkTMV7fwhyhhlarhgBpRayCdNT3fNEJzSzLme4YZ3QFmqhU8hxFnbYGHNUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254697; c=relaxed/simple;
	bh=WjR/rbwNJc0Qp2k2aQAdE2Gr22tCrag3f7ATcKE39Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WPSKJtO+HuqNTdkafMiW+kJ0PPFsjZWZuDHECU4genrc9RGR45fhSvIggaX67Xyt2B8OA8V2BYRdv1ivZBdWpcAC87kDAFtXrY7C7omduK7ciRSqM5mPFtj34skmBZbgZeLk0baBzpycIKjf9RE01xdYEnoMypw3zE1s9MB+a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3RvSpFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3RvSpFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755254694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5GOAcmmdxLGbEbM9B2YGjZnwu9h8dtTUkFqo/i0QYA=;
	b=D3RvSpFiPsa2FmJK2sfh5ZvZRlyGaew1zKj73nGe2fS1qiPQzYiRg6FIyd+aDiwS8hK6w3
	T+IKNXAPb2MbEv8ZMbejg1gflqnjIqvne/zCNWDPoZJPOmc8w+0Zj099Z98PcHgTFBq/d5
	HHK87JjrXRJ6v00iqcOmSPMpfmJ6b9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-bRh2OaZZPi6hmLEJbI8HIw-1; Fri, 15 Aug 2025 06:44:53 -0400
X-MC-Unique: bRh2OaZZPi6hmLEJbI8HIw-1
X-Mimecast-MFC-AGG-ID: bRh2OaZZPi6hmLEJbI8HIw_1755254692
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41e5125so1075497f8f.0
        for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 03:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254692; x=1755859492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5GOAcmmdxLGbEbM9B2YGjZnwu9h8dtTUkFqo/i0QYA=;
        b=gDxd67pNywn9wA3d4Xl7TozsBLePMaUlyb81W7cs87T+BgJT743GfF0cFV3KdE2FYC
         tNe7FckucqSciCcBSiJ53AToPLOXMGVCetnnKyrMLpxPrNMgzbHjp66lcRmNC7DkZQTq
         WhJ88XVGa6+AcxRNNxLXcFuix+62FU8tOt+vfsT82KCDxpF0eyA0adpp4by9GDGdiOPS
         PVKkOCnfcHzSSy0hN//7sSVMdZ5h7noljqbDg0GdsVkKHqJWI8YeIO+der/sHcZ8rRQO
         Pi16iCcmQ6V6W3+08i+/msGOii4l934fr+9N6uGJa3cTxrdiVoyOThp8wUbVb2kMOEqw
         GL0g==
X-Forwarded-Encrypted: i=1; AJvYcCWDA/16l5Y8olL5P9rMtq0FFe7yRFT/9cR7/y0G1kYUgAPF4RyGOs4zIOFAbyu+zNcCu6zQbZWTfXrxL5AaKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxYj6X+dJIXwJe/QAVCY9/RMmbX7Fxp5zADGedDqcVPuBWYP1z
	kAEXzWcWlvVFxO/vdYFVVlS5tXRk9xAOCXIpmUWBZcC4dXEcb9OlFexTqw6E9E0w7F95ikkLT8V
	9Ni5rDzgBD1UyzMI2LersdbCTWBhVQJ3xh8yBSDIf8tIgl/adFQlaYkJVHM4V/MeZPG5d
X-Gm-Gg: ASbGncvNdyOt0H25YwDSKhKhQqumauH2UxowuQmAkhNMdGUf/9fQ2o2uOvbCQHI/0UG
	cBq9V5pNkKuHABJWaKaIkaKx84PivK8p8SZKwwkHyYCzeSjR9vHGJtYtFKAFSV9jaXGwtl8sjZ4
	Bpukh3IuXOO0PSzpQKtp/dOJnYrIYjJrAS9cWJ+VAJwIs80+JzBchrVeZZMq4UAsFMCdu1L/HUx
	C2e56ie8biWbDYUFFA/hSFF3VUQPe2hk/GW1dBfn5Mc59jVsDXLlDlhItYmaqAxzW59Z1KFYgop
	momWshFABvb2Y7gVgIEx9/jtC37Fg1+sGwM=
X-Received: by 2002:a05:6000:1a8d:b0:3b7:9d83:50ef with SMTP id ffacd0b85a97d-3bb694af396mr1111604f8f.55.1755254691693;
        Fri, 15 Aug 2025 03:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxJ9VfnonVDFqga9qmU4sokEZCEtKZYfi4E6SPLLakFaeJSs6iOf6aXLBGPZEAaqLwiSlKQ==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:9d83:50ef with SMTP id ffacd0b85a97d-3bb694af396mr1111588f8f.55.1755254691299;
        Fri, 15 Aug 2025 03:44:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9936sm1456218f8f.38.2025.08.15.03.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:44:50 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:44:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in
 virtio_transport_send_pkt_info
Message-ID: <20250815063140-mutt-send-email-mst@kernel.org>
References: <20250812052645-mutt-send-email-mst@kernel.org>
 <689b1156.050a0220.7f033.011c.GAE@google.com>
 <20250812061425-mutt-send-email-mst@kernel.org>
 <aJ8HVCbE-fIoS1U4@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aJ8HVCbE-fIoS1U4@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SfTRMm4em7sx8AX7pZ2wVBkJUABUrcaI0pW5uK2hK7A_1755254692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2025 at 11:09:24AM +0100, Will Deacon wrote:
> On Tue, Aug 12, 2025 at 06:15:46AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 12, 2025 at 03:03:02AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in virtio_transport_send_pkt_info
> > 
> > OK so the issue triggers on
> > commit 6693731487a8145a9b039bc983d77edc47693855
> > Author: Will Deacon <will@kernel.org>
> > Date:   Thu Jul 17 10:01:16 2025 +0100
> > 
> >     vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
> >     
> > 
> > but does not trigger on:
> > 
> > commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d
> > Author: Will Deacon <will@kernel.org>
> > Date:   Thu Jul 17 10:01:15 2025 +0100
> > 
> >     vsock/virtio: Rename virtio_vsock_skb_rx_put()
> >     
> > 
> > 
> > Will, I suspect your patch merely uncovers a latent bug
> > in zero copy handling elsewhere.
> > Want to take a look?
> 
> Sorry for the delay, I was debugging something else!
> 
> I see Hillf already tried some stuff in the other thread, but I can take
> a look as well.
> 
> Will

I will be frank I don't understand how that patch makes sense though.

-- 
MST

