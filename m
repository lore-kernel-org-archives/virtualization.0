Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52819232367
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163482; cv=none; b=DRzCItuV7ym2P3xZaIcLpc+u3v+8G3WsKCM7QJWhvTtis26NVbnKIkEtOiouhHRzN6ypo+yWjUnFGVu2TMueYUq30gGyqve5HN6o8HVKjVU6cZlF6HCmfB5Eg0ieseeTCiM4dMM/B2DAvsgq9L1Kxxf25JAxJdj1L9/LDKgAh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163482; c=relaxed/simple;
	bh=3dUl3FwynBQpWRnlP8tcB6RIntT52auTEx8Ov42iq/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqeieAhYj3KwFpV2Xwof7Q/XDKce0IpRb9u9L7pQnCvXTiUViL/aEOHF7aBP16HW6/3hpVVKJpxy6HO1hnxZh1LgRSP3q3xWRTz2XzuWOTS1Eht9NKY19PQDZ4dL5b0GOsjAIDSEdLG2NXEEkPj3pqQWR40eTczAOxDIokN/f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEuXmsMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEuXmsMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750163479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KShC4QJThQfwPAvgTMBPmuZLHMXp5DkJgcjKi26gyHI=;
	b=bEuXmsMXetGmAXWjKAnEbfYCYV+1e6zYzCkWjKAqIFPCCN1mQqBdcYx9+scmRLas+lmlqo
	QvNqBr0TtyY17blElFegYjyvwWkNNE8Wz8IGLBezL+Sn1TagY4D7jdIOz9FFUd0/O+0wp9
	L15ZowCApdxwWiLesEFDzwqLuavmyu8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-b4_FT-CXNyOytvhirGsOfw-1; Tue, 17 Jun 2025 08:31:17 -0400
X-MC-Unique: b4_FT-CXNyOytvhirGsOfw-1
X-Mimecast-MFC-AGG-ID: b4_FT-CXNyOytvhirGsOfw_1750163476
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2fa1a84568so3768014a12.1
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 05:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163476; x=1750768276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KShC4QJThQfwPAvgTMBPmuZLHMXp5DkJgcjKi26gyHI=;
        b=ghUY11hDQIAeN52jToL22ElV/9urMNvXfutXagiv/hqDYQMwUD57dTuq1kO2Le1XfY
         bm22v81MNBl0QDKHkGlj8MwO30i3EaHIXL2OpjukAqCxLDuYgAHYamgkxdcjrV+9oY/s
         rvfav06J9+BU5NouvaEVCOMhQj3tr/NtndTCUy2W2XXmm6CaB64LnWM9q5PdUm3FUm8B
         2ERR5qAbB1BYqJOBUleoyj7ls3eSHCkMIQjI0WGBIU4U9kfXXNs9GEQ1CV6duHRwDniu
         KkZeLWQw0hsQbg1/gXdRYCrCYesjmFR5bw1nIBViKNLiradUQAKhfTkSFOEcjNWafrIZ
         h1nw==
X-Forwarded-Encrypted: i=1; AJvYcCVdYduz8ArVw08Z2JKSNjmaMaarzS2CtQJxKSCt0oOxsUxdgn9GOYXlDAO016lqJ8QeWkL5AUJTT1COwbrHPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqp1Fsk4h/LJjpzYqiqAQz3N8kTQU+DkQmwUGOVThrPH3o8PNv
	sIDUxBOIhbMu/jH7MSUfZe6hDlGrX6An0UR1Lgw6RXQH0ttSUrADWhhwZCWufezv3afqlNwqUWb
	vdShEForupfdQBSNoR45fLyzNEDmFxt9Gd4Jkw5EqzF+suJ8nBDx/5WLILsRLoqiztUwbKguH4/
	90KFWtkEYfQ5UPGReqX84iHlaHmiObZ2MqLVxqd4Sa8lU=
X-Gm-Gg: ASbGncvczeTPIhs+Q8puLnx7DtDIOvtKvrI1fFDLkLeh0a1nk/gsJElU/XM2h2pmTjb
	Qxk6CMkLxDoFrTO4mWc/MSnMJjSjHpxspEYQxj8F5HIWUgdkBkQQ2VMuM0PSpGzEz0awbPIH45z
	ewJw==
X-Received: by 2002:a05:6a21:4006:b0:21d:98c:12c9 with SMTP id adf61e73a8af0-21fbc7fb787mr20024578637.21.1750163476475;
        Tue, 17 Jun 2025 05:31:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7HH4JHZZHWGn7WxI2rGQ/OeijPwRemStRDBDlQeXn02r9gXZyhyGGRph8cab5dQyPSJpmb9OnGFTrO6w4wWg=
X-Received: by 2002:a05:6a21:4006:b0:21d:98c:12c9 with SMTP id
 adf61e73a8af0-21fbc7fb787mr20024532637.21.1750163476107; Tue, 17 Jun 2025
 05:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617001838.114457-1-linux@treblig.org>
In-Reply-To: <20250617001838.114457-1-linux@treblig.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 17 Jun 2025 14:30:39 +0200
X-Gm-Features: AX0GCFtjoUlasDEXuV4xySiG1s47WSqTu3IKcqaRn-XCjq44bSF-f3FN4m8jITk
Message-ID: <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vringh small unused functions
To: linux@treblig.org
Cc: mst@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kxRed4ZNdiXf2q5Y-Ju-Cs3JW1AXvOgPO6_tcQgdUl8_1750163476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:18=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Hi,
>   The following pair of patches remove a bunch of small functions
> that have been unused for a long time.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

