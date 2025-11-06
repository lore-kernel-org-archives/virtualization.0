Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637823B616
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411469; cv=none; b=ppAaRLQo2+yJH84NgmrNi72fgUaBUfhwDXuL6QUxaLurJXf66d5eiDD+Oh92ALVwkkj+hLB7cGMdyLrJtcJSCqICIGGPN8CV2hupQkYRKvqgvUhwOAbV6Pyn+3QPo7GWxwm+FY8vPIY8hl9tx8uVG9c3M3aZiNch22PFHTgGFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411469; c=relaxed/simple;
	bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEPfLS+ircwbnkAdmglLc4rSMJGRkkmS96G97ZMeX6lzlUGsfzBKauaveY5Qbhkvck78LOXgqdu/2cbLtog0uEWFf0X7w+876FTEFUMI8nZuZtRd8Pt9ROtEyez0/FVS/svv5idNflwKexRUNULx6wKQFvVppY+L0gzgHBttml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfPcwJmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfPcwJmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762411466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
	b=gfPcwJmOj+BEFPX0Te79OstjxGbpRzhmqok6VVdMGBFNAJ4J/1iAYvPR1vjZxj5m5IYnZe
	GhWBY1V/SPjpUCBUZdTXRWCRViCodevM0juNfDiZNWUDbE1NSQ1mF+RUtKD7UM3FHtMSdu
	wYpQ1wAWMYcrXVtpKypwT4SYeHsELoc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-hTcmEGjnMAWuJJ8pnRdq7w-1; Thu, 06 Nov 2025 01:44:25 -0500
X-MC-Unique: hTcmEGjnMAWuJJ8pnRdq7w-1
X-Mimecast-MFC-AGG-ID: hTcmEGjnMAWuJJ8pnRdq7w_1762411464
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294a938fa37so2533265ad.2
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 22:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411464; x=1763016264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aOwbplGzocz2ayqjqOgyLj5sAO0MgzGCQLCTpyfFfM=;
        b=jYZfVA0zAGVX1rF4Oz/IPX1OpdIQZHWsg/ugbYP13kxmDFfHNF+Lm84lcTL5PdlwCE
         bn+dRre96mnwwMp0v+hCiUspkJxlf2BnOabAXiercyFEG4UI9DOgquWUfmGt5nO1qPFO
         hg2FJbCwEzgamg5NhMN4W1mZlbCEtg+04CqLrlksQwwKviSrr+A0CfPBpkfQvezE1YZt
         Lq8OuYVDoOJ9sPIlbrXETF4UB8gcn7mbhHw7IJhmLBcKyxUK2BaTe60taRpC0MDtgxFr
         0qWcXgnm7pujeZdJ36lCVBj+Q0UNR9B+zlXjI105MqXiVjEkDQJSmlvMxl4hwpl8dPTR
         BUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcmd5/i5zV5JYCTYzrbAmOb/lz+5DGeN/fe0DCuTfpL5Uzi+OI7Vti1tRwXWD0phmOFf7Ktnpcdocgu8zapw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp88gUTVbKk5jNJ/LqJkLvQIUc5Lltf7iX1sFQGdqNriMGqo6M
	t8ksswAOiGuWW8Qzy0NL8aALd4YQO48KsCND7i2A/77rlYr1RGoCdjUZb8j+3jd8WavOSzlWDv/
	VTRwY0ErsZoMuPDG4fBONnrvJJJ1z0XgDB9sPsg+7ihX00vXdz8GNjfMBr3em1MiLDHuRgn6S5R
	gBsBmJMc2k8NGLJB01eaD0TpS4oSIA/lc57btybQultEyplyvD4g1ZBNJl
X-Gm-Gg: ASbGncsGjuF5JYQWO6ktpHM12H3MJTO1ZJ4Je5jNu1mdxuO+5KV6pUnLu+UdoPemW6q
	1fSHS1GoLo3ryPYVzrqsn8zJRYUGlKvn6JOGLiaSmSERCVvudxASChPZJiy0jq1/m/3zsqHe0DM
	z2BGenjdHdGz4Oc0pp5fNPYfjewMvY0E6GhzlLcMq108bshfMArovDtsjF
X-Received: by 2002:a17:903:1b63:b0:28e:7567:3c4b with SMTP id d9443c01a7336-2962ad1ef5amr84646355ad.16.1762411463889;
        Wed, 05 Nov 2025 22:44:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNZkWVFrgyX6IG8QwdVbXXabDAgmhxboOVYqMKs84MfgEvO2GkEnqgYjqE4lmrXZf+XuZQPTBJ4U9ZXyvnqU=
X-Received: by 2002:a17:903:1b63:b0:28e:7567:3c4b with SMTP id
 d9443c01a7336-2962ad1ef5amr84646045ad.16.1762411463463; Wed, 05 Nov 2025
 22:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029033559.83145-1-hsukrut3@gmail.com>
In-Reply-To: <20251029033559.83145-1-hsukrut3@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 14:44:12 +0800
X-Gm-Features: AWmQ_blG6rCuODjNHXnzSBsblyAMCOBCmeR3DLx53_79KRl2HplNxsN72I3qYKo
Message-ID: <CACGkMEs=xB3nZZMaQC6m15Gm+K9fiS68twD4vOgQid-B0BQ8Qw@mail.gmail.com>
Subject: Re: [PATCH] virtio: document @vaddr in virtqueue_map_free_coherent
 kernel-doc comment
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wrwlICgZva8d6ZO2fwGfEzNlKYu2JTrmuOiK9rHRSCQ_1762411464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:36=E2=80=AFAM Sukrut Heroorkar <hsukrut3@gmail.c=
om> wrote:
>
> Building with W=3D1 reports:
> Warning: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr'
> not described in 'virtqueue_map_free_coherent'
>
> The @vaddr parameter was introduced when virtqueue_map_free_coherent
> was added in order to provide map operations to virtio device, but it
> was never documented. Document @vaddr to silence this warning.
>
> Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

