Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E33A9DBF
	for <virtualization@lists.linux.dev>; Tue, 20 Jan 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901862; cv=none; b=PQkxVNQRQFfpPsUlCEBIdRwb/uWgWMUZ28xMijg3/Sz8hwKyKM2pRYGrgkMcGBnBL8U5T2S2BhutMON2gv/I8nMg3sIbjG4U9gpY5nDVTsjkKiIvkMhxqD+BGAGEtBO8UmuegEupDWjoJRyXnrGE6sa8i57aqdSLFwNQW+mvU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901862; c=relaxed/simple;
	bh=gJ8LRdePpGdfZIJ/xvuV9faBPChp54PHBmUoMXirzAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FnIw8NG7IM//FdSb/sxgaQTvYh8jXcvpShctxt8ArC6MVCqlVcRhuh9pS9GTc8F1UN3teX5+h7VBpWPrWRCx3LI+IjvZznS1I6RXIjAzBETifq+Zv9nG5We50EAFHGxWi9L1jDXZQg8SLKsR8Gx7rVcwR9Gp72zFJ/n4YdaXHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8+JF6mM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8+JF6mM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768901859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1riUelQkHubbog4Pig/nehvQm9nmVpndQsv6Cs1UVao=;
	b=K8+JF6mMHL76bZxS+ci6CY7KEnR5jdjxJGutZ+fuCfQlF0fbr47SzwJjAOKJRQ0ugF1xb0
	2Y71nRwmVtTchM1c6Un9PoE5UDZrtlTG8co6aH7HiMY+vimmGji2SprwxZjyjaG8yEzvWS
	uC2gzmgydR7cJT0JMc9UHzoDT7IdtXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-dCbRQOkuP3qmKGji1nF4Lw-1; Tue, 20 Jan 2026 04:37:37 -0500
X-MC-Unique: dCbRQOkuP3qmKGji1nF4Lw-1
X-Mimecast-MFC-AGG-ID: dCbRQOkuP3qmKGji1nF4Lw_1768901856
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430f57cd2caso4293342f8f.0
        for <virtualization@lists.linux.dev>; Tue, 20 Jan 2026 01:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901856; x=1769506656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1riUelQkHubbog4Pig/nehvQm9nmVpndQsv6Cs1UVao=;
        b=tnpofcYRLTpB2Ldlrre6jhe0dY3POqlNw8sSiJaKaltItFldY8iA1bjnW7pPAIC9Ls
         jN6eEqD0bgQKhHxeTHPUZ6fZGfdzaXcmDfUnvcmI+/RVnPUglKA4wBs0GSHd+epOk7tP
         67/WMibwR8R0yjuWS89bs74CL4YczY251kHVgURW5tgJmJ3NSFC54tmEYPxx1AtC7Jze
         viqfITd3YP4dgNhnHQpFZ5a5pAwnmcg8d/EyU0ORlXTUjvWXnPgXlxXMHyG00FRZXp60
         p5kYEUPkAO2GnphcdOz7OJ45gU50dcpargaaaqFO1RTtPFt5ke2q6WYzlvPbNvVi3Mbj
         rkHw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5GYMalqXSUtt8KXwhIfuL4/beUdf630f5i5O6ak0xXjO6JgMUSaWzcf6BF+unbXyPDVkwa+u/5jtUjsbOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUuynBBBKshHHNRpz8mT5L0TDrS47QFgSp7nyLzp1IhPXe4NIZ
	vsnaLfvib329geNbYXBjn9FQn6G8LT39p8MjyK7428Me9w2oQc6mngbm7v+RShm4aNt4UrhfN7U
	/Syvevx+cmD6I5IJKJj2s0ml/X9Yv3f4XC+3dChyUc6oJ1w5FdcniB+7JWhxAabetTOY+
X-Gm-Gg: AZuq6aLjTaE2PpIlmwIrKlqMpEP5WduFuNrycYWw10tLiR+Ep1CMadCS8Op2YZFTcRT
	SO4Zv21zkBYj/qH3iV1LLImTuMSAwqbApayKb4i1l6/8PleGuXsvRCadL06ha4TU5lORLpOw3s6
	CcakMBufxPmlxFAdU0inbA5pM4gCXQFb6m4F6RZypxSLOL3DsvfQ0EIt2SmGyW6MUUROlNso1k+
	Ktyxqf0O24awHsjxXukYgBc3zVZOnh3e+qvHafiwVvWnypGJHGhPpsy8O8A9dZShpqvpb2lcF1u
	q5lsXrHqgWukVt2baksB8H+/MwB457B1fx64vRswiOChKLvcYPmpn3Y1Fc1dB6eROrABfPbgMKl
	9aErnuwUkUb5AX53/JWd+oBmmWseBhx7g84SUqsALwPAkmlJaXwILBRs7e28=
X-Received: by 2002:a05:6000:2f83:b0:432:5b81:480 with SMTP id ffacd0b85a97d-4356a03d2demr19167518f8f.24.1768901855992;
        Tue, 20 Jan 2026 01:37:35 -0800 (PST)
X-Received: by 2002:a05:6000:2f83:b0:432:5b81:480 with SMTP id ffacd0b85a97d-4356a03d2demr19167470f8f.24.1768901855514;
        Tue, 20 Jan 2026 01:37:35 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cefdsm27663754f8f.24.2026.01.20.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:37:34 -0800 (PST)
Date: Tue, 20 Jan 2026 10:37:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Asias He <asias@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aW9L0xiwotBnRMw2@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
 <20260119101734.01cbe934@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260119101734.01cbe934@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aCRrV86u2Zu7ACZNLsA0v9AlfO71BNWI7JRR2rRTors_1768901856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 19, 2026 at 10:17:34AM -0800, Jakub Kicinski wrote:
>On Fri, 16 Jan 2026 21:15:13 +0100 Stefano Garzarella wrote:
>> Resend with the right cc (sorry, a mistake on my env)
>
>Please don't resend within 24h unless asked to:
>https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

Sorry for that, I'll avoid in the future.

>
>> The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till
>> v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/
>>
>> Since it's a real issue and the original author seems busy, I'm sending
>> the v5 fixing my comments but keeping the authorship (and restoring mine
>> on patch 2 as reported on v4).
>
>Does not apply to net:
>
>Switched to a new branch 'vsock-virtio-fix-tx-credit-handling'
>Applying: vsock/virtio: fix potential underflow in virtio_transport_get_credit()
>Applying: vsock/test: fix seqpacket message bounds test
>Applying: vsock/virtio: cap TX credit to local buffer size
>Applying: vsock/test: add stream TX credit bounds test
>error: patch failed: tools/testing/vsock/vsock_test.c:2414
>error: tools/testing/vsock/vsock_test.c: patch does not apply
>Patch failed at 0004 vsock/test: add stream TX credit bounds test
>hint: Use 'git am --show-current-patch=diff' to see the failed patch
>hint: When you have resolved this problem, run "git am --continue".
>hint: If you prefer to skip this patch, run "git am --skip" instead.
>hint: To restore the original branch and stop patching, run "git am --abort".
>hint: Disable this message with "git config set advice.mergeConflict false"
>
>Did you generate against net-next or there's some mid-air collision?
>(if the former please share the resolution for the resulting conflict;))

Ooops, a new test landed in net, this should be the resolution:

diff --cc tools/testing/vsock/vsock_test.c
index 668fbe9eb3cc,6933f986ef2a..000000000000
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@@ -2414,11 -2510,11 +2510,16 @@@ static struct test_case test_cases[] =
                 .run_client = test_stream_accepted_setsockopt_client,
                 .run_server = test_stream_accepted_setsockopt_server,
         },
  +      {
  +              .name = "SOCK_STREAM virtio MSG_ZEROCOPY coalescence corruption",
  +              .run_client = test_stream_msgzcopy_mangle_client,
  +              .run_server = test_stream_msgzcopy_mangle_server,
  +      },
+       {
+               .name = "SOCK_STREAM TX credit bounds",
+               .run_client = test_stream_tx_credit_bounds_client,
+               .run_server = test_stream_tx_credit_bounds_server,
+       },
         {},
   };


If you prefer I can send a v6. In the mean time I pushed the branch 
here: 
https://github.com/stefano-garzarella/linux/tree/vsock_virtio_fix_tx_credit

Thanks,
Stefano

