Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF54214228
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919639; cv=none; b=PgcTqShZtM+eb7lhIegtgWeDR0q8Bgoy50QRO+iL8D3ukbMFhX5jnRoMOPcrAX8Y53z2Lf69hAb49ecOXabjrPwv+0CEn6vpjNEfFDLq8haiCOv9Sna6Fii1moqchXQJsGBAaqFVxTmTtY9Us5yGhG1aRmBUswWiHS06NMwXvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919639; c=relaxed/simple;
	bh=J4s9+J+hh9eMHsOMiBgtL6JiImJ/4Z+NIXFm3a0EhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jPefeeMGoOf92AY5/9ZoRIB4HUgHqviWYFYoZtYlvaJqj/CB+p0G1U5R+3C8PeyjzmfKjAZOAaTWGvOfcVlPWhR5FsRPuNlfbEuYI1QOVSDzSNDgGJ7ZbI7FHo0sbrutgtOvO4lUPGgYJsP17XFMkyl245SwoaRORhKKdT0C+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIR3paP/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIR3paP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750919636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
	b=aIR3paP/I7Jad4i6rnZoKfrZU/CExFQTaLTlgbY5DK/dWA8yzHgZs1GMV33PO4H2hvgMKI
	3cdekMXZdfNYXABIJFVOB+QFXPaxyqQpPtHF1s1s0nJ3PP32+dyQV1+XW5a3oR4uF1C5lk
	i1YGxeC+SFCgXgOOXX07ZDnHW7PWYUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-cZZsdV0RN4aX0Bb_508qVg-1; Thu, 26 Jun 2025 02:33:54 -0400
X-MC-Unique: cZZsdV0RN4aX0Bb_508qVg-1
X-Mimecast-MFC-AGG-ID: cZZsdV0RN4aX0Bb_508qVg_1750919634
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so2737615e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 23:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750919633; x=1751524433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
        b=FmG2Rdvxs86Xa1kacCsKk3Dl+OtBtXwnPUkhj0EOuQ7K/ySzrzt9BQn26gIRp4Bwf8
         e0Hecdv7Ek8S+oJMJieNQ81OSen1KKGhPnr9gj8FkZAIRTXBmREGCxgIUkktnBSeMpA9
         dmWQkSU7vqDplnoRScRikPBsVntHeNu14PS+R2UnQEh04DwRcBKcUVG9ohEOSr98iBXQ
         JftbOXRwDk5NcplIeR1RwxWBbmHQoGTScA+UjCoGjswDqASF8HaXGUPONG98sGPAXXNg
         WRmDH/lCbZF6/LEH1zp1+vzBnyPnPnbrHvKbGMtMK5xS+8LfnLsNjzL/ECFMshtnPIOQ
         wJPg==
X-Forwarded-Encrypted: i=1; AJvYcCXj1JlyM0rPqZ4391JOgKmEsRJNO8Iby4L5DgLnWXo8g/FYOiGOys44iNdCq+jPBAUCH8KTgYCHbij+7VFGtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0oHGWylCom13ySw/zg2s/ytwuX+Jxo7FCxZvE1KoLxPR4UrUk
	4HhWHUgpX9GnLlVXIu2YslvTbIVRlTSXIuIA8/KshnocC8PlY8r5lNr6MfBQ3VlTNmYEtrvOZxO
	RFrvj/LUXbIWf1VX/yaCUbmeKDduuZNAoT082F684eUatC4wgBvO/xuGLZ2/tVaQ2cHs8
X-Gm-Gg: ASbGnctAFfcWtc23YcZWYz61PWKYnf9E+zRsjIjjhp30TBwuwGU7MlddNRFoDfapawc
	ARcG5fGks7hO4Tp8priDqcC7tPXNDodbAhvSjvl8QCRjNe7T6q/ANMbQixNDJ9J3lyECp9jDYN0
	n/ZMlv67cOsVsdcqjF02sJJTSsoXCIYtfMNKkcyV8QBkWsBAJZLcRgjEPqFEavwzQMZQCaMkmLx
	t1Qzu0xLKFl8OGzGWlRVqa8IKSa5kdSoM6R5EN+R6lb8byYmQ1xJ5qZUxHozeZdUFbH9Gbq1zct
	X8/kR2+5oDpMkZ4/
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953745e9.16.1750919633508;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY1gVtAu6xNPmuOKtlgkoZHvhQWkHC705oPq3RWgy6yjcOgBSGke0BghulB4p8vItj5d6DqQ==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953305e9.16.1750919633023;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c3c7csm39585545e9.36.2025.06.25.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 23:33:52 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:33:49 -0400
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
Message-ID: <20250626023324-mutt-send-email-mst@kernel.org>
References: <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b3y9XMQswxvxctqbuMioCaobWeVqERIylbyglSkJNXI_1750919634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > yes however this is not at all different that hotunplug right after reset.
> > > >
> > > For hotunplug after reset, we likely need a timeout handler.
> > > Because block driver running inside the remove() callback waiting for the IO,
> > may not get notified from driver core to synchronize ongoing remove().
> > 
> > 
> > Notified of what? 
> Notification that surprise-removal occurred.
> 
> > So is the scenario that graceful remove starts, and
> > meanwhile a surprise removal happens?
> > 
> Right.


where is it stuck then? can you explain?

