Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149C4A19
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010723; cv=none; b=Glf6APhOquZfWW84mBw7N0pmmz8NpxwwDH46l685EmZOUEpBrAxwWgGAPPwBAknyK/Si2B8/T+UjfbsmPqnA2VhmVmicncDQ83g+QDiHdbYZqEAz84/2ZnLwZTpo0txg7aOL4sVAKnyEQSvYwPJkDMxHqdlhQkTuVvJ+R69KYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010723; c=relaxed/simple;
	bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3ZezSx9cO747/BStvaFRfod79sKzUNaLWJLIdYvZbQzJ3m3CBZLEtXGi27O+/4SiXR78XF3L9JqvlOuV4w7LGaO+mFw5k7cgGn8OeUNLbrUJ8BR+zipG2XqzLEaGYak/ZFQot7q9XFoOGrsjU4z1Fyf+651MvuRjVKlf9lSYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UivIQVZ8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UivIQVZ8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E84881151
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EOBoD-DSkn55 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 02:32:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 901CB81111
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 901CB81111
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UivIQVZ8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 901CB81111
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721010719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
	b=UivIQVZ8h2vQKHugcAmDdHF5Dz/QHNqeFpXNhv8INedCiSIDur226hh8+5TIWmy42V84+2
	px6e6bIa7qsoZz0dTFCSfYkGQ2Uo5f/oBttOjNE8OjpCe/TqWUdHpuGspWX7W97R+/Pk9J
	1b9d716NtThRRJSw4t4yQM00PveJxQ0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-rlTf6hT-PXeRj4pQzHKbhg-1; Sun, 14 Jul 2024 22:31:57 -0400
X-MC-Unique: rlTf6hT-PXeRj4pQzHKbhg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c95f737113so4185069a91.0
        for <virtualization@lists.linux-foundation.org>; Sun, 14 Jul 2024 19:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010716; x=1721615516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnOm0UWKGCVA2ZOxXTFxnrXlHHcrHT2itOGyOeQT8XQ=;
        b=KlOhcaA8ynMKrOhynqBUBMbVl2NI7yJWLCcsOo71TcMD8DZtAsTQMk0uxfRIcadjTE
         7GE5B+2nFutfnRBcNqKuoqGuqJHzandsSsUVy6lUHL1uTM2EDBs3UhaoLpgakJn3z5q1
         v7lknKa+0Q0/PDd1YG6Wr4aDLZiuocOjm2vmBvaFuZKL5dWM7oy5/OR59B1OitAblByw
         m0SCWMc1TGUXPfeCS/c715RN7kECvSjE5F3vauahMjxgCIAmZ/Llvadg6pDYU0K3UNX3
         wsbeJbnLf8aevUEbiIrWzH8igEt6bdGs/XTzYqVwlO5IunbRRKrn6SQLOLgA7b12dxE0
         sKeA==
X-Gm-Message-State: AOJu0YzNUWlqY7GLYy+nWwEeWGB5zKQEjr17skHxTooV8Iqz+Kc+oKMO
	ALPvBWi8TlILo5Mm/J7goMcm3HoQst91Mp/v3vkffzIcV6oGzI/Qp3phxHuSvUmSe7i+OlSxX83
	yg6GVd94te+vmOJldaP7Mlol/tFjOAkFh01pwHHo22EuCg5xfUeukR2cIi1X+pwTEHzl0lQ1pVH
	xNYPNinCQzKU5KRnAfTP9pMU7OLlmj1TEbeAR3lJubdIU2VVYtTw7urA==
X-Received: by 2002:a17:90a:d796:b0:2c9:75fe:d18c with SMTP id 98e67ed59e1d1-2ca35d86f43mr13938058a91.46.1721010716674;
        Sun, 14 Jul 2024 19:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL/z8uwuzjQl7CgsPLS13e/2gJz2vcQIvI3U6hogJmhxKgUDG7AL9z1TKJA+tQ5UBM5/OMww+Ori1wyw9Q0W8=
X-Received: by 2002:a17:90a:d796:b0:2c9:75fe:d18c with SMTP id
 98e67ed59e1d1-2ca35d86f43mr13938047a91.46.1721010716313; Sun, 14 Jul 2024
 19:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com> <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:31:45 +0800
Message-ID: <CACGkMEucbri21SeE0q848O--yMVCtuT9ZMKUYgd6hLEqLGN7Tg@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Add the VHOST_BACKEND_F_NEW_OWNER backend capability, which indicates tha=
t
> VHOST_NEW_OWNER is supported.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Doesn't harm but should this be part of the previous patch?

Thanks

