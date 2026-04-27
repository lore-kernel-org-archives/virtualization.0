Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6575809
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252859; cv=none; b=j1+GIu8IJbpfuopU3D0zDOLupI722RDflM74LouUGF5mfTT3f+swenonDd1RvQgPJcc9Zw1MEU7DA8cYidsD+D8TlG5dnhG80jkf5N89r+SCsIkpMfIabrU9DrjL/fYlCF6anGwvWMppFA6vU2gM0hbcgD6eh5nTFk6ljkeyLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252859; c=relaxed/simple;
	bh=oh51aO2cib4XTCSWrtPjpqnL6BKix0KKyx7jCKBjvQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gb5uqXDs474tQgzfUCOxGbXXU3UkTEc+iAOpnqO8s82gBAQsU+MN+wpdmcOxlxRP3Rjr2lGGxS7YZDepRddVGQqMVLRlUDVN0z1NZVCyB/E9aGBmfFJEwFQGTgYw/yLIT/tN35/lSjsyajObFUtTYfDoucOT7uTIgCSxZY/Od4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EojJ4C38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EojJ4C38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777252857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oh51aO2cib4XTCSWrtPjpqnL6BKix0KKyx7jCKBjvQA=;
	b=EojJ4C38CAZs+YqEKC5yki+YSPn6mhC1h42Ki9aao+3UGOww/tYQuxRDrSYpo85ahgaQGk
	jA9a7jbnlbX4UXeVp1KRqTpck7+GIclsZzeoizb4928p1TNTe9Zrs/eSjtosVjrm3z+OFk
	J2059QHGAsRgAkW16y6sogdRrFrWLoc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-VWVr-k3CPOO46CrBii-iAg-1; Sun, 26 Apr 2026 21:20:56 -0400
X-MC-Unique: VWVr-k3CPOO46CrBii-iAg-1
X-Mimecast-MFC-AGG-ID: VWVr-k3CPOO46CrBii-iAg_1777252855
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so17900087a91.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 18:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777252855; x=1777857655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oh51aO2cib4XTCSWrtPjpqnL6BKix0KKyx7jCKBjvQA=;
        b=f0y6TUp9bfPIZCtPbMMcm9paIAKRzGjXGITuBy7dIqH25WCoFC0M+fJVQe0J9nkx35
         n4sVuk4jGE+m6QGQnj+FJmegVFrlOYPPQEhsCxEPubvp4pPEkMjEF39xsY6jWBH/Qlb9
         Cux2K5kUFYPBmcIbyO6+Y+dMENO27OPwTppwwy7CX8Is/Ze3imEzC162HZvTgqCdEZ4S
         OVL7TU8bAGlPLGn0VPcFz9lk6G0NryzoRLiqQA/GarxG2irdEfK3N+G8Yc8KOR/FmSuK
         olQ75B1Dtygnf5qS0XHP1rfxrzda/YmwbziomQuH9r+GOihV+Sd96Ayx0g4YiI2a7X8c
         aDOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/c8J251svCdfcoFAs3Osf1OlcgVTmuimrg1V2ouwMfE9u9XIM3l4NyezTXsm+fmkl0HcNP0RaMsD5yr73dJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Xi+Sh3khow6UgjP3evgyvwyqxCJgn0zYSzcATUoKHmNPHujZ
	98MErdhHJtIC2xl9UB5NmFwKd+DxusTTzuX0LJhXkir6pXXiUel+zQGotp1qrp/QB3cTBTmNyUh
	PsoUqek6ycZutui7kvbQZ1csx1RnYsXX26HE1ZWzZNUyRdd8jzfq9F3EskCkIbFjOC/j5Wnp98h
	Xw7/h2T9fXm9yIEfgbZER2RpHUVoK5G9nERKMZxGtBb78=
X-Gm-Gg: AeBDieu3IVmDZtByx2XE/ePFKsdsKHT7JbbVW7QnPAvzS/lQQrUL98PLtB8FSvNsogZ
	OAqgtv2uHFNyzswtYOxiJ7EkflqLnG2vP5GReeyHJDQgkMh5yWyzh9/b1hZiMebqNiIDnAPSyOg
	cE+0H2FSvjCdVPMP24Ca+OXe9B3Z/Tese8e+eGQtuZxULhvHDN/XtE5cR7TaCQsKpGWErSd9mBo
	wstpJIiugP0TZ9OMw==
X-Received: by 2002:a17:90a:509:b0:362:e7ea:244e with SMTP id 98e67ed59e1d1-362e7ea261dmr7673194a91.16.1777252855259;
        Sun, 26 Apr 2026 18:20:55 -0700 (PDT)
X-Received: by 2002:a17:90a:509:b0:362:e7ea:244e with SMTP id
 98e67ed59e1d1-362e7ea261dmr7673173a91.16.1777252854778; Sun, 26 Apr 2026
 18:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424104703.2619093-1-johan@kernel.org> <20260424104703.2619093-3-johan@kernel.org>
In-Reply-To: <20260424104703.2619093-3-johan@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Apr 2026 09:20:40 +0800
X-Gm-Features: AQROBzBQHsimRlTPC1OqiraPB4G5aaaONVmv--XnjnSSqh4VXv7kwDPQeUkAHto
Message-ID: <CACGkMEt6A17WNhBGVpLhAOe3zpSHt==sAhXbwL0C0fnayW2oNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa_sim_net: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HMboFQpAw7VrYCAyda4eDVuIvZlMuUv4njAGy98eMXY_1777252855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:47=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
>
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

