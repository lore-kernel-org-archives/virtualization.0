Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF135280
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743994473; cv=none; b=CM4kssZcAuHl6H9S+1Zg+c2PeeWNPl3YoNfAc0SA0pSbC3O4jZ7NEelRConJzb4Z1e/M2VrXeC96dn3j+S31z97crhbgBYa9AFFO5QWKpcVDyHHrqc3m19vETqfpUqd3KHBVfmTKbBXE5+s0WODJsDlx8fbyYLcBeCjMIhjCPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743994473; c=relaxed/simple;
	bh=78VYBtVNDDMVcqLfVurU2jzF/nks381crfP8S6661CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHk/GBW/78ZGRQ4vDVBHtkO3PyY/G1CzCdGXP0uIdNVSAtMytxbJFnW+vO3PQs1Y5ypJyU/H20s0dW3vPJe4gWkHvCz4YApaR4Y3FkkxUxBJGVOM7mAOd1xalvcWwyf9jCmYIbwKfSkyrne3ZLQsSr4IXaod1EiyX2Xjg+z417I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3ljwfo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3ljwfo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743994470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRYTVXsNSGpfzKQctOT6faNFmutksfxmob0Nbhsev3k=;
	b=P3ljwfo7LjuHp1h1RUFkopyEtytYnsgatc+6SyKMmyahnO1fQ9LUAFjGh+TwCpzsZSXfjl
	lZcwushdumSo0Wwy5t2JEXeMZz4fSvbjryfomEGCtv4nLyzCyTnvnjREKx4bxIoGy6eeLu
	lCKnU7remxPLFdf4XPFELEg1v2sBLVU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-swIB-kX-O_aHQRwqJ1xkZg-1; Sun, 06 Apr 2025 22:54:29 -0400
X-MC-Unique: swIB-kX-O_aHQRwqJ1xkZg-1
X-Mimecast-MFC-AGG-ID: swIB-kX-O_aHQRwqJ1xkZg_1743994468
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af534e796baso2335992a12.3
        for <virtualization@lists.linux.dev>; Sun, 06 Apr 2025 19:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743994468; x=1744599268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRYTVXsNSGpfzKQctOT6faNFmutksfxmob0Nbhsev3k=;
        b=b6Ti/olQrSxCMm2aGWm5C5YY1bE6vlvUaUW9AEiMcZrkZzt3TrOAEhPbpIAnZq7HDA
         itDkvtcT+w8FJ+aOyv+v3ItZvZM7lyC4gbybA91+d5oxvUqD+9ODJhULwCFPyEjq4/SZ
         XfH6HJiUr8npIChi/Ic5yd/OeHbmy4m7zfyYZ0nIbEKOLC2a5af9BtN8E4oY8fM/Rajz
         ncsao2A5cWN4i74gXwaaCNGrnPQbLYN/5rAyEiAT3SDg9CgwOV3oiF36hRKcjzzu15ht
         LS081YL9IObMHEmVNWB//wkKeyfW7FHPvfKQEfp3Q0nzsgfxhFNDgiGSr7CiA5+YXsJe
         Ckvw==
X-Forwarded-Encrypted: i=1; AJvYcCVl4JUmNs5nxlDTZiVhp20nYARZQ2GXwpFhCobER2TZLTzZp949Oaopve3p9RACq3AR/CYoQhNxoJbbLDjrtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBjMAH5qNN6RynHUWPpoMS2IDRtxss2ljq3On5FgGSWZVlZKec
	VQO43YvnWQKLkndyQaa7Mqb58aQeIs8vGETTTDF4585cRaR7Lb+M2oK4AQ4F0dBHVKmjpIm7hHo
	P9ouPuU5iX5m2KgyHqrdNnHMMaRowYAUsLXwxMTx5jtTWZn16s4HwP8V9Xe3+cnv+JYLBAeI5uW
	wt8nr5PIy4TjEI/tJcSgqDsB9YyrSdeUoi85ZeCUI=
X-Gm-Gg: ASbGncvV2C06dJmIfJfVylCXveaWZUw8Rg1nYof9+Fno3Chrhr/BgjnPjQs9Hz0Rr/B
	wCE674fkmGYq6g9y38t/jAwOXsDFpHCk4MISxja7XGaJXGZZbPepANgpPl+qxAPlTaoHB4A==
X-Received: by 2002:a17:90a:fc4d:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-306a612a138mr15338039a91.9.1743994468413;
        Sun, 06 Apr 2025 19:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXA7LEkfeKj+UJM3EgBo9JimsT+EXs1f53vLTWxMaMpQ0p3dYoCeDfB1sKILY75A1/XhDlE0eb1/3ARXiXCQg=
X-Received: by 2002:a17:90a:fc4d:b0:2fe:80cb:ac05 with SMTP id
 98e67ed59e1d1-306a612a138mr15338003a91.9.1743994468043; Sun, 06 Apr 2025
 19:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250401043230.790419-1-jon@nutanix.com>
In-Reply-To: <20250401043230.790419-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:54:16 +0800
X-Gm-Features: ATxdqUFts7q2N1G290I9w5fzC7i8BKP_qVhbpym_CyiIkKmnXdbijEE_7p0Hj9Y
Message-ID: <CACGkMEty2SC--kiq64yfgWQ-q6Fg8b0+Le-dUGMaJgcOFhosRw@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Defer TX queue re-enable until after sendmsg
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mWYwKBB5DtW6WHvna2IVPHDI1y2ntQV5ZK7fgT5VQL8_1743994468
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 12:04=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> batches up to 64 messages before calling sock->sendmsg.
>
> Currently, when there are no more messages on the ring to dequeue,
> handle_tx_copy re-enables kicks on the ring *before* firing off the
> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> especially if it needs to wake up a thread (e.g., another vhost worker).
>
> If the guest submits additional messages immediately after the last ring
> check and disablement, it triggers an EPT_MISCONFIG vmexit to attempt to
> kick the vhost worker. This may happen while the worker is still
> processing the sendmsg, leading to wasteful exit(s).
>
> This is particularly problematic for single-threaded guest submission
> threads, as they must exit, wait for the exit to be processed
> (potentially involving a TTWU), and then resume.
>
> In scenarios like a constant stream of UDP messages, this results in a
> sawtooth pattern where the submitter frequently vmexits, and the
> vhost-net worker alternates between sleeping and waking.
>
> A common solution is to configure vhost-net busy polling via userspace
> (e.g., qemu poll-us). However, treating the sendmsg as the "busy"
> period by keeping kicks disabled during the final sendmsg and
> performing one additional ring check afterward provides a significant
> performance improvement without any excess busy poll cycles.
>
> If messages are found in the ring after the final sendmsg, requeue the
> TX handler. This ensures fairness for the RX handler and allows
> vhost_run_work_list to cond_resched() as needed.
>
> Test Case
>     TX VM: taskset -c 2 iperf3  -c rx-ip-here -t 60 -p 5200 -b 0 -u -i 5
>     RX VM: taskset -c 2 iperf3 -s -p 5200 -D
>     6.12.0, each worker backed by tun interface with IFF_NAPI setup.
>     Note: TCP side is largely unchanged as that was copy bound
>
> 6.12.0 unpatched
>     EPT_MISCONFIG/second: 5411
>     Datagrams/second: ~382k
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  15.5 GBytes  4.43 Gbits/sec  0/11481630 (0%)  sender
>
> 6.12.0 patched
>     EPT_MISCONFIG/second: 58 (~93x reduction)
>     Datagrams/second: ~650k  (~1.7x increase)
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  26.4 GBytes  7.55 Gbits/sec  0/19554720 (0%)  sender
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

