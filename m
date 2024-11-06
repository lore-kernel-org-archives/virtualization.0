Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742922076DB
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916894; cv=none; b=uXTe0fIvpNN91sdW4vTxCLJ6Oj0IFXbbeitZ1OpBjZFc7+rl+M8DIQR1uOS+StuJeRKUjfdQ+QwsG/EH2d4ktbFGACtB5waPqzhYw2MtQ6LHlQvkcXSyaTyumysPcBp3wvsxFzniCfBYavSrdZXP3IWvCUQnEbT6wiCc0ZMpl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916894; c=relaxed/simple;
	bh=4J3FXXfZ6nQRphlmnavG6lROM8RB4aH97LZS7b1szkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tAJDGc67JlYm9JdCUTTse7CZcQcIb+YVrDq3tlyp55H9Fhsv2UUJbc/qG3SLIps5W5xjNH0Bzk2ycd7omDAbGIolqeQG0Q08xMW095FtlrzLd9yBt1vcriLi28QsN7CICM/Q0ma3arN8G50hI6GAx3EIpQhoG7Wc5Nr9wbuiM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6U/b4NR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6U/b4NR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730916891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pozyU9gF5mzD8wf/N0qDNO8ekR6qCHOutnWukzEkFk=;
	b=i6U/b4NRPH5woAFggAFsJ3EaNgIbIkirf9mNKolwe5otFXVwptS/bS8ynllj6zONoNeZqU
	jSuwKn55bCb8IMUe1aQ//Ghb7Y+5xGvCXwo0Y47dRTlXA2812tqCVjB77t86IU4Z27mCES
	1Tj1YhejGUtavZqD1YkfJqpQK1HDXhU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ysQGzTmbM4Gc1bc3DOe2Ng-1; Wed, 06 Nov 2024 13:14:49 -0500
X-MC-Unique: ysQGzTmbM4Gc1bc3DOe2Ng-1
X-Mimecast-MFC-AGG-ID: ysQGzTmbM4Gc1bc3DOe2Ng
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d56061a4cso12393f8f.2
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 10:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916888; x=1731521688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pozyU9gF5mzD8wf/N0qDNO8ekR6qCHOutnWukzEkFk=;
        b=foNeQdlgKQ5O372P/OhgmERRlVA3BXhUOMOqziwOzpe8b1W1jlF0ZVCp//7ziaLmxu
         pRAadpVcLaO917XZABkNQvVmM1g4P3L/4v89p0p4qDTJNEkU7saUZVLQuKqIqoiYBgSk
         J969klrrYNiJ2HDIRBHSmvAWgWfhOH53r6e95W9LEWW23obDaD+bmriEbDAukq/5mN+5
         Ls68RUHPSN9XKK5/qv1IO23Y8SaKYd+KNcERj+IGmV/cIoR4y90a8kDYFyTlU954lfZ2
         D6BPKbR7C9lvrhhXjgPh4r7HhNQ9f4JJCPVLyYVYEI960dBMaQeFYycuoDj/t09tmpsY
         q9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7qn/VOIMW3XgmS4fRZhjXDV7q7XWxL0U25FhkoOqt0TRs0kEi8INlHIH1AHoDoH/XC9m0hfK5arqZVZ+6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqKbxLPQ103ygtjWLM265WbJ5WmTBzaeUBTdhbM+8ac80t4hoe
	3iGvR5+xkYehrBo75B8k5sRymUhZJu5W4bAg2bSdSxZMQ4E3AngPPHc2zS9aiM1thJCbctGeGEU
	keS10JBImamy6Z1+oJua//MAcAv/TRsnrTE7xGb2bNIov+eZZ5z8JiCNqnwQH54Az
X-Received: by 2002:a05:6000:d0f:b0:378:e8a9:98c5 with SMTP id ffacd0b85a97d-381b708b566mr19045068f8f.34.1730916888027;
        Wed, 06 Nov 2024 10:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ+fzLkoD9tpZWIBitUfh2EDEyD/DqLzoVcDBBUPvDl4NX6tSaiyBPx7Xn713AJSHDZNXOUg==
X-Received: by 2002:a05:6000:d0f:b0:378:e8a9:98c5 with SMTP id ffacd0b85a97d-381b708b566mr19045048f8f.34.1730916887666;
        Wed, 06 Nov 2024 10:14:47 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm20135841f8f.88.2024.11.06.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:14:46 -0800 (PST)
Date: Wed, 6 Nov 2024 13:14:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Srujana Challa <schalla@marvell.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for
 NO-IOMMU mode
Message-ID: <20241106131351-mutt-send-email-mst@kernel.org>
References: <20240920140530.775307-1-schalla@marvell.com>
 <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org>
 <20241016134127-mutt-send-email-mst@kernel.org>
 <ZxCrqPPbidzZb6w1@infradead.org>
 <20241019201059-mutt-send-email-mst@kernel.org>
 <ZxieizC7zeS7zyrd@infradead.org>
 <20241023041739-mutt-send-email-mst@kernel.org>
 <ZxoN57kleWecXejY@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZxoN57kleWecXejY@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EeR_fCO9ZOJOAV3KfdVbkX1VIMxNQEbDIGrAq61EZjw_1730916888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2024 at 02:05:43AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 04:19:02AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 22, 2024 at 11:58:19PM -0700, Christoph Hellwig wrote:
> > > On Sat, Oct 19, 2024 at 08:16:44PM -0400, Michael S. Tsirkin wrote:
> > > > Because people want to move from some vendor specific solution with vfio
> > > > to a standard vdpa compatible one with vdpa.
> > > 
> > > So now you have a want for new use cases and you turn that into a must
> > > for supporting completely insecure and dangerous crap.
> > 
> > Nope.
> > 
> > kernel is tainted -> unsupported
> > 
> > whoever supports tainted kernels is already in dangerous waters.
> 
> That's not a carte blanche for doing whatever crazy stuff you
> want.
> 
> And if you don't trust me I'll add Greg who has a very clear opinion
> on IOMMU-bypassing user I/O hooks in the style of the uio driver as
> well I think :)

As a supporter of one of uio drivers, I agree with him.

-- 
MST

