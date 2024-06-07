Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF471CA85
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752974; cv=none; b=qgglGNLBls7jKCXbyDudXhqZaMep3vWg9SlyxLoBHfgELx8nZt5lDufbcl9Cf6/XR6IL2iIposh1i/wyVwl0cJ0Jvx7kV/cBIg71CZDRQDEBTc52szg6lnsYPMoEh/rRHudXUqa9j17rxTryVgkJjMOBR4eECOSqUq+ebUePAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752974; c=relaxed/simple;
	bh=PnvKfl77ig6dGAbYwcJXEg+qtTmFjX8P2WxbDHsH3O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=U71FUUQadRxeuteUb3H4HtA9msnwbQ3bCX/ZjndYVA5BJ83dl4hQiCGYFSWnDz2kMR4p3xOuQB6fGcp6SibvA2kG0rnrusf6dJigdBYu4VZ3F6v+wDgbZ3ViLtfZRuYnB2fRDVqHoRDMPeX02sXeIhKJ7Powpdcp4DakRII95p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehxbS02d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehxbS02d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717752971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bawrq4Gw+uDgGJ9L/GlXDoIwsQh44mvaubcqPDcOpC4=;
	b=ehxbS02dKsXR7ZmnVcwMr/BX6S4SchnCijfFben1p7Ln2hES9nIYGVo34hwnlenPb7MIVv
	FZCKF6bBarnM/W/1D9FJVF8t1lQz4bINtdYtTBFhrw4xZ5xxDTuxb8rtRa8s+G2e5BsQxZ
	kXx9QKYfwghdFmLJ1DNIjF5nFm461Gk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Y3U5hzOEOUWVBs3ZkbVUOw-1; Fri, 07 Jun 2024 05:36:07 -0400
X-MC-Unique: Y3U5hzOEOUWVBs3ZkbVUOw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so983918a12.3
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 02:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752966; x=1718357766;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bawrq4Gw+uDgGJ9L/GlXDoIwsQh44mvaubcqPDcOpC4=;
        b=amaJlWpUVEpbjuDndM6yBwGLWLMgGGaAhvD2IKzZZVSL4HM2Zvv8q7mm/4ieC+6tyW
         DmgKqypbYgy3I7DhmltngLj0SW/dLpY2dJ94FPnUn13TtRx4W1hYRC1py892ZSFaqYep
         A+03SAEqcLBsiB97k/+FyrNp22S0RZcsbrdwAArVDoJti3UjhwU9gCFrePVSf66+sQtS
         gJiF4Dng7FNCRojtstiV0QRMG8gU8qwdqN7KvwPvAiFRTZtfP9Hxq+Wq3r2Iryw3PD1B
         bdedQCpwVP2VCNtmim0mvREgwR2wqPDnI+jutu1lDmAGyeMoO+IhBkMVMb8pCZdIJlMb
         h/+A==
X-Forwarded-Encrypted: i=1; AJvYcCULWjRUBJx8Sp4xelzu6G7K7EvES/8WUfx9IYmA1m+2FkV1/a3NYxYx0FxC5k9z9KsDUQ/noFIyA559s7tEzfEUIM+oycLlxzDvBAO50I4=
X-Gm-Message-State: AOJu0Yx8iwUGdqgpCzfBaXTWI4+GqN0h9miKCzUnpWdEPHSqSjJfe8tV
	ZtOiRKbmkVkjI70AkSpDAfIgrsyYt3tTsy9u6NhWUVe5NhHDZ8PTgF9jFrq58c7dr/vWGb+NQJc
	mHj+0JClKeQL1ZG4zIKO7cpLoEvDbaePVOglRFdd+zQKsEf2ymuE4i8ZerE5e+PWd
X-Received: by 2002:a50:bb49:0:b0:57a:2f68:fe7b with SMTP id 4fb4d7f45d1cf-57c509898c8mr1161946a12.31.1717752966046;
        Fri, 07 Jun 2024 02:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPo9hRQAmxtw1tsSLlSzZoMzGcBo+vdaY8dslzj62Zb9TxctNy/NjjA9zPtEkhFcwsBKilLg==
X-Received: by 2002:a50:bb49:0:b0:57a:2f68:fe7b with SMTP id 4fb4d7f45d1cf-57c509898c8mr1161932a12.31.1717752965467;
        Fri, 07 Jun 2024 02:36:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340easm2428102a12.91.2024.06.07.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:36:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:36:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lszhu.dev@gmail.com>
Cc: jasowang@redhat.com, lingshan.zhu@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH V2] MAINTAINERS: Change lingshan's email to kernel.org
Message-ID: <20240607053542-mutt-send-email-mst@kernel.org>
References: <20240514165125.74802-1-lingshan.zhu@intel.com>
 <9542fe5a-893f-4e93-91fb-6e2007c50d7b@intel.com>
 <d3869be3-44f0-47cb-9a0f-6d9d404b458a@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d3869be3-44f0-47cb-9a0f-6d9d404b458a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 22, 2024 at 06:24:54PM +0800, Zhu Lingshan wrote:
> Hi Michael,
> 
> Gentle ping as new merge window coming.
> 
> Thanks
> Zhu Lingshan


This kind of thing is ok outside the window.

> On 2024/5/17 12:22, Zhu, Lingshan wrote:
> > Hi Michael,
> > 
> > My transition period ends today, before I get a new email account,
> > I will use this lingshan.zhu@kernel.org email address(cc-ed) for patch
> > works and communication,
> > this email address represents me.
> > 
> > Thanks
> > Zhu Lingshan
> > 
> > On 5/15/2024 12:51 AM, Zhu Lingshan wrote:
> > > This commit changes lingshan's email from intel.com
> > > to kernel.org.
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d75527f7bb0d..501b81b61b6d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -10466,7 +10466,7 @@ F:    net/ieee802154/
> > >   F:    net/mac802154/
> > >     Intel VIRTIO DATA PATH ACCELERATOR
> > > -M:    Zhu Lingshan <lingshan.zhu@intel.com>
> > > +M:    Zhu Lingshan <lingshan.zhu@kernel.org>
> > >   L:    virtualization@lists.linux.dev
> > >   S:    Supported
> > >   F:    drivers/vdpa/ifcvf/
> > 

