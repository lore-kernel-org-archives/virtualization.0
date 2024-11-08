Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45F5FEE4
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 02:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034447; cv=none; b=NAK7VwxenHWJ4Flbz4z9OI9akAcXMLkCxN+fkr7dg1qCZ9xE6Pz/khbCga9b6jIee7//Sb5lIPe01wfAmIEK189jehXXJZ0yp/A09MCUZQ3J/Yh5HO4+XeC6Rb8iYi3wBjZTJ6LGAMjulkA6H8j1fMRjATYACT+kerU3ax5Sj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034447; c=relaxed/simple;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehXs0UOedDixTn3z46v+GjFiGl1yLml8VB5SRGLG+KBhaTortSFA8QvkaiN9scJ5+nklRr4Gzz6PT+n+1J/vxh54iIVJDIKBy3ZyRkNme6pj3xnVHKv/Ptp37M6esuAQ4K+HWE2rOSnaqJjdx9gJMcBXnO2oW9RKIr8RxHkPCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5zLAl4p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5zLAl4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731034445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
	b=P5zLAl4p1pt6TdjiAB6dy/I0NIRN1vseNHZjHmSEU/MmKlGIm9ruKVglUb5hzS929MGolb
	nVVvW2hOsINxz86ewT4ElhVFH3vaKjUJb7LTkzgCGz5upsQJuLLbxUVNfcW6JBJ6ykMn4t
	6OYVk+wmjmpejoFlGAJq7rEYJ286fHE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-2DXASoYMMoqFbkOZqjbI6A-1; Thu, 07 Nov 2024 21:54:03 -0500
X-MC-Unique: 2DXASoYMMoqFbkOZqjbI6A-1
X-Mimecast-MFC-AGG-ID: 2DXASoYMMoqFbkOZqjbI6A
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e5c75bee71so1907315a91.0
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 18:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034441; x=1731639241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwEqbnHj/TJxnIy+3o2VhKgoUs8GcxvB6wBbbqhMWAU=;
        b=u9FrtrQ/wSzJOWkXF5SXgRwEBcBF9Pw9Wd2sHabMUWkXrtwE8xRg68RvDiSC8fddV/
         RuEg+cAkvxxlbW6OGjJZAmGj+aYbL1FDOOk/7WBZ1+ZVGl5V0v1ZDSbkHI9cPWf60DhC
         Dbf5y+zhXSiXM5HPsGHzolqD/ldaG1KP7SPaGw8gZ40w/BiD9IEwgRTHvQsodbceJGK0
         TOqZG03yYfKBZYLUrKbtHrNKcRuqeEEYRMRbdf2PWwEy9YXEkO3mvIUt0xa8zTgAqxaL
         CjpFR+Lgy7OFSMXv4pNdaUYJMyq46dv6Sk4q1hN2a9WxWMPmJT1xaTwzPqXwPlNIRHkq
         CM0w==
X-Forwarded-Encrypted: i=1; AJvYcCVemmL37qF0DR5dgBGWAUmDR2JzZznHH96sJZvtG/6TJe7cDP5FIsCyeC93mQkXzH4hhovAHxhd4EQpqVCB/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWDgBpr1/9J9zeb3uQw28VfvRX6rx3R6rxnyyJIz4uA1JYDXDX
	oOyYXfI1BHEdELq2J+jXZa1YBeDrAgL4XMNHB/BmcErR3WVfTmu62Frx6OIucFE8FfqyusdQX7w
	jCSw8WcO0RshDiPpoNOuJzISKafUw7dWaZumg3N4c0DX/jwrEpZXZtzhyn3DEjNvifm1vR+71jy
	aucHUVLWdB1thVYSA6MWy1mJxI0qc9F5wdb9zQhB0=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id 98e67ed59e1d1-2e9b177632bmr1984145a91.28.1731034441391;
        Thu, 07 Nov 2024 18:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeAKu6FXOO8aouj3/WFxZQgxhtW8ocCUmDNXhuRcpuePvBO35pclspRsjXFn6dE+pdWYMrEjjMCT0rnXoNyZM=
X-Received: by 2002:a17:90b:3d91:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e9b177632bmr1984080a91.28.1731034440508; Thu, 07 Nov 2024
 18:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
 <20241101015101.98111-1-qiang4.zhang@linux.intel.com> <CACGkMEtvrBRd8BaeUiR6bm1xVX4KUGa83s03tPWPHB2U0mYfLA@mail.gmail.com>
 <20241106042828-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106042828-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Nov 2024 10:53:49 +0800
Message-ID: <CACGkMEv4eq9Ej2d2vKp0S8UdTgf4tjXJ_SAtfZmKxQ3iPxfEOg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: only reset device and restore status if needed
 in device resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qiang4.zhang@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Qiang Zhang <qiang4.zhang@intel.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ede_v_xVcG1zB-iR3AyaDldGHv0xI9jqgfTmxLP9rEk_1731034441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Nov 01, 2024 at 10:11:11AM +0800, Jason Wang wrote:
> > On Fri, Nov 1, 2024 at 9:54=E2=80=AFAM <qiang4.zhang@linux.intel.com> w=
rote:
> > >
> > > From: Qiang Zhang <qiang4.zhang@intel.com>
> > >
> > > Virtio core unconditionally reset and restore status for all virtio
> > > devices before calling restore method. This breaks some virtio driver=
s
> > > which don't need to do anything in suspend and resume because they
> > > just want to keep device state retained.
> >
> > The challenge is how can driver know device doesn't need rest.
>
> I actually don't remember why do we do reset on restore. Do you?
>

Because the driver doesn't know if the device can keep its state, so
it chooses to start from that.

Thanks

