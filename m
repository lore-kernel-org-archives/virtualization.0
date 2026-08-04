Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9DE3ED3B3
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814792; cv=none; b=sLuHhUoJMwMh5VT7VCT86xx9D5XsQTDS2wYrzZLtKKZSRCwPch5gaLzn7qjhXqqv6j1qQWo/CbKxqhDq796fI1OX/IZS8todGL3Vej8X03vC29TN6/9lgSh93iwDeH9nT8gWWRWKEvLJCgusktRr8XS9Y9NVpEQ5osFVX4zca6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814792; c=relaxed/simple;
	bh=vC4qQclBoV67ud2evHeSbDFkaZmPoEXMBUWK5AoYXEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V89OUAnzsQIX92vIsqOpRYPM4JU7aXEO5gkpYc3yl30NJrZd2sod7AnT/4z3s+lKFF7w0zPHxgwRmLh6J3oToiAAtW6NDg7j1o+g/oeByuOU828mghezG75ma64B0i629UhfHxG8yLpI713Egewojq8U6Ox2vtDIySgwPcVbITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRMdCBIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRMdCBIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785814790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
	b=SRMdCBIg/U+DAgnqQ+ve77ZLQjMQnZKq91lCZi+gY9MYrfDyta+jL56JkbOdaEioEzpZCO
	DsqVackRJ2vX/ViAANwjoKfIvlEYA0yutOYt7wnc2rMaU5ID1dmjwlyJUvMPstS5kaQk6c
	kzVqMGUgQ2G6khIL21Esrw2UjMiCKP4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-Soso8vZQO4OudFi6jtfvYA-1; Mon, 03 Aug 2026 23:39:46 -0400
X-MC-Unique: Soso8vZQO4OudFi6jtfvYA-1
X-Mimecast-MFC-AGG-ID: Soso8vZQO4OudFi6jtfvYA_1785814786
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15e82278cbso334494266b.2
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 20:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814786; x=1786419586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diYn9AH5DOp5LofRkeGafvYOwV70LwGGTt9FgR+upFQ=;
        b=YZqjH0/MGHz0Ks3f3Y9D4orFc8GPXlgRmez8qovYvWf4YH8OEQRFahxuUPAcReMMYm
         HrI47NTHGvpWZWTIGOUwgaZTyd6w2rRuDOSz9X50nj1AqIeglZ0WjBTxVACif5ndlJSJ
         4cjJUCsbUnfc1UwZpd01YybMLmCsW46XwSMLjHlTkviBH+Ifq32KdycawrlINfhbUlJW
         pNNRYFaNSZzD/LetW8H6l5zVpuI/bgjyQG4LzIiRCINk3rMpbdaY+2ZJFpSyCSG6+/0y
         CRTsIcD8kdrVmNr5xZYGcMmqNPYOv8qbfzVbJ6kpGhRoOP7zwzBiUxjvfKznv2lc1lfg
         RJGw==
X-Forwarded-Encrypted: i=1; AHgh+RpkVj8laepg8RsxLiNJrgbVmE1VFCYTGBglUiPmtBE7CDRYvECUePvm9nHu8CaHVwI9dkHKvJ11Q6m7BrlY2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyur+8YSZ5s1sg2/05M6RjX/NxPkdNyUPq6VJD2BbPp27jzNhZU
	dwqvlJm2kpZNarygOwIoZtXkIWOfgX/tlX4XnjrcdryeBgsPXCdECwQsxS5p+HLdlqlQvc56D4Q
	5vL2aqddg8l7sRFyh9f730L3GP5L/NfRP8A1FLnEcryuNptQNajZ1CE8gLzAu5DApv9SrSRXsG+
	d1mTU=
X-Gm-Gg: AR+sD10FeC5EK3Jxeg1Ex1eAxH1CO9KbCem0jdLmOfc/SiFpgKvcKgpMZsgRn8ZQcHg
	nFR64q9Ih2fFwX0zG6JYSAhp1pkAmUuyDPoy88wsLaccy+JKT4QlSaHOWa+jkhk9G+kdbzRQ7eE
	lbOybGHxJiaEkjbAXQTjY6R9510q9cYCQgnOzIBcpCGXuY38o9pKSvpAQDiYtobidMsIDIUkFHy
	PgfqsEYu4/aciteLEdlvsyqiE4BJTvctDtvbCVqKqmX6iEfSWvBaDxL0pAVGjT3qaoxG3EqUEPd
	554c0zl+euZIUBaE+/MH+DS9bkn0eCQATwA8OXaST33+QyEfCn4eAgkopHQFsKKKiyc9
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148196266b.2.1785814785638;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
X-Received: by 2002:a17:907:1c22:b0:c15:d4f8:dade with SMTP id a640c23a62f3a-c1fe7eebb0amr1148193466b.2.1785814785204;
        Mon, 03 Aug 2026 20:39:45 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c93a87sm631061866b.18.2026.08.03.20.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:39:43 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:39:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jia Jia <physicalmtea@gmail.com>, jasowangio@gmail.com,
	pbonzoni@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Message-ID: <20260803233841-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
 <20260723105451.1563439-1-physicalmtea@gmail.com>
 <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <45a33302-0b28-4d00-8724-c3af6e1783f6@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lES8oJKJff_2hPl5k-t3YGj3pHLMaE1gaZqLPTPTL5w_1785814786
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 07:02:43PM -0500, Mike Christie wrote:
> On 7/23/26 5:54 AM, Jia Jia wrote:
> > The owner must keep the old mappings valid until the ioctl returns.
> > Remapping or dropping them from another userspace thread before then is
> > outside the lifetime assumption of this transition barrier.
> 
> Ok I get it now. For some reason I thought that was valid.
> 
> For the patch we don't want to flush if vhost_dev_ioctl fails
> and there's no reason to flush for operations like
> VHOST_GET_FORK_FROM_OWNER or VHOST_SET_OWNER.
> 
> Could vhost_dev_ioctl return when a flush is needed?

I agree but also this is consistent with all other vhost
devices.

So I'm taking v2 of this, and we can iterate to optimize
all devices with patches on top.

-- 
MST

