Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32543A1CF7
	for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945860; cv=none; b=GKIxLZRZ9Fss5pt03pTTkjrdJr3ynPfjxFl07SNHh2dweo1+SEVEoAevhNk9NhrgkuBIQjrh96qYBsai4e90sYAV1PiyTvU0d2LZotGjlIeh7YpDUfNTWMqF9zsOrOPJ4onShy3gHanLo5534ldJwcWU9o488IxHYAlera3Uu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945860; c=relaxed/simple;
	bh=Yw++ySpwmZARZwDkHxFtsIMZXrLfykb7FK8NOCCtc9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T2shLb1kJ7T/ucEbYCJHTz8dRyWQh744m+A3GIUiQLE6TZOFZm1lefZDbr8B0MeGayP81Cn/4rRq/sNAJtHUjvlfJ60jNIvVf4S+V4G3A7JbnnqJgu4ASufNNLZVIxPC0pCOtFTc4RHjRmVT51lttrWDP8fz+5iQFvzFNkE9YQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSS8YikC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSS8YikC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWBmRFKI0tFktXtE/HuJ4+L1Im2+ihdnnfM72IEIXjQ=;
	b=hSS8YikCZphq6hOwWluXcGc1ri11P3peiiib0YRf1bWRWPGUy7jTRxd9kVj9Cs2cecEO1g
	7nt8kPNOt03VZmBBEbEwSCFPHFSp9qxq2apl9/wSsc/ssRi0agk4gyFfbsIw6JNTTQvy1u
	PE9zbQ6zKD4ykz2kWMvYPJ+ga5FPleE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-K9rVoCt6N9Kp7AfI2rkqZA-1; Tue, 24 Feb 2026 10:10:54 -0500
X-MC-Unique: K9rVoCt6N9Kp7AfI2rkqZA-1
X-Mimecast-MFC-AGG-ID: K9rVoCt6N9Kp7AfI2rkqZA_1771945853
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837246211bso59371285e9.0
        for <virtualization@lists.linux.dev>; Tue, 24 Feb 2026 07:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945853; x=1772550653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWBmRFKI0tFktXtE/HuJ4+L1Im2+ihdnnfM72IEIXjQ=;
        b=o+NZCboTsD47sHH4akxG/47E/4dyhNdg+YhtkFfjMQ7jdnOLLt/APJbWpdyb5u0O6E
         mrLdEO04hjsPL3mfZUisU69yKqAWCyJ8lNMHNEfaXUgynPES8QbfWBDMjG4w+lFzCwE9
         tUDGHonR8B8ySkO9tluw1OYO/nCpRVJiibcYwpWEFNy76lUTUdcaD4Pl6TH6AsVTjWu7
         0uerbA9tkyxoyh1PX6ufOHch+3bEYhI6C8w43lMPCPBCS7EAeytfebqOrHfZektm6pG/
         wncZY/eSJ7m3CekP32grzYoxI0PbhmuxXij09iHWN45S8qtadUuY58lOMx3iJp+LxGGG
         /rzw==
X-Forwarded-Encrypted: i=1; AJvYcCXUMyNX64s8sJUqqn/ct08pab242xz4JX2rGexkRUeRC/cOaG/4blIASkNIFHEODcuwWxq7F+5ddTkHEoMueQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/GEVWGyQl7zs1yhb0apqbX5NClTRb2Yw0kxUaNjBAkfcMTPjN
	GWnaM7yaePVVQf8IZyzqdAkSRaagi5m0aAYo4SrhVb/VyQAu85tSBxmEeRrXlQoACjsYKEZjr77
	LDKoOjUxL5W7cv4l15jgjkFWEEsVbfsfmhYvmi5xrki9rS6XSTQZlszY79XAghHBy8CIZ
X-Gm-Gg: AZuq6aJ+U/arRxr05rgOHb3BJ3JyXiHtHC6WuCI/5Oof+m4XiTo3veeJKt73MK9VnqN
	oZFwf4bSK30pBiajfbOMvGJIAcPkKfCCg5FNpFbU1EwHOSkE0IqlrKQbqEy8OebK8A8e1pl6vrK
	dhFHHiZoVsAjX3nrbtVK6hmijHlkS7uXqNqK5yNWO5tO4L+lgzJr8UlwFvLu2VyGphFMEhAjC7G
	xy5scHD3G9D5kx20tL3vAS/06wkHuDS5vavB12Rqy1aCP08y4qyFpewtta9gWO/AKZ+0bnXBdJF
	hodmSxvrHv3gHqci7iXBQ2zb9D8K9MXK8/X7eljsg/YhcUb8jwvup2ahKtA5B/fWtpFjXglMEwL
	CuG96R88ZKjgyfcHjB4kkvY6j6M+h0gS6GPxs+kk0uO3PUJ+bNx4i9N33m6Z5sIPtUq+dIQU=
X-Received: by 2002:a05:600c:1e1d:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-483a9637a55mr225647075e9.25.1771945853018;
        Tue, 24 Feb 2026 07:10:53 -0800 (PST)
X-Received: by 2002:a05:600c:1e1d:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-483a9637a55mr225646485e9.25.1771945852482;
        Tue, 24 Feb 2026 07:10:52 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd68826asm9484475e9.0.2026.02.24.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:51 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com
Subject: Re: [PATCH net v3 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZ2_cPL2zCYQznBI@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-3-c0cde6959923@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260223-vsock-ns-write-once-v3-3-c0cde6959923@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jAMOd7AfiJW3aR5u2jBfuSajNGM80XAbXqyxMIWJeYM_1771945853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Feb 23, 2026 at 02:38:34PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Update the vsock child_ns_mode documentation to include the new
>write-once semantics of setting child_ns_mode. The semantics are
>implemented in a preceding patch in this series.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v3:
>- update language to clarify language that first value is locked, but subsequent
>  writes succeed.
>---
> Documentation/admin-guide/sysctl/net.rst | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
>index c10530624f1e..3b2ad61995d4 100644
>--- a/Documentation/admin-guide/sysctl/net.rst
>+++ b/Documentation/admin-guide/sysctl/net.rst
>@@ -594,6 +594,9 @@ Values:
> 	  their sockets will only be able to connect within their own
> 	  namespace.
>
>+The first write to ``child_ns_mode`` locks its value. Subsequent writes of the
>+same value succeed, but writing a different value returns ``-EBUSY``.
>+
> Changing ``child_ns_mode`` only affects namespaces created after the change;
> it does not modify the current namespace or any existing children.
>
>
>-- 
>2.47.3
>

