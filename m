Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C030C364
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946897; cv=none; b=o1RI8yKEikU0oT2eISYjusVfCskFE6A5W0dTltNB42Xji/OZEjdUdoPGhhqh0wbqRa3lXl9bkV20c881cFPBr2d/FAIgoVkikQjrOBXpPu+WwYQzbJD5jm9MggsXlF9e1KaTAjD5QYK0qXckeyYykSXkDhe++mYqMKMOu+RvMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946897; c=relaxed/simple;
	bh=w9b2RxEPIpBQFFaebpQtwOH3HfQgFg+EyEqHMhWr7p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QzfkEHYa8UuWJcm+PQ6L+m5mCRcSPl8Dk9kDbxgEttr8mGdBxBcwsUc+d2UDljL5itBs+9rs8uRk05Zd2Xy1bCl13Etv9/HK1naNkXEWmgPmRX7OdTgBm+pYX54SH3pNuAbBpAnTMOotfv4aP1ik0TJl9PSqkeMK8sHwagaOUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqWLj8dR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqWLj8dR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
	b=XqWLj8dR0UVXIYp3mQjGTZjR1Yr7Irn4ASejy+/Y/Tl2C3Y43g+JRCj5Cd6tSOc9hBASBP
	Q7O8cgW7xWmGVN/265FJk7FOLHFHbldVvHS6Jfluqq7LVHDxhE0RfytYtvzW4FanH7wnST
	yYkseaVlvXwDwArGg1PvGlDkeSDvz7o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-4HFV31dcMdWujaQz56SYOA-1; Wed, 12 Nov 2025 06:28:13 -0500
X-MC-Unique: 4HFV31dcMdWujaQz56SYOA-1
X-Mimecast-MFC-AGG-ID: 4HFV31dcMdWujaQz56SYOA_1762946893
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88233d526baso22274276d6.1
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946893; x=1763551693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=iHzY14APLmK/xecpD8nfqcjkCaKBBo4/EaVGi1HhqAZ+YAaPreFE9WHdgTf6HCWNc/
         X/tn3JK8IEbTL7VNAIqjq5DKtHsv2wCaeziQaqzWokwg8G3l6kA0kPfIQSAutw2cSQlW
         eAc2POoKGx52xMCpbzDReiRfUJk3NaAX5yXfj35SRPtqaZ5GGJHy7yqtnUQxwcBeoOmg
         Z/Ey0Zn0zHwEtGjsSf3G2JqR/Z3DlOs3eHloj+cpND8dfvVyiOdneUt4Mrb632ECNOMQ
         Nvjk/NaaMvXGyAK7mOI0oradw34hF9wICHicWVmc/dzBdstbe2cHRk3mp69jCVT5HbyD
         WX0w==
X-Forwarded-Encrypted: i=1; AJvYcCU8WnB1mqYsnZ3qoGvYSoSaFwvCswcjjAYB3vESp2Kg/8d6AZqNA6AwXYAxiDswht+XouvKqrfKYPHgiMYvKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWquihw524DSTstYcfOSELbYWANPCjAfAfEZBjUue1LFfO3Gyo
	SBeK6NIUvmztASMOGiWLaMiikALTxDPNtC4dq+xmbotMtEjHCt4aB/BjBofl0PFDXN5wQ2UqUde
	F8Np4m5byUVQ2up1rAPo+W+YBRXB3zCSoWMRwTU5XELizeqm3LnQkTD/ICE3IaHbSHQH6
X-Gm-Gg: ASbGncuS2OQsjgKBYNXVKe04LUmfbj0Ka25NxoYYUVDFR9+XrJiV1RN3GUcF6KPywQ7
	3CapA22U/Y5KdtyDaqYAUQVgfMZzu8pSwZ4EnUB7VOCPHJUvVXWJ3CYmzqzbXVY9LMCWNT1gIiL
	stW1fhZvL0H53dbgjkJtVv/MNKEZ19/gblfuWbQdYsY9z4ig14H0nXkkk7XOwNLogbNKpyjMGsw
	Sp6KHy5B1VwiR7YWi8smjgljGXIh+iDr7fs7FYgmEXIIrSTmESSqbPKZZZKY5zS7xKFmPMGoSRl
	VSHOK+rE8yKt5hsrRqC9UuGJpCahCUW+zg+7FQIx61dhV3ysbItstpa2QAn+9guwqtqR+KT0sEP
	h/wcyAiDryK7KS7K/txe7yqcyBFfo9/dyYAXUhKdDlspk3h9ngPg=
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352966d6.35.1762946893350;
        Wed, 12 Nov 2025 03:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnA7ozYlvXHQMnpycDhkhnMaFa5erx7IOPg689k7NBMlvaatOo3MEwHXk4xMfYTAwAfX3oqA==
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352786d6.35.1762946892999;
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm92866156d6.17.2025.11.12.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Date: Wed, 12 Nov 2025 12:28:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Message-ID: <r5uyojkue5zgoiixgmrjoew6pe6p7jzhd4hsudoxdirwummht3@fclnufaabg6g>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7uNDDroSdCQaa1wC2IeoL3_VkyRXGrjlC9Ibk9rB9gQ_1762946893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:01:03AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Disable shellcheck rules SC2317 and SC2119. These rules are being
>triggered due to false positives. For SC2317, many `return
>"${KSFT_PASS}"` lines are reported as unreachable, even though they are
>executed during normal runs. For SC2119, the fact that
>log_guest/log_host accept either stdin or arguments triggers SC2119,
>despite being valid.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 42e155b45602..c7b270dd77a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,8 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#
>+# shellcheck disable=SC2317,SC2119
>
> readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>
>-- 
>2.47.3
>

