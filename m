Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040A39EF30
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171964; cv=none; b=JsIjrRAek2ud5PD8g11+ZLIzk1SlNRqCftQCjlgCZjX4dj+Lh9czBmZeIg75/I7LAklA2IrfpuC4/8Kgaw9Ys5bi0snyJUuN1ufkZWwfWVkv4O9SRxroAxwoivyEgHKq/Sg64eYPod8yQMTz4qYSMclT1LKwJmuG2IfrUe4Lazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171964; c=relaxed/simple;
	bh=ymhkASxbIVWv9j+mePOgKOi1FOiNAz+RhJolG3knZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pMdcosIIQBzXd2JDOMMNe8iEaH2C1vRpQDYBU1wUVsqbJRAgK0ym6dBIQ3F00+r/L+hw2OI7ghbLJK4xTxmu5Tnc+u8VOD6bzahdwz0JrBhIjatwiXzaMEapnUu7LFRn5aoIIJjF0QPpIsUV09aJJjebgHIRErei3utgn/ifrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK7q57rN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK7q57rN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781171962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hdogEkd4s3EnCeQjcrov4HvOxfOonGkNZrPgkWOPMM=;
	b=XK7q57rNuV3/dnpJ5Brm6c9xVRcUYN2XijZ5jJ1tuMRcbe0lGL0eq0rrdQ1ShpBMKgK4jq
	RdYPhqbmhB+kdUmYZrrUzRfJzf7tgRSfqX1PU5FLunWXD7o0mpuMWmzYHTTIVAKQnhu3zi
	47wXfjJk9WJQrK616ZQ+Xg5VwBdsiR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_6eBGjpIMwK9zYmyzPwzRA-1; Thu, 11 Jun 2026 05:59:21 -0400
X-MC-Unique: _6eBGjpIMwK9zYmyzPwzRA-1
X-Mimecast-MFC-AGG-ID: _6eBGjpIMwK9zYmyzPwzRA_1781171960
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b93debc8so63348055e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171960; x=1781776760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hdogEkd4s3EnCeQjcrov4HvOxfOonGkNZrPgkWOPMM=;
        b=EtUL0OcGxzHIzB4whNzaD4tJpn0QlmrHQsYeekOW0mcCuMmaYFyn+PGP8i2dRzNPbq
         z8tbClV+Y+2jWQd2DrzJHp73iz08Ejlj0o+d0wDGImfmAmQg3fxZoI4AZo9soTxojgxb
         Ey/NuWzhwO7hZXFqN5CQbZ+V6Dn9knJ/PlfjAD3ZZVQaAWt2CJa3Xxn11/7xrKBUVAft
         wWQ7hyHPn5hBrblZwjtoXBX6NeA1kc3bBezhzFmN6TuqTbQ1wVM/CjyEwHCaWEf5U64i
         r+ocIH8636aIeKTc5rjagpa4zUEMb1JRU2QpqAYODqjuP5dStR1stf5/gcCgCnhDEhIp
         UXmw==
X-Forwarded-Encrypted: i=1; AFNElJ/YIR/Ff00uCf6JQl2ppd+fz6VDO435QcKbN6TYRg/wWr1rT9Gw8K9mWAl2rFH8XLxFpM7COTAFx/hOsgEjvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYDQMlcX3y8vY/GxqAYFtS3nKUTN02fuPx9ZHBtpeDNek91Iib
	qvrf8P/Tc50L/ajabbdOzm7d2YPuaBtpZAv1i4aDv0KvzhW7G3ZT7RF2iukYGFkQ54y+c9rjvqU
	E8dbJGls8BpDOGEeARwtr1dcUyGbmLe3e+LzlJBPyyuGdEFXjz+VCVMTJee5AX+6ZJ+MevIUwKb
	KT
X-Gm-Gg: Acq92OFG/tqUqbqh6Wx2F0by//Qib4Tcz7GjJzRmW9KXUhomEEo/XpcLaRYrlWSCfZ5
	qt4A8A7qfwOjnbzY6Uy97ibeEs2GkXQzMHGvx0rfOe0SCxpYhEx5w0xWZMvALxxz+gZywZMu9bl
	gWlW5iNiJAj9zVVIxtqsbOE175HJD4h4kDNNbBNYByQ2nGZCv5BtFcxTXCxhtLpStrD2dc6MzUM
	SbzLOL7S0yeNey8TpceadcyLznGqiFoxAb71Xf2YX25/+fZ69O6Q05jueO/rgAE9ZBA9bj3l2JW
	QPOjUfDsI//FQ1xC3BRSp0Wy05684VWH/bFfyK4WY9uqIYNXmO8WvdH1jv3QFX7N12x6V24B+oN
	f0IMjxTCdTdrSrh3bcdodjSHp27Ifkb5R2gRdYc0gbA+rH13czekmcra3Mb0BepJ/jQxmUjpjVD
	TqpiJ/Vw==
X-Received: by 2002:a05:600c:c082:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490e560b59fmr23257805e9.22.1781171960348;
        Thu, 11 Jun 2026 02:59:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c082:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490e560b59fmr23257385e9.22.1781171959774;
        Thu, 11 Jun 2026 02:59:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52a553csm39112405e9.2.2026.06.11.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:59:19 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:59:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiqGyLp4w1zKU9JD@sgarzare-redhat>
References: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
 <20260611095509.19125-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611095509.19125-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4Q13tadzUH8t1YgpTlxs8mcj66QwmuEyGnIsv3SS3Yc_1781171960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 09:55:09AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 09:42:12AM +0200, Stefano Garzarella wrote:
>> Okay, but VMCI still need to call vsock_add_pending() and
>> sk_acceptq_added() in vmci_transport_recv_listen(), no?
>
>Yes correct, vsock_add_pending() and sk_acceptq_added() stay in
>recv_listen(). vsock_pending_to_accept() only replaces the
>vsock_remove_pending() + vsock_enqueue_accept() calls in
>recv_connecting_server() once the handshake completes.
>
>So the v3 series will be 4 patches:
>  1/4: introduce vsock_pending_to_accept()
>  2/4: fold sk_acceptq_added() into vsock_add_pending()
>  3/4: fold sk_acceptq_added() into vsock_enqueue_accept() (virtio/hyperv)
>  4/4: fold sk_acceptq_removed() into vsock_remove_pending()

Okay, LGTM!

Stefano

