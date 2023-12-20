Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776121D696
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoE9z/Kv"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05D9B4090D
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05D9B4090D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoE9z/Kv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUWJ9nD0Pb2m
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1EFE4011F
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1EFE4011F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpf9eaQ+8IyE3naaIp+h7AwEmeiY2hzKB3PbB0UYHK0=;
	b=CoE9z/Kvgr42UUcNMHEcngBNFh0fgD151/O0on/18M1+tcTfGv3UjLwr5TeJDJvdQYCiqV
	mgCs0Hr/xalNzn0QzjxV+wGp0npzscLUwxMfe4bO6b99ZHFdTgbt4igRrtCLJjOtuJNtWD
	ovaOdbdB5TWOsKgnSETg144t8kIbBsA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-i4GKVExxPUOm3HxXpoIjpQ-1; Tue, 19 Dec 2023 22:47:13 -0500
X-MC-Unique: i4GKVExxPUOm3HxXpoIjpQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bd736e536so120729a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044032; x=1703648832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gpf9eaQ+8IyE3naaIp+h7AwEmeiY2hzKB3PbB0UYHK0=;
        b=QsK3h4JkQU71fv4b6C/JI6MoOjWn1aQk7PVVDgFHrFklPEKaBoD0JXyauAEHGxTMyR
         ksBc0ri0EaSibrBerKZlZNSgswxhbgbpzTIv5Cds8HAZlvOgl15GOdiqqlH5KF1lS7in
         BR8hf91Pci813IjzBWEx5EhqxQAF+6Op/VgFwTCqts0Pe4t2aa5AF2jcc04REkx6ZWX9
         6FhoDm6iD1HhYIXUO5jKnvGGqbbbX9GYn10gl2ZZUUivWQzfW1Wk5xYdPN8DuBEFsI7a
         1U8BEjrxst3IfGWdtsk1BnADoUlPSxQEl76qidDrQAAxdExbySHncPPLR9BBiBMA9LYg
         uV8g==
X-Gm-Message-State: AOJu0YyKOyKGoeWP/wLve2k75VWq74ek2ya3KGNGxqjDr7aQM7zf/5kg
	dkuYpm4kUJVez2dKapKRnGnwL7rfn5WIt5F/d4WUjJew98FYbA8wAzTT6nLUymI+ITXGTEFC//4
	eRtmrch6YxBatnQa9kJlsayRfxiI5uB2+0nKuK65nsYHWgnhPNMgdkaueVw==
X-Received: by 2002:a17:90a:a091:b0:28b:bc1b:7de with SMTP id r17-20020a17090aa09100b0028bbc1b07demr1614903pjp.40.1703044032153;
        Tue, 19 Dec 2023 19:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDcI4ixQybr5i5c0P1DsfG1krVEzdc5+7jCz/VxN07e6GQutc26ICOW0Eu/Hr7GtQW0pJUC6ahOAcBoKibwTQ=
X-Received: by 2002:a17:90a:a091:b0:28b:bc1b:7de with SMTP id
 r17-20020a17090aa09100b0028bbc1b07demr1614895pjp.40.1703044031879; Tue, 19
 Dec 2023 19:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-11-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-11-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:00 +0800
Message-ID: <CACGkMEvnDCv7eGQM_fdjg71Mqs5=9Gsox2fHa+vVAoqu+ywy7A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/15] vdpa/mlx5: Introduce per vq and device resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Implement vdpa vq and device resume if capability detected. Add support
> for suspend -> ready state change.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

