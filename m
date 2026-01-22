Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAC30E84E
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090150; cv=none; b=tdlh4kAPMZrcvj7Tp2792Wo0BWds2Af7Y9UDHe22mgm/YEkRik7NSwYqTJR7chRi1tSGINqtbCU1fqYGgD/3x/sgUoxDj3lBKkSg8fJ8oWlnFR5xVAy+vALcNIHHbvMBT4XZANxkJdJbz2xwuTT3Z/dT9gWmhK89inJNwVjU9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090150; c=relaxed/simple;
	bh=2nXcGNysBiBdRcr6vy4ZStKKh5dYZxcbpIG7VnXq8as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MdVHiINTQnHgTAf9W+gklNsOVwfvituYdCyLpSqvipzDKwk3ORxf2SA819T9cA4/VeN8icOvsC4KEDOzvKjsPlsl+J6S4cV0Bn53wxjigXYQelbW+OXpBGIjKSmS+2ZUrh/iTN5ZIIPGgIWaXrEMus7CobQo7nZ4xy7+3KqZziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrh8Nqtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrh8Nqtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769090148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3Df56peZRg7yuOoU4r9j2z63CMqum3dw8Q62JAWFUY=;
	b=hrh8NqtzKAS3i0VvegahIku82rxpVkFQodVwYjhobiC+dNwXxoY6s3O0TO0eGU2R4lMWre
	9aB6I3TgAnp10wvMd5fLAsY/kIjlywGwvM866tATfqdkxnS5VbOZnQmAM5sicwoN1TgEYb
	sSgy/qngvycZLVRTSc41L1Z69ZrAHVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-B-6LwBVRN-6V143gbkqI9Q-1; Thu, 22 Jan 2026 08:55:44 -0500
X-MC-Unique: B-6LwBVRN-6V143gbkqI9Q-1
X-Mimecast-MFC-AGG-ID: B-6LwBVRN-6V143gbkqI9Q_1769090144
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4358f90fe8dso673724f8f.0
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 05:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090143; x=1769694943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3Df56peZRg7yuOoU4r9j2z63CMqum3dw8Q62JAWFUY=;
        b=UbkjknLr/px0yk3A3VavEvIjCvjxbY/dAYXxblP6cXK+wf0cdxscaGvhiFnZt+qfSg
         r5FRCj/9xXmSzWUz0x04gJy5+gOzg/6G8ygTVVybRQqRuHg0dP2P+8zBPVAopyhe1CwR
         ivZTQrDt3GYnXXR0FehFobgt7GkioVzGWuOBcaTEdligauK/XXOqttjCeqaePr8OB3/Y
         Og6b9GJKsCheJTSi/voAaFRU/2KvaG+4wg3dZ1M/YIV5IJ+R96RFzSdaeWwpLvztBe+4
         rGi6JfkYpsewS6prOtpJUCXrUQzCAz8b23sRcOnbsWphME+OOpkEvHTQL4SHLA2P8qVA
         DHwA==
X-Forwarded-Encrypted: i=1; AJvYcCWEVitSc/tEso7LA2K8fahlKwNcRBB3lHcLHxcwodJv1wTwLPCTjQgPbTRfypPRSi63NB5aIduh4gj2v3ZxfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3i3Xns4gzNylN+pbF9cBlJTqeU5yjBm74uD3Hai/7W009NBtn
	Fy5XUCUFyvwNBw2YhtZP4fnKho3g5qXoUpNBN8YuafnPs25Ga9mw60JmlXk23BFrRpLmfImitUH
	EP1XU5Mj5wP2gnWKGr/tHcxO86i1vTNt2XDIlm/0krLMyv+v7y9VKNutzd7xeXa3qZNZH
X-Gm-Gg: AZuq6aJG25ZbijrDHQXb5epMQVtp/VJXS+y/Vxv22gtOEerHq0SpWbhK6kxtlRa9gtt
	ZhU2SUzMev8kx8drre78oG5KhLStyYeAvNxPlvq5q8RhLRJ4YV+JAA1Sz0dhtZzl7M1zi4oqydm
	dQWFIXQYZLD5/FnEDBQfTm+LmdCD0BLoz/JNVfRzacm0vTW+siiXD4t4bJwj2hMuHXKWjlyOl6y
	35fgAyeMkQ1+ULVnl37y+0VTszXKHgwC122z3bPxgI3PLdOtuZd6LxNvNJB3Cclifne56G6iy5e
	u3zV5StD0nQxKseTR9YJB3IrfWm2N81U4X/cePUyLpB0CyjrhQHfaaEGbzfvEbT11PEQbCD7ACo
	yo80MPgI9gDctKpdCrMIcEbHaHF9Wh0irORFVw8AAgGMTPq0mX9O15cIKeEM=
X-Received: by 2002:adf:f812:0:b0:435:9e32:2b85 with SMTP id ffacd0b85a97d-435a5ff993cmr4488713f8f.29.1769090143501;
        Thu, 22 Jan 2026 05:55:43 -0800 (PST)
X-Received: by 2002:adf:f812:0:b0:435:9e32:2b85 with SMTP id ffacd0b85a97d-435a5ff993cmr4488677f8f.29.1769090143056;
        Thu, 22 Jan 2026 05:55:43 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4359333b924sm18095487f8f.13.2026.01.22.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 05:55:42 -0800 (PST)
Date: Thu, 22 Jan 2026 14:55:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	linux-doc@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aXH7YCgl0qI2dF1T@sgarzare-redhat>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R9_tpsMZHapAo3-wVcdEM9hfVTGfWy2nsNfeyAbOjeU_1769090144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 21, 2026 at 02:11:40PM -0800, Bobby Eshleman wrote:
>This series adds namespace support to vhost-vsock and loopback. It does
>not add namespaces to any of the other guest transports (virtio-vsock,
>hyperv, or vmci).
>
>The current revision supports two modes: local and global. Local
>mode is complete isolation of namespaces, while global mode is complete
>sharing between namespaces of CIDs (the original behavior).
>
>The mode is set using the parent namespace's
>/proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
>created. The mode of the current namespace can be queried by reading
>/proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
>has been created.
>
>Modes are per-netns. This allows a system to configure namespaces
>independently (some may share CIDs, others are completely isolated).
>This also supports future possible mixed use cases, where there may be
>namespaces in global mode spinning up VMs while there are mixed mode
>namespaces that provide services to the VMs, but are not allowed to
>allocate from the global CID pool (this mode is not implemented in this
>series).
>
>Additionally, added tests for the new namespace features:
>
>tools/testing/selftests/vsock/vmtest.sh
>1..25
>ok 1 vm_server_host_client
>ok 2 vm_client_host_server
>ok 3 vm_loopback
>ok 4 ns_host_vsock_ns_mode_ok
>ok 5 ns_host_vsock_child_ns_mode_ok
>ok 6 ns_global_same_cid_fails
>ok 7 ns_local_same_cid_ok
>ok 8 ns_global_local_same_cid_ok
>ok 9 ns_local_global_same_cid_ok
>ok 10 ns_diff_global_host_connect_to_global_vm_ok
>ok 11 ns_diff_global_host_connect_to_local_vm_fails
>ok 12 ns_diff_global_vm_connect_to_global_host_ok
>ok 13 ns_diff_global_vm_connect_to_local_host_fails
>ok 14 ns_diff_local_host_connect_to_local_vm_fails
>ok 15 ns_diff_local_vm_connect_to_local_host_fails
>ok 16 ns_diff_global_to_local_loopback_local_fails
>ok 17 ns_diff_local_to_global_loopback_fails
>ok 18 ns_diff_local_to_local_loopback_fails
>ok 19 ns_diff_global_to_global_loopback_ok
>ok 20 ns_same_local_loopback_ok
>ok 21 ns_same_local_host_connect_to_local_vm_ok
>ok 22 ns_same_local_vm_connect_to_local_host_ok
>ok 23 ns_delete_vm_ok
>ok 24 ns_delete_host_ok
>ok 25 ns_delete_both_ok
>SUMMARY: PASS=25 SKIP=0 FAIL=0
>
>Thanks again for everyone's help and reviews!

Thank you for your hard work and patience!

I think we've come up with an excellent solution that's also not too 
invasive.

All the patches have my R-b, I've double-checked and tested this v16.
Everything seems to be working fine (famous last words xD).

So this series is good to go IMO!

Next step should be to update the vsock(7) namespace.

Thanks,
Stefano

