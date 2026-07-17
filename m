Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0223EC685
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284132; cv=none; b=m9PLfOxQstdlHLektGcRmMS1+Hmlxh48pYJtg8GQJZ9LJnXngPTIIAnh6y6g7cG8iwExMAo0K9vCJlp917iRTWiVTnXlZRxdAhPbP+Y73B6uraIYYAT1kOd50yXpxv05VaUhl00rIY7/rFdl0ziyeouVdhSktzvQGZv1U39JG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284132; c=relaxed/simple;
	bh=1bR71OBYIuKF6d0+s+uurBcJTAeTBAswij/yZeQ0RBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pZ6fZCXaYNea+BGtdbYnkRLSXUiaibVeU7bk1U/Koz/XhYwUdBsw/OZ4Eb9X8IXPRl0heuzNwGMKt2VPpkYEAA/8WGfbdR1YtjVXirfWxPAsIDTnNpgTItche/fwdbFlm7CjlnqWOp4LaUlc4aSY3CMZSnif13J6QmrtJDN4h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd+Eo13y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd+Eo13y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784284129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOQT1Jg33Yvda7kkuOvUqKnsyyCex3ws1+ruIGhae3o=;
	b=Gd+Eo13yt+9FQM0MpYAaTaRQIfBd2X5c1yys6/AHuxBCg3aPv1oF2beX01/UWQc8pRN4T+
	7jaW15f3N3Jx+3wRDPot0zfRz5+yaVFGDidYADjeHkUOqUF7UuuREnaGC/DL4ul5rO03E7
	ZBE7nqb6hSrdpeF0Vlh5Yq2yQ4noldY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-nrhv0p3MM6an7UDT2R9idA-1; Fri, 17 Jul 2026 06:28:47 -0400
X-MC-Unique: nrhv0p3MM6an7UDT2R9idA-1
X-Mimecast-MFC-AGG-ID: nrhv0p3MM6an7UDT2R9idA_1784284125
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493e94719e7so50920635e9.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284125; x=1784888925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOQT1Jg33Yvda7kkuOvUqKnsyyCex3ws1+ruIGhae3o=;
        b=rDTyhjemY/QWL3LEirPXvVyLGXPVsRCF15QcBKqTzErBP/Yzkb+k8SGQlN1XrS79kA
         xKuzwI2G+CG3knPCSn8wYZojOCq4XZqE1I2brV5UEAb0ZwNyYnbG/7iCsL1wtw5bEYxJ
         5szQeLmKp8qaC1W1ITfbFCdlJOILvK6GEX4Gn5+D397zirzZLzFo8NJtN52ZOBx5Lh5m
         3+zegUE/RdvqK3XPqp43LO84/8uaVsjigUIa08Hd3lXfVZvLsEFkV1cbdC+rEKoyAS1L
         4B+URpLwnC/xZ3oWSnYUgbiulpwpZ3jzXkuc+o5TxO+C5Z+J6EXytVeX/8iXAlRIPmMP
         Ng4w==
X-Forwarded-Encrypted: i=1; AHgh+RpUtZVBVGAaxq+WfT6DSR2kDjXdzOd6uoObhw8py3emGiWSjZ0yDER0DYXnRoKuNadPzvrdoEPAIF4gBxEL3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxE7EL80aOToWYBArqQna7W9jjAE2AJTOiLbWzqwnJRwU0LfWx
	SLjQyRYqS5324v98mFFdbBpnoBEDFbtFadqiuDBpKLWTpB+n4f9H8paJVIF1/GAVlEbaI2KILPJ
	lE8welDWb+cF2InxYeQ9EC48JX5sT3tl6Ts7EzpJPkl2plz+t8IcRnKAjdgAxAPzHPkI4
X-Gm-Gg: AfdE7cnER6LdOIK5rS/HXnEAby01nCtSg5vAD1v7OJj7EpSxyy10dgfm5Ur4mFE1mu+
	MpAyRvRVHtyacpCnTQ2vtSAG65+n+HVWfVKKvvbNeel4Kg4cWEOFK+Bi+5xl32RO24q+53lH1XM
	LY9jR8EYiJcDsmDNm5CgWf6EUTLN8YhoZnaJiD4lJHZAhn8od5fD53yNZzmhtFkH1KNZfZq1rbA
	szWGIEwksqG1nSkpjG32UopuTEzLVmq1xR4DO5694FNm0Mshob580Tc47HBPlbjaGKBidjtr/MC
	yBW65kV4jkP94hgQfZX+Q3jVeXBw2q/qwuNtQJhePC1D8/Vn+C7zYo3+ROdNjGtPOmonNJ0z/lg
	+3pPHl+P4e0gUAmpjY2G/bJPa
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id 5b1f17b1804b1-4954c733e07mr8967075e9.23.1784284124442;
        Fri, 17 Jul 2026 03:28:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id 5b1f17b1804b1-4954c733e07mr8966685e9.23.1784284123898;
        Fri, 17 Jul 2026 03:28:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e850dsm40816685e9.9.2026.07.17.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:28:43 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:28:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260717062436-mutt-send-email-mst@kernel.org>
References: <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <5877a6ae-5a9c-4376-8297-f17695964db0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5877a6ae-5a9c-4376-8297-f17695964db0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C9sHZAS8NInOOpd5lH5FQJY_7ro9mZU_GtKpopj_3bI_1784284125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2026 at 11:21:34AM +0100, David Hildenbrand (Arm) wrote:
> On 7/17/26 12:15, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> >>>
> >>> Why not do what USB does?  Don't trust the device until AFTER probe()
> >>> succeeds?  All of the needed checking should happen before then, as that
> >>> is a "slow path" so lots of validation and the like can happen at that
> >>> point.
> >>>
> >>> After that, during the normal data paths, after the driver is bound,
> >>> trust it all you want as attempting to validate every single packet is
> >>> just going to be impossible.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> People do expect that data path validation at this point.
> > 
> > Ok, so you want this patch :)
> 
> I fail to see the value of this patch given that there are plenty of other cases
> the device can mess with us.
> 
> But sure, let's check for some conditions if it makes us feel warm and fluffy as
> we audited a driver and it's now super safe, fine with me.
> 
> -- 
> Cheers,
> 
> David

I merely made some generic comments since I was asked to clarify how
virtio interacts with coco.  As for the specific patch, it does not make
me feel fluffy. It lacks motivation.

A broken device confuses the kernel with no way to exploit that. Shrug. So?
Nothing to do with coco, apparently.

It's maybe reasonable as a debugging aid but if this is intended as such
let's make it clear in the commit log.

-- 
MST

