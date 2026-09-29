Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C74F96DC
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675260; cv=none; b=bXkjE/zNgpnBJ9odCKnwvLJELDmEZ9Gji2kzCjn840qSwzbNBcLbrMaomAe/gvZAfVFqprm5g4BJulwrO6Q2xYMJ+jfXhu5lRxCHRb6bAsT+K/J5ZgYvZ3FpFGKvaA2IdEDBlLYwMs46q04e/71bS0Hovi8nHfNvEpmBlOt7/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675260; c=relaxed/simple;
	bh=Mt7SZomNurAHm5m1aCwHi4vxh82+wXlBKSPbJLJjhHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PjLspFsVowiLqo/zLP/LS09OYAt82cmsJ3lvVCR9Thz3v91UhGcJAsrC/6LT6nWPWO619Gl8XiPuHY3Z2qy8zI4vI9DO+RVdVNs1qiqZxNyNq2tifAt4tFnlFqGKQ+Yg+DWUol2DDXylstoY0lwy6hWWmuP0NdmB/0SKUQqe7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9GTP+Ab; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9GTP+Ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790675257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MAC6JZiAmxnJ/+3CjxUF3FBsOOD+FRcLr0XHqXCFJg=;
	b=e9GTP+Ab625T7/Fikd9HOipq2B7y85H4haYRUw4T6iZrrPYGmOLykDJMpidjrwndNU0dg9
	qVXaOVpw2LRu2LgdWJ3g+w/MdRKPSp97ZMoTWC/bl2bzp9C5TXPZqR7v9Hha65bkpsVkD5
	J3aMHo3ymh9b/N6V9dfx0ao6uFOEuZY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-RYA4itjBOI-S3xWa5iNDnA-1; Tue, 29 Sep 2026 05:47:35 -0400
X-MC-Unique: RYA4itjBOI-S3xWa5iNDnA-1
X-Mimecast-MFC-AGG-ID: RYA4itjBOI-S3xWa5iNDnA_1790675255
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6422198fso25970855e9.1
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675255; x=1791280055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MAC6JZiAmxnJ/+3CjxUF3FBsOOD+FRcLr0XHqXCFJg=;
        b=lxe70Sz/buF0InqocggceqH2J0Z1ikNmyzT5yGWZ9WfnKQGOMGIDxR3g9wq3niuUCQ
         dyWvQZILPXCDx0PPkUzl+SgOvzX5xph3uDFBaQW6W694tMLRqioPMlVIklu/YpPf/Oba
         GAHc9OOgI8Q4bnTgT9XQta7w+KGtvQ57hoOMlQegPlOqeo75bZ3EGWxrt5TaRJcQsw6Y
         /hZY/7j97b4c/DSNwBp5Wk/TIMzOz+AFnbd+NE+fTA0SuuiEAQ58osCwzJCfIbBs/nHG
         8iJCY8CP/osmLDwAMcO8rKhuRlQRVMT+XhBsnmol4ZPQtzjwl0NavCNxwswY8pBF++oX
         qvrQ==
X-Forwarded-Encrypted: i=1; AKwUvByJWDFvWmNIrfmDRk4trYi/Eq3toxg2Uz2Pw6stIY7cp8h2Eyn3x/en9B9da5m5keHIuP0fMiVEVCWz1tedFg==@lists.linux.dev
X-Gm-Message-State: AFuF++nc0jKhA9uXnF8So/7tMVkk2EMgik/UzNagX6Au/9JDmXKvhsVh
	ozHRLsOSq1TjZkQwY6UWK1CRW7eA7wxqX11eKwVMQ1nUcpbO3PaXZtkGgyM8z46+LXGBZMr3hxc
	CTlsFrtI4tSC5gmNqDSop6XO799ESPtG3/FW4Qyamhyc5HDgA1xD4whh/SuucqJQkf8+t
X-Gm-Gg: AYBFou1q2Q3OJ507GobhOlrfzxfq5VqSpOosRa8xEUftBZ/HglVsY9rREqV6I7cksKh
	w68Img9+zGRH/w4k1igDGJThCYIK/NbodDGcYLas7kfZ0fil/2NOqDWFmvCtxWdILeOMm/9WnMb
	Z0DWR6c+57jlRnxVvRss1jmPNO4+p7Vg5mV8r1uQL1kPlqL2jyGj2KbXiQPWXRSCCEpQDKXAGlD
	iC7k8JGPZ8lVxMrXExNbOdu+K1hC8YIKr2LbppgpnPegyCcRuAk2pEBquxjwYeijWDcc/oIdMR4
	UmeloPJUKKgOSV8APyXxW7gLGLZXVGaFxE25JwsF6DVKP4AraIlw+zy5LRC2DhnOSS5sgQ==
X-Received: by 2002:a05:600c:8719:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-49fe66c8a5amr279390595e9.7.1790675254551;
        Tue, 29 Sep 2026 02:47:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:49e:6c11:c4fc with SMTP id 5b1f17b1804b1-49fe66c8a5amr279390185e9.7.1790675254016;
        Tue, 29 Sep 2026 02:47:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm68532735e9.0.2026.09.29.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:47:33 -0700 (PDT)
Date: Tue, 29 Sep 2026 05:47:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
	Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
	Trilok Soni <trilok.soni@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
Message-ID: <20260929054346-mutt-send-email-mst@kernel.org>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: og3hI-GwYkfJjuD9ENmwScJJq6GczfOTbCIz5JX0dtc_1790675255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
> >>
> >>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
> >>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> >>   virtio-comment@lists.linux.dev
> >>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
> >>
> >> This driver has been tested end-to-end against our own userspace
> >> virtio-usb device implementation (host-side backend) in two setups:
> > 
> > Where is that code and why isn't it part of this submission?
> > 
> The backend we used for the testing described above is an internal
> implementation that we're not releasing as part of this submission - it
> integrates with some systems that aren't ready to be public. We
> recognize that limits independent verification of our specific test
> results, and we don't think that's an ideal situation.

Supporting vhost-user with a backend doing pass-through shouldn't be too hard.

-- 
MST

