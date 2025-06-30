Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DB238C05
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269642; cv=none; b=C7tYLyQyfvV0Fq9wksaRhDhoXiq3otMz5oIc0utSC1iKWmHsvPpv+btlgqMic8fqZ2bQ4nfwTN5MKB83lJESeLTAVPbzJy8OAjYNneuYnClsfsk9IA+Fld5mqfZLoSqh4+J2+owm1TOY5Mu+TYQ+yaxXXCY3wV8LFTEKoV4kvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269642; c=relaxed/simple;
	bh=3WCJLLv4RhnKEvcl21V/JHUYDcouCFwoRzhLS4CQ9mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lq0y0FbDmXV3tS3KRkzDcZUFE4yWtxbwRBzZ7kK6FY3qkSMv+gZuBoogVRpfdu1O8TzhZVXmL1NtvAOVZRVQjx9+/SHhmZ6jHsp+pIlhpxtF1verk5VAz3lSqMcl16UCF1dRqfRUOEEJ80ZKblevbvleQgsv6G+MHskMksLDzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+07wnDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+07wnDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751269638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ktNPhfijuEzODMwYTiQC+VuJwh6IE4+mAtetQ6pS/E=;
	b=Z+07wnDGYHQgJxeMEr4EXfJz1TH1ZAArOBZS62ZwOzxrlGlRh5inm5P2ggNcfYjz4E87IX
	Bf2on51Ldpem93qlp2Ag5kayZo++/5+7UUgALffPPusuNZRP3ZporDVEkdHaXl/Z2OZ9gc
	A3Zva7xxlNt0a3uslcadP7s3oKelciY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-EFCJiQ5nNoyudci473_H_g-1; Mon, 30 Jun 2025 03:47:17 -0400
X-MC-Unique: EFCJiQ5nNoyudci473_H_g-1
X-Mimecast-MFC-AGG-ID: EFCJiQ5nNoyudci473_H_g_1751269636
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so1988101f8f.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269636; x=1751874436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ktNPhfijuEzODMwYTiQC+VuJwh6IE4+mAtetQ6pS/E=;
        b=OxzUXRNoE/uNpMK5HLsTzGAK4ww8jZ7Hax3O23zj6G69xxsquZF14cUIzSVWGTn6f+
         BqykbWS5sd72Hh0Hvs4iQajKSJ1Yuw3hFWfuoRb/C74e6Y+/u770EOYoNsBOXhumDxXP
         33tHDSvoz6/8yv0IeSXQHDUoKm/dAItqtS64Aw6c6fiMeMSXqYlQy29y4z2Ed7/cC+C6
         twu8D//SB0UTOBypurhu47XzivKPIGxcpC/uzulsuWWVdzFaXJ2NpfmjYbO3SwHwGS6+
         EO1bH79xfVqwyw0S5sJ3m46/GQfFZoAVd9W61Zda7fGzdwR0lpZtx7pI2FdW3M3mSCXe
         vpXA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0ja8EdywQpWUWi/phfsGpvv7LymF6C/ORK0CkjTDQiFTlMflEWqb/5KZlkPEaoKOE9O/JFACg1McUBYUWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUsM1iaGdu9xsOEd4RF0VRLR7qDn6bLoUIIL/iJ+cDT/O1Ej4g
	AlHgWGMUPSJMOMx+z4VtWykLqmmDMzkMgnWH2zryplO3WRWfYm/7XKoVRizqA00ixRNtpT0XdeC
	XysWOx/UqfjO3jhT+dg5boBVRepIMJfch/omZKFrjagyIi7GryaRnTJKHptdysw3hHgrY
X-Gm-Gg: ASbGncu5gmTQ+Zl0lMRSIgb1Uknwn9DnFeLJaOG3tG3PTmBzVGU1qb2yztzfPKIrwgc
	wGnf1Q5XSsn+zTGQWYpbT0O/cLEFORpQtdaaocD4AQfaqiev+s4I5qsA62zNq6SjYYScsWpa9wV
	I1+PIZ3GlxW7DZRuPn9j26ggexH7JonZGy821SMftruk4JpVYc40hYL4ewREe/EFPCc7Tnw2DIG
	0C5RmIXz7fUyLkv5l/Kx/9xXGaNU1iFvESrN/2/PKKi3dNbwrmsYX97gV2W780TqPuzptmYg7gZ
	N9pnZm9jhD4dgNAx7lTt4OHQQRIr
X-Received: by 2002:a05:6000:418a:b0:3a4:f70d:aff0 with SMTP id ffacd0b85a97d-3a6f312df2bmr9022661f8f.14.1751269635640;
        Mon, 30 Jun 2025 00:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxPyEI4vtDCAHmMrt9Bgdg2700Ez6oVkN9Z1NlWqAtZ1aXzxk700hjPBCX6uj4jbe2vAmlKg==
X-Received: by 2002:a05:6000:418a:b0:3a4:f70d:aff0 with SMTP id ffacd0b85a97d-3a6f312df2bmr9022638f8f.14.1751269635049;
        Mon, 30 Jun 2025 00:47:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453814a6275sm105907065e9.1.2025.06.30.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:47:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:47:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
Message-ID: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq>
References: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s0ISCyh0_99LfOG69ozRwPQkZSi1AxrWiOlpCw9GC1w_1751269636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 03:38:24PM +0800, Xuewei Niu wrote:
>Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>bytes.

I think something went wrong with this version of the series, because I 
don't see the patch introducing support for SIOCINQ ioctl in af_vsock.c, 
or did I miss something?

Thanks,
Stefano

>
>Similar with SIOCOUTQ ioctl, the information is transport-dependent.
>
>The first patch adds SIOCINQ ioctl support in AF_VSOCK.
>
>Thanks to @dexuan, the second patch is to fix the issue where hyper-v
>`hvs_stream_has_data()` doesn't return the readable bytes.
>
>The third patch wraps the ioctl into `ioctl_int()`, which implements a
>retry mechanism to prevent immediate failure.
>
>The last one adds two test cases to check the functionality. The changes
>have been tested, and the results are as expected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>
>--
>
>v1->v2:
>https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
>- Use net-next tree.
>- Reuse `rx_bytes` to count unread bytes.
>- Wrap ioctl syscall with an int pointer argument to implement a retry
>  mechanism.
>
>v2->v3:
>https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
>- Update commit messages following the guidelines
>- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
>- Move the tests to the end of array
>- Split the refactoring patch
>- Include <sys/ioctl.h> in the util.c
>
>v3->v4:
>https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
>- Hyper-v `hvs_stream_has_data()` returns the readable bytes
>- Skip testing the null value for `actual` (int pointer)
>- Rename `ioctl_int()` to `vsock_ioctl_int()`
>- Fix a typo and a format issue in comments
>- Remove the `RECEIVED` barrier.
>- The return type of `vsock_ioctl_int()` has been changed to bool
>
>Xuewei Niu (3):
>  hv_sock: Return the readable bytes in hvs_stream_has_data()
>  test/vsock: Add retry mechanism to ioctl wrapper
>  test/vsock: Add ioctl SIOCINQ tests
>
> net/vmw_vsock/hyperv_transport.c | 16 +++++--
> tools/testing/vsock/util.c       | 32 +++++++++----
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> 4 files changed, 117 insertions(+), 12 deletions(-)
>
>-- 
>2.34.1
>

