Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726567765F
	for <virtualization@lists.linux.dev>; Tue, 12 Dec 2023 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGy6emSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702397711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
	b=KGy6emSc00pX9sJ2phYhKEdBOgZjMZiA6yQZUlQQBw5QI65s9qzKSy0EXe/2f2ROWDbzfA
	/OubCJDr+Zcl6Iw1nldlVbo1BTdfhBhoK7HOYPlOvJW/1GTYnj2rdZQAx324zpjwE85pjB
	Xgzzt4T5A3naPCezoPz8s7S30H5aLQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-vtxq8MZaPOGLBPuzVcoV_Q-1; Tue, 12 Dec 2023 11:15:07 -0500
X-MC-Unique: vtxq8MZaPOGLBPuzVcoV_Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso28676965e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 Dec 2023 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397706; x=1703002506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
        b=HlY0hpiUlkezgUw3vBRUlw2JPDhT0QyOS1chpHMfWzGsoAgMRIwUaLS351P3o0Dap1
         BDiZmbstG5ozFhY93gkgXgFyegqp0DkUj/QJfS1NMueHZuiwXWt2bSBzjsWjSM71rEx1
         /pQeY830qMo/ndMToXF13lAnIFacTRqdH+J5Og65S/SrBlr1aF5olWoi3XQdheaRnrMJ
         c3Nrm8ski+eQS7vvaKuYl6qr+X1C8gxlMG5nwLKElmFlcdzOiFXmJjp3UmoKslkja0gC
         yUVol5LCb+T7NuVi4KXuQ/fOVF3RwmfNV0mEp+665WkUGF6KdKoiS1OuaT8qSHy8TuIw
         lpWA==
X-Gm-Message-State: AOJu0YyXNAUWVvzDmYl024BNSm8DtmclUEOisroi+2gXcRxC79F4x3Iw
	tIFYFd/Qoxo2K5/CkT41RAIWB74Lbte0kGrTr47DM+K6sn8Qy2IA3gBcR5/xWF88J84eOH9B1PK
	bxo/Eg09xLBxB8JhnwSPmPQSc2gs=
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106313wmq.141.1702397706199;
        Tue, 12 Dec 2023 08:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfYaO9aerEATODsvvXvfPwf/DmeS9S4RdZVSfiTQn3TL+p+4u6edQ/gY6/zAQL0WCJWMCW2A==
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106296wmq.141.1702397705901;
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004053e9276easm19320264wmb.32.2023.12.12.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Date: Tue, 12 Dec 2023 11:15:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tobias Huschle <huschle@linux.ibm.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231212111433-mutt-send-email-mst@kernel.org>
References: <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > > > Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?
> > >
> > > Or a dirty hack like cond_resched() in translate_desc().
> >
> > what do you mean, exactly?
> 
> Ideally it should not matter, but Tobias said there's an unexpectedly
> long time spent on translate_desc() which may indicate that the
> might_sleep() or other doesn't work for some reason.
> 
> Thanks

You mean for debugging, add it with a patch to see what this does?

Sure - can you post the debugging patch pls?

> >
> > --
> > MST
> >

