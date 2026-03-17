Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C4E3E8679
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758804; cv=none; b=ABWgT8yY5hRfUOt+Y0WY7hCEKIeZq906ddEvL8/GILvBmZbjWuO/8UwclMOcWJPTRC4IevRqeu2SHGxQfTkx4LiVj6uzkVRomrOAq96j16rf/DBgqpuADJmYU4dgiAH4p6J8lYpzE/I7Lxvl+5mXrtZm4xmv9IYEKR50HL3TLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758804; c=relaxed/simple;
	bh=PJwDGvf6trB943jn00qkBQDhhgwKxS7QkCVGOozd50M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0jvErMm6qlc6pacD8BkYpb22EbH0RUTbQWN/QoaJ2kgV1YaBVEILZDrT7UMh2WOGlz4gcVbkgkRlwfCrAt4GVc0RrbvlH6e9YjqkdH1bwc5cuAIaZ/RqRMb+5XFWdEkIzD/XcGNKYw1Sl1PNmjhX4RrhHw1o6skpm/GzVA6B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2A7LRJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2A7LRJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773758802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYgcgasxNaCa6wbkN3+j7gIOt+KWXemXDliasEJTpOA=;
	b=A2A7LRJ/2whnqF0+5brKrBkWohnBH8hxWEE7EFVs4pxOfLKb1Ck2jPIFUpB1oFzQ00U+RF
	h20kej/4YG6VHxg+WTY4+2ezcHfEXUtODay2/xXLlfDOvCONa2uVJ1f1mCLv6P1O440J0F
	YWDpPL1x9QgOivtK8eXRNPO40LVeF1A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-GujayAlHMOmmQMEN3fRXTA-1; Tue, 17 Mar 2026 10:46:41 -0400
X-MC-Unique: GujayAlHMOmmQMEN3fRXTA-1
X-Mimecast-MFC-AGG-ID: GujayAlHMOmmQMEN3fRXTA_1773758799
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89c4885814dso511730536d6.3
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 07:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758799; x=1774363599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYgcgasxNaCa6wbkN3+j7gIOt+KWXemXDliasEJTpOA=;
        b=owE98LOz18ZmuINZvI1AyNmYle/pyZY3EwHGoziU+mTN1qLci0LBy8QXELoM8dxjL+
         xKB7gKfTGwo8IakwHuDpPnwccObn+Y8y3xbx9zokxgBjQ4/udk7EntTlc+Z5SC6BMez0
         E7bkIidto7ZD84CUoOnqxyLPAeFdkZXPHyjGtXbICqE4X5qnE5SN/L1OY4/9KgFBHJZf
         5nkseLsRIuOwac4WUQIgSK0TCxCqizIxfgI0tnMRoRAgLAl8DKPo1hnYWaXAZ0RX6lXB
         eegXMZkT7xZGr06AIkjnxuk+nZVSRvsmelha/7euEAYvkgCPxuSXVC2wQKhvV0nN+OQ1
         S+Bg==
X-Gm-Message-State: AOJu0YwY3TUaEuIRCK2zmAKbsH4XD2+rIFqw5M4lzdllOM9kanjJtof2
	NExQ40lpiCcPtYkchPbg3z1LEH1WbDzJOICGesGrRHw3f2BG9rnzssRSIcV2NANi3bsd8tKVfBg
	Lypv5TC9r46nZeMFpmG9BijWix/X3N+zKcq1YZNP95OaeTEnrgLzqgYv9av1SYW+dQ2cB
X-Gm-Gg: ATEYQzyYlD0ivly+6tlrSGTSmHYYm3tRF8PfPZG8kEd6a04I0xwYQd8yuO6Q3/R8lhV
	jVdSXP7bwAx1KmgOV8kc+iqbo1k0W+i1yNxNe2tkAkGGouGH++T8NNOQrPeV5vj+apmUTpUgciC
	8XHZn7UrbRVIc5o1TCcd+vIqI3mz+64VSrSk86E87IHLt8CLKGANGZ3tmFUa3vZvqgWsvAA+lAz
	9wWPSgYRn69fuASSkiPB6XMPC4ceSI0ZxlUUZ/TwY+UK7I5tGenUpbxiAGQOwX142nLDV9t2uKD
	W4MwzdjKMgktUKbtq3N8jF72vB0kIJbRseIKy2NH0BAqWiMrq8kSaf8SKwlwTWPc3sTUmA3yG8W
	VLMRrWELpJRYPNh7go2OCqdPG5+FL/CV/w3MXVs8v4cfHPd4y1y3g1Ks=
X-Received: by 2002:a05:6214:130d:b0:899:ee4e:63b6 with SMTP id 6a1803df08f44-89a81f6062fmr268303336d6.44.1773758799340;
        Tue, 17 Mar 2026 07:46:39 -0700 (PDT)
X-Received: by 2002:a05:6214:130d:b0:899:ee4e:63b6 with SMTP id 6a1803df08f44-89a81f6062fmr268302936d6.44.1773758798845;
        Tue, 17 Mar 2026 07:46:38 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4feaaebasm49171566d6.37.2026.03.17.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:46:38 -0700 (PDT)
Message-ID: <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>
Date: Tue, 17 Mar 2026 15:46:35 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for read-only
 nested VM runners
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
 <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x8OIyYkUn3l4w5jUUnqAYeMX6ZT_pLgsnTaIVUw1Ga0_1773758799
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 1:00 AM, Bobby Eshleman wrote:
>  tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 86e338886b33..c2cfcdf05d99 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
>  	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>  "
>  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
> +readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)

shellcheck complains:

In vmtest.sh line 45:
readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
         ^-------^ SC2155 (warning): Declare and assign separately to
avoid masking return values.

> @@ -451,11 +464,14 @@ vm_start() {
>  		--run \
>  		${kernel_opt} \
>  		${verbose_opt} \
> +		--rwdir=/root=${TEST_HOME} \

And here, too:

In vmtest.sh line 467:
		--rwdir=/root=${TEST_HOME} \
                              ^----------^ SC2086 (info): Double quote
to prevent globbing and word splitting.

Did you mean:
		--rwdir=/root="${TEST_HOME}" \

The first occurrence could possibly be explicitly silenced explicitly,
but it's probably better to really address the latter.

/P

