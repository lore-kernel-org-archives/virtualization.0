Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874E26B764
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804944; cv=none; b=W8texHiYrGYVTkaNPbdH8GHi8wC8tPyJqWox/vYT6H2P0iFV29dzqNpk8XFlLqJ84TLQryWYGGba3Q14C+7qV+Dul45LujTZjwWP73glqjbev3EmMsD5mkey+epYSP2qBgihvnNnhL8gqI+I5PDe2en1UbDpKGGcXCTuOxvI/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804944; c=relaxed/simple;
	bh=dVLJ4RdKRHtXZuQi5rc97UIMisOWRJlke5CqiiGozHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keBDDaUextffdSqojLI+OU6/O+WOdQSG6gSEDnTajEvDrTtM69oGiUWyTCm4jnGlCv/Yd9jNQu9jMnApjeRey5sr8HjmJKB/w+8itN/6LUgsaIGaAwl0NdTkgxUplfWjaugLqAgyWT7O+tM2W/32qe6Yprmx3psv3a1qc8f90Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eo9fEbnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo9fEbnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768804942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8s/hpnwDzQVyTWL48mtHKiiW9kNrSLxz2pFOhYeu1I=;
	b=eo9fEbnXAbpeFrTaI65kW7Mn0koJwChsHr2g1Ov0JCJqOE8kDiMVwhCPaSIZ1GJ6PR/xVk
	KHVKQHmmGpGCcr77oXAh8Qmrl+Exr/OFe4qCZo/F/hjUCuI9KntOfAISWx9eivawh7YUn5
	3H6ZOi6BwD2wTpYh8MPP+Ul3eJqbwOc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-SAPfx1jxMcedhI44cSWqug-1; Mon, 19 Jan 2026 01:42:21 -0500
X-MC-Unique: SAPfx1jxMcedhI44cSWqug-1
X-Mimecast-MFC-AGG-ID: SAPfx1jxMcedhI44cSWqug_1768804940
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c52ab75d57cso2241435a12.1
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 22:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804940; x=1769409740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8s/hpnwDzQVyTWL48mtHKiiW9kNrSLxz2pFOhYeu1I=;
        b=HJhWLcIs2xAVBgUDUWCVNTsIBs78XAwaBjZ/YnT8kiquqaw/5thNwV/j41ZyGvwwC+
         ji6k0dli3CxGZ6MQjeTIkZRrBn1LCJwropv8t5xk8F2KNuKEH7Lj9iNBQpAoM+Op8ZZ4
         iI74ZgqFY1WHV5hBdL5xW5DQ2zkP8afgrQrEbNcy/nkw7FgtLhKW8VHvun6Gmr5HkLic
         i7QxqqStuawd8S2v0f2EhK4PQN/xxaohJwQd+REijSdC9A8+CVYNZcULwA7fQyuggB7w
         iZ92/zywjNUs2YouinBfaWW2XWuYvEmHLg+YNUwfYOKdzbT2TqSAaRvLrGs8c5Fi1TE0
         dhKw==
X-Forwarded-Encrypted: i=1; AJvYcCVHEEGeTtS22rNYvTlqpvv2aMMBgWAZzdhvrOqa6ThpMZ/65LKglJFpwJiC7I9b0/zpORwRQc5zM2tK/Osvew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya+o4BDzyCdhsdlu/zhggWiiKQ3ro+3ZQus/0NFKAPqSAWYLmL
	pgZ96MIPL/zEmjuZmaxhEJYPvub24DQF72EAEXARdYRWj7NacoTd56R4Hnemvk06uaxWJ1SMZrm
	QnQlVnzbOdxQ5HMMem5H8t+1o0K9jCNnEJmPagATXJ1V5LCWQt2NtKW2HMnsX2gKX4M/iiNo7bm
	EEkbMUmb03SFekU3ql0TLq6IRZ0gghqeRM4k3OPhi/sZ8=
X-Gm-Gg: AZuq6aJi5avP9ZbMBN56R1tqgZhdbftOOA+j818XPpYh8Rws/2TYUhclJGzUbs5K8PY
	1Usl4EHycqffYA40loMw+B1kQ6aRZEH+DbsOTh6uqxOG4iUtGNq4YtBUb0b8E+cxazaaqHSasoi
	UuxR+ef8ILGSTIAv+gq3elZd+R0/1omdVg9apRaIlS1W3Y0jNJF2fcGgX2vQ8BIrthPVU=
X-Received: by 2002:a17:90b:2f8f:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-35272efc3d1mr9514935a91.15.1768804940237;
        Sun, 18 Jan 2026 22:42:20 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:340:2f48:b51a with SMTP id
 98e67ed59e1d1-35272efc3d1mr9514912a91.15.1768804939845; Sun, 18 Jan 2026
 22:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-10-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-10-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 14:42:08 +0800
X-Gm-Features: AZwV_QhG2adnDzfZthBT9yr03oaP0WRufNbiccab_cl_QarlpjHS7EbFrTedHIU
Message-ID: <CACGkMEt6_cbOM+=dfb1MhNfBxrT9PKe+5qTC2PMgp+uZgHAzhw@mail.gmail.com>
Subject: Re: [PATCH v14 09/13] vduse: take out allocations from vduse_dev_alloc_coherent
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZWNah81N7XzojYC1_4R_SsBTpyYUjew-a3mFRH_Bns0_1768804940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> The function vduse_dev_alloc_coherent will be called under rwlock in
> next patches.  Make it out of the lock to avoid increasing its fail
> rate.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v12:
> * Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coherent
>   fails (MST).
>
> v11: Remove duplicated call to free_pages_exact (Jason).
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

