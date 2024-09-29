Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1843BB22
	for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632099; cv=none; b=diDBktSx6VdsvBsFdgN0yHxAeesFbSG9HaItHr5zbS4jP31NrfcsGWUtYsTqJCPan43x7AcXMVOBX8x0eIB5gu02UPmojTZn9AqWpsq7jemGRvxUh67Hv3+lrDD7jZfcz/cUrRJ+HtPoGRwxbsjT+M7lR54yOgU8WFuMbSgWGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632099; c=relaxed/simple;
	bh=AvobsG1jhuHDFE/RNGfVUQyDfh3hzzI1idLKQDaPtl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K4a1GrWVyZ8m5SIR1znauwx9gx1cu1bcwwYbEk1JsG03H9+NXJNl44PU1vj1TImsqeSh5vX0oh7siKP6Va9HX3bvIxWuhZJ6qWLI8RlbjGF5uNHLF4jyBEStbhKLWeYc0yl0X9E//ItV2hykibEwzrdfZOpeee0jSsIEB4z8xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNXWcXwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNXWcXwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727632096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2SJ25HQ+fRHsgbGXM+/9uz/n92kl540u3O+51RIevY=;
	b=UNXWcXwMLwL8c4rhiByxBaOzFpkG5NbcIAduvQlwdmEd3vuk0u76SlfmRyviq760kt3sd+
	ejpplKyhvM4vspfuRgcSj7Kn6y32+jm2t74iiDBk/aF20/jAHMgtW2kwMubv16riOurkvs
	qM03aWbdnvmcnj6vWJqcevWBS6soti4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-aW8Hz9JEODOTJAHQ6nTqFA-1; Sun, 29 Sep 2024 13:48:13 -0400
X-MC-Unique: aW8Hz9JEODOTJAHQ6nTqFA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c877a8db97so2767660a12.0
        for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 10:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632092; x=1728236892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2SJ25HQ+fRHsgbGXM+/9uz/n92kl540u3O+51RIevY=;
        b=s9TIkxYAsKTb/u4vDbvIsMexCLiJ/D2/nvMDDWzK/Mu5fI0e4w/XP28yxCkKvFNhOH
         rxMju57I6TOAUpn3499VoBZez6dEn/YFEAFiWrw9pAtnJdlXIWD7cV3OjZJR/FVsD9qk
         BJAHDczLbIZvQu9X0Eiti4g19u1yHZgDjliUTULGv0L2j8/j9FAsdVCxL3OMlhZoDNoh
         LgUUsRnC3jFw+XG5rpO3EJB5PrX/cqqP/pd/D4dRcpwPS89OUoqrTfOAUVikXNWIMC7T
         4Frk/Q0Tyx5cRnF9WH8+XHMbyLXIAgYAS465GUbP+KEID5HY7kQVUplYYIWkMHO1n+XM
         Kr1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9RXbd7EEosGSICdBHtRM01dcDA3Z0KBwTz6HagihlJO+y255wBU9siJ4MznI4Ww22v2ms3KLx7TQvWcIFPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTAfNq4WlfkRdO+6kJ2cQfaJQIDkiqU6D3QLa/qw8n+Ell6dkL
	CUrCZlznMf5rsfg6TQujlmkGWr1DPMAzBLvcg5ahGtI2U5J2pAIw3brhkiXj1IHA3nNwD69f/U7
	6Fpov/nbtZBHvF9MRD8VWn6H/Ax+3GZArwJx/Fwe9c6ukjjaT+BgoZwnxa644cfxB
X-Received: by 2002:a17:907:5083:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a93d5d30c76mr524243966b.13.1727632092391;
        Sun, 29 Sep 2024 10:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqTNCryWEzIqqf/1Btme4Xway6eGbeCP9wgNBqt//k4KeV1eDqkHhHROUxGnKGL7CROE+tg==
X-Received: by 2002:a17:907:5083:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a93d5d30c76mr524242566b.13.1727632091972;
        Sun, 29 Sep 2024 10:48:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a4d2sm403334966b.155.2024.09.29.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:48:11 -0700 (PDT)
Date: Sun, 29 Sep 2024 13:48:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929134716-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929125245-mutt-send-email-mst@kernel.org>
 <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Sep 29, 2024 at 07:35:35PM +0200, Aleksandr Mikhalitsyn wrote:
> On Sun, Sep 29, 2024 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> > > Add an explicit MODULE_VERSION("0.0.1") specification
> > > for a vhost_vsock module. It is useful because it allows
> > > userspace to check if vhost_vsock is there when it is
> > > configured as a built-in.
> > >
> > > Without this change, there is no /sys/module/vhost_vsock directory.
> > >
> > > With this change:
> > > $ ls -la /sys/module/vhost_vsock/
> > > total 0
> > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> >
> >
> 
> Dear Michael,
> 
> > Why not check that the misc device is registered?
> 
> It is possible to read /proc/misc and check if "241 vhost-vsock" is
> there, but it means that userspace
> needs to have a specific logic for vsock. At the same time, it's quite
> convenient to do something like:
>     if [ ! -d /sys/modules/vhost_vsock ]; then
>         modprobe vhost_vsock
>     fi
> 
> > I'd rather not add a new UAPI until actually necessary.
> 
> I don't insist. I decided to send this patch because, while I was
> debugging a non-related kernel issue
> on my local dev environment I accidentally discovered that LXD
> (containers and VM manager)
> fails to run VMs because it fails to load the vhost_vsock module (but
> it was built-in in my debug kernel
> and the module file didn't exist). Then I discovered that before
> trying to load a module we
> check if /sys/module/<module name> exists. And found that, for some
> reason /sys/module/vhost_vsock
> does not exist when vhost_vsock is configured as a built-in, and
> /sys/module/vhost_vsock *does* exist when
> vhost_vsock is loaded as a module. It looks like an inconsistency and
> I also checked that other modules in
> drivers/vhost have MODULE_VERSION specified and version is 0.0.1. I
> thought that this change looks legitimate
> and convenient for userspace consumers.
> 
> Kind regards,
> Alex

Aha, that's a different matter.
Given userspace already depends on this UAPI, it's easier
to fix it in the kernel.


> >
> > > ---
> > >  drivers/vhost/vsock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index 802153e23073..287ea8e480b5 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> > >
> > >  module_init(vhost_vsock_init);
> > >  module_exit(vhost_vsock_exit);
> > > +MODULE_VERSION("0.0.1");
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_AUTHOR("Asias He");
> > >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > > --
> > > 2.34.1
> >

