Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2218625
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiwNxq9S"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0860060E1B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0860060E1B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iiwNxq9S
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TOv31hOKKPSG
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6D4360DFF
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6D4360DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+JDn1KJzJATgI5zfmEFBJrCFOmZkPUddhQTthC2QFc=;
	b=iiwNxq9SFMESWRA5pG0M+S95N7DAAvx+DHKyjjOYriOntCM6YWSSTWpQTyJcHmdbAEKw1Q
	2/qQtJ1ZquIuJ77jucZR+pI/4hnRkqYB1Ns+3McDLRbjyE3k9gX84PHJ7dEV68QwT6f6jq
	ZIu3VCx9bxHpW3HtEjSNqjQGVlrJFTs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-fsb21QeVPLqseTZIaTEvpA-1; Tue, 19 Dec 2023 22:47:10 -0500
X-MC-Unique: fsb21QeVPLqseTZIaTEvpA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bb6f239119so267260b6e.2
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044030; x=1703648830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+JDn1KJzJATgI5zfmEFBJrCFOmZkPUddhQTthC2QFc=;
        b=CibaFFBLRhboyxYqnKN0kjMz3+B4pXTXYEerV8Zc68YPG7Gqq+FD06sdpyzBnTBJxl
         zppWr5+PXhtSnxDtY/nb2M8vO58WDYA5/LpcCnfsxxHKBTxug+zK77Y+4FTYQJWOOnvQ
         2F3UgNAuTF/ZhZKxHVTlf9tQUoBQDpHnRgwVhAHpFyVVmVQaEB8gtBLYGuuVQqBP4Mpo
         iEI7ap0si4w7WGirkEPxHQ5w4Hdf2VdwKPICiRc6PIPkXo9S+JTTDtCdYjcdOn7NPBW2
         cKoYhUzfL1DzoWUjQaRAnDoq478HsiJ4R/gnB0MGstugqmXkXSRz9LjZeJpaHLVg9t3s
         uW7w==
X-Gm-Message-State: AOJu0YwG4i9BO8NTBKxLs8JKjhL0Q6tVONiz1noFqHH+SyG0g/3pH+cA
	GZR7DGUrBu352DaQACR/RGhmgfWV7bFp4b/FlohF1df1junAL2DFsM7vaMht2qCwREV8ImZEPTS
	8nZNEX1IavVyltJfwofLNJOn6zMdcNzhipRsdycRFK8h1NjaK+kyF3KnsDg==
X-Received: by 2002:a05:6808:16a3:b0:3b8:b063:5d75 with SMTP id bb35-20020a05680816a300b003b8b0635d75mr19240104oib.92.1703044029952;
        Tue, 19 Dec 2023 19:47:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjc78+yw+xCGEIAPfx0ZKd6JVwAwXS+dRnEknTKLfywa1GFI4mcMh1fsZ51KK4vW8KtASd61JsUKG4h1Ooauk=
X-Received: by 2002:a05:6808:16a3:b0:3b8:b063:5d75 with SMTP id
 bb35-20020a05680816a300b003b8b0635d75mr19240092oib.92.1703044029759; Tue, 19
 Dec 2023 19:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-10-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-10-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:46:57 +0800
Message-ID: <CACGkMEu-UOBojsNa_f_XWe6mQJfA+TGdP=ZNTS7bUqky_zdp+w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 09/15] vdpa/mlx5: Allow modifying multiple vq
 fields in one modify command
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
> Add a bitmask variable that tracks hw vq field changes that
> are supposed to be modified on next hw vq change command.
>
> This will be useful to set multiple vq fields when resuming the vq.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

