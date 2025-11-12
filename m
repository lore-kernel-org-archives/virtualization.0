Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139627E7EB
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946140; cv=none; b=YODqS9owOxgw0VZf7TTNePG020wliYduHnLVPcxVCrZ3KSikf42zgTKhU/KMXNm8fbMFxtnsAdaPuvqKWvmFWwoDcMyDYhrTtpV5PxOXIseOi3aKDM73Kv3pLHOaL9A6f2f+9XZ4Z8EKSROIUOkYXyKEODNGdVhFO3vIHjVGOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946140; c=relaxed/simple;
	bh=KV9j6tjQ5QXn5f8pxeC8kmzLrI6wkQRac7WkDx7/HyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wck00pJdPBEtYFslaFfS8BcDa6RrZCHoWltsSrC05SUFnHByiGtXg4GjXdM5GLCHPd3jF8GpZ88WGKH1g/yRJCTDf+KtLTNRHAr0TOcCd7UXFUH7TsVDRswP16XBFmHA9f1u6mO3xrzP0bWWdbPAU4jj9I4HS4qI9v331hv3iR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxnYa2lv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxnYa2lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
	b=dxnYa2lvssxhY0vJN36ScAt/rGj0LFpMErGC+Ms08eOqdEydR/M6+S8vq3FrINSBjSWjW7
	8PvWGxEO35T/GuflVsidf1bSforRuxt+BujyInLlDIZLC8gSA1IX1GwtxCQ0m7Ly7S6PCL
	leE0eiU1ZoHDqQV/jb4MPlSkYVXXnZI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-clUs5_0HP8ehOxqXU1Tw7w-1; Wed, 12 Nov 2025 06:15:34 -0500
X-MC-Unique: clUs5_0HP8ehOxqXU1Tw7w-1
X-Mimecast-MFC-AGG-ID: clUs5_0HP8ehOxqXU1Tw7w_1762946134
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb3eeae67so27188011cf.1
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946134; x=1763550934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VmL1OVkwxFNMuOuahfScs6JqfQbzrAAR04/d20fU04=;
        b=wbtkroRTLevCkpU+a6dTypVD5xAkxhIPNvSeQ33BQmNywvP8yWrTxiVbZAOWCzUwWp
         jezaQI1axXRTPuEN+WWVYk6wz48D9fv5QFBA3D/qqYVI0QeDmSeuv4kS4oKHMv3VLW0q
         cS3LEskq6jlT2uA5q03V2lmy3rMfC9lkkTNUjoH3FLiGLUUaUooBEdLpIruP7BuAgbT5
         N4AIErOAcwRTy4xqSzQaX89e+XBlocAIFYzslvuqOIJGhHb/WdFknU5CtnPpwdMQUSHZ
         55JL6nuqgO+R9UeZqaV8Xj7ACufYvJkZ3AnLwQ+qspDN0iTDJMIIwXNUzJ1UlLCvAsEf
         RPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVI1hCoT+ONoNIUuclulNT1X73pNQ8+3BbwDwyVKbUAa+ZCtS7y+vwuQSTxoj+mfrGpeLyJjk+J1qSKN+iYlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8HY5k1Yi/jvVXgSKxJC4wG1Biy8nbMsbiopQI5KiW1+GPW5+7
	z0z8DNoIqXYgMx1B9yDuqHsKIDxsMV7eA9ZnjHlMIXEE+wpEjhb7kOpOv9rAvmhVbl5W3/u4vsC
	SCcBXdcFb1Kj21I+l6kAwG97S6EhP9Ex3PZJ545w7056U9FJApm2CIsuFgT91MybdDi8B
X-Gm-Gg: ASbGnct+y0njO2CFMehS2/VFtVwxi93KA+gTxAWkQ0dPjMJ7pl0NvJ5DyMg2j+e1v3x
	14WaxyNZ2irh8kC2auRftGklLgNBQsKUdFCyTboOV+lqxwUioBEOMgpniyQXmTsQmU195RhR23V
	lxVXvBZxyAySD4MWENR90yHbZtVviGbpVXthDuAeYKsgtUcvbu2t/1Jwdb4d+t5znBaV5y6B30d
	L2kUM4WDcW7Xknfz+buVTIo240J7AYgPYmGp4oi4svhAP50/9xvbQgLV/h0noo+jX4Ht5bYfFJG
	Fm9K7MdmxLBbyMc9mLg4kKf2Zwaia0Ya9w5FQwtJrbcju1wJWpFFcUq8bg+wxAfCJLOmfuccmhC
	EaB/l3NvenD7fubNkJ9PWw6ku47DhNmgGD4K7cD1grxQpYD8qaTE=
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774361cf.9.1762946134031;
        Wed, 12 Nov 2025 03:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzBmGdmGhOlYiVIRlWZU30TyBg9MVhguagEmUrNtm3qfqZ/uALNevR67J4XeGgywzJuDlfEw==
X-Received: by 2002:a05:622a:54:b0:4ed:69c2:3b13 with SMTP id d75a77b69052e-4eddbc6a48bmr30774101cf.9.1762946133569;
        Wed, 12 Nov 2025 03:15:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede379ef71sm2086971cf.0.2025.11.12.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:15:32 -0800 (PST)
Date: Wed, 12 Nov 2025 12:15:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Message-ID: <wlflavm4wt3focsl6w4ylu2p2itwz7jl3hbcnczuyi5mfew7nu@rd6wflle5gjt>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-2-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Di4cyEbB__DzOO3Lc77L6Yyk6cZ04lMCQ7D5ZjDKzEA_1762946134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:53AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Rewrite wait_for_listener()'s pattern matching to avoid tripping the
>if-condition when pipefail is on.
>
>awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
>exiting upon finding a match causes false-positives when the pipefail
>option is used (grep exits, SIGPIPE emits, and awk complains with a
>non-zero exit code). Instead, move all of the pattern matching into awk
>so that SIGPIPE cannot happen and the correct exit code is returned.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v2:
>- use awk-only tcp port lookup
>- remove fixes tag because this problem is only introduced when a later
>  patch enables pipefail for other reasons (not yet in tree)
>---
> tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index bc16b13cdbe3..01ce16523afb 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -251,9 +251,11 @@ wait_for_listener()
>
> 	# for tcp protocol additionally check the socket state
> 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>+
> 	for i in $(seq "${max_intervals}"); do
>-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
>-		   grep -q "${pattern}"; then
>+		if awk -v pattern="${pattern}" \
>+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
>+			/proc/net/"${protocol}"*; then
> 			break
> 		fi
> 		sleep "${interval}"
>
>-- 
>2.47.3
>

