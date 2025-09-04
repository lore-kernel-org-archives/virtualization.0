Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8823019B3
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Sep 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995572; cv=none; b=VtjouaHFTgoEHIKw6YTwkjAwVzledKYoxA/inXGMUyjsR9/jYQvArUL8cHPSmqYwehfvqkmUN9ycF2MoJ6T5gOuMML2QtlaeEGpJiu2xrHto2FcEERt+SzyBUTMV+yQI4xH3yXXBMVP+jKZAkdnxURqNQMnpSt9hQhdxzTRtlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995572; c=relaxed/simple;
	bh=y10BOY2bhipVhs6u4CV71tafCYQ+dgvqXHPNVXyu5uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EMkFaG6lab30cB4ddmWdZ4VKZScnoP0CaXwMevW4LwKh51Wo9wOO8PIfNbSuYWdLTaX14Vux/A+Z8Nvdk86ZKiyf427ho1uZw+CdOVNKjY8Z0QLYgZQzUDea7wSf48mc5FkZX74gLwPMg82qj/cQkIZbjThhaKi6IecnPDo/Cf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ag/Zyw1f; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag/Zyw1f"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C77342235
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Sep 2025 14:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.457
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-xmy9Il2fmE for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Sep 2025 14:19:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1E5F54193E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E5F54193E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ag/Zyw1f
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E5F54193E
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Sep 2025 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756995567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ryrJLkGkbnWVchG2uLLYEQrTQzr4tj9oydy9WqHdpys=;
	b=Ag/Zyw1fK/Vc/HBIfUvwcJfhuTJR5I7VXQln6syyU/StTO5gejnXieflO3ARNJgP3H2LoS
	oSvCwbr9pEeADEuHyr7ms/ARQKC0ELf+L1CjsgFYNy3jKYxtAyOXvdF+zBJqwfymVNiqHJ
	8fQFAfIVDiYquy9w2oK3EILrlsXRWg0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-8EFuTFcrONWApUEvI5Ep5A-1; Thu, 04 Sep 2025 10:19:24 -0400
X-MC-Unique: 8EFuTFcrONWApUEvI5Ep5A-1
X-Mimecast-MFC-AGG-ID: 8EFuTFcrONWApUEvI5Ep5A_1756995563
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9c1b756cso5471125e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 04 Sep 2025 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995563; x=1757600363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryrJLkGkbnWVchG2uLLYEQrTQzr4tj9oydy9WqHdpys=;
        b=lrp0AiezqvE6TufhdSsCFZI+6yNDYUnFBzVjGaZ/qu9L/ZH2PvjuKNDi2qVgW9M6La
         C/dfVvX9FdFEoHP26U3JOVxmdzHwb29TVifykIndB+7F4aaHx0Pyn6q07sXD7N0Hq0Zs
         TEjXfc+cG8CtPXMs8fgztB2PDcNBf8XDTFCOjuE4dXPhJRBKlBRmANHWJscu1J4BqxSa
         V/R1fcncOxxZlSuzizc0ZGaLuMfmAQsxFPBqmNreBjPSZ5dqJY7FjtBdLCQ6XHkXPSbQ
         Mx26aeOZDxVY63ycATv8z/+2+CYWxZ/pjELlKJbjy42crr3klMbRx+Hkm4uCdzUlU/Rb
         3BbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcco4dKV1uY/84Dol3R8OjHr535TRkmEK3oSCVgy5+kRSBeXNd6DRhOhFt9FzkHw8TOg8Xi7dCJoax+oE7/w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YweifsFIH7JuFCURKjkb63J8lvmNKTyiWCfhsonmBgBLZ3KA/8R
	JfRlkE4Cs2dKOLqJ0+oVU/YBwcYAdmREe7bStyByIYRpQwfAc+FEnHyKoAUIahlpUcqhk0Sb1g5
	blNXwCO4ox2U/uXylro56+pXd4hIY6QoUBPQVfpdDlUjBNcDuPWp3YMkfEr+abiy+1qeHLx4dJW
	/LkWSLA2s=
X-Gm-Gg: ASbGnctdWBTBDQmjdvFv9+yABV//Wt5LwQ7kfy9LMrSH3HjxdR6fCAdvrX5QF+1kk8Q
	K7v00iWg434STwPYnhxXdbp1MppjoUURPAo5adKBckwUfN5wvgJ/2erDJaON2IQu1sjhW/JxufM
	P+9VVKyKnuiIPiQI9JjuFvXEXlh1P87RDrwGe4I1FuXzULDBYd5CL88TF5lf+uFHvPliOgdPNyF
	iltfxDw7gQbbqLNiOa3LgqJCdiZynajvUK27llBWjbYNN7eYTIdyUGVXKcHjhW+yJsBNQ2T7Omj
	ENKU8i1GEefjeLZu2iHE9z/5dV/xAPY=
X-Received: by 2002:a05:600c:c491:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45cb50381admr64670215e9.10.1756995563516;
        Thu, 04 Sep 2025 07:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj8dKOSoqZDoUMeKOpb0xF4IjxY/Jl2uTzegN2UDaeOTp7hqFfy7Kwpb6svQb/dzbeUfhNwg==
X-Received: by 2002:a05:600c:c491:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-45cb50381admr64669875e9.10.1756995563081;
        Thu, 04 Sep 2025 07:19:23 -0700 (PDT)
Received: from redhat.com ([46.210.239.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e211346354sm1557640f8f.10.2025.09.04.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:19:22 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:19:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: alvaro.karsz@solid-run.com, hengqi@linux.alibaba.com
Cc: brett.creeley@amd.com, parav@nvidia.com, virtio-comment@lists.linux.dev,
	virtualization@lists.linux-foundation.org
Subject: virtio net notification coalescing
Message-ID: <20250904101548-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BTU_SrrlgM4N96E4fmueYz-oiUgK3qm2YJLm5uD-Kaw_1756995563
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi guys,
The notification coalescing feature has been in the spec
for 2 years now but it does not look like there any
implementation work still going on. Is that true? Know
of anyone working on it?

-- 
MST

