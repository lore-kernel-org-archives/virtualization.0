Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32217AE11
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811388; cv=none; b=DaWjV5Fn4izrqxSpVXiqRk9jc1mCZkYaqF4BPvJAq6E0WWvu/YbXSxxIM5MGUv9k+u8bW0CLIwKwIK1mOBADaVLuFvqrbHw5ca/UoPDSUF5JjwEgti7Rfi3WHdLyDqGcAh1PV5H8m/gsNnjc/eNAQsOHAo48h50Nt9E6dqvyPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811388; c=relaxed/simple;
	bh=+v9TYg0I32wj9TIv39/8XJR+K77d8shcdZ4JpLtQeWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qNfo7MO+y1P634VD8tTCnJOj2e2mWoZCYGo91I0oI6PGwCfeHt2/cyglSMTHaSOiL91D6JsCLRgouaB5W5u7apasg+tiVE1eDykykFfRERuqIr8R3ri/CMf41VTfcSez2QTqPKlUokUH0vlGzfUCO2KO2/YnWtDBS2BMJHfNnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnWYRW95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnWYRW95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761811384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OGlXAC9k2Rj+4zSzAHyi3VogDCtRFy8S0qEf2+An3Yc=;
	b=DnWYRW95TGGnVhgDOCyJUJ9ArdTBk72R5Nd0toBX3DIG/d5Qrlyu5Kwn+AHZYm1PqCo/9q
	HOAiO+/G+vDlwRB/EIWha1s9FtE4zruNrPbIjjurh7ianaG7Y15L8GcMbMCJcn9EzdxPz7
	aTIYo+OsIZhvEX0WfTbFcCCkdawoqa0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-o8_5a5fYMuKn1XHE0MfijQ-1; Thu, 30 Oct 2025 04:03:02 -0400
X-MC-Unique: o8_5a5fYMuKn1XHE0MfijQ-1
X-Mimecast-MFC-AGG-ID: o8_5a5fYMuKn1XHE0MfijQ_1761811381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475de1afec6so5095395e9.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811381; x=1762416181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGlXAC9k2Rj+4zSzAHyi3VogDCtRFy8S0qEf2+An3Yc=;
        b=M707D/GUlQZtv9RN4hABFCZkk8z2a4D+sLtPCdqJDfdUn8K/4HipPGqiNDfUHvnKUw
         lvKr8WVbsmuWLhvImMdlcMQ8zPSYWM8L/K73/DaPNfHZZflqjPF6mfHAubZDRk7bAsSu
         HFIW1CZywFXZMocd6BwBk+4o1AMuCNFyi0G7JIN/U/9LJ8/p69OV8L2+QMK4rUIW7ZIi
         SiCQC1mm8uu00ctFbcbB0j0VpZpAXFOIjxkFLElVsNcRul3LWjWXkp6qKyEBC849/Qec
         jF6aQ+pyDMqBjR5T+9+TK/C5YlgFUB8KgmdZUD1yykI46Bc/DQC/NhVVQzJJX9cGRx8S
         MaIg==
X-Forwarded-Encrypted: i=1; AJvYcCWq+dp+ERIZ8CJnSG6BC4wxGZSx4+g8Y+/Ri7Afn8Jh0vEaVenWT8mOsExj3kruVBY5XrPOCWVNGF4nI1lzTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUm/AJcyrjlHUghSEmggXtHlo7GAWwS2hX9StAkqUDlRN4QnLQ
	tKOYQ7Hp5frTJYDoM7dfXRRx6/A6+JrNluYr57z7WsPBpCaFD908pTneu64KX15r/4cPhaIf9Ip
	hstf9a37wROw45U8lyvm0qu+WV1mvydv3QJgZFFsAG9mE7V0dvX9vQILVzyUZaLDGR/MB
X-Gm-Gg: ASbGnctfvy5ZLy8lIAHCGUvW6kvCJmu32rvjCOrn5P5DjF9SANuU1TiAecFTe0bmGqg
	1i+Ww1fSbb0li1sskI3KAU7x7C+uX2nsPMkHBXRneNkhM65Lmms8okcaNb5AdlG/HMHc5Na/G8k
	Zov93RG5bqSLvl9AK7EMEA8Q3q5X0ksPmNC44ZN3cyGy2cZ6p40vp+PUYuK8szugD8AqM5fqhZC
	qljul5/moFYQVqkAYC5k2+vUcHxy/WT130QnwgtVpfYVk0HD9vvPV2MCS2cUvZmIPXTKvsyh6sd
	U1HiRL0z9PiyXrOUbU1CL9ORCpB30e0ordJ+hZwQwStvAQ5EMhZaE6TkZXGQ44kEeJEo
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr15795985e9.3.1761811381065;
        Thu, 30 Oct 2025 01:03:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIk/aVFQrnT9Hu3ayvn/eJjBsnEhmM/97mhlhQ2wqghUOS1OPCyVarI+Iir3/xbIPyjDpwIw==
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr15795425e9.3.1761811380513;
        Thu, 30 Oct 2025 01:03:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:9d00:de90:c0da:d265:6f70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728999a4bsm24950915e9.2.2025.10.30.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:03:00 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:02:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 0/4] fixes two virtio-net related bugs.
Message-ID: <20251030033025-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gwFdqrZ_a8sVUJM6SLhfkp5w8mVUOBxrJGrpkaUBSlc_1761811381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 11:09:09AM +0800, Xuan Zhuo wrote:
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
> small amount of code duplication.
> 
> Commit #3 is new to fix the hdr len in tunnel gso feature.



I think these are completely independent right?

When there is no dependency it is best to send
patches separately, this way they do not block each other.


> 
> Thanks.
> 
> v4:
>    1. add commit "virtio-net: Ensure hdr_len is not set unless the header is forwarded to the device." @Jason
> 
> v3:
>    1. recode the #3 for tunnel gso, and test it
> 
> 
> 
> Xuan Zhuo (4):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: Ensure hdr_len is not set unless the header is forwarded
>     to the device.
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/virtio_net.c   | 16 +++++++++----
>  include/linux/virtio_net.h | 48 ++++++++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 15 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

