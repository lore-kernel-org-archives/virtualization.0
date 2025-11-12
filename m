Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311C26F467
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946652; cv=none; b=E/jWkpt6dAtzPIwybT5xn4l9OkGBDhxXsasMvsm8nozH0m8CL3d5gtT0RhudFOmHZKMwxepyARG30ViJx4G1CG3RCWLgJxPghqOAoEIzy+GU/lOygrvK8InO6OmAvsvLRQ9dBMWJsw95xX3L0i/gqaH3QbvAO8bDrxGDopFM9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946652; c=relaxed/simple;
	bh=7/0V7WKhYDg3U+bnov+MRIZUZa6EKfNx7qtPM/VQN+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ei3pQxOWmLFnSdfij/QkmGi8o2JB9jCQkWcHWp0CyiLt+0TMonxYvQoElIu80WddV58lgWzryFvNWGmufbiA0BcUbJocU75Wk1Zcoa/4lxUi3emDBQlm0DwMVY6/t2GYvSRQTWMaIiShSAt9IOTkaX58FyLCOImjRaEeXgWC7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/6Q6RXo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/6Q6RXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
	b=I/6Q6RXoxwVev8YX5ysYl20r7tzL/b51ReiFqmnpUgzL4OzTJqJxmx30g2U64PbMEccikQ
	u8YS9cwcJLOf2O79wHmo93QNXStXp6MQKQv0mC6GY60+WBpPtK52ffsHbf6FjvGN0HelZM
	azyvufj2LZj9NC1R9DKAbk7e08233Gw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-c1Zj-KYTNpqw-8f4jtV9YQ-1; Wed, 12 Nov 2025 06:24:08 -0500
X-MC-Unique: c1Zj-KYTNpqw-8f4jtV9YQ-1
X-Mimecast-MFC-AGG-ID: c1Zj-KYTNpqw-8f4jtV9YQ_1762946648
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88236bcdfc4so16558666d6.1
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946648; x=1763551448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRM3b2n1y1d90nSJ+/3SrEo8VmC6gmyRB7DQ+Gs04+A=;
        b=fI/gGAef9gTk6zRfqWtE//TTpJthtgBTzKX8nE1AjFeH/pJvn9Rh5RBv1MtwSxww4g
         jly6RT1h8sOzj9SVzNRIq+tiwgkIInP+VYwJUb0G3pKLNayqPBaVGG0jWEW7GkT8jczE
         4VXRjEroNBIZiJNsyMsXRQmBc+L7nkaT4C8ucvG43Ncw+lpiAMQfyZ6NHNakKYh9mJMU
         iEfWMescu9+gP+9N0yJ+V2i7pY6mCWBeW+/URfZkM5RSsGJ3oEm4hOTljUWxyHWXpz2N
         MwzGCAKbPgNasHDEZO8Tlwd9+REeNJf3pe1fE8FQa6FNkzPZ/r3QWvePiMrah4Oy8oMO
         0SJA==
X-Forwarded-Encrypted: i=1; AJvYcCXRDCjluKxVVqImmM3WhzvKuZ51QMttcH/u/2aR4XLEsh2fukYkZbLn8bPycLe5C5fd+2866JTtMPnORq/mvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtRqDeU/9Ow7tf0Ns1C/oTKVr3qRjZy6R4R8d5UXZWo2hq1+8R
	6aFV2fYGnKUnh1Hzp9T7Vk7S7nn9mnL93digOdHej+ntE8kHSsPCDjle2GvE3TuwVoinhxTBq97
	EL3TjnbAgYfoiSQDSvbktHLjRO9gqd16zqd0KwHsB6Fts9lSAEa92Du892NUEyQTn/mfy
X-Gm-Gg: ASbGnctP+mzgeJ5mkvz28TmVe/G22+v84c3S3s8zsoteAz/g0PWNg7E/c1FJWRs+5Mx
	wlA3aVKFcPQHXr/1uj5ESjYJlsYnVlih2e8rg/JeerNaM4o4ShRNLSl5N31nkrFT9y7l1zOvr3z
	SESWn/9jKmExU2tFVDJVxhH/hqrDYDe5pj5x8pv1gHAJF38s8DqOtSS/I8VqPEVopMOpaFcGdz7
	l2K6RGVgc1Nwuyg6BH412+3kvtpU84hdHM8pIbgyzcKo1nuZSSpAtBA0tsAJUOt0CJ2wwZsk5v8
	u4buxbNIdT2uma1k2fXugfmYKhWsp/b2fy4wkFOGV/BAxPWqKrW9gdLVx/MFLZGjVVkXZaswnZ/
	FmMsI33+IhM93uQRG5mwmIpwo/3f6dYL7Oth0opKdGTpGsM/mYec=
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525811cf.68.1762946648369;
        Wed, 12 Nov 2025 03:24:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi9lfYrqcHRO06/1BdvE4+TDOFgR+mc1Xy/qr6FjnRCvkl3aS8R3iVlzWEotM9WMLpQRj+pQ==
X-Received: by 2002:ac8:7f0c:0:b0:4ed:afb4:5e2a with SMTP id d75a77b69052e-4eddbdd580emr30525511cf.68.1762946647933;
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6f88sm172172785a.30.2025.11.12.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:24:07 -0800 (PST)
Date: Wed, 12 Nov 2025 12:24:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Message-ID: <jnhqclrso3uy7ptqutykcsaocu2fh26wi6jm6s5ny4eldnv7zx@4wblegex46a7>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-6-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jWbYrFxbjg7DxK0B_LMj_BZE08Xaj1704HaEWfoxZtU_1762946648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:57AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reduce the time waiting for the QEMU pidfile from three minutes to five
>seconds. The three minute time window was chosen to make sure QEMU had
>enough time to fully boot up. This, however, is an unreasonably long
>delay for QEMU to write the pidfile, which happens earlier when the QEMU
>process starts (not after VM boot). The three minute delay becomes
>noticeably wasteful in future tests that expect QEMU to fail and wait a
>full three minutes for a pidfile that will never exist.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 6889bdb8a31c..bd231467c66b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
> readonly VSOCK_CID=1234
> readonly WAIT_PERIOD=3
> readonly WAIT_PERIOD_MAX=60
>-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
>+readonly WAIT_QEMU=5
> readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
> declare -A PIDFILES
>
>@@ -236,7 +236,7 @@ vm_start() {
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	timeout "${WAIT_TOTAL}" \
>+	timeout "${WAIT_QEMU}" \
> 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
>
>-- 
>2.47.3
>

