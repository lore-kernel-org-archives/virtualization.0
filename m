Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447B331233
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581283; cv=none; b=uMi69uIvwNefTCXemSMiSUGIpnxRWSZ6RPf2OhvutPbBotkKEbWSccmA1j9Bjah7TQooOnV473x0dx0VEBqRZASwUI7re2hu/Eq7Bm3aJwlRDYFJ04NnjvAKdq+dLC/BZxEuFiCrhfGfZkoTXEUpLB9JyrqYty3x4ItMz7q3pX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581283; c=relaxed/simple;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KEif3adCVRqrqSZsCBekJAhxdd+5Z+vv7s6plL9+nnt90h4kWTY2c2skc8y6TOZUhwZBoj/8J8+4Pvn+epR7BpWNJiN4MH985bSAHHtxKU03T7Js715uk61pDPHvsWFuiU+NhV+W+uv5yOfxkSkFbu41+IOTd3EN6RacOynJr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAGu+9Ld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAGu+9Ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766581281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
	b=BAGu+9LdkgXJve6guLUEb/NUDKR2WiUSbkG0BwECraH/zP1zfNijwcQnTQ8aJl+dXopbvz
	0pn3fVxQTiYjpbRQcI6MmTFKKrU4tmkwtfDV4HYHpOn3uBlKTmitFYVbqfeItwNdIfYS1w
	3ob99kfYk7CVJB5aUlEsIWCyltQvSr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-tDxrRurcMZWUIti-SGdCQA-1; Wed, 24 Dec 2025 08:01:19 -0500
X-MC-Unique: tDxrRurcMZWUIti-SGdCQA-1
X-Mimecast-MFC-AGG-ID: tDxrRurcMZWUIti-SGdCQA_1766581278
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso57717965e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 05:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581278; x=1767186078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPltMTzBETTQT1CqF+sZl3/fAao1GzI/HXVbssWVgUQ=;
        b=lvU2VihRtQb2T4bFn4ojITKzX5Yc1VdTrKPO0P3T06+4bGjB4sh4yAwIku0lmASR1u
         5mzYwauMkQEFnKCdSoQRHrME5FDBeVMKCIXE/Dkt2NvONyUPIbH6B67+0OLhfl5zRKbR
         c9ZFLiVKCdDR7BP+WOF8s64maEDs419vuTRWO4TbAXJONGiQThkdkYym6q6ce0HiC/ee
         5HZUEsWLY0Z0Npmm8HbThiV+Ex1FtPpnVClMIG7efEKTtZRE6jk68m5FGIRE86qN1m9q
         kOU6kXPrw5hDDT9EhtmKYEZxUudz8pydlG3fHkf7bMcRO9iFUiDCH+Il24lhIXAHN1Om
         Wy0A==
X-Forwarded-Encrypted: i=1; AJvYcCVqwnqskmxQWUfUQy2HHMWgKncgKU7INuucjmA1cCD7hHNrrPM58oONbZ2XfXD+IR1KWm4ibwXA5IGYNN7S9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1BdLoISJ3rgNc/ymGtul++jLGa4yeflW8rt/J43H1SEHckE4x
	OPZ8vpzJzfR9riiwxbyefEYqJrVQOS0h+WRkxfiBNMsm8jy3a8ZFIU+9UQCw24RX7bwcLgDaUeQ
	GRF9SSjp5HElSTI+2Jly0HC9I0YIVmIEngpELMLXB0tz6TQArRO+oU+qhUZvVNHsxM4MD
X-Gm-Gg: AY/fxX7SmMCXJwXnWeNORBqJrjLn8hzhJWfi3cIVH2qEKlDJrg8jhU+ObPe3ERinZFt
	C7FrqaYtDCE8wEemC3Fx8GbgzYJorgKlcVBOP6NNLGjeRh+ZNpayR6dj9C9uW5I0YXwQkqrabnm
	P7tReP9Idtwiu9ZKrTE4Ajcj+CQMpLbuUJWdIf4GIIWxcr8Hb2q9lxOkxfMjUP4HyZoZvjrv3Lv
	YhEMoxbJLwjGDOdp7PTaQPnCn/VWS/jCgsVdkFBbvNB3HLtvaHqGGSPQslgaM2z8UpphdPP2z/L
	uEfGoZP/uK7cWKJKcSLCEqmPOrugxYl8IMxQSzr2E5Vbzw+/W0UB7qvbkr2pLwFvzORltpowhS2
	akxoUxhZRLn/Txqqj
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759755e9.9.1766581278174;
        Wed, 24 Dec 2025 05:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHybeuqcZcHlfztr3bbKh1cFE8NLb3cLhTczAcvHp67h5Q0r41aRhsvZBwseTxwsTVGzvf/GQ==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d18bd57bemr161759125e9.9.1766581277580;
        Wed, 24 Dec 2025 05:01:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm339791035e9.4.2025.12.24.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:01:16 -0800 (PST)
Date: Wed, 24 Dec 2025 14:01:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aUvjj1HyEG6_hoLR@sgarzare-redhat>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
 <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VVMRbCUXDJHxwp680NXSASducJP6wezU2Gp73VZdJno_1766581278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 04:32:30PM -0800, Bobby Eshleman wrote:
>On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
>> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:

[...]

>> >
>> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
>> > middle, I'll do my best to take a look before my time off.
>> >
>> > Thanks,
>> > Stefano
>
>Just sent this out, though I acknowledge its pretty last minute WRT
>your time off.

Thanks for that, but yeah I didn't have time to take a closer look :-(
I'll do as soon I'm back!

>
>If I don't hear from you before then, have a good holiday!

Thanks, you too if you will have the opportunity!

Thanks,
Stefano

