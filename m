Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3049312836
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211961; cv=none; b=XUpbhi09M+wiMW634PIhIM0C02p3CSopxdZwTWMb9WU1suMcPEuFEhi4PemAYG93b7hgIJhpKkjE6bwuFkxWbnvGRaRekwjwcI9LBuWb32VPjYpcUIoqe0R7oBlcUET6JYz/mps3csJ2hqQsFSTegLUdexJr2NdrCKZDGtJv2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211961; c=relaxed/simple;
	bh=3ChuK9dLT+j/JKhhXXw790DwdOdULGToKTA4biGxyaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gTdDzyPVRjjpUz93TMNPdokibY1ztc83JmEV57CeUPZ/VxTy3JTpM4ABLHFCrZpioZmQw7F1Gt7xeV9jtx4Vg4VaOobAJdeVIQiUQmVdj9eyvz3R2NTO3QT0W63PhZg8FQfGD2ebMs2PuQcd5UFq0/LP6aVepus3vvN7DqQc74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgXD12Dp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgXD12Dp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55E706064C
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ep6zO2dVYIb for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 16:12:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 55B2860643
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55B2860643
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VgXD12Dp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55B2860643
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
	b=VgXD12DpGN+1XVTwwomy+lWTBgTg+uKNUOU0IptEAtjPoLX5f0Hct7d9Q3Ol2MZy4m3VzE
	jb6zGvd3KVZ3Nw/ea+Hxr4BEwBuUC8UuQKE+AUGTRuPC+c1Wah3eDMlZXDYgCShVk7TnwP
	dPrbEsftsVZMGm7YtGPlz/cRzMhc1qA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-mdUaFNyIMqOjZPSuLkrYKQ-1; Thu, 18 Sep 2025 12:12:34 -0400
X-MC-Unique: mdUaFNyIMqOjZPSuLkrYKQ-1
X-Mimecast-MFC-AGG-ID: mdUaFNyIMqOjZPSuLkrYKQ_1758211953
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso868378f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 09:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211953; x=1758816753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWkKglNyHyj28Yf+KWWRVKsP6YQNNJY7QhKMXW45eIw=;
        b=jGHvrLQsuqpqDeqiDrD5I8/nyKDNoL5OLvA+7jVQPTFVUs3yCncQeNkSKlw6Z9YFgg
         qkdbtqDtNf4gbtwgTzFpXVSRhRJ2bjtqUQ32UIUfxV9/oanRnYwtkGA0Kn0vjpJu1IQ5
         Nt6Odqc25Ur+NaGpqMd7YkVWJs2mqw2v6pS9Me3S/+0+fe03Alb8Cnswnk12ka/VJmYS
         uw6SFNbk9SdH/m7p2RMbV5HzGaEWlJPrAAGupSOB4nUNSmh2oeoufb4ZdlJfidvqeF5T
         5gaDrQ8aXyLNscvfCku43hUGLMkm63jbrNO8Wno9HhhXK+Dx1HqKnJ10sBEI7hHXhITB
         XM6w==
X-Forwarded-Encrypted: i=1; AJvYcCUY85zk3EPaTpbwDrjv0bqnyV1R1dJdyf18j+76QmV6qKPZLJ3lAD4mWo7WmgLarAkVHzez3+MIms5UbJ3FHw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxO9LGpD8tbidpsix8K2xfc8DzWfns7JCJk1O9Ga+ZSnJxCmkNK
	j4GwWmHCDpHypaPU48VXoV4bSlP9aONcW0t95Eo4MBgXNbXqR4r0xYJeMbKrtqlUsLyHWW3tLnJ
	T4gLhGyNynR8BOLOmTcwDzao/eltAFN4oGXCagVM2Rsne8aH+SxUmsAIhzsFpVEDMciU21Tov21
	Dq3AsQGW8=
X-Gm-Gg: ASbGnctLf5/+Nsj5oQ+Axso//Bs2I10oFMnImpEUFdiSVSDWkousjW02oX+es4MajzN
	4vWrBk9CGTKu1A7K4HhssHfQmgOayE47lD3BUuWKNQkh82MGhTRQL2VplLVuMSFVsoa25dPAZmt
	2SKSnpf36HMntA3qJ8SsuARRLTvdIrA6YdhLLhNzzIFyB7bcofIF9gQ2j9vDTjwKUU8bXxgBTRz
	AkbwviJSDUu+2cF7DvkHhRhHoYPElSCX78986P6xwZJfAFx0fe8v42UGjHCd5yie7MWBMJ8794i
	LcJE/5BsTjyZ9RVRtO2cKnyZIW1nNQ7p610=
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499607f8f.55.1758211953351;
        Thu, 18 Sep 2025 09:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQNjD7OmqbUX0lKdSCUxk8S1FFLIR2TIUSd05xm5nCE+NLCdpN93A3STkA7r0Jij+RWM8oVA==
X-Received: by 2002:a05:6000:2411:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-3ecdfa59c2cmr6499570f8f.55.1758211952931;
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm4389523f8f.18.2025.09.18.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:12:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:12:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com,
	ashwini@wisig.com, hi@alyssa.is, maxbr@linux.ibm.com,
	zhangjiao2@cmss.chinamobile.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121009-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
 <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <869d0cd1576c2ea95a87d40e6ce49b97d62237c9.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9B94xpR6giQgx4-Rs0j8UWnlf1_dR1ZLW-ATDtiZ3Dw_1758211953
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 05:45:05PM +0200, Filip Hejsek wrote:
> On Thu, 2025-09-18 at 11:09 -0400, Michael S. Tsirkin wrote:
> > Most notably this reverts a virtio console
> > change since we made it without considering compatibility
> > sufficiently.
> 
> It seems that we are not in agreement about whether it should be
> reverted or not. I think it should depend on whether the virtio spec
> maintainers are willing to change it to agree with the Linux
> implementation. I was under the impression that they aren't.

Ugh. OK I guess I'll drop this one too then.
That leaves nothing relevant for this pull request.


> I will quote some conversation from the patch thread.
> 
> Maximilian Immanuel Brandtner wrote:
> > On a related note, during the initial discussion of this changing the
> > virtio spec was proposed as well (as can be read from the commit mgs),
> > however at the time on the viritio mailing list people were resistent
> > to the idea of changing the virtio spec to conform to the kernel
> > implementation.
> > I don't really care if this discrepancy is fixed one way or the other,
> > but it should most definitely be fixed.
> 
> I wrote:
> > I'm of the same opinion, but if it is fixed on the kernel side, then
> > (assuming no device implementation with the wrong order exists) I think
> > maybe the fix should be backported to all widely used kernels. It seems
> > that the patch hasn't been backported to the longterm kernels [1],
> > which I think Debian kernels are based on.
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/char/virtio_console.c?h=v6.12.47
> 
> Maximilian Immanuel Brandtner wrote:
> > Then I guess the patch-set should be backported
> 
> After that, I sent a backport request to stable@. Maybe I should have
> waited some more time before doing that.
> 
> Anyway, I don't care which way this dilemma will be resolved, but the
> discussion is currently scattered among too many places and it's hard
> to determine what the consensus is.
> 
> Best regards,
> Filip Hejsek

