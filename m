Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0D379C28
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398163; cv=none; b=cKs3duLcIo5I1/lEFm+vYW6y4+/0b/YS3HQeACku5X+WD/s8A69BroTPl6JtsRLdrAIYv35612K3/QE3hZzfdtoBWZJN9ufCGTXOMg4kiloyyjH7xpAA5OzwKMN/emWgxAMge7T7KAbZLp1N563NvlJ5z0yM1jF/xZmQreXlGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398163; c=relaxed/simple;
	bh=8hpE9nsljlM6tmO4jy65/s0BrzX0SxrerfQOPk9V8zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l00/BfvMDKMnOviHXXN65t4L4DXrFaQ1JH0cI5u67SZCel2p1ZivXROGITWFWBWH2R2xO3kD1uAGmOIXE+o/HFOhCJOA23TXMj9YpNS11dSeyjlFUkw5K/QyOrF+JB1H0fFCbWu2dg4V39F3TP/XVrrzrStoFsIVwtYWpJSWHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwL5cd2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwL5cd2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786398160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8hpE9nsljlM6tmO4jy65/s0BrzX0SxrerfQOPk9V8zg=;
	b=YwL5cd2+Td4Rt93hc0Sc8ftnERImiJOpXFxxOlzeKKYrYAaFv/pflaQBYsS3fd8CFvwkWv
	B+hgG/v5uBCevUe9CJRo1WDjLPMfTeAw6yXHC645YCorEN3n2YlIxrzjd3+xo5p4XIZWg/
	BWN8G1uqCG6KWhia6kpll213tTTrEPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-BdErWUc-PxWfTsjLJj65gw-1; Mon, 10 Aug 2026 17:42:39 -0400
X-MC-Unique: BdErWUc-PxWfTsjLJj65gw-1
X-Mimecast-MFC-AGG-ID: BdErWUc-PxWfTsjLJj65gw_1786398158
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47fecbb7f88so1608825f8f.0
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 14:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786398158; x=1787002958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hpE9nsljlM6tmO4jy65/s0BrzX0SxrerfQOPk9V8zg=;
        b=FcM7WWkNVuCjLvWx2rTheuSLtqwwMcJ+xK7r2ZcWc4/UEPFMekFv1AMwzcsnzH6zFU
         Y/FlrQNp8loPcK7Y1nVhirkuoFJTbuCtJp7TWno7EFkrZOZtnW6Wuht9R7Zq0TD29L9K
         qK5s/+b2eZWLe0mT7P6AR+5HMn1+utBcGkhbvqHilJ+PVxwhf+0/xuqSgs+Scnwyq6Qk
         2JSEMltVumYkekZ38maZs2M/ZRAV4vALY9eWyTznN0F7yt2o8IORZ5U0yqRAUWNbjya1
         yc9ex2wVxS0/iEMjAQ0H9IvGzoqnWug8w+pYrbb1UPLGUetBewKjDut/6i8/ex+A/6dg
         f6rQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/k9Hu5GCq7UfRngXUOrwTRkqInRszyhwyhkzDtNnoP7NXkLb+dxOQ3xIOQjlVqXNVYJsaRW1Mhqe94s6odQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKM/Z8RaN42nM5N61h919xxw5YG8UUi++zbilJGvg1ucqn8VNM
	yGnFbFx/1sndfCYIBrTDNdLSnQ6iOmc5v0GRGklaypL67IcHTyKTralI40C+Mcdo8OsCY8Hru8s
	C0p/5gzELasntPx7CAL9tchUFpstdgwooiOnHvLcf5fYyn2QONgHflFd7U7ErMxVpEtu0
X-Gm-Gg: AR+sD11bOV0Is2yFwDzqbCLbm7kZqbxM8JSG9Uxek4AEweXTcCu0k4NlT5ywCCnK1aY
	6ELgZAY8QTABnbvICX+m5eQ3e9x0QPOk6GYIi1mWjNiS2XLbO96eDM+CmwH3OEGEgDLqisdVd58
	0uQddzmAATKSzLIspimwUkRWkdhWs6Nt0ZWWeECbjFGvH8Fp7zE6SLMWunhxnPeOtGv/yhQIznT
	BvFI2+PimfHOZzt8d2BAIxkvnJOxclAKl/dszpwGxy8wpalBtUwwqEN20/4whBpQw9Cee756znk
	vmXYldwpNwqbSBUEdxEEkQAcZx+Vs4mq8nPqb8GYRzpvYgFx+TmYTpuW5vHv/VRNuwb5FnN0eyT
	39nRup18joWMvkUG/+4DzsQ==
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-49961b8a027mr260735415e9.15.1786398157977;
        Mon, 10 Aug 2026 14:42:37 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-49961b8a027mr260735045e9.15.1786398157508;
        Mon, 10 Aug 2026 14:42:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49974170572sm17781805e9.15.2026.08.10.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:42:36 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:42:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
	David Airlie <airlied@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC PATCH 00/12] virtio: support devices that own their
 virtqueue memory
Message-ID: <20260810162924-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260810021450-mutt-send-email-mst@kernel.org>
 <c56fb4d0-33ef-4e9b-ac18-ac4e896957cd@amazon.com>
 <20260810035246-mutt-send-email-mst@kernel.org>
 <bdcec878-d627-4d0f-a97c-35e596363b20@amazon.de>
 <21714074-dc1e-4ef3-a515-6602bd19f055@amazon.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <21714074-dc1e-4ef3-a515-6602bd19f055@amazon.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R5JRJgwCELcOmTimarSqbF3-SX6W4hrMLWmB2npuh3A_1786398158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2026 at 07:14:09PM +0000, Graf (AWS), Alexander wrote:
> Maybe I'm missing the real point you're trying to make? :)

At least one point is not to have text like "intepret every address as
an offset" in the spec and actually make it an address.

