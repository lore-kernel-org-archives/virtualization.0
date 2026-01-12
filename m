Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB937BE67
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238796; cv=none; b=SdpuafVD93cAyefE6GhoKSR3dF6n/wSXooYtViF9E+b4NiICjYbWzoKZymJ7K9h+RYi6QDIUoK0joEXmYuRpCcEjNFn/LHmb65zBmJm4nENssX/NVZxscpOWzHmG4C+9qfmtNISigXgqHYFghA88NYBNLD0xAyYoArs5VZa7u70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238796; c=relaxed/simple;
	bh=VcWKMM3TsRHjfu+KXLUJOs/P3Fis/5txZmCUs7c62Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=USeValVcTK7Ogg7vVU34B6kXmBWr5+cQ1g2gwlh1XptDnqG1y7+H4aFrgUg2NWEVWNAWqA/fv1Wm5V8Mog4IprubV4tYqkVPzYR0N+oJstLBiSMxDPPSm2Cs4vFxoLG/VOwlIYRDUvTP2pm2Kd8MhnGUPBRmKS5TXTEelUk8ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNj0Oim9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNj0Oim9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768238794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcomD5fw9IVBx/EvgIn//kfeDV6vnh/bPzC6DXjWibA=;
	b=JNj0Oim9wKof8VBgCL+0xXrfpqlgwjE0j+zGrhSJX8gZPu83ps7s3wIs2Rp+Oq4y7dpb6g
	nhFZ4pQe/z4bVWUg09iX/tHoJIZHkcpPjZ1olu1FgzH11ZTeGLEjwElfrYb4ae2FZxy1hD
	r+gtw4OOZIO6eI1BvpNExri8+RfMl+4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-h15uqUZcPqKA8Jbbl1uDcA-1; Mon, 12 Jan 2026 12:26:32 -0500
X-MC-Unique: h15uqUZcPqKA8Jbbl1uDcA-1
X-Mimecast-MFC-AGG-ID: h15uqUZcPqKA8Jbbl1uDcA_1768238791
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso47204855e9.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 09:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238791; x=1768843591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcomD5fw9IVBx/EvgIn//kfeDV6vnh/bPzC6DXjWibA=;
        b=kA6ojOYj9CVYMJB4nd7/dTYS30jhAOas4hgVsfZfhQJEuaUWP0rtfxER3m1RKGhc7t
         qYyU9n3hjBBm6a1phJLaxFDsLNfSZqADnX33tXgl5GkXVcTW17JQo4sKoFQvajvpeiBa
         x/+VmzXwtuu0AOlCddfeWeFDJjy5+FEFksXyFNTvonalD+cGdnT1NF8+uTCYJuclXsK7
         YtRCEv/J7WdMpyXeIxKU7UU0RDZnNWyntAQ0S4LIk+eayWWIWaELIyy3lwKsLahssdJG
         BMKL7iuRvohbwDu7JBoJqC7GdAcIeqZv3CcKfW8gQPDYibde79YhyBdgNDNcHX8tMBuS
         1BOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBDiYkiRXXb0xOWxzXyZzk5bq/FeqSzIhb2x3WoC6qlZgU7NvzRjlCmzeHFy/hA4Q2qk5bmg6eoMWTbWPazg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH/TKGTfGbH3uQGPsFTceKn+8VS8mzO9G2/fC6tV76AoCRvJwo
	c71T6YcQg3tewQ2GU83rSgpkYxSsgjiDc5B6+DBUv2GIlDleBHG5PwpDRIBnouir0FTjakYJxGl
	/PAGRWPEzE6PyvWMHHhXq0OTOzTundG5fqt+xEpMh7eoss+ivT2ZMTfsNrDT7WQTD3JsS
X-Gm-Gg: AY/fxX6feZ7LFNKWCEe6OC9Jvjtv1l8vt39CKvMSk+cK2u3sBxJ5nAz0ZBkrZ4d0kUu
	bdli4WYN0zpPC3Znp63fL+H9jvDkTbUW999dKbkOnB0Z3tu8l0M0VUxIFnXj1wDQ5Je1MKTaT2L
	QEwfmOhabTFqMf4GAMWl8RbFVvz9Tq89c0mHRSRKwGfMo7dE+DEWEznc0NvgqFLNDSeNkqkhKn5
	uxaH1GxupKygRG2n7E0aYl/f5zuvS8bBuIxGTVfoT5ajSRmOTX1gns4JwIXkrPmhUBtUABPpdcP
	4EcvKWJ7XHZPitdM9/AeB3m6Pk1bQB9ZL8hViz1l7UZdbIV2TNxqziQBrK6loeo1d3G+Rkj7xLF
	vvVfaHb9bSpA3S/wNaEaQOzu82onYwaGpdkBFsXlfBXBIIR8ZWvci/ORcDWIchg==
X-Received: by 2002:a05:600c:3556:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-47d84b0a23cmr220596085e9.3.1768238791230;
        Mon, 12 Jan 2026 09:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbooX6m235tcKkT8gxwgze2BljLHzxenepn63aMTJ5BFbz8FRH46rUY9bsCgL8OFUNeCvvZA==
X-Received: by 2002:a05:600c:3556:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-47d84b0a23cmr220595755e9.3.1768238790766;
        Mon, 12 Jan 2026 09:26:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm358964245e9.11.2026.01.12.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:26:30 -0800 (PST)
Date: Mon, 12 Jan 2026 18:26:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260110191107-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6gc-H4Gg1agJiQkg6HMvrEPKjPubjaP8LmWYXWaH3Zo_1768238791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
>On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
>> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
>> > This series adds namespace support to vhost-vsock and loopback. It does
>> > not add namespaces to any of the other guest transports (virtio-vsock,
>> > hyperv, or vmci).
>> >
>> > The current revision supports two modes: local and global. Local
>> > mode is complete isolation of namespaces, while global mode is complete
>> > sharing between namespaces of CIDs (the original behavior).
>> >
>> > The mode is set using the parent namespace's
>> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
>> > created. The mode of the current namespace can be queried by reading
>> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
>> > has been created.
>> >
>> > Modes are per-netns. This allows a system to configure namespaces
>> > independently (some may share CIDs, others are completely isolated).
>> > This also supports future possible mixed use cases, where there may be
>> > namespaces in global mode spinning up VMs while there are mixed mode
>> > namespaces that provide services to the VMs, but are not allowed to
>> > allocate from the global CID pool (this mode is not implemented in this
>> > series).
>>
>> Stefano, would like me to resend this without the RFC tag, or should I
>> just leave as is for review? I don't have any planned changes at the
>> moment.
>>
>> Best,
>> Bobby
>
>i couldn't apply it on top of net-next so pls do.
>

Yeah, some difficulties to apply also here.
I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as 
mentioned in the cover, but didn't apply. After several tries I 
successfully applied on top of commit bc69ed975203 ("Merge tag 
'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")

So, I agree, better to resend and you can remove RFC.

BTW I'll do my best to start to review tomorrow!

Thanks,
Stefano

