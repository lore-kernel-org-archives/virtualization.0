Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517815;
	b=xlXgzkUWXFFxNhy+JX/co06xSvhsrzoG4+RMHTzaCrQ/5uVMWFbddy9+BUeV1a4sVcNb
	 Z57vSPjBPjskIzlt2NbqhjbqOUV6ouAleCqBWgg6ct8PORz36PnRpdXxFAxlDKT0qYPbZ
	 rUPolY95++CS5WoUqFuF78gXKAXLIGlfkej7O5rJ3pvgolBFu4w+KOCrfxEuGj7J1a7B5
	 8l9zVOmJdpKIoYksndfqKj347SYxeOE4f8DKTx8Mi6S2O5mggA25oOil9GOLIFCFy/jTt
	 K866SBR+Jd/r1tXLgPfZMc4ZsKETmO3R+hNyog4w3meySQw2IAQquGyNtRzJGfyUHfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517815;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
	b=lKUBYS37Tx66L54yregHPeChEp5jhC978BwI/MK+5ZEPOBeTX9EEqeKT1/YGJ/O/QrVE
	 6+TL1slhA1RKyhZDs0I201UKF4ltQA9gnek/dc3rv1b9COv6YRyxFUfpy8vN5PqG2N5Mg
	 sy9tS+/7nepDvYw9IQkgjVIIlc59i2fOBf9mjq7VfrtBwtDoAjwQsTVxN4VG78FLosfYD
	 DWgDA+iP8xVPRUroK2HEhwzaHe1JfuEV0co4cI0zqquvWnolHW6sx3Pq2H7+A0uJGab9a
	 wwuOYvVm+YKSkZskwARkNc21mJwU6ouBpseJq8ad/6zXRL5FXmIX7qPMaA3xpJi7/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIz2efb7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25544606A321
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 10:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25544606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIz2efb7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795517814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
	b=jIz2efb7kfzn3tVsUYgofhmPVjMZK0z8tdr/Rm1ubVtaUqvAJZEF2KEMjuwZh4wDij5k6S
	uY63qfVpQIoaB760fHNmLKiDKC8Ehi8iFmCcR2RbsdyY1F1RhJ1sbgVK0iQimQa4c0PTSs
	dtbT8GoEDeIDQhvEQOw3Ra+eSwt9OGc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-L01JUIuJNsuHsz1wRA6eUQ-1; Tue, 24 Nov 2026 10:56:52 +0000
X-MC-Unique: L01JUIuJNsuHsz1wRA6eUQ-1
X-Mimecast-MFC-AGG-ID: L01JUIuJNsuHsz1wRA6eUQ_1795517812
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9210a12765eso38088026d6.0
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 02:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517812; x=1796122612;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDS/jS4MsyU8dKC6AMUz/M/v6mO2eBfnVuVFitaUJyw=;
        b=iFVqGvW8fUwtsM+11wXu+s0uQBC7NopeuyKvwcp4RQbQz63OGbSFDk7TjWh2dUZoHy
         x5dikHi7YhCrZhAzz2BBKMA7VOm6N/aNp9TG6AIjLqQNEMDvh8NBuAYWQfuAlZcXCP1f
         SLhPY8xO2q9Qp6geutxM33c4uTyF8sNPsWYhORz7+euJajwpOnUFuX1sLOR7Lb6zuwXr
         deoX8S1N+EdEoNAbpB17X3q/HlTFKXQ1XaiiKXoNIJbl7rQKO3NC2KcbnJSiEpKNmA81
         L+FYDs2J9mjJre9hUl4HFyckU9arc8jMbCt2PlZoXoacrM2p7GhCv1pzEME3nyGuv4Gy
         Aarg==
X-Forwarded-Encrypted: i=1; AL+hErHsvABv+HsQOZSDg3IOHqOx5FIV8SszHQR7dADTLXz671ABBJ+jp7j0vWVqS4gyRS8dsxK83L48xP+k8JwbXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8eiuokv0nqUe5LtXpcMm69bf6uUZDTVCMNnGtSBXbrZ807tt1h
	6QD8YWxkgxAxIIJOGqiSex0f1377BAbZz/n3+X5B4zPMczZWHmhFr9bJcLRwijqUgeISlXolROA
	TQi0WwvqJFOV7P1jUuXwhZc2fP7ixSdF0xf8D/r12/gL7dBTtb6858142hBkd0sJCPqMz4svqyP
	VjN5PKWHUg7nmOxPJrqLqPxITrUVJJ9ftkupWtYHgHh4A=
X-Gm-Gg: AZFdTZcggMijiO3/QIyN0L2m7I0vmQwvKpnYCnLUpcO6O72Loeu4I/XMVV8WG5FWDto
	Aj/36IJ70IkPOhNw1W7BnTIl6Kea2QS//ngEtJZhk2TPJ2zs1PDYSsES//T0ZxGWw0bPVvCNNfK
	zfMLfy8X3MaK1xxy93qwGoNCvj1Lok3eKeFH4laKFk0btimHXtUHhz6HY=
X-Received: by 2002:a05:6214:226d:b0:921:37ed:5d0 with SMTP id 6a1803df08f44-92137ed0715mr242412876d6.48.1795517811511;
        Tue, 24 Nov 2026 02:56:51 -0800 (PST)
X-Received: by 2002:a05:6214:226d:b0:921:37ed:5d0 with SMTP id
 6a1803df08f44-92137ed0715mr242412426d6.48.1795517811018; Tue, 24 Nov 2026
 02:56:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 04:56:49 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261120174540.37d152de@kernel.org>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com> <20261120174540.37d152de@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 04:56:49 -0600
X-Gm-Features: Aa3M54oXKMFlMM1Oml5R3p9TM3DnPWFPNqxfUYAgRUMjL9U7VfA3l26fuKvgEVA
Message-ID: <CAAiTLFVC-oxH-7N=FOCdVNcJEEVMU7WFV_k5t+g51Ce3ZdrO-Q@mail.gmail.com>
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network namespaces
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fOMaF8Gf8JsGwQkzq0hIxPQ71z9suAPRnsFvCVUNIVI_1795517812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 17 Nov 2026 20:01:52 +0100 Sergio Lopez wrote:
>> VMCI already rejects datagram sends from local network namespaces, but a
>> datagram bind still creates a receive handle in VMCI's global port space.
>> A VMCI sender outside the namespace can therefore deliver to the local
>> socket. Its handle also prevents a global-namespace socket from binding
>> the same port.
>
> Looks like someone (silently) applied v1 :(
> 00f445721c7f ("vsock/vmci: reject datagram binds in local network namespaces")
> Could you send an incremental fix?

Is it worth it? The change between v1 and v2 is merely aesthetic.

Thanks,
Sergio.

