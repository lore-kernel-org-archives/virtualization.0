Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA626CE25
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804175; cv=none; b=cxHfvl5oummhsYJvcWrFj20mtcFakT6/hdN/0NfSRyNII8O9DxBt36OZmYudOBWnJX+bap6yoiMZ5ykTuD8j0ADUDL3E9js+JNMbtDiioo0Md6iOJK7AE71VNJoSVrdFSIWlwy6l6HryTsmUet+6rqJA70k6lPd++NOthxI8fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804175; c=relaxed/simple;
	bh=MLjTuwCMQTqAvkc7xk3CzVDtNqMNpEP7Sj14iJtFNPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjOn4+Err1y2hHv77MHe5oEYXIp6a1/XlrauM1cwVqzuZexZzRG8SNPQshdDkN4DI7xUPnm6qF/eNbHW3z1OaHaNbDXj81oIwRyg46e+DgZGch5F4n3DVjVh/gwqdLDspd9QuyD57BkW8pngm55lOgWubZ5361y4HZ2cVHT/Cbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF2CCxfb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF2CCxfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768804172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+/7LgZOF3kRzpx8olX8BSkCcZF5blRFi3kf8Nbc2Yo=;
	b=RF2CCxfb9gROA1Pxhec1E0fasazFllzyD4lcI3N3UmJnmmT3QHyX9OVgrzciGYW6THdHd2
	JM5ptnGGbyQ18xEd42SYg1tBDmH+2RL8kr0reR32lHDHlOxCY7B8Ob2uA5urrHUIVnz0OP
	xM/3bOW2qieKFPP5hLLXH0FmtV8fKAs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jObdFEMGOD2YTm4HDKqINg-1; Mon, 19 Jan 2026 01:29:30 -0500
X-MC-Unique: jObdFEMGOD2YTm4HDKqINg-1
X-Mimecast-MFC-AGG-ID: jObdFEMGOD2YTm4HDKqINg_1768804170
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c213419f5so2551795a91.2
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 22:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804170; x=1769408970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+/7LgZOF3kRzpx8olX8BSkCcZF5blRFi3kf8Nbc2Yo=;
        b=aYrhYBaVGrzl3QoW7fpopcAbZ6xOjftj75kJIeHmNGNbGnyja2LqjstXPAeSf6kZLB
         s2YIuzKGKct6d3Z93QLO9vZSyycl7HT443Z5V/UM9vjL6SlXoPO6gBtFzHa6AnPOIASR
         WUsP2XpOthzuisJYAJBFP0EF91+ucM3/MMWCiugrCSGZQWQIKGAxMpg3xDXG46SiJe86
         sP4t7VEzzh46EHozyILnxjHom5mngsn5mxmWl9HRTuvV0rzPkhC81hy7X4cuaEhlH3Ps
         81QMa8KejMCGEgKOJRxIZ4Gx+Cqts3l38okqpq5Lt6eOoFai0jy6WUmxcEz9LAzh4gjq
         twBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz+bKL+pIWQgbRZ4t4dCVHfgzRaa7bSxn8KDV+Rngjp87xlebysYLLoSdaBrenia2S9A5WahQP7eir2IJ8RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+l5bbIuU1T+QVzL6chcJ41l2iU8AHbga+BhBn6LCbLvh/3STm
	JAXaaN25hWnrexjxwfX7tqCYPHqiRyWpSgQjA+2q0yDghgOGfOjmWYl/PRTp6DWxW2bqyrw5vCq
	ZoPqoiXn1rb7sUQvEma37UlHb580J7HWXOE9uFKQtKkk78KPT7QCSIDQyQDN554AHavrC5vNtn4
	HuVVRx4VqBzQWoPhOuY9/rIkQwN0YGx6vxgRSlvg76d2g=
X-Gm-Gg: AZuq6aKvXEES77I4+zT7GNA4wYlnea4bS+lJAPns+LVjZcpgzXuOxRJ++JDlKfoq4sT
	RgBewAJ6auxjedrx8P7oxPfr7pVuVHB+/UZC4P0GZsC26aM0h5PLZob7U5cThXf1WXlD6AXRNag
	n4ScG223OtNu3ukWlA/CIUVNmV8MUrmX5pWW6gpDqhYM4fLf9UjXkJatDw9aTo+77Smok=
X-Received: by 2002:a17:90b:51cd:b0:340:d06d:ea73 with SMTP id 98e67ed59e1d1-35272f725b6mr8387952a91.19.1768804169847;
        Sun, 18 Jan 2026 22:29:29 -0800 (PST)
X-Received: by 2002:a17:90b:51cd:b0:340:d06d:ea73 with SMTP id
 98e67ed59e1d1-35272f725b6mr8387940a91.19.1768804169466; Sun, 18 Jan 2026
 22:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-2-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 14:29:17 +0800
X-Gm-Features: AZwV_QhZ87_YhYcy6Nl12ap3zPOnCqqdSfTymkO0Oyf3N0U9ya9V2LVuA2XcA8o
Message-ID: <CACGkMEs-hw0N4G=4gAWghD+JEEnb6ex+1ML0i_AzfbZvK0M8AA@mail.gmail.com>
Subject: Re: [PATCH v14 01/13] vhost: move vdpa group bound check to vhost_vdpa
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vqNdY6c-LgqgYv8BXL-ODbep-OmOO2SkIduXy9BXVJ0_1768804170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Remove duplication by consolidating these here.  This reduces the
> posibility of a parent driver missing them.
>
> While we're at it, fix a bug in vdpa_sim where a valid ASID can be
> assigned to a group equal to ngroups, causing an out of bound write.
>
> Cc: stable@vger.kernel.org
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v12: Add Fixes tag (MST).
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

