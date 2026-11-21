Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795261146;
	b=lIZO2vz60ifP7/VD6zeudznpFnbnllDOJDHyFuDkylZmSSIhhow5nr36H4ncHvdY9VXS
	 kz3FP61Gy4cC5olVtkj0C7FImMTxgv1a8U1EVVBwSQtsefwe5LEiLcjI6iegF3WIr2XZP
	 jJ2cOuOpvab9TehU81SJPoK5fCjajUdfAAiRbQNfizGM3S4s/1p17IR40pqBg57yxGBQ+
	 jHK+Dk6FnPWW5ay19VyhFQ/xYPyGecOge7j1+leuCA5ecADe6FMh+4znBZXihfioS1rz6
	 IWH+2Mcir3Hcomqj6oC+mfoD/O1OiIarGgFu2lApYWxuRduHdHaMUxEofmUJ7rYAMDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261146;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=teMH6S7EaqFQYM4oDuVXXitgWf9SxZUq56tJupIshRg=;
	b=RmYi4xFb/v6lFBvjUZP3ZDdcUIChBdK/vR8UcRXhhovfl7+C4vj9OiYMyiUtwOCFWHz8
	 RnyXXgdcsasi13ATBgU0Pq44Kka/EgAE1mrWAyjPnpzoFP9l4ec1wenxkzq1ENvYg5mCD
	 nka/2mMKWSiOR1g35Dc37YODpphra70RFE3lCPr7oMr6sb0XmN9QiCuUa0uRAEUlf7sR1
	 Zl3POvXg4oHpadUR4VSDBxV+TH/uDkRE547pY10PHlBC0/jiwkbGfVjbSfnHNDQNyckEy
	 DagyUt9PUHa5YX9FhCK5BzaQk02zVKcGaQL8WqaI5sVgDueyp4wUabb3e+HNZLQxhwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1SREw11;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C765606A325
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C765606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h1SREw11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795261145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teMH6S7EaqFQYM4oDuVXXitgWf9SxZUq56tJupIshRg=;
	b=h1SREw11lMWWZ0CBLh95248ovAN5don5/8zO25x1wDQoJosldf4HgUyh8OBdlmQTpZFPiw
	vW518q8rC8UY1dCa4o4OaaAaQaP922izij/Q7o5141sauJFMbmOh01+G2dBXAj6TlexcLd
	8LfHA8uxRsQgJUTLcGvQYVV+/lxG/Ec=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-fGVdDNqQPiurAQmNHDCYqQ-1; Sat, 21 Nov 2026 11:39:02 +0000
X-MC-Unique: fGVdDNqQPiurAQmNHDCYqQ-1
X-Mimecast-MFC-AGG-ID: fGVdDNqQPiurAQmNHDCYqQ_1795261142
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so13561275e9.0
        for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795261142; x=1795865942;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teMH6S7EaqFQYM4oDuVXXitgWf9SxZUq56tJupIshRg=;
        b=BDANfxhBcD3r6NkFbcCUP5B2Igcq1dYfSRCXE/uLIbaAKtnhzrE9d0vmqXxfe7/Bbj
         0nfJRvW9h9Sy8sTX7TxJSff+pQc6UAYB2Bh/Pv4oflmMKqhMkSeK5uU3eKhqgPIWjiT0
         g6OUcdX0WVaJbhNo3fCcojG5vIBjqj5KHWUdLkw11rAvhaqRQPpqW7+8Lqyv7HRBEQgz
         If7q8vcD2QFwISbZcJwOKZptB6DE47/FlBnVytmLfLLKk9ygL1oBVFogC1ybH+yH3gha
         bq7F5fh6TYGGkEkyXmf0O668ih3m6YCMZHYOg/8kS7jO89OtijKzEjhW7Do6V68JgtWd
         wvWw==
X-Forwarded-Encrypted: i=1; AL+hErEugTXQjMt210Mlq+Sg4gbXaFmbD1jg3teRZ+U1ISBX+7bUmecrHN+I52KJgQH8F/wJIU/fKSGxbSLKTFou/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7DXFiOuALcHpyAMfSA1gHuI34IFoZ7wr7/xfAnAKN3HZmm0cJ
	lydboIyERWGsA1xwmloWuLRAv2SCvZZPRIjSH7cC14RbdqqqcfDqsAI3wbQaORKkZTsGCmER4iz
	8R0yr5eSKbhJC0S6GkG604r4dZeQpD+BOII105xBRvGKxMmmgZNPT6JNhQANO9Zr3kdNT7PoMzx
	Kt
X-Gm-Gg: AZFdTZf0Dp5a+rBRcOn1Gv2esCXYop2M8vfaKO4WMFhs5fm04e7TR10QhMQVUStsAYy
	RX1EggpecXQnZK+mRxYEB13eIACfiQLQdI5X//q7LQJ/GgU98CG1wzdX4rrVV1s1kpFC/EVy92p
	m2FNHnL24YIlISqLKUq5BtECKSYfqZRyXFyj9WYLITVfuVYwQGX5WClrxU0ytNBs0uuAZMXqr4i
	WmapCbJRHOotuNMiZQJQxlTClQSoo7CZNEvKGn4kLzWRw83DwzpZwNMx7elzal0xYGJ3FHuCxW9
	0wIKUOJUC8r7HF/bV4vW88+YgLECix7cVR6KdeaRt88YrWmwy4v+7xuyXTPdMJSlSTN0CgDsAYR
	hojUHo/PO81MC11HOhEYOr6xGkrQoX1heCTDKnrNZ6big
X-Received: by 2002:a05:600c:6749:b0:4bb:8508:7fb3 with SMTP id 5b1f17b1804b1-4bb8881c3b3mr126399765e9.11.1795261141519;
        Sat, 21 Nov 2026 03:39:01 -0800 (PST)
X-Received: by 2002:a05:600c:6749:b0:4bb:8508:7fb3 with SMTP id 5b1f17b1804b1-4bb8881c3b3mr126399535e9.11.1795261140981;
        Sat, 21 Nov 2026 03:39:00 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm334176335e9.4.2026.11.21.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:39:00 -0800 (PST)
Date: Sat, 21 Nov 2026 06:38:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, vlad.wing@gmail.com,
	brett.creeley@amd.com, eperezma@redhat.com, jasowangio@gmail.com,
	jkkm@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	joao.m.martins@oracle.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
Message-ID: <20261121063742-mutt-send-email-mst@kernel.org>
References: <20261109184253.531677-1-vlad.wing@gmail.com>
 <20261119200654.1048266-1-vlad.wing@gmail.com>
 <20261119181557-mutt-send-email-mst@kernel.org>
 <20261120171435.83458-1-jonah.palmer@oracle.com>
 <20261120123500-mutt-send-email-mst@kernel.org>
 <b8ff5bab-d08f-42b8-9c88-e4665ea3078c@oracle.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <b8ff5bab-d08f-42b8-9c88-e4665ea3078c@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qHjEyfxP6rbLc_rSiicsGvrCfS6ensoStzjLczp6J0_1795261142
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 08:35:12PM -0800, Si-Wei Liu wrote:
> 
> 
> On 11/20/2026 9:35 AM, Michael S. Tsirkin wrote:
> > ZjQcmQRYFpfptBannerEnd
> > On Fri, Nov 20, 2026 at 12:14:35PM -0500, Jonah Palmer wrote:
> > > On November 19, 2026 at 6:16 PM EST, Michael S. Tsirkin wrote:
> > > > it's in my tree.
> > > > Hi Vlad, Michael.
> > > > I've been looking into this issue extensively. The proposed 48-bit
> > limit
> > > is a suitable conservative workaround. My virtio-net testing for this
> > > issue shows that a 51-bit DMA mask also avoids the mentioned issue.
> > 
> > Do u want 51 bit then maybe? x8 memory with no BB?
> 
> 51 should be fine for now, but it's not the final expected limit. We just
> wanted to inform you that this is subject to change, once we have firmware
> issue fixed. Maybe you could wait until the FW fix is cooked? It'll be a
> short while but we will let you know asap.
> 
> -Siwei

Makes sense. If we can get by without kernel patches, that's best.

> > 
> > > Full 52-bit DMA mask support is planned. We will revisit the driver's
> > > DMA mask once the firmware has been updated.
> > > > Thanks,
> > > Jonah
> > 

