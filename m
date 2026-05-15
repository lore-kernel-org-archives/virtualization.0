Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E233FF1A2
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860088; cv=none; b=UpTGr5d9VXnindQn5juMFda07GIIozf4XnEXEDuMmUzEe0lbMyIh4XcXVjPYyvgOe62uJfvig8W1TxhlB2QVHiFNKLmFJpXUOyfT33fCE1uyB0HzveG69WL3WYe/JiX6w6rheZL51DRfdnqUz8rYNCmKOGwqovKZqP+S8GiP5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860088; c=relaxed/simple;
	bh=WX8Na5O46N/1mGmAO8R44Mtob2oRjMv7bEtc29QSnOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZJjC4iGrxcd4bZ1+FyZo99hBvM7PzpL83flZvU4TS/2RmK3iLdcD55jkWGG6aLkqjap7llL+9dLaMNh/OOn2geWfAEyMmrB1gHRSuozcmdxLB3UEOhdMvEBNth1iQyznwUHnrSJSSgTjJg5NU02T3PIRaoL4L8C8ayvygxmHisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTzhe341; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTzhe341"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778860086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sx+eoO0CgxcgeUymE9wAWQQJ/R1ryTtZZ9xEd2rEqc=;
	b=dTzhe341sCGZR9Ts7Q7DYEJZ64AhM5slj0ca5DfXOr/Zylinn7ZIxGatk/iQq1cN984WFJ
	Ah+3P9t0kEBNnm0Jax7biZeKQqdmLcXUttYNFJRahLAsZH2+92UZKIQGpueDKbgc9qacC+
	5NY4EDjl7guaRAYk7Dv+Q7Hzu6KKpeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-thx8EhynOWKkRRa-UgFHiA-1; Fri, 15 May 2026 11:48:03 -0400
X-MC-Unique: thx8EhynOWKkRRa-UgFHiA-1
X-Mimecast-MFC-AGG-ID: thx8EhynOWKkRRa-UgFHiA_1778860082
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fdacff6d2so16141475e9.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860082; x=1779464882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Sx+eoO0CgxcgeUymE9wAWQQJ/R1ryTtZZ9xEd2rEqc=;
        b=SybDBtVPQ5sDOvLzl+1wX1Ty4PX6l6y4ONsUPvpokdT3JJ+TZVrqfHoLulgH0T36H6
         E57umQ/0VuEb4K9ccVJlSGmrBM5Uvx5PmQS1DUpVZcVe2KGQoTBVVn81rxp8LX0RoiWI
         P4IMT6Ec/lY+tjg/tC+KnN1mdspOScaEtrm2uCAsOSAj4jihHjeIfuetG12naZ54dewd
         n5DpouJEUV4kLWyqBZQCP0bEaWTN4EroU/xHZQroBPgH71z1/WQZXMx6L0rNqPk9dAu/
         aTdJNEqX9Inkbf9njV93d6ZtBo8XTFAfWbpURM1mZ9g6uU+C9wXhuC18VmzWsXRWXcz1
         FxsA==
X-Forwarded-Encrypted: i=1; AFNElJ+K7OSZ9QwoIM2NOhoA5tdPM+wlAnJKuy9dkGzwkjarmGuZ+mWCLmUjhq9s2YC7ZabXDUeQoZ/eCDvg75ILrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjC0SNJGnKUVuB2t8746DTdMfEwvlCvW6NcF/Dt6Z0bdRaiRy+
	TR2s4GG8xGYRd3KKLdv+cMTjWNd0zvap846VHGE5/e01UyjAriaFVxUj3PJtOhP6YKSwZ4AqA/0
	KxGt45AB8Ix1J/MUvGs6SY6Ah1DPrsdVT6zTUbSxxlpUhCLmziPa2gCZ3b2ZIGYPTDqIJ
X-Gm-Gg: Acq92OGwo+xHgEZfUpOk4YyMhGMBnaewq9kX2YnfYHe7z5kF25L3aVAK6pkD0ESwafm
	QDk3RtpKlvrivp/QodVbUTTaBMElmylPnDTOHVbWO0Yk+vkCASS0YhYeuSmz9eFq6ot/F9nOaDZ
	8D3m45iq5ar19nF6U3i/G2avhs/SF7PNiWgP3HMchmq2JVnstUt7zCWnEWTT+RDQdAa1fR71fPy
	L73ok4C9AcDraP1/Fua1KULfEXM9Us79++3y9Frtm92Tvh1Iz0MfEGAuy6UPBkCsqk0/e1fcIqg
	+0QAdv3U7RnZ6w/KvW4kzf7FIC1FTuc5PNFx0AynEu+prcWr2RyjUzefeMB+byyOM8icO1nm6Hz
	62KEDkAswrEMUVqMmosHxCFoJp0Q+dFZsn8AkPrlH
X-Received: by 2002:a05:600c:1389:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48fe60e5271mr62980195e9.7.1778860082223;
        Fri, 15 May 2026 08:48:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48fe60e5271mr62979655e9.7.1778860081693;
        Fri, 15 May 2026 08:48:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm21181015e9.9.2026.05.15.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:01 -0700 (PDT)
Date: Fri, 15 May 2026 11:47:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <20260515114521-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026051526-banish-strife-6dba@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6MlBXQInTWWgacWEaAZsc50sDYO6GRxIqHlSth9dAWI_1778860082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 05:41:48PM +0200, Greg KH wrote:
> On Fri, May 15, 2026 at 11:36:12AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 15, 2026 at 05:21:53PM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     vsock/virtio: fix potential unbounded skb queue
> > > 
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > 
> > Yea I have some doubts. It fixes the DoS at the cost of losing
> > messages. We are trying to fix that upstream now, maybe wait
> > for that?
> 
> being bug compatible is good!  :(

Well you are the maintainer. Up to you.

> What's the status of that fix?
> 
> thanks,
> 
> greg k-h


Stefano posted v3 and is working on v4.

>  Should it be reverted elsewhere?

Donnu. With the change we have no DoS but the socket gets silently
broken.  Eric felt given the brokenness is  upstream already it's better
to work on a fix on top, not revert.

-- 
MST

