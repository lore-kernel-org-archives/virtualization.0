Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28123CA
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbcbfX5h"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DB8561420
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DB8561420
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbcbfX5h
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E_2TYdBEZQuL
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 03:09:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BCEA611CE
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BCEA611CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNYNKmM7NDZMIJrSd8d1C6clX1k5LUGTMeNK3m1Ci2g=;
	b=LbcbfX5h8hcQSsVE+gQJ3fsZfLEe4b9LL5KZ5Lvnk+XGSzTVJn4Y0Y8QucX58Vmk39q1F6
	WKJ3rLbCaj8YqySQ68xW12qXfTGzwQXadnz5rbBzVg4W+boUlkPhNcMbWpns9IBeaOPe7H
	3BEg1PdbIOZjms9w68FsSrKR7zBploU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-A3RLqq9aPSqLP0LV-4FlVQ-1; Wed, 10 Jan 2024 22:09:46 -0500
X-MC-Unique: A3RLqq9aPSqLP0LV-4FlVQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd393ae026so4179084b6e.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 19:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942586; x=1705547386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNYNKmM7NDZMIJrSd8d1C6clX1k5LUGTMeNK3m1Ci2g=;
        b=RsC3fob2XD+Q3s96Bc5TrHYZcJ45vU5hU5GpBGoxGR3Osj18ZWoeN6zqvs1lr0GhBB
         zyPTIMwddosztdTfKICbKxxMZTqTiGiYfvTgPuuAGlwblU0QVJNKpficco1db1a/v/60
         8XnC00Zn05x5ty9OLKSKnJlaNo4hIQ1SSMq7Cp5XPSIOYXiOE1fcMMXVrlxL1MDl63NW
         ZrUrMY+qCc0kxwIPLzANOb8wIcXpFb1B/KMu44vVJmTGpGsYPFdlF5OhCs91M9Wi3riC
         tcy7WHBLMmclUPKSBjPk0JgfbfxCje4cTcT9IyBVI9AN6IeQHrueYeXUgeRuf9gCl+Xp
         B+AQ==
X-Gm-Message-State: AOJu0Yxd4dBtjplA9JkFZ1dOb2uL8iAENeEshoK1uJMdIWstfxMFlFqg
	mqd1I7IDqlsQJ93h/DBYuyJiklM+13zTyg7UMezOdj0nX0RxIFsilJoGEnwC5kcGXNFOhg3Ixry
	GjRbRplIkQBnEFBA9gSEESlvMKHYvWMyvnF+bUQYkaSCQY8SRs7STy2BMUxLDe+A5Kw==
X-Received: by 2002:a05:6808:1306:b0:3bb:ce08:87ce with SMTP id y6-20020a056808130600b003bbce0887cemr739595oiv.9.1704942586288;
        Wed, 10 Jan 2024 19:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkSF42Bz+C27pa2iZq0sSb7fraKOPPdGWFH35GMBpvyJ2sxt5wIurZ6XGTr4QXgYffbuynq56k0KjbEL/yrxw=
X-Received: by 2002:a05:6808:1306:b0:3bb:ce08:87ce with SMTP id
 y6-20020a056808130600b003bbce0887cemr739588oiv.9.1704942586089; Wed, 10 Jan
 2024 19:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:09:35 +0800
Message-ID: <CACGkMEuJ4yf4reW2SzDqgNZGBWo5Rcqeg+cFS=N7pa_gQmmDXg@mail.gmail.com>
Subject: Re: [RFC V1 08/13] vduse: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

It seems we need a better title, probably "suspend support for vduse"?
And it looks better to be an separate patch.

Thanks

