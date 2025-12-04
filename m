Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65636340A70
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874000; cv=none; b=EHkD/J/jRfeThA1ARB0UTxHUXCs3at06uKkj3mA/c5yHTSYjON6KPIKmj2m0HAAiVc7r8Ecylt94EFXS8ztE/jFKdCkryp+EJt2eACqpOkoQtbu9o41Wy5FUaj+olawlmaV9/Eza6QgcN769W6OpSQk1PzvbUbQ8safgwIss/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874000; c=relaxed/simple;
	bh=kDmx+jqAM07EbGA0yxM6gKmHdbwT1pEl9YhR1+eZC6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TDWKuzd2+Vj7v6nlMNwo84XzBAj2ASRELU+343DkfM5pBWlhwnvosUh0GjFZGiQmoIDU5mnNLQ8V1pEo4Ka6F9G0PadAkIZ3Q9Up62GMLn2qzadfGX23aFm4FaSIUxQjNH9gXNrMfnHb4CxjWoPBtzaHCppU5YzEaDHJ4yA/3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3OOdyor; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3OOdyor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8fnsz7UCU3OpevI0Lzd6UBe25AmbBTPRZuBjUvVLRo=;
	b=B3OOdyorsppUOAeg7ltiiEshkeEMYkA6yuq3zZToRfYgbTdyo5bu6an7LPbY+FWeRG4kY7
	JiBBbs8VsJn5D0vBm6c6o/51Bk3i2H1mXYZR1vjMMR1d3594vsc1G1PlJbH6/mWZceCavs
	IzwgdH7hA9E1Xun+baB/T+o5ntkgbGw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-By74sW8_NQmRW3ROnSc9ng-1; Thu, 04 Dec 2025 13:46:35 -0500
X-MC-Unique: By74sW8_NQmRW3ROnSc9ng-1
X-Mimecast-MFC-AGG-ID: By74sW8_NQmRW3ROnSc9ng_1764873995
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b432aecso7794125e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873995; x=1765478795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8fnsz7UCU3OpevI0Lzd6UBe25AmbBTPRZuBjUvVLRo=;
        b=sM/0YfLp6M+M6kQo/vS0I5N9Nhcrk5Krl+h15zcJordJ49pDe7Wj00GAkwvTsJZnil
         5nOqw7iKOheBMtc/gThpVrT0QW9i22wReN2DnEHPkTRO/sD+MLA7SpoG4CkX97WPZ+/w
         5Dg8RlOgjC8ZZjoBPtEV6+fTHSTnf+G3lAHTzvv/8BiUXhbzG1ttJwE4GcE9zYDVzdOO
         VOImxOdIX1ju5levLbYhiY9A6C8Me2sfksCwXrdeKldK8PkOEhL4jhh1z6+Wx0CJh7RB
         aHwv44SvOhS5Gf9fdo2x+sHowA3OHvsisSvvUbjDJjQ77d0SktZe3HLF4Lsalv9H7bUK
         Z2fg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHCzdCD+MQ12rFqjm6v7RYIDst5smDNRu97TaTl0HiYLs7CYVLtcMFZAoDEVDiCYl59viu9DQYCmhJ/NYwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNzbZecZin+NCS9os38QMCrrcRQA5Qdis4mPeLqH9lz/zEOfcp
	I2FeoV4/Zh66T3ULkn1r5jpMr9x/O/OJmyiku8QgetTENAAyLtvN50ajgSu1hIR4LfNM66y33ah
	IAfMO9/NZVa7yAfEeAirOjAsbl2QbzjLBWInjFL/v8ykI/3OyYO8QvRCVq+e7FjwjroCd
X-Gm-Gg: ASbGncuQTJJrCBxAL+PR3H8+7Vx45dX/MOj2E/vHXRt7rMalRIZ4kHEaF2bcAcfZGIH
	GyAmmEmEzBPe2mBm1xNbME3NkEuBQVAzZITYfJSx5gKtL8P1+WA3W9whebLm26TGxSkScX1PTsx
	enNLD1rCPH54bj2Jrx3W9tdVnyUAKhwOaX7ph81j6c62Ku9UHHG90RB+3qing7K/jvrPSCMO5Mu
	08OvjRGXX0ONGQ6nF3h8qHBac52eYgrJ4Y4pE8vBLFPbcQGM6ZHsTN2gbQMjiZElVN2flCYXe4A
	HRT/WZRdRsqaMWPLSmiTNvRgp9NQoZJNELYV37u/v4E03gxiYoKXyUtCX8JdBYdz5YnPBdOQxa4
	=
X-Received: by 2002:a05:600c:4f54:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4792af34a2emr77374595e9.24.1764873994536;
        Thu, 04 Dec 2025 10:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu0n0WCg/9uJkwkcXw5SseF6XM8H8H31n2B0AiW3bqwpiZL+k/pr7wBSUNNGm0fRxkwJmIcw==
X-Received: by 2002:a05:600c:4f54:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4792af34a2emr77374235e9.24.1764873994009;
        Thu, 04 Dec 2025 10:46:34 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm49628085e9.2.2025.12.04.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:33 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 14/14] tools/virtio: add device, device_driver stubs
Message-ID: <0fabf13f6ea812ebc73b1c919fb17d4dec1545db.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TTpIv7OikTj5_fBmR0JyujBwR4TFGhdrfawftgXyKJQ_1764873995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add stubs needed by virtio.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/device.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtio/linux/device.h b/tools/virtio/linux/device.h
index 4ad7e1df0db5..075c2140d975 100644
--- a/tools/virtio/linux/device.h
+++ b/tools/virtio/linux/device.h
@@ -1,2 +1,10 @@
 #ifndef LINUX_DEVICE_H
+
+struct device {
+	void *parent;
+};
+
+struct device_driver {
+	const char *name;
+};
 #endif
-- 
MST

