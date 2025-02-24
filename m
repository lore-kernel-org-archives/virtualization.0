Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD881624C1
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361207; cv=none; b=WU1a1poWUrw4WD9ZAAxzgMLg5S1ZAy+0Ir3plI6CFlXMKHs2yUSZtWrPJJfPPzSgDHsOTa0iMrTWS3p5wabGOWdMEhYSC/GofsTnBbqLbV1WG0YvV2prLcprw/ohVMsAJs3jPtporXCJZPBnXWR/5VRtTvH7YDmiTPxcWFB97zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361207; c=relaxed/simple;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ps50v7g/E2N+6SHU7IGGqNYJYuvPtpgx+v5yLFYU0zB6NZCkykpBYJDXDgab3VBQT+rZIw24RFsoFUnVZmUFT3AFzg6BKyyrZIfyNAu3NOBXvc/BStQ+nhQyAWojY02T7w8JRMK6pIo9S7ffca7Zj/nqP2J8DMKoADa0ehUZ1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbxfMlSM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbxfMlSM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2C2880AE7
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zHxsLJ-wwqcI for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:40:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 42B4080AAD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42B4080AAD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KbxfMlSM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42B4080AAD
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
	b=KbxfMlSMKtKV1ohBrqiEqGRsVVznotuGFcUAQLjMMFfcmBhxO4cUiK6clfPjcXdZ+AQsjF
	0Qisi0cCIoO6NAIsRJCxqLJQUWlPcBAj3r3YcTm4+WN4SAKbrbdccAiAQ+inCX8cFzHtIq
	hPpKrOU+FDjwaCGZNuXuTBmm4IlyKvg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-4lUPj3M-OGe3SHM698L3ZA-1; Sun, 23 Feb 2025 20:39:59 -0500
X-MC-Unique: 4lUPj3M-OGe3SHM698L3ZA-1
X-Mimecast-MFC-AGG-ID: 4lUPj3M-OGe3SHM698L3ZA_1740361199
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so12872369a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361199; x=1740965999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrfskPXfZaYSBul35BNpLO2cF/gkFhdjabAqJfP6oJw=;
        b=roRqjvuX/9RHiP8FGHJzY0ADfO4/2e0gZhNlhlkXmIfdEqC9daMglzAbF5Cg6svQ1u
         UX9HUxgHUoWa4T37haf86Mj8u1CzzC/R+3Z7oxIC5ANiRh8PHCyghB+RfoUlIzPGttES
         WS3bhlRXbwG8/B++Ka+21FN77hsfTYp5MNQoQGNH6zutPq80GzjDI83aVGLstUoAOmKp
         0vC6IEne+oN2zSIVrX5c/8InGuytQWVkROf0vHwPu/ZaQVtimpKCKJtVnwZLux6L5ILA
         fRQXqtHSaoFB7mj5xP28MsctLHMrzHqVy2jaduszfJHL9F80RObpgsh/I03pir7V9hA4
         fYbg==
X-Forwarded-Encrypted: i=1; AJvYcCW2jxJH+3LutTQboxpozbPPWpVJFP/f9vuW8zT0lS93p05VpVl8GWrrCuy06E3xlD1KBHvGUfX4hnyGkDNoKg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzmCxM/LhAELTJDSCBWyiC1B7mSXRe+6YDozMNTmGYMJsvig7Jn
	R1GR93v2avHo1LF2MZvIHNjhDdC1XWn3A5qOrBCPUSiQxnpJQv3fK929Oz0GNjXtm+aD8ZO9v+9
	CoO1TFKaybZtLq+Nh/6ZzYui02P32oA5iREKX+k7PWa8MMyUrXMK1PFmpqa/IEgeesieJVCKiEr
	/U0VKW7UiuOQv4nd2kJJDYj/tqY9GYp53qt5P3F3gLkh0xVshTitANzQ==
X-Gm-Gg: ASbGncuXxk4tR4mQxaMu6x0bqti/V+Mv8mKhxgEwDhFnV47KWqvQP+LOjsXkgNeZwiI
	Ned7pSfA1/94KrjuoKETnjLy8A+0U1gRNNyHOlyffGeZHKUyPh0+iFiiDGRDregC49gH5TUm0FA
	==
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id 98e67ed59e1d1-2fce7b2c06fmr16130621a91.34.1740361198905;
        Sun, 23 Feb 2025 17:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGONcBxFR0n13Ho0Oz96boeVVOYPPhVCv5Oly5cUz/HAY7eIJGFtWgwnxADw9SLiWOkHbcKmlHWn6DR44VUsY8=
X-Received: by 2002:a17:90b:1a88:b0:2fa:2252:f43c with SMTP id
 98e67ed59e1d1-2fce7b2c06fmr16130601a91.34.1740361198521; Sun, 23 Feb 2025
 17:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:39:46 +0800
X-Gm-Features: AWEUYZl6q3WmzRiZ7R6AyPCTyXoGgL2WiDIIupnXJ0sHWiJQL0PPi6nbPrX6XJg
Message-ID: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aqg2_SEWSpJL_Mjk-QkOOg3Y2U4qsbKz4QAS0_0YKbs_1740361199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add back the previously removed cgroup function to support the kthread
> The biggest change for this part is in vhost_attach_cgroups() and
> vhost_attach_task_to_cgroups().
>
> Reuse the function __vhost_worker_flush, but in this situation, the
> attachment_cnt is 0. Therefore, add a boolean to disable this check.
>

How about just tweaking its value to INT_MAX so we can avoid this new param=
eter?

Thanks

