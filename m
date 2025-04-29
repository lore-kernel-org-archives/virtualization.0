Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723722BEC5F
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924163; cv=none; b=B9n/nj79gugf2E4n48ai4Ddx505Th2tdyRCQedf1mRPw18emm3MEDsVb7AmYgVaERgjHmWiI0wCj4mYoSbz96ET35Y9KMbEDq2lgBWI9AmUmJXqwPuwSzC5BdHyz+qjXxWNA9Y5nHbBg6vMaygbVIT6NUamFpFHPOYTf/0udAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924163; c=relaxed/simple;
	bh=2XOsrJ9QxJ2xmMD7aI3JwMzLwhIcEOOkFjqywzEOBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GcindG4OyQrzgZggJN3oEhTyjOiK51LaQZszzrAldP0Oax8757Axqlyyp+Ev+luQl7sg/7ZS3YwKHCKCN4wGsZwwqW0qY9bGLb6asGzdLP+Fcc9uSAu0ozoQXKuRUTAXSHolSWYOrzwMQerupi0mNO1/y4gNWU1uSjbPCygsUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFmEnN0t; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFmEnN0t"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 075E4606D7
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 10:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yVzbZ7c_CcO for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Apr 2025 10:56:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5491260693
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5491260693
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFmEnN0t
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5491260693
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745924159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19RTGAYgSCXwR1/QnePt6pjSqRpqNVt5Z/wpug3TfME=;
	b=CFmEnN0tx48xOF29CTLyNjnpLmCOW+ztzbOGM5ICNbzkTVok9q1VCtBIKox4lK+BmzgPUb
	BvxTI73tRli4dnnAqTnbRApJy122VvXss7HUMJiEVpnw7093G1DYyQ0QzEktBmWumgOU41
	gZy3OpUeISetbUItPCqskN0VA0iazMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-7CooUoZvMEiglYZgfB3nHw-1; Tue, 29 Apr 2025 06:55:58 -0400
X-MC-Unique: 7CooUoZvMEiglYZgfB3nHw-1
X-Mimecast-MFC-AGG-ID: 7CooUoZvMEiglYZgfB3nHw_1745924157
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso40182745e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 03:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745924157; x=1746528957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19RTGAYgSCXwR1/QnePt6pjSqRpqNVt5Z/wpug3TfME=;
        b=gzhLt0e0eH8brkvG0lBBfH+VTO6Ohqo8LdsPhfDxbO+lhhormYhhHms6yLuT8VilpD
         TnrOw7BAqqBnYCSAsHgccgHy2w8F1IfBRX4J/wSm/nGuTW13PQCjV/5I2m2TT/NZrO+8
         mQxcWvKVeDXtIHh6tZ3rRNhMUHPiFzZWpzl2wYT99WV5FtFQsPDF1DcIciBAx0A1xcMr
         bLR5NerSeBJXOTo8EdXM7/wCnlVTOnAeZSYlDxC7jxysazLH9SE9yUjvkSjBBkpAfqYy
         NYy/4YQ6gfaQ1FoH/MC347RYg5zSezi4oYiPqu7H7C65Gi5oc689k+tAsQU2o5H/1Gqe
         XY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdREcvMj2Hyal8Aoa59P4Lt9xx8+XdbpqlDgX/42bSwIvcn8PLhCvhGqURxSiRm7/c7XRcMr9e/AI2oJwvjQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHwUWgOWOo9wSWvcBQiHPgLycK05j0Vd2/luxivj4QD7FI3dYT
	jzvmTUuhpVI11p1N+Na2O4a3zKG4hl1MV5InpcUBZX+br0PyJnJFp3H/CollXo4BFiyMT0bFho5
	n61EZEQNXSIFYXcCUdJlfrCvDNlI2k/1xnzu4UcWVzQZkcg6qY9P/E73IJpnIKhTbfErE8HLq7f
	1lJCg=
X-Gm-Gg: ASbGncswUtYXBgCWMMrKI5Wd5I2c4Hmh8sNIs87jB1h5M0dMFq98y59eoQlk662JHip
	saNRLZt7eSM9R2g5Crv8hmLFQODq5VjvQFhubhH/ia0/KRs5jtofgVQJ4kFY4fHzaoagV/oWivt
	GSkhau6eTF1XQAdRaAikjjgfHXg7Y99o3y4JYh8mHfD/6oLUzc4ybkMJ+HO7iGKC0lW6AYnornx
	DLnila7jtew7pHRrP0S5I/YTIVOJ7C6/S7+1LGkzpl5T7r6MX4OTF/cnowRLStrDd84qp5fNKnk
	bevDiw==
X-Received: by 2002:a05:600c:384a:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441ac85cfffmr30415245e9.17.1745924156963;
        Tue, 29 Apr 2025 03:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHhPyQF+kfEhHY8Rir1hFUnKPAus/tT9SNHKVUQOtQwHP4Id2+yIhepQRoyIXOCX/07G8ZQ==
X-Received: by 2002:a05:600c:384a:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441ac85cfffmr30414975e9.17.1745924156638;
        Tue, 29 Apr 2025 03:55:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a1ddsm154027115e9.30.2025.04.29.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 03:55:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 06:55:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250429065044-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qjWRNWcBdxb3_sTaQtQP3kMa-pb27XkOokb03yN_ooU_1745924157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > >
> > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > is disabled, and any attempt to use it will result in failure.
> > >
> > > I think we need to describe why the default value was chosen to be false.
> > >
> > > What's more, should we document the implications here?
> > >
> > > inherit_owner was set to false: this means "legacy" userspace may
> >
> > I meant "true" actually.
> 
> MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> applications need to be modified in order to get the behaviour
> recovered which is an impossible taks.
> 
> Any idea on this?
> 
> Thanks

At this point, as we changed the behaviour, we have two types of legacy applications
- ones expecting inherit_owner false
- ones expecting inherit_owner true

Whatever we do, some of these will have to be changed.
Given current
kernel has it as true, and given it is a cleaner behaviour that will
keep working when we disable CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL in 10
years, I think it's the better default.
If you want to change it transparently, look for ways to
distinguish between the two types.

The application in question is qemu, is it not?
I do not see how sticking an ioctl call into its source is such
a big deal, if this is what we want to do.
A bit of short term pain but we get clear maintainable semantics.

-- 
MST

