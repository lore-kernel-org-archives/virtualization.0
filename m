Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DE16DC24
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707174; cv=none; b=N7NWisG+miMAo4DfvRv+mHtQOdiwLPBePsNraqE9vSL8SOtUXa0Vfn05X4q3bBymUAV/WW/sSGyeFNLEZK8N+Wh+/IEQjCz5mWrlJA1zCTfwvZgrmhpBIgLUH6PxlQDhgDD8/0gaFqyxs5TLAZ5UuaKSTGH1+3EiwhHwgQWJ7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707174; c=relaxed/simple;
	bh=dFrRBkJl7R9hxvgTFXcfhz/5bf+uuLP1erp6wT8mbB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gvdOLz/1S+9nR6YDYKE4NakHJdc+4pJ5OE0WVbocII5dv9C9akS6ulwLv/IxeUSu22sLjv+/ZMiIGYoTFn2Ibxp6KEqIJLOG1cSXcu964iWdIlDptdE9ax3e0eNSQDwip2dGXtpjNkE5SKlfkBpF6cnPhD0ldTjMAi0h7XvYdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZC5Ldsp; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZC5Ldsp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D98576072C
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 10:39:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qhxAeNbnITF for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jun 2024 10:39:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 066336065A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 066336065A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZC5Ldsp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 066336065A
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718707170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUpnx4iA/H5rFTjd+Mex3wPRNbIj26vNn+VnYBxGz0o=;
	b=TZC5Ldspej9cmgyfRk9eunXXDRiUiMireB3K/aX9sAo2PX3bzzFfs1s5eEa7cu1pfLi2W7
	P36lAFpivDqY1VucRFhnqoSAnM/8tw5ZelGBIAHfoeOyxV2WEoZu1agVBHsrcnX9xTYcHB
	a+ggX81Sx28DznHqYmZNiKauKuQohWU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-JVRlk6VhMXWiAQFGeW_KYw-1; Tue, 18 Jun 2024 06:39:28 -0400
X-MC-Unique: JVRlk6VhMXWiAQFGeW_KYw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c97141df8so1578035e87.3
        for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 03:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707167; x=1719311967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUpnx4iA/H5rFTjd+Mex3wPRNbIj26vNn+VnYBxGz0o=;
        b=sfV1MY06sqpvNx8XS1N7ofEaoS/mYT45WPJdaoLAeoD5iuZUM9n3bp1+2ncIW/3RBj
         oixKEQmuDB/sb/T0+MtQhMR4uhYvPIXLSquFp46GFPXJ2VY8bsRisbqYVv5gqr5dgrOn
         Ca9BDYi+1wSlHPpRMVBF0Xc9Tq+qifsZ469iVf03jIL//KQiX79OtQ2C0B+6KrEr8vLa
         ko82caZtHFFkSK6Vt/bJxuN2dlWXjzu9ukHVHwgrlMtZxqd2HJAOwwm+Ta2vH3dTDyS7
         SiayVN41vMyKKz4jUAkjpZEGzJ7Qx55hxnrtTnULPw3DWAyTXdr37BdkNemTIykQ3Zoi
         nH4g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWQGsuASyPO0q6G0Vl/IyjHsOy8Ajl2qtbbChMxGn7kaoBw9fbz8AaZy5sVZ0aP4A4w8PNLTgSQkBB/y1yJqNN94ittTf60iiHUI1RsMd8Vmw8k6/qU30/A==
X-Gm-Message-State: AOJu0Yxn+L152OivKZmLZ3VqqWlCEd0/lCIb1qo93z2MUpjc30J4lUfs
	Dx1qNMYVAh1nJMKBKMAzIGK5ZSqqmDCxbexbM+AWrNW0vKF5bzGHB2GyigTe411/xw+3IC+FJkC
	GXSEN86P85tNn9zdgOFIGxwL0w/SeIaQp6YhbOdyXRp36E0wF0KLXwkGwoZaZV3niWPgwzm7udT
	wxPRE=
X-Received: by 2002:a05:6512:10c9:b0:52c:b5ab:b6cf with SMTP id 2adb3069b0e04-52cb5abb7e6mr5463297e87.45.1718707166758;
        Tue, 18 Jun 2024 03:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFze+XHONw1pKhSFRlONo3MnV+d+IuBKNx7zowmQrnW5HIibz+c67gR1XvzUPSIqN7ibLJNTw==
X-Received: by 2002:a05:6512:10c9:b0:52c:b5ab:b6cf with SMTP id 2adb3069b0e04-52cb5abb7e6mr5463273e87.45.1718707166240;
        Tue, 18 Jun 2024 03:39:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm222635295e9.7.2024.06.18.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:39:25 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:39:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240618063613-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
 <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org>
 <20240617121929-mutt-send-email-mst@kernel.org>
 <20240617094421.4ae387d7@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240617094421.4ae387d7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 09:44:21AM -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 12:20:19 -0400 Michael S. Tsirkin wrote:
> > > But the virtio spec doesn't allow setting the MAC...
> > > I'm probably just lost in the conversation but there's hypervisor side
> > > and there is user/VM side, each of them already has an interface to set
> > > the MAC. The MAC doesn't matter, but I want to make sure my mental model
> > > matches reality in case we start duplicating too much..  
> > 
> > An obvious part of provisioning is specifying the config space
> > of the device.
> 
> Agreed, that part is obvious.
> Please go ahead, I don't really care and you clearly don't have time
> to explain.

Thanks!
Just in case Cindy who is working on it is also confused,
here is what I meant:

- an interface to provision a device, including its config
  space, makes sense to me
- default mac address is part of config space, and would thus be covered
- note how this is different from ability to tweak the mac of an existing
  device


-- 
MST

