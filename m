Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F54155CB3
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361001; cv=none; b=UpEw4Gn8jIawynDK0M+dpNAXVEbEkIE2J59888VHw5gnMn9obKWBc9OS385/kwEVDSsJkN/yHR45IcXjPdqRgvBgGo0rtBm3cqL/J7HVKr1qJG6nGLrzojvoa2555VVu+2rxNztvPfvXIuJ2PUAxaMjlVSlsO/Q82UnYsFxiV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361001; c=relaxed/simple;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjmjUsInTNy22V9kPbDkqAuEspC4gmx+M4toDqSLgEE5UF6XBDKW3NkEcF8Rh8gUTIkP+6aQGRKXEG45rUQrUrJ1AE2NnWLcE14flGlgeh4umy21/aNN1BGp+AVQFQYa89KvGjlMyl43d+sa1458bDhm+nPcDnGZh1vKyImphxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITfsYMlC; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITfsYMlC"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B28338111B
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTE2iqJ2R1HY for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:36:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F045681115
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F045681115
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ITfsYMlC
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F045681115
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740360996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
	b=ITfsYMlCxad7+W6ZUA56k42Iboq9P7Y8/hgEZFbVV1xhbFab547ENrb/BK4S7UdJiXff91
	ONiMNSSLBvd2HEO+3r9Xyl88xfeC5zB5cqFAANOZAf/oE12/mPrRZnQ0jUjPeHGy+yi2Oa
	eBwOm59u4kTdIpQolSIHOI6yqtp1Myk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-DZMzwxQUM76ZwYRWD7LpWQ-1; Sun, 23 Feb 2025 20:36:34 -0500
X-MC-Unique: DZMzwxQUM76ZwYRWD7LpWQ-1
X-Mimecast-MFC-AGG-ID: DZMzwxQUM76ZwYRWD7LpWQ_1740360994
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc261eca15so9499733a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740360993; x=1740965793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xotTqisRghDcxyjI2q2t2iC1Av+pZimZy4YwMWpa64Q=;
        b=EwoFuMycU8hzjKfp6/RAit+oBrKMFo36Yv9H++JT3m+pncnmG4x7W7BHbTdDvQXpuV
         8oBBLwYqH5gAokylFC4WWaAqc3wG/jjfQWARiz6DqczVov5AXg9LnZ2qaGd+ziL4Yued
         Vf0H52Duq3R+bSIQRzYnceCbnRbchjtaC4bQqUiBYx6co1AG2duzzDsAlElyn//5ySkf
         XfbCtcdm+6mn/WK0hQ83eIdGt3zJIJvDSJckK2XwpYGEYau4ZYC76Ml8wg0Xj83BuoLo
         y+w3NVlgnSrmxLzUD+20O27XGAjqiaLgwRHVzK6RZFYi+MIuykLYC56poFj2h1tRWE9t
         Zwdw==
X-Forwarded-Encrypted: i=1; AJvYcCVm9uahdDs8wPWiGKvvVCj6cjsOzxZFvfy7s4B+/Qe+X5i306eICdR87j90d8skBPoprijrqMPrbWAPysaZ+g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyXzW9vMs88QHGG8kGaaf+Lrym3KSVGfcQveVRrZPce9ffA18IE
	Wr0QeTvo7tn5AqVHY/n6h2iDzIWZgehOnPmSXDOpdA2qYB0WqCX/A3WDsUXEm7YgVywXbfGgd3v
	i/N947L9PinSZKn0h/FDYqoK3WZVPAl4TRd2xDQqrqNUKVKkCtTDjFzSyWtmTguOGQFeH2mlbNM
	C5xgsN03EzH2aguiLXDSuay9lAjwsJG3gxAtddNE9MRQGn0arA0JLqNQ==
X-Gm-Gg: ASbGncud16v/mq1IwAZwpRHZWI26fJm3ndfUHwbWqTnkhu8UCtqKCRH7tzetq2nHXoQ
	EZAWbTuYT2XGtj1JwxT7GadL20QMO8IiGqrrJ/mV5pBY7ZQwhuPEYvuK3e6n+uIFroHQn4G2a8A
	==
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2fccc97a25bmr26776710a91.11.1740360993720;
        Sun, 23 Feb 2025 17:36:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdpEZuC2ughhZHzH398Wnf911hWUS3XNFhm3aiYtLUwM/DJUati7wFDAoaJ6jggj1FoQ8gleBOESVt4o4W74c=
X-Received: by 2002:a17:90b:4c04:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2fccc97a25bmr26776675a91.11.1740360993337; Sun, 23 Feb 2025
 17:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-2-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:22 +0800
X-Gm-Features: AWEUYZkkWiq9RM5OoXawlOjb8hi-Xzqh0EdRsTvUVm2UbTIaH-IMbmewVYe9VzM
Message-ID: <CACGkMEtRQguy5dg9X_8AYj=88DC_yn+HXPx0Lu_=e1JK02PhtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uc3nOBdfGzAONH1EDUhbcmJC738zBEjgU2_pSareeH8_1740360994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:40=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

