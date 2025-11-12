Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0C274B28
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946634; cv=none; b=QWAqBET8BtX0ZRQVOwBWNMvftb4Bnv3eX3E++qTbjd8FBC88feCW+yIchsZds7P5R680/NtyHRh1y4auejUX1FCbeBGxhFumbMPfuN4Zg7ygs4DaN4BWux6utoMmweRhfeAxEX8+P2+/m78Iil5298O8wHmjuZGnTZoTg6mzRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946634; c=relaxed/simple;
	bh=SDyYLyP6tCKgZow9SIBWdRS3PYcrbQQi85B2bhjoTbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UE1aOUUgpdSZYBZb8RN0j92dXP4QA0N42zjiLtHfsx6MHsSBcufN6zhgaWvtPLkcxfG9BkKY4RS5rhjuScjx2H1SZ3TciTd8jv+aE7T+kjrabzaPgjfRALplvRquYfxl+aZeg/ZO2RksAfddUOAW4O/HrdIEzJ9KwTjWXLa5nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcD5XfAp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcD5XfAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3H0HyO28+OYSSXAxEHzY6dM2GaftH10W5eTlFdtLkc=;
	b=KcD5XfApUn51sMHsImre0sW1jaCdRWI2JwCmgA9ouyT9RootRotaYINgHcDoAZWNt4DZWV
	EGaEwNWOZiQ7ksvWowpA7eahqFcI7ArtjtQNY34KWRQEYbSd/e6orE6xpNK5WM13SmxzPq
	LAWNklKBSXDocHJCOqsE0fyW/jV9Hsg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-G7lAPiH0NSK3rTzJm833ZQ-1; Wed, 12 Nov 2025 06:23:50 -0500
X-MC-Unique: G7lAPiH0NSK3rTzJm833ZQ-1
X-Mimecast-MFC-AGG-ID: G7lAPiH0NSK3rTzJm833ZQ_1762946630
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88236279bd9so19160136d6.3
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946630; x=1763551430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3H0HyO28+OYSSXAxEHzY6dM2GaftH10W5eTlFdtLkc=;
        b=DzlksLyMcNN45mos16lqQ/cLefvA/+8skoKvRkgM6H1s2CjpUf/q6h8YHao+/jUp8R
         SmquG8SUtg1rJ44Abqveqyx0YvWe9ZUIvweJNNE/lepD37Yn4aOZXxEPleo7EznmBRT4
         i80/fH09NcpyAjbrrAi/EGipy05YJRmgA40/EIkaztiter2SNQAfEq2Zs84SxAFzJs0G
         fSsQvVGhux3cHON+0Y6PQaUIaIyZ0NFjpZFshDI5lirsOvY9/rFXESnrTTmAsLx3w2op
         X/rpmtJqGcLQONn7DsgpDcKg3f2r8BE0Vtmw+Iirch4d1PDv0fHRg/TCfccUF7+sfozG
         f8kw==
X-Forwarded-Encrypted: i=1; AJvYcCWnmU/C3YbBuDTYSdOZI2TFcio+apR3AIzljKjHv5PfUYTQyqOG0KFFL2Lic3Ljjr17gkKpSUM54P+MJv15+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM9sHMczkZ2NnIzBFvf6K+sPteUr61FXtuvHE28VsuNX1Zc6nF
	3yevpamAs4RLulwTBWYN8kdbXYNRTrclof6lKcyOFkLT1cGmHYi3XL2FN/r9VabYQLjllJN//xZ
	ZOIm+QUOfPMqLmgQ2axdN2YKqhgI7/+rju4GeL8RGLY3Zl+iLDeEk75KmAgu3HqES1IpU
X-Gm-Gg: ASbGncv+j0Qtm/hyQEIt1NisUGqV3OjCeINmh8qdjzxQFEoJzdqczqARG56UjXO7eMx
	Wec3sx81zqAz43IKB1ISqWSnk0iRyn9RDhtgJFQh0Ppwc8sA+DsCBVeR12BVgqDYeoRyY5B2Vbi
	pogYcSXWF6wLfeR2cSon1fkDUjvPDPLHKvOrhEDjgR2Pwt2VcXEMRtEw/nPyazD+fBKa5nuCJma
	36AklCC8dTjkl66tuXHfJK5zM2N+iRCgkPA3+7WAGGMM5OQSNzv2eNo1ahzMUgxJ+xrm4tJr5BK
	gV96Zg1GYPp1LV4elvQmBsnBVH84iZ6dLipDV3NANsABLcRV5m7dx/M+AYV2eakjeMSD3dqTTU/
	DzYvV/GLqa8RPsYvmHpv0sQcT6lLo0J8inHfJmcMMp6osLw2mMWU=
X-Received: by 2002:ad4:4ea7:0:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-882719e68e7mr44666276d6.33.1762946630288;
        Wed, 12 Nov 2025 03:23:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH75JP6UyDj3zoFvW86TbiZUWcqb8so45eTwS+F/Ht1XSgKOAe4vkrTmnLDJKvoh14SKJ1KRA==
X-Received: by 2002:ad4:4ea7:0:b0:882:4be6:9ad2 with SMTP id 6a1803df08f44-882719e68e7mr44665946d6.33.1762946629843;
        Wed, 12 Nov 2025 03:23:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b4045csm90028026d6.30.2025.11.12.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:23:48 -0800 (PST)
Date: Wed, 12 Nov 2025 12:23:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 05/12] selftests/vsock: do not
 unconditionally die if qemu fails
Message-ID: <6t3kq42haafazobjbrnmcppg4bhyzfbmkuyld3h2y3rq5xaehr@olnyeve44x5l>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PYQ5VbIimTw9Yp-Etw2KfCy-5DVC38PtDC3eOQdGHWc_1762946630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 08, 2025 at 08:00:56AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>If QEMU fails to boot, then set the returncode (via timeout) instead of
>unconditionally dying. This is in preparation for tests that expect QEMU
>to fail to boot. In that case, we just want to know if the boot failed
>or not so we can test the pass/fail criteria, and continue executing the
>next test.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 13b685280a67..6889bdb8a31c 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -236,10 +236,8 @@ vm_start() {
> 		--append "${KERNEL_CMDLINE}" \
> 		--rw  &> ${logfile} &
>
>-	if ! timeout ${WAIT_TOTAL} \
>-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
>-		die "failed to boot VM"
>-	fi
>+	timeout "${WAIT_TOTAL}" \
>+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
> }
>
> vm_wait_for_ssh() {
>
>-- 
>2.47.3
>

