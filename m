Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B0176ADB
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804342; cv=none; b=WepufdnpOViX0cBoCipzopY1pqPD/mevC66W9VAqBrryl16b8/+sQ4wBfEge3barSvUlqiusSOx35lNicbvOXQJnCLJEobS+Z1C7ix62NRmGWGoOOOR4SxB/2SfmKuK2LRUrXf2sW3q+NIOLBP9SjXaboPuqPZcJXZJyJ5mgTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804342; c=relaxed/simple;
	bh=Bd0wdlJgOoLY2UugowTpw6GvesFjETEHYAq7bu16OVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uutwT0T7RVLuBGBUn79hGNWQRCvKoVFrhPzSYaiE/v2sxgSeEoK8/RxDPQHQ4F0nHHagb9BlC7us2I7P1klW4X4LDyLcEVmfKuTd6Vl7tP10c0vIxGzqAxJvkQLqhp5ENkR5RlSef5ZvR04HPItbluIcEPKXbIXYvuG1NnMwb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek863kBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek863kBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752804339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bd0wdlJgOoLY2UugowTpw6GvesFjETEHYAq7bu16OVI=;
	b=Ek863kBKPsdNzchyJhrgmpA41mmXY98JUPQTKgHVsEKXZzoAYvkIeAn09Q1CWBe4zlu2rN
	AGxsM+/gBqHnA63v2pDHlJ8306mQ5Kyw54ES6bpLKhWWwQNjirmAaHigT7ArlBG0FyT2LN
	EnxXPWFR7HxfW75VLtu2Rzf89j5tMBA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-xjKYys41M-Kfobht4df95Q-1; Thu, 17 Jul 2025 22:05:38 -0400
X-MC-Unique: xjKYys41M-Kfobht4df95Q-1
X-Mimecast-MFC-AGG-ID: xjKYys41M-Kfobht4df95Q_1752804337
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1654263a91.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 19:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804337; x=1753409137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bd0wdlJgOoLY2UugowTpw6GvesFjETEHYAq7bu16OVI=;
        b=D0V4tKTnb1ZIdfVtLzKDx0wmJ8Hd183XiGxBVxDXLoI75o/RKuDwYgwqVt1ZYAjrhP
         t2EvgBLpjY/J/7Xnd6pqeYmNajxOEwlRqJOgXw4DJ91N8Jc60YugtEyWvsHIuaziE2ps
         0yZtH8s0pNrpKL9VCwa07kz5sL64VtOMhIRvd2RE6Rj24fMRqYjnu+xhQGfzfQvgGCHX
         TKYUMhu0wWpeIycwxtvf4ciCi20YVuXaBf3Qk/GV6EBgyOKoqzApleCLUuu/AQveahEp
         fj2zVSTFRC+ofVykplL41ttpkAiZbL6sA8AL9iz9ZLVXkr+PSCioT7XY8viHctl4A5Ny
         SSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHCziFzx/zI+1U6hEbLpNcukeyEGcxu2jNGbzxj8+aFVykQfQwwyH0CDalO4PlwfTapXXsTMc/icIfQgNpjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM6LbMYdULF7E1zHG3ZI9F3P1KMQjic8GTu8WLrcwZ2gCbtpcp
	xw3BKQ+uUeX9UmFjPR63eOLkZb6V8mb3Rkl6mr0k3VJFuORHcwcem/Q3dKfu77XYHeevw/6F1y3
	GNnlzmviKqyxzS9va/Z65bkZXgWQcR+nfNif49FMGkUBXtaAjJtNl7bslFwJee3e82ZwI6n4/Fu
	z1QbBXtYSGzt15eDxF+JqBWwHkLuytkPDLrEJUjPv0UA8=
X-Gm-Gg: ASbGncvgOA48i6qSVPVz2NJ3WlSaX62z7SVg0JvthTlkBwJFo/vedDLFX+n151HwzML
	YebPCX+pXwL1kCBMcTetz9Q/1zptiXCm1Ovg1s+hIkgie1BHBWwGMr7lvVKL447yw2VFAKJ5f7j
	d/799A1K3cqLw/+vo/ALqh
X-Received: by 2002:a17:90b:3fcb:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-31cc03c0030mr2724552a91.3.1752804337113;
        Thu, 17 Jul 2025 19:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHaijQUdcISZJ2+gWmUAgo3CQ1cCzKs7uJdhigowLjVS7M8Iczb9Ict0y3nQd+PJiuTwb/IJgrc2cyo28QGi8=
X-Received: by 2002:a17:90b:3fcb:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-31cc03c0030mr2724519a91.3.1752804336677; Thu, 17 Jul 2025
 19:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717080237.6518-1-jasowang@redhat.com> <aHj56eMSTxR6wZBi@infradead.org>
In-Reply-To: <aHj56eMSTxR6wZBi@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 10:05:25 +0800
X-Gm-Features: Ac12FXyWu9rHO94LiRZIj9HDexjVWSPCRlkfsJ9VM5xttryZ6MIvr_ZYVJUd4ho
Message-ID: <CACGkMEtXKp4xCreKSU=MEt9dbUs3V1jQrBXseM1JW0taQHQuXw@mail.gmail.com>
Subject: Re: [PATCH V2 0/9] Refine virtio mapping API
To: Christoph Hellwig <hch@infradead.org>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7k8T4NZQgaTtrYU38XqZadTGme0qoOb-Vuvsi19Ji_o_1752804337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:33=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jul 17, 2025 at 04:02:28PM +0800, Jason Wang wrote:
> > From: root <root@dell-per760-18.lab.eng.pek2.redhat.com>
>
> This looks wrong, and will give really odd author info when committed.
>

My bad, let me fix this.

> Except for that and the Kconfig nitpick on the last patch the series
> looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Thanks

