Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A025B2FE
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274616; cv=none; b=RzWC1wCPw+xGyUApLJwvcXYlFoK6pLUM/uni7KY4eW+SWtDUUdH32seKvW1pCJPbPN1vpxD3Ll1NJ3uQOjF9ngj0OpEdYQ2rVfmh7huiiWPiW4dhIKc2jU4Ln5kYPgru0J1/6gi8vIUY6KPXesgg9QNRpMS9AfShQCnIWUgVsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274616; c=relaxed/simple;
	bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nq1U17Z0Oss2p+RPyb3yDaNtnhh8WlPSVg89C+frbixWbq0GbUadrCvvLidAwho4rEeBJEp3vPF/Hyegrjcv7o8QaMPrA2Pr/ecxhFFeEgqnfCyj/nT9/FJgD4MTAjzukDv+TUCCC3Vw1FcYC8hUIyxWIiAjFgv22/X6F85mwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0zZiw54; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0zZiw54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
	b=O0zZiw54i55TPcQal5ILDc9ipN36CC90aJsPKIvFBOts0jwBNya+1TQaucNhnu9+Osk5rV
	bLEGCdoCFdnncCCPLLB8va9duYaHwlGcHQNgFZ6HIvPN47eT4SuckwBDlnEvLriGZ0fy2a
	xjJQ5p37I4WqHb6vVaLFh3P41fOiuSE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ux_jrGNFPdqpZ6W7TYOWTA-1; Fri, 19 Sep 2025 05:36:53 -0400
X-MC-Unique: ux_jrGNFPdqpZ6W7TYOWTA-1
X-Mimecast-MFC-AGG-ID: ux_jrGNFPdqpZ6W7TYOWTA_1758274612
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-733ff1a73dcso34681317b3.1
        for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 02:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758274612; x=1758879412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruz9kdaDLCE4+rPabbd12pnH5qUqJwoy8Vr7fc+q3tI=;
        b=DTFkERy0AkmKQNONNKDy4x8lvFG7K9urbhJ6cL0VN8uGHi0unMy0+1ShB+dAyZOBXC
         xP7FenAQ6vNRia0Zp1DU97/tvte3m5oV+5DCDke8PxgTt5dYw+cdbLtYENIs5l5ZfMa/
         ihszDsRU/zEgCRHc2J+JbvPM/x7UI7WTA+yi4fYAA/SyBHrCem0mQTIij+nWVWDWOXhC
         jSmGVLdGhZtnazDNi8YSGa6Hl98Mn4bywbt5Cw30CpGAD/6WROBOw4PDuVnbLC00gdrr
         NonwBTWmd/vylMgvnxl9yAOkF+YgsxZpvqgLMsVkhu76dW39PoMzgQOlmRP1X17aITuq
         n3qA==
X-Forwarded-Encrypted: i=1; AJvYcCULSiOjYApQnsRRevpxELhAT0UyCkhMMWgYZglKZVhE/F+SGULwpMI8N/u6K6c2d09q8jE8Frf5hJhkkCY85A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy29NJJJeq3ynshrtjH5T3ZOt9jpNXTDU/NAJdyyHKraYsCzPJX
	51s/F5oqQ3xLm0vzoCvpxFmS2Z/sNcg9OCYf5brsAPeJBSZ06DWGhur2CKbBmuSSX7DV2ouT5M+
	yzEJQ1PeydkiCyvLRAFZw5wLedzm++DdBoURxaXxbB7+cQvvxZuHDHm7tFbOQU404Q+fQKmdP/R
	KIbN5fC7ybDKDj3PwngDzeGecB9S6YZBuBPJJGllEsinM=
X-Gm-Gg: ASbGncuMiSDavQG7snWZfL5qyVv9wg0Z4vvOrMI+8Mn4MOx0I6nCn+TBkwM1PQFNC1M
	WrRoQz94GCimRA0XCSMUTToOwGx6LCP81p1yQqWIdehWnLJ5adCtKdA7BT48gO88IkGZVmMRV3e
	8JQbGA9J9CVjBcspo1u2ICuoPs6mvsbttjqM4zqpUs+amg8Vt5p8cnQ2lmknyBhX/vGPMqxiaGZ
	cN37LrN
X-Received: by 2002:a05:690c:690f:b0:737:6973:fca8 with SMTP id 00721157ae682-73d3e2a15cdmr22403297b3.51.1758274612340;
        Fri, 19 Sep 2025 02:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPKXVRQHM5BX6WlYQ2cBNEMEDhW1rNSC30sedm/I330JAJc5f9vDousTwUFG5/BlT/57DXfjYaIWiVnMmx4Q=
X-Received: by 2002:a05:690c:690f:b0:737:6973:fca8 with SMTP id
 00721157ae682-73d3e2a15cdmr22403137b3.51.1758274611905; Fri, 19 Sep 2025
 02:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919093231.960393-1-eperezma@redhat.com>
In-Reply-To: <20250919093231.960393-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Sep 2025 11:36:15 +0200
X-Gm-Features: AS18NWBUmghOHNLPQI_96FL6YYrZHCEaA7Y_8tydnZj0vxyJbupjglhz-WKCBg8
Message-ID: <CAJaqyWcymm-O+ED2veDojVhcH1pAnekYLnYXe_P-9VA3rOcuQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add multiple address spaces support to VDUSE
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, jasowang@redhat.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P-gFaY0sZNIoAKyNt62HSKFae-eNHmAb5kEfcgiIUtk_1758274612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 11:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>

[...]

Sorry I hit Ctrl-C in the wrong terminal, so this series lacks the
final patches.

