Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D144206D
	for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632128; cv=none; b=lp5NPRRwcC6jDt6EeA3n6iCUxEoYzsk0j1Is5ZVMBZssxFWHy+kQrzyUtqkNynqQUET+BEvRCh6ZXGZBRHY/oYJAVpbpNxjaeWeJ3/D2e2NHJ4kYegFupTGCiPAY5jTlw6ePW0kxbvVuWnQ23FpA3HjOg5s265J1Lg/hQYOSzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632128; c=relaxed/simple;
	bh=do27kc5Fwyi6Kx7WwmJUxF9V16BLmQ7JLqwuhDUy4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=loXwvDgc2YChTweHSyZSMfettuiIK3HyoHZlaMJRVX6RARxgU8Dkumm1qOoYwwlxDUytU5uaS1O0hNopV605WU6AHhk3maKfs9LjtizwD/6Q1agdgq0BO/6dMJOFnq5d/ILrRELCAmU0P5NHa7VK2+hoEfF71GS0nwsnpvH2+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdWDHJd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdWDHJd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727632126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPatogrvfeQytgMf1DGOYNKKTCyiWPsjq+uNPqesLks=;
	b=TdWDHJd9BPPH2HTP4lnkPvCAjdjmWM6jZqnCaKxeXcMhsS/uvCF8XFUw65X3k9Poog3Ofm
	5xZfkf1wKjKMp5SKgY13J5HSbVqzbFT02aoD7siQeQvhKS5TsYTyfSNWaLj++4MLAPqCrz
	paxrOeD9H24r+NnplX06YSc6+/BM8pQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-wCDl_XYEOmeRN2iL-OJ5pA-1; Sun, 29 Sep 2024 13:48:44 -0400
X-MC-Unique: wCDl_XYEOmeRN2iL-OJ5pA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a8308cceaso474961966b.0
        for <virtualization@lists.linux.dev>; Sun, 29 Sep 2024 10:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632124; x=1728236924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPatogrvfeQytgMf1DGOYNKKTCyiWPsjq+uNPqesLks=;
        b=MRRCy25fACdFDHyd6A7vwkrJKPwueh+aie0sPjkVZ87OoLf2hpadnrGdUE6iFBB/Fe
         YGlV2Uw+S193m/0XoC5V/g/qTvcJmcvFpjESAyWQZjZT8kBs3p06Vr/s4umKEuyFOkIz
         SCGLCP4rOyYI4Z8ymA1DFltExgix2/OTz51BqDS3zX1ehEHOwIcTms9p10y0ciOeGfX2
         P+0dwQhEnpUUwv6qWwN6DHTfts6ixas03cT8JbG8dDmhiYi4YxZp5buaxGzlwS5j8HqZ
         Ggv8AY4EuRJ25E4e3lEYELW41//Fe71rc9IHw3ABsk8RWumDjtAeBzOQ8v5fpBA2/ETS
         xNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2qO+/aenrNwHcTHb3eCSc8Vuh/4Ywvm4BX6HWDtXKAkYa8uUBg4MlX24pv8DgQLCV7YXk0duQwwosAaqvnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoB/gyjjBvYNf+ROCRjwFpgkOIdapK+L1yd7RARAQrvSZZmUZt
	4PvsRR5drZzK2l2KGC5eD5BmOLKN3Cv9hsWZd8ty8+ea+Q/+EuiKVOaUOv0pyuT8a2JwbSuUAY0
	39ULg0uDk2kcoCD4til5zMd7ha3FRiY93wFTBripblbclKg8HbV6k49Dl6Ihtnhaa
X-Received: by 2002:a17:907:8687:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a93b165dacamr1584444966b.22.1727632123589;
        Sun, 29 Sep 2024 10:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8yhcltAXNNOPlgdZbg2eX/lkfZ7eFhPOsGjV+HlVBPUltwDUsyTd38J3Fyn/QINeqZ/Q5XA==
X-Received: by 2002:a17:907:8687:b0:a8d:4954:c209 with SMTP id a640c23a62f3a-a93b165dacamr1584442566b.22.1727632122934;
        Sun, 29 Sep 2024 10:48:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948fc7sm404346366b.137.2024.09.29.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:48:42 -0700 (PDT)
Date: Sun, 29 Sep 2024 13:48:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929134815-mutt-send-email-mst@kernel.org>
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


I'll ask you to put this explanation in the commit log,
and I'll pick this up.

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

