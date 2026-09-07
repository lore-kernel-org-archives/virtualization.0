Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC641375F82
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817288; cv=none; b=XccvGr03KLTTy682iLa0wd1s2sfTykRJv13+9JDb2GwrO2Uf2wqX+h4FEWu3NjKZ4I9KtrzAXgBt5G2MZPQc272+i8CiIQSd9p4+vl6G3Ck7Xk7KKhn2ncCnbXfAFInMdWuNiLWDVXZub+XSi963V+vgD0aRgGP5TGiZfA1ZroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817288; c=relaxed/simple;
	bh=1i31BeRMFT9Vp3AcAN/RmvKH0I2VjZNU1gijNLV1tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MTT6EsvrqHMiPJLDuSYgGNskuxMopwzlcEyHktJ/DB64B1QViHo/W3DIeid18tS8ypJUHA5QWLKgoidmpRF9K/8NKxW+RfPUmXEOyF7YZFqYHujD1nrCyQbaYqQ3XLpNqa5bdIuQs8YULMNksdM62ufglWS04MgGPiG2HCBu9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S87jxa6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S87jxa6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
	b=S87jxa6g3lJLjBi4dFjQtC4NqNtoLEpmw1amWj+Tl+XvD30AFI7G/mrJ+hjw723dTw4tNe
	Syb9+kmTy5dhOguDW2dh6eTHqTMPxh4+vdCqgtGJ+bworbn2RPLeepMmVZKfaUDQZvBwjE
	1hpK8FjBpjm7fDFZVBQ0uaFA3hA0FQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-j03fQ00sMX6fOgD6DssEfA-1; Mon, 07 Sep 2026 17:41:22 -0400
X-MC-Unique: j03fQ00sMX6fOgD6DssEfA-1
X-Mimecast-MFC-AGG-ID: j03fQ00sMX6fOgD6DssEfA_1788817281
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so27672515e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 14:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817281; x=1789422081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=Xeq9vH27CyRn8ui+vWf9eSIrc9ufV5r0MjZpZkvp3JXc9YE/nT1gpeRosqFBCct29q
         2PINKlbBbMKdV2voZyhTbrJ7VBILRmrX5y2AbFCLKmT1ijoMT75fioS3sVvcqDA+oNaq
         rXLKjsQXjOiDKL7/N4Wx8C1bgLZhgju4vfjB2/ldR/ui7sROmhUQKmhudX/Ovh6JBgtY
         3QYk6eSLNZqphHYqt9ysoLsHpyaV9fI3tsU7ucPzfgevSk6lsOA1S0HKGiTkqKOLnK7H
         cUjszQpVuPXWYGbcWc/gQEJc/svIkMxqvc0ebIMjVrPUBVN2xOu1C878ly3ydK1VfgIq
         /unA==
X-Forwarded-Encrypted: i=1; AKwUvByOsCUiRSo9kU81MpRDGVjpe/SzfdBC9RTb+sd3tiFm09BPpsJ3i6/wldm1+UNL2WN95kANfXgiDqJt2VPNEA==@lists.linux.dev
X-Gm-Message-State: AFuF++kN7xgn8D6Eum1Lw0Te8g2Sg/2rQgOFIQSZr3El++Q5HcSO+X4T
	YJHWep0mgXAHEXtcfUa/0iM4IQ/XVOW9FyvzDMKLV+P8wZCmmAk4kvcPyglABECpUpXX7p/mVuS
	AZxjx9pEJxy8+pPSQp0GIrmgvto83eSuOk8vZ3M0le+aTWgcona8BTBe13rfWrOKPToPvFW1FYs
	Tw
X-Gm-Gg: AYBFou1TDvrHh5ToyFSkbwodikHqTT29Q+oY5UpDH/PL7SX+l/8+WmIFqsmB73E4xWC
	C/Kkv/CHc1okxhNxCr0ezgpe9BqPHrza45I2MOa71sKydn6rLa1zRH2TxWkOMpWl769iqpd4Yue
	NQrrwthMqaCXTff9ou4I3P4NVc5Z1lYNslXRBxbwmUt0u+Uu50RrA5z1cR4cBUWHSY6j283S52d
	yqnDROHRx1Pm0cMdJoKpqG1V/aN96vzQpSCBOaaagBnez1NyUOB7utjDYUJzSRsX5newWaRK2Pn
	nCLgVvslZXK7v/ucejhVN08+anguWsKEopI9kOtmqVfFrMD9KWUVlttfV3beuX0nwCFexkIyPru
	VpHsFb2yavZc1ninKwKw9EL4=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765695e9.5.1788817280970;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765175e9.5.1788817280462;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm892607965e9.0.2026.09.07.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:41:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:41:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907174032-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
 <ap8rCQII9fASEosZ@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ap8rCQII9fASEosZ@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zvpIFYqtHAT8KQe39UzQNK10xYXLa6ayFK1O4V8Iamc_1788817281
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2026 at 11:23:19PM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> > got all 3 patches now. it's a good start, thanks, but they need
> > a bit more work, in particular addressing sashiko comments.
> > I'd also prefer patch 1 to be split: moving code from pci to core
> > is separate from ccw fixes.
> > 
> > Pls write or at least edit commit log messages yourself,
> > after reviewing Documentation/process/coding-assistants.rst
> > 
> 
> Thank you for the review and feedback. I'll work on a v2 now.
> 
> Karl

FYI I picked the virtio input patch, no need to repost that.
If you want to fix the evt leak, it can be a separate patch.

-- 
MST

