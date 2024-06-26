Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06B15D5CF
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388388; cv=none; b=RMBtRASrc44JbR6MXcDhiwlpvZI+r38dRU24SHtUYmKirIeRJXIpcUBNm4MgzFM+RaAw5GsRsAzchCJ2Nw47VXxxxb8Y/+ITqpPjXkKKkSsR52F8uSdWzJppv0fRsh+9aWUjuDsbiyJQ2gjo4L2k17nQo0kHXIu/qplL/21jNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388388; c=relaxed/simple;
	bh=U4wu/v4LXIMjJbnXQEUS5N/tOZwUCIwjd6RBuDr2u2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ayp9WSa9FtMD4SNV69k7ywbNMuBWsfnlQpcFzqSG9VQS/0J0vUZ42PONCVVIsdGdpHLJj8KFpGIbRwH7mbHwVh9m3Irx7HFFckNkbxDa81Dll7/5iwJIQZqFGfeieuuijIFOTF7nA1sSUEYSRiz8A82wbFARrb7X47oTqhNNEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdyCskRu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdyCskRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719388385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbhQ5Bt84GkBvdJqLycJ8eMJD8s7TH9FNQOxnZ/P/54=;
	b=YdyCskRuwBKhDeQ+2L0bQf3WNtVO5tJDeJ7oWg9fQ21ehqO53bpzX3WwBnuA+OIX019f0H
	loe81sDPKTontkoh751hGtnEWwvm4+fJ5sWXcRAWCQueHTnxyiGV0NQcdaFl5gJUjx8r/C
	pIRzRsy0oVGiK6xtoEcYb3Z+tLsoA3w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-3GdcZV_AOfaBgxAHjZWDpw-1; Wed, 26 Jun 2024 03:52:54 -0400
X-MC-Unique: 3GdcZV_AOfaBgxAHjZWDpw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cd8c15ce5so3690316e87.1
        for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 00:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388373; x=1719993173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbhQ5Bt84GkBvdJqLycJ8eMJD8s7TH9FNQOxnZ/P/54=;
        b=tYu6X948Tt0FCQqJtN8PeqpAkCXMKU+fsysG957fR1s66pIG6eXBrnfYBroDZqIABx
         1RnXDpKdRoSxp14jFTrVDWlKeZR9bH/vOEfizK+F4nX3tfAgXJfCCxQrr3oT89f9lepM
         kykSJdbuBfjGATfodm+Jlwgtra8PUoRCu7KPv6V372xu3i77LDpzMu+8EnbjkPFjUiLl
         rDc/7TpFAYj0Co0AQi9lsUxtCTO0BhQtEKEel+9lEY42HCM8E02VgqYwcJl/r6LpoBsn
         c7uZAqSM4pM1WY1IOEkJQiRI2s2oEDjXf0me8lGXuZvoP6VOcc6RZXJHSiHThZKB54pk
         0iBA==
X-Forwarded-Encrypted: i=1; AJvYcCV80MzGIFkRvXjr9azOhMvqGCI8lCRCDnVJAR4Tl12gH2XTj1Do7K/d76rqRCI6lpOXZJHk6J0TFg6Xg1cfSsiz52yFjALONJt2c5wThrE=
X-Gm-Message-State: AOJu0Yz4DaCZa5p6ctqjp0fmvniveNrSYQQGRveyb6Xs/M8Rw/8QnCN1
	NuScP5eIw4Yyhc2LN8SNOO1rb3G+D+KG97Yj53WYVCIidTO+9q9oKPYQp6GdCGAv75MjCsSBCFU
	tHqGyrOtj6UVhg4PeEZefrfU1u8ubIUsBcu/bvGciif5utmR/5Hq4leHqPdeclwl7
X-Received: by 2002:a05:6512:1154:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52ce18325femr8818744e87.2.1719388372850;
        Wed, 26 Jun 2024 00:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBePmSX2xltrQ1Gn2n2dv1Ce9/shcHte7tpXYQEQJvsTYn/f4RpL4bX2GtXjheFQQMtpVfVw==
X-Received: by 2002:a05:6512:1154:b0:52c:9942:b008 with SMTP id 2adb3069b0e04-52ce18325femr8818718e87.2.1719388372008;
        Wed, 26 Jun 2024 00:52:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c838099esm15062065e9.40.2024.06.26.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:52:51 -0700 (PDT)
Date: Wed, 26 Jun 2024 03:52:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240626035132-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org>
 <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
 <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
 <20240625043206-mutt-send-email-mst@kernel.org>
 <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 26, 2024 at 09:58:32AM +0800, Jason Wang wrote:
> On Tue, Jun 25, 2024 at 4:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> > > On Tue, Jun 25, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > > > Workqueue is used to serialize those so we won't lose any change.
> > > >
> > > > So we don't need to re-read then?
> > > >
> > >
> > > We might have to re-read but I don't get why it is a problem for us.
> > >
> > > Thanks
> >
> > I don't think each ethtool command should force a full config read,
> > is what I mean. Only do it if really needed.
> 
> We don't, as we will check config_pending there.
> 
> Thanks

And config_pending set from an interrupt? That's fine.
But it's not what this patch does, right?

> >
> > --
> > MST
> >

