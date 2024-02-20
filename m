Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737A7602B
	for <virtualization@lists.linux.dev>; Tue, 20 Feb 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452357; cv=none; b=rxcj4MNKYzW1ALcCQS0fxTelvD2wla3Sw4wISudelzhZvWzmVsUhyk/1TQV+yEbRXAhkABz8fwSnAMYSvlDZnDlE6TjbEZcAHj+Mt1BNU0q8z+djk3Nj346bV4ez9Igx3SdonuJdJ5OD55IfWYj5pfxNrxmFTJE945I9KIjEl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452357; c=relaxed/simple;
	bh=7WDWZ3xVOCtPvxw5YvZObLikDkLEhC5zrw4/cCPbSac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PzGgU9hhpI/PVlYNkOMXwliplfp1nZNujbyjDIpukhZrt6KoIvwMzez1aT/wX+LJfDe8zoeLORBsrPyrPGhp+vHiXP5bRxMD0AvKUffQV5jlL9xDR0jti1VLJZYt4S7uM7yF3tI+rGO/hxHFYgZ9W7gu971nQS1b4ARpxLHYwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8csPElg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8csPElg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708452354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoQ7ZD634mLeO2a5g5a9LcBPxa8AGvETdNLdFSlbHHU=;
	b=d8csPElg3TgzqS2qNe6+iSSQ1dy6pvCAcDS9/uCsvom6J+gnyGtNKoXLNCrSKqD2sTok6F
	NUkChDg7Q1NFAND4++gVPnfGbjMAJBDZIChN0b3A5ZEGyv01tKMjgSBpyxu7yVN0VmH+zO
	41FUZElWhDR5z+3gD1QTHumb5UHf4C4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-BQsnWRJcOz6J8PVCI3f94g-1; Tue, 20 Feb 2024 13:05:52 -0500
X-MC-Unique: BQsnWRJcOz6J8PVCI3f94g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d6fe52221so303422f8f.0
        for <virtualization@lists.linux.dev>; Tue, 20 Feb 2024 10:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452351; x=1709057151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoQ7ZD634mLeO2a5g5a9LcBPxa8AGvETdNLdFSlbHHU=;
        b=c02fRXRQoZSnDdWSDbS3+lFFACYBSsS9IG3kxNNF61wtuGCCSYdzaefUaBM5wwtSLW
         IRwfyM+S3tjAD0HxzP9z7voL/+P+y1ztZNLiyoIO+XeievV7SzB9WRmaGpgqHAGWTgZn
         PsWd2rHoq2vG6+7ropwigFaLFV7wRCLtPNFgNRF2bPyyMghYxa/c6OQunkC3RDSTOqlQ
         YOrgpfAiNGWttuCdIKawdn/tYVoQvG/yx1gDD4wJlhQ1rrLEIvEoF2KteaiyEIBKpCV2
         37v6JwRP7p9XTPADX4683fOLuXnkUJZpT6Ti0ux7/Irxp+UcY4nOxjBFYv3zIpE414U1
         xVUw==
X-Forwarded-Encrypted: i=1; AJvYcCVkR0jzLsU6uOB+VKFig2zfWije4h6i3Zpf3kyJ/4OGHh0s+f/N0yipRFXmQIEjTShY7cSuW/6tkLLCNfzyUpXsPgY3z/5682qUeQg3J9s=
X-Gm-Message-State: AOJu0YxJKjklHD/1LXcqfrxMpvuTSUuh0zQ+LqCI0Nb28gQ52KOXhQ2P
	3uRDS1NTYEZb7agSnAXyaMV86UC04aPUkv7wZrloyHuMAxYwiKZLJTtTDeMV3xjR6okDoOksWxd
	ui+zOngBvyzpeyqpmhvp6bib567GJoLWl9dLfGmLIJLXGArcHpUviEH626si3t+Nd
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id j5-20020a5d5645000000b0033d3b82ab2amr5763425wrw.19.1708452351356;
        Tue, 20 Feb 2024 10:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT8HPGXtmeAx5ZvlUTUILh5dkmcmg9dNbay1klbPUGWBUdh8jxIshmoH9DaAjlfADf1MgEpA==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id j5-20020a5d5645000000b0033d3b82ab2amr5763406wrw.19.1708452350956;
        Tue, 20 Feb 2024 10:05:50 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b0033cf637eea2sm14341300wrc.29.2024.02.20.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:05:50 -0800 (PST)
Date: Tue, 20 Feb 2024 13:05:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240220130528-mutt-send-email-mst@kernel.org>
References: <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240207151748-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 20, 2024 at 06:02:46PM +0000, Dan Jurgens wrote:
> > From: Daniel Jurgens <danielj@nvidia.com>
> > Sent: Wednesday, February 7, 2024 2:59 PM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>; Jakub Kicinski
> > <kuba@kernel.org>; Jason Xing <kerneljasonxing@gmail.com>;
> > netdev@vger.kernel.org; xuanzhuo@linux.alibaba.com;
> > virtualization@lists.linux.dev; davem@davemloft.net;
> > edumazet@google.com; abeni@redhat.com; Parav Pandit
> > <parav@nvidia.com>
> > Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
> > 
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, February 7, 2024 2:19 PM
> > > To: Daniel Jurgens <danielj@nvidia.com>
> > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > counters
> > >
> > > On Wed, Feb 07, 2024 at 07:38:16PM +0000, Daniel Jurgens wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Sunday, February 4, 2024 6:40 AM
> > > > > To: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Jakub Kicinski <kuba@kernel.org>; Jason Xing
> > > > > <kerneljasonxing@gmail.com>; Daniel Jurgens <danielj@nvidia.com>;
> > > > > netdev@vger.kernel.org; xuanzhuo@linux.alibaba.com;
> > > > > virtualization@lists.linux.dev; davem@davemloft.net;
> > > > > edumazet@google.com; abeni@redhat.com; Parav Pandit
> > > > > <parav@nvidia.com>
> > > > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > > > counters
> > > > >
> > > > > On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> > > > > > On Sat, Feb 3, 2024 at 12:01 AM Jakub Kicinski <kuba@kernel.org>
> > > wrote:
> > > > > > >
> > > > > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > > > > Can you say more? I'm curious what's your use case.
> > > > > > > >
> > > > > > > > I'm not working at Nvidia, so my point of view may differ
> > > > > > > > from
> > > theirs.
> > > > > > > > From what I can tell is that those two counters help me
> > > > > > > > narrow down the range if I have to diagnose/debug some issues.
> > > > > > >
> > > > > > > right, i'm asking to collect useful debugging tricks, nothing
> > > > > > > against the patch itself :)
> > > > > > >
> > > > > > > > 1) I sometimes notice that if some irq is held too long
> > > > > > > > (say, one simple case: output of printk printed to the
> > > > > > > > console), those two counters can reflect the issue.
> > > > > > > > 2) Similarly in virtio net, recently I traced such counters
> > > > > > > > the current kernel does not have and it turned out that one
> > > > > > > > of the output queues in the backend behaves badly.
> > > > > > > > ...
> > > > > > > >
> > > > > > > > Stop/wake queue counters may not show directly the root
> > > > > > > > cause of the issue, but help us 'guess' to some extent.
> > > > > > >
> > > > > > > I'm surprised you say you can detect stall-related issues with this.
> > > > > > > I guess virtio doesn't have BQL support, which makes it special.
> > > > > >
> > > > > > Yes, virtio-net has a legacy orphan mode, this is something that
> > > > > > needs to be dropped in the future. This would make BQL much more
> > > > > > easier to be implemented.
> > > > >
> > > > >
> > > > > It's not that we can't implement BQL, it's that it does not seem
> > > > > to be benefitial - has been discussed many times.
> > > > >
> > > > > > > Normal HW drivers with BQL almost never stop the queue by
> > > themselves.
> > > > > > > I mean - if they do, and BQL is active, then the system is
> > > > > > > probably misconfigured (queue is too short). This is what we
> > > > > > > use at Meta to detect stalls in drivers with BQL:
> > > > > > >
> > > > > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@deb
> > > > > > > ia
> > > > > > > n.or
> > > > > > > g/
> > > > > > >
> > > > > > > Daniel, I think this may be a good enough excuse to add
> > > > > > > per-queue stats to the netdev genl family, if you're up for
> > > > > > > that. LMK if you want more info, otherwise I guess ethtool -S
> > > > > > > is fine
> > > for now.
> > > > > > >
> > > > > >
> > > > > > Thanks
> > > >
> > > > Michael,
> > > > 	Are you OK with this patch? Unless I missed it I didn't see a
> > > > response
> > > from you in our conversation the day I sent it.
> > > >
> > >
> > > I thought what is proposed is adding some support for these stats to core?
> > > Did I misunderstood?
> > >
> > 
> > That's a much bigger change and going that route I think still need to count
> > them at the driver level. I said I could potentially take that on as a background
> > project. But would prefer to go with ethtool -S for now.
> 
> Michael, are you a NACK on this? Jakub seemed OK with it, Jason also thinks it's useful, and it's low risk. 


Not too bad ... Jakub can you confirm though?

> > 
> > > --
> > > MST
> 

