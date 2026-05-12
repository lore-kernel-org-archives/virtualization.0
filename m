Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3980C38E8BD
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584682; cv=none; b=s/seko+e/vd55pbn0iDlod+YTQGd5GxMTSfmLKJO4TEb32cMBLEujnfmcFvKDlGcBqzBusT8kJt8BXIqEuv4KyQXnmjltKuXc1PWflPWO4oTEGOc7wRir2qbPpCUqyBOeeAGQ5wb9aTYxh3PHZU/rEMHRJRgS1mXnGFxGZOrcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584682; c=relaxed/simple;
	bh=3pilreO7Jxj4wUh3RXkY1+6fibHwDc1PkYQ0dqDnEg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gQO46pjsv4yUQ7XKsZhRnLMIrxtXMQKgMXSErABsrqA14upwgZLuUlS97Sy/qMZtCylwCs6tdiPZKSUfUVmSgwKDRDAkRB8t2INAi5UJffwKow+6A9Pfmu9Dv7Curd69uJYwgDcpMVbrYaMx2fFnD+Jun+P1IeuuJej8dHnoKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBAvkLU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBAvkLU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778584680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
	b=jBAvkLU2Iup9kO1Z2nvhy+d6NZJj/gyve01FmKWU6HKJ2EgOVbn2P7clbLHzthjsE+7qlO
	SumMIuJaTFQPMA7BnwyqepJ1nFetxk8yqly2PMwmw5k+vrX/8VDk+QI06tdD7ZbnqvQC5N
	xJaQfAyJT4ma9PF5nWPCOVOgvi8YdYA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-EbYJw41lMAG4sFUZSbZFeQ-1; Tue, 12 May 2026 07:17:59 -0400
X-MC-Unique: EbYJw41lMAG4sFUZSbZFeQ-1
X-Mimecast-MFC-AGG-ID: EbYJw41lMAG4sFUZSbZFeQ_1778584678
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a589c7879so49010865e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 04:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584678; x=1779189478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZVeaoeGQMUpM7eRCOoBsTgdkpWc0LAFF4999VoUN0k=;
        b=B1KgxQYuemcv4uRNPRblX1DfvprD7EvY/gs89vU/GJtK8uD+5r42GjFfMVKRWApygq
         JVLY7AHnFVQGk7LWdHN4j2ILIzu3U7k/b3GxYqMXS1HdnHPr8Ih+6maqKrwEKiBbFdZ7
         1WQQvwNRzSabEMPm3Sxn8Cq6LiIGufCtuCj7QsaS8IV0Iz6zpyA8Ink/V9WpDOWcraE4
         RHWN9uq3GUoXJBg/98sDEmHelYw1iQmG96/qKpPh/l4sNZntcAeTwsh8TPkNen4l3yA/
         dLFsJHf4UwEP0r5ARePcRPVEgQIoeNfIOirzEjvVtzHr3ZNJaZGW4Uez/x045yQchLMO
         diuA==
X-Forwarded-Encrypted: i=1; AFNElJ/7raU+rt8rterIb6pfPbq8BxR/FwEVGSbHwEG0LjNsToAKCDobJuJylAJWK9AXQjfFSUxjHc6aCx07UM+vaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNzGieA4ceHEqrm8GEILtqHS9Kv3ccFNc5Wc5st9XVkRfeR6LS
	Gk/HxNx2CziWjSgaqNL+Nsif36M6w9ajbFJvUviKn48vV9mbwGWBfxxIZ7ypufRy4PdwWFUEIe7
	8u+QbtYnVc2ddsQMNtptl2PV9nvrpGS2uc7bJwGWUa+VVcUWhwp/K50/aP7WheNSuDUmu
X-Gm-Gg: Acq92OEqNiQQtahdsfc8o7YV+XightQ3CDu8apEonb1YE4qBfTCdGPn1ckpISriMCRN
	g5ATvW7JrpUsnP+0hv1siyPfhI1EiJbOTHfBpBImIOqMQ0de5uG1gUQV5gngyuz72/Gxyv0LEw+
	3ZfPfBC1F8rlvVlKceE3LKZ516n+M3VUPBLrWPQ/SRK2KonhxpGay09Z/uX2s0MfpGyxAfEaKrs
	oMqbudYPceCK2/U7psOtLMQs6FgUXa3zTymbOpinr1eBQLNbBoPT67XIKxyDAoM2hrDOh0Q0/Pk
	vbeOnvn6W8/t2Q1Il0kM3Fs7sVhr+VP30+Png24wSjWko6H9pLUODJAe0Hm33SOiOGm99J3cmTg
	Sin/UZPK9P+UGT8rJviKlcTEp9K8lmbnb61AMxeru
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750885e9.8.1778584677972;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
X-Received: by 2002:a05:600c:c167:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48e8e207f2bmr53750065e9.8.1778584677428;
        Tue, 12 May 2026 04:17:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm26866475e9.1.2026.05.12.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:17:56 -0700 (PDT)
Date: Tue, 12 May 2026 07:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512071726-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
 <agL0ewq9R-Br9mUh@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agL0ewq9R-Br9mUh@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zwK0c7Vjyg32dTQ_JPHkKIfvQFSQzw0obCFLChiBIr8_1778584678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 12:03:38PM +0200, Stefano Garzarella wrote:
> On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > effective receive buffer below what the user configured via
> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > silently dropped and applications that rely on the full buffer size
> > > to deadlock.
> > > 
> > > Also, the reduced space is not communicated to the remote peer, so
> > > its credit calculation accounts more credit than the receiver will
> > > actually accept, causing data loss (there is no retransmission).
> > > 
> > > With this approach we currently have failures in
> > > tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> > > test 22 always fails in this way:
> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > 
> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >     Resource temporarily unavailable
> > > 
> > > Fix this by using `buf_alloc * 2` as the total budget for payload plus
> > > skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> > > is doubled to reserve space for sk_buff metadata. This preserves the
> > > full buf_alloc for payload under normal operation, while still bounding
> > > the skb queue growth.
> > > 
> > > When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> > > flooding where overhead dominates), the connection is reset and local
> > > socket error set to ENOBUFS, so both peers are explicitly notified of
> > > the failure rather than silently losing data.
> > > 
> > > With this patch, all tests in tools/testing/vsock/vsock_test.c are
> > > now passing again.
> > > 
> > > A solution to handle small-packet overhead efficiently also for
> > > SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> > > This patch is needed in any case to prevent silent data loss, because
> > > even if we reduce the overhead, we can't eliminate it entirely.
> > > 
> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Thanks for the patch!  I'd like to split this:
> > 1. buf alloc boost
> > 2. reset when out of credits
> 
> Good point, also the reset maybe should have an other fixes tag (i.e.  when
> we introduced that check)
> 
> > 
> > this way we can revert 2 easier later.
> 
> I'm not sure if we should revert them at some point, even though we'll be
> able to handle the overhead better,

I mean we'll prevent the overflow, the condition will never be met.


> but I agree that we should split them.
> 
> I'll wait for a few more comments and then send v3 with the split.
> 
> Thanks,
> Stefano

