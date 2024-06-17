Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059F14E2C8
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641231; cv=none; b=u9G3eTO3127zy2r0M1XF24g43TUm7h4ltIPMSxvXMbpF4ufe6hdh4rchhmn+B5FKyAKrmtC50QOd8KY6kr46aJY/F1keZ22w3aSnXHJYZNL7aVgbvBuWCXfbWHR80wKlm0ckSrnc5jpahZcgUYRJfgI2B1OFp97ampxfjcuwHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641231; c=relaxed/simple;
	bh=1YMKriBvPLE/aY5scq43G0zWcXPtBM3EQFqBpiwdFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jHC49dUUqy0bayULHW24BzkbRtOif+n05aJ8VJ93Ug6PqEnbXNXurDw3wWUvq6XYFChpRGWeueXu3vb3t5qkTV9vQ+cn/pGVsUxTAT4RQvztViN+hLPTgvTIVqXjk82OSZBoaNnRBkMQP5St45ZWwPSSVTuVjWZFXVeHMaNRp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITz8R4jh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITz8R4jh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B41E16077F
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ecH-CElVMv8r for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 16:20:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DA79C6070E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA79C6070E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ITz8R4jh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA79C6070E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718641227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQRV2hrWRZz2oGiqD2uRSCHZ36VaQn0Ap0e/dg5aYkA=;
	b=ITz8R4jhxuUj/44sC6IR7AzAUGz6FbybDCr57UoUEmtxVrUEvcUPdWSUtJeuOXbcYfdNQ6
	ajICeAEbXA6r2+HBPGdiaUS08yShTPn92IaIBwLLR4Fkuiu2N5bK+bNnKWXI/EIEkILyvE
	PWWpdW+0ZqYWoVucNK6oZc2Yjft925U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-GUcst6rLONaBPLQu-pSGWw-1; Mon, 17 Jun 2024 12:20:25 -0400
X-MC-Unique: GUcst6rLONaBPLQu-pSGWw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421eed70e30so33110305e9.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 09:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641224; x=1719246024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQRV2hrWRZz2oGiqD2uRSCHZ36VaQn0Ap0e/dg5aYkA=;
        b=lGJCxA6LLCJN+8ihQFPGX9MytQ3PBxFfGsXrClkY93l/W0Wcqw9Jnx7n7zDtBmy4Bq
         gXcFbMp0N+6msR1L9w00G/j7xtNgs+aqfmi9cYSQEq0ThMGLdTAN+vIOH/ngcda/igS8
         jVA6gKxzIjXyA3iQ5jBc47PjTNXyoieHM5w1k0Fczj6uAXaVP9wtQuN2RU1zutZzmVJE
         TgQOuqb6XNnDT2ThraTbYj2FIt3F/kSE/5Wa/3Yg42bWmdn9N/tZHes2LdwxJXtYw9p5
         t20gCEPb++3I4cXF+Io0esybIE3HNWlRK/MGrFR+Jzb5XG4Pw0U8ec9rV1afmsLJ3w+W
         z1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDYa6gDhSKSKxVuWYd4I7oG0ayy3CxShSaEkLP7AZZRJltD6d3VCdrQk46ujjdmGp9yjLPrA6j36ubtaiKwt1GJa3K01gOVYtI9XTUFQis0k9F2J5ZCujV8g==
X-Gm-Message-State: AOJu0YwVTgrVYyl2Yzdv1bvNoRBndn3e1F28Qnu/pPWDGx+WhgTjkHNv
	Ko3IX/6L9mLedUTkHQuur4RHRJ7POh6SQ+VvDaX2AZ+XilE7Q03pNA4XLR3kIzdWK9hDuS+uMuu
	Eqq6bzqEm5iEBcyg5LB/InDlKf2pDk76q/tu/Pfyyi+82xYg53KN3Re66VzBuu7SStJ4aWmrjJt
	fYOkg=
X-Received: by 2002:a05:600c:4b23:b0:421:79a1:bd16 with SMTP id 5b1f17b1804b1-423048264f6mr100417055e9.16.1718641224471;
        Mon, 17 Jun 2024 09:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzccSMh+gGntzm0iGboVzC+6fVzzvRfTEWxR0IH3kumTR3OICOIsQlYAnDEfRgmcC5ufh2ZQ==
X-Received: by 2002:a05:600c:4b23:b0:421:79a1:bd16 with SMTP id 5b1f17b1804b1-423048264f6mr100416835e9.16.1718641224002;
        Mon, 17 Jun 2024 09:20:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422d0be1424sm169109495e9.12.2024.06.17.09.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:20:23 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:20:19 -0400
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
Message-ID: <20240617121929-mutt-send-email-mst@kernel.org>
References: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
 <20240617094314-mutt-send-email-mst@kernel.org>
 <20240617082002.3daaf9d4@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240617082002.3daaf9d4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 08:20:02AM -0700, Jakub Kicinski wrote:
> On Mon, 17 Jun 2024 09:47:21 -0400 Michael S. Tsirkin wrote:
> > I don't know what this discussion is about, at this point.
> > For better or worse, vdpa gained interfaces for provisioning
> > new devices. Yes the solution space was wide but it's been there
> > for years so kind of too late to try and make people
> > move to another interface for that.
> > 
> > Having said that, vdpa interfaces are all built around
> > virtio spec. Let's try to stick to that.
> 
> But the virtio spec doesn't allow setting the MAC...
> I'm probably just lost in the conversation but there's hypervisor side
> and there is user/VM side, each of them already has an interface to set
> the MAC. The MAC doesn't matter, but I want to make sure my mental model
> matches reality in case we start duplicating too much..

An obvious part of provisioning is specifying the config space
of the device.

-- 
MST

