Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728617C21C
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026885; cv=none; b=HLEHazHYbm5Z5h+NhsH3Lx5XFP56sliLtjC3ZIsIEXkTWZ1GtrYdHyv8JePX7anvKUv7pmw5qWPB/u1fwXarbiwV5SXMYzoLfwitM3nVM9ulfLsVEqOgD+/mEoVzRf7OHsBdnL2r/9Z4AizIU3Iav1Mcqn7Vw53td+ttLIMXPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026885; c=relaxed/simple;
	bh=+5aEYy8/LHHi4FXnbdS5ukMXKdh3+6yLZdvJXSlBL9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BtRw8Y/10mhpISYQ19yT7SAx795yZWC5Yr510dQrPBo9owUf1o/OUz4Mwzb2gmLOUray7l5FXWSWw0CIcyP69b/mIr57H9r4Pa+bp3QAgUXjt+y21TN0BWutxoLMMQflOLOm3Ke2dbeRYiQttT9H5rtyxxw0nCymz2mq0C+IFrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bh/WqrKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bh/WqrKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751026882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
	b=Bh/WqrKdTOXrScNAQ0DDWUDQXZoHKMbHSZR7cQgRZH8v/XVMdh0YOkIGc41BfGDTAKlgQq
	YdIM5Je9QBz2lQh/K8WKc29AgoZf7oHfUMQTuuUp0eKn0Xc05iTMSEj0zG7EDhp2gFpWXR
	xw7F43BlBkbnMpBdnoNV55+fFnool6E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-FL-0shklMrC6CZ3gEsdLKQ-1; Fri, 27 Jun 2025 08:21:21 -0400
X-MC-Unique: FL-0shklMrC6CZ3gEsdLKQ-1
X-Mimecast-MFC-AGG-ID: FL-0shklMrC6CZ3gEsdLKQ_1751026880
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so10938265e9.0
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 05:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026880; x=1751631680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
        b=R38+dJwhveGb47T7mZgB8pBC9SnCism5bbpQJ/dFIL9zUdKJyZXn+wFPXIP+zQ5OtO
         pXvhQruQ79siESVNYjrPmIcSO/hf49iK4IuaAZnDcmQmehsnTFrCB2PRnmwujwitYCIb
         nMR9pRLP7X3nN5RtOLU+I5MW7+weCCl2rpP+unK828QuEcrWVbJhrp0aiqyYwC1xVNR6
         OrLjRVR9bfLMOOzKdUYzZ8T0zxDRej7qJdNABKWMqaQtpkefhnQP4UZitdMj/5Ujo/Me
         qk/U3TqaiRGWFCI8WIJL36c9DCowJh4J6ExX3OSmCO0S39ZoNakLljNAtNcMie3pfnCF
         7DOg==
X-Forwarded-Encrypted: i=1; AJvYcCW0q9YwbtBpooI3jlbd/fARXUnPEBblQ22vay4bnFJECAnCZbsuYS0ILC6gz9rbFea5wcm1TlR2PYUr4STVbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdqElP3T8G0+9v2PTkev5MS2dtbpdy6T/v7j3hz9z2w4IuQ8Or
	y+MQWcqntY3daIo7qzMfN7SEFrkd3Rvu4hRPGeA9LzuHZ6C8rsx7nAEKwc0xFdrSwOsXaSDdhZW
	xW6WAx6o1htMZgax8Uay3K2eNYe3+eMmWfrj3nidDRo02R+3SP/mO3tazm91T+ZDCbLBu
X-Gm-Gg: ASbGnctvCgmJesw74KQfrG/zNrO30xb9f+jAsZ5p/rog00v9hq0itsSZkLxDIkXFWGi
	xh+FlHcYXWpO1eC/lggKACfOwL85974zpoUFxQ9/odIlSUIZqA91WMuGOYl6+gbI6kVPXJAVwg/
	muIZT8p1MX9gu1kiQtpXYp+Wmb+TOiUreC68luxepCQQ6DYvuyRChh73oOmNJnU7+uvnbqSkTIU
	FYfNjvOWWkE1OIQlEp6fuZVbNKqg7vQEPGb+iNS/Fc7NW7WG+RuAbYz9Ec9fAlwEgStkxu3Wsqs
	BJSX+WL7Tqf7x9b8
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929625e9.3.1751026880163;
        Fri, 27 Jun 2025 05:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPFIKbNJqoUHfjnJfvtoip1KeoRTxGz5M9CfWv8c4GpayUIF3Rky7v6/Rn9JzNgvu+kOV4tg==
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929215e9.3.1751026879698;
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380fd167bsm58441225e9.0.2025.06.27.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Date: Fri, 27 Jun 2025 08:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250627082048-mutt-send-email-mst@kernel.org>
References: <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626023324-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aQWWtriGrw2wVAiDUcsHnuQUj5VAPmhZiGfuUD3YRcE_1751026880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 09:19:49AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 26 June 2025 12:04 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>; axboe@kernel.dk;
> > virtualization@lists.linux.dev; linux-block@vger.kernel.org;
> > stable@vger.kernel.org; NBU-Contact-Li Rongqing (EXTERNAL)
> > <lirongqing@baidu.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> > xuanzhuo@linux.alibaba.com; pbonzini@redhat.com;
> > jasowang@redhat.com; alok.a.tiwari@oracle.com; Max Gurtovoy
> > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
> > removal
> > 
> > On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > > > yes however this is not at all different that hotunplug right after reset.
> > > > > >
> > > > > For hotunplug after reset, we likely need a timeout handler.
> > > > > Because block driver running inside the remove() callback waiting
> > > > > for the IO,
> > > > may not get notified from driver core to synchronize ongoing remove().
> > > >
> > > >
> > > > Notified of what?
> > > Notification that surprise-removal occurred.
> > >
> > > > So is the scenario that graceful remove starts, and meanwhile a
> > > > surprise removal happens?
> > > >
> > > Right.
> > 
> > 
> > where is it stuck then? can you explain?
> 
> I am not sure I understood the question.
> 
> Let me try:
> Following scenario will hang even with the current fix:
> 
> Say, 
> 1. the graceful removal is ongoing in the remove() callback, where disk deletion del_gendisk() is ongoing, which waits for the requests to complete,
> 
> 2. Now few requests are yet to complete, and surprise removal started.
> 
> At this point, virtio block driver will not get notified by the driver core layer, because it is likely serializing remove() happening by user/driver unload and PCI hotplug driver-initiated device removal.
> So vblk driver doesn't know that device is removed, block layer is waiting for requests completions to arrive which it never gets.
> So del_gendisk() gets stuck.
> 
> This needs some kind of timeout handling to improve the situation to make removal more robust.
> 
> Did I answer or I didn't understand the question?

You did, thanks! How do other drivers handle this? The issue seems generic.

-- 
MST

