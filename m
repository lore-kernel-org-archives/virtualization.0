Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9930E0C5
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946862; cv=none; b=Yamun/KXmhJ7WhT6wLfnZaJ1PbT/OLc0lWy+/OE7wxYm3RABAu/S0c2KnQqOXib0k/dKouonKB5reMti3KUZUfHTfSFEqybPA6Fp8UuWZCNyEvZlkGnTA/+eH9scN7bWQKBX0ppJr4wPCcTHzYzd3nzAMlP+XqyetllRH7gVYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946862; c=relaxed/simple;
	bh=xRBVszb46PCRdqH1h26lnmIbsU3o+gPYt33KkTm/MtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T7wms7ZN8vMqaM7nqTIRSXcJ06YhBNFtcQ/IEYe5ZKrF0oRhQjxivohVQ6FzYH/lsp1FJsJShEmAsW3DmZW6mX4hd09pdM2j8AK3MIghs0VgkMgAPIxAgrhGv3qz4Tn+qiJzuuAE51M/jv1eMJHud7B1ljExpvYLsrfJiF0C7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UL/xRgqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL/xRgqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
	b=UL/xRgqYISFIpUCC23pav+X9Afc3zSklz6Ni1wzKtpHgxd0fUiBd0SiZ1XbJxkgLvQu2lQ
	m85OkaYKSPhJpjPVo26hA0mc7Aik7XMBuNDsZrMa9lnexcL5bucdw++I9zRZ+kxDbxHGNp
	Q4JIaQBEPkiIpLc/2nXKCfXnG5cjYQA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Iu-cKXHZOpCt56cQR-Nzqw-1; Wed, 12 Nov 2025 06:27:38 -0500
X-MC-Unique: Iu-cKXHZOpCt56cQR-Nzqw-1
X-Mimecast-MFC-AGG-ID: Iu-cKXHZOpCt56cQR-Nzqw_1762946858
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b244ef3ed4so197789485a.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946857; x=1763551657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh9ROHXwX8NyJE0uRznqL1+0stTxgI+FrZIpPuJINh4=;
        b=mjGfKyszzlXC/2vbVjdjSMIhjOaObRJJ4yD3fMUXCymWaYroXuNRphMRcCqjZbwqz+
         FhmfB0HO+Smjyfj3vEiCJtVZQsCPkp5xKsJmmrsw8Y36RJY86EwzIQN+DveBCSp+oBXE
         txYmyam+gjHZBd9FYeV5Tsc9q10qIolIcMW2jozd0IDIGIQx+3huPUw2/7toRRhRK9Xt
         KkTBm/Asqb7i+lPTsxpp/grnbsIjp0s0zhEWbIjn4tBmGsuKqLLY6cztgnlCvl7xbUu0
         SaIHE3HZMkvwSdFhGO84b+TKoecdQ6VbHsDHgEsX8aHvihM9ro/EtEvgSlM7HA/Ctzwd
         1yLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMqaG7a8ta9rciJwVY111lyQkcj0XxDHi6V1AlboOFQvI6xImYGH8JAjnwKmkcvbotvWCLRiTVD/0WjUVWkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwolB7KjdzOqKD7yQ6gPW6kXEblJGCU7RjwVbr24XXW7D3vAlXh
	PLcdo37S5tsurvy2lLrFelC5eWmSn3MJY/Wu73kSI1lmH1qOSG5fPqvSl9pDwXTxy7HLjlHYYFt
	FXGwdmPt/VO1ulL6u9MjADWiIl8MxdGUR+CHKjj+ASEv51G68bDcG4tf0ERZM5hbOwvgT0kceDk
	Kc
X-Gm-Gg: ASbGncuE3XxjgosVBKaVqzDUfkrUo4Qnbrb9oMyM6HcQ/i5k83oXRe+RqFKe3bF/Pwd
	kM/y1dwWk1HYJ49otYKqLkCCsNbruRQ7yQrW9l7jb6uiRN97D4mERxSw/uvbX3fUn09tJFfanZE
	n+tQChJIXrJIODsUKjphTnEN1KdPex+jLEFqEpbmzi2IzG62ifTSTQ5+i5qQKWPbRjaV3gtqyvb
	STo5gBG8D3dEmX9u85Q8vkUHZZ/m2gTgoXxS85CSZu070oOlzMOwrtlBT+4FFeDVWTbJL8D4LaA
	M7i20A/gS/mWDRvi1qL8TS11UPbRgiAPKrJ0ySlSo75oBz9ZqeTVXc/7uBXTzY3pVVN6xCBfnMK
	FCiMOvwyWpWkfyO7CVECztZHkjvBtkSeujp87eGpAgzt3w+yZzLQ=
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300897585a.6.1762946857235;
        Wed, 12 Nov 2025 03:27:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1QM6xpF4cwT0P5BoTaUqTULeYAONrpImDd2Wx6DOvB/yt3c13Mp66Q8AvPTabRL1NdGvMrw==
X-Received: by 2002:a05:620a:2911:b0:8a3:d644:6937 with SMTP id af79cd13be357-8b29b755312mr300895485a.6.1762946856845;
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa00850sm172322185a.44.2025.11.12.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:27:36 -0800 (PST)
Date: Wed, 12 Nov 2025 12:27:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Message-ID: <ay3utqbmbi52pizmrp6zrcitxjftyghfkotjamgeicwlwv52sj@j6jfpj35rssm>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5MwncHWv9gK6PosRohnd6twyS2an7_gvYbFAXpaSWgc_1762946858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:01:00AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the definition for BUILD and initialize it to zero. This avoids
>'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
>set to 1 and is later checked for its value.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- remove fixes tag because it doesn't fix breakage of kselftest, and
>  just supports otherwise invoking with bash -u
>---
> tools/testing/selftests/vsock/vmtest.sh | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index a1c2969c44b6..e961b65b4c6e 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -548,6 +548,7 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
> while getopts :hvsq:b o
>
>-- 
>2.47.3
>

