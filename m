Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FD14BFA8
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846252; cv=none; b=c8P8etZzfJVofpQnJk0Ca96yy/o7cTWbyKJG2B+N2X423uwthS/WD+L8SmETO56QexZdPyEPbSS8tsImNKpt0IEdaVXLXaxNNu9LKhP/IKjYArZhEKenKiEJIwwp6ywev+22kO0Uerabd6/b7wZx4/O4tpPfo67vh7NRT8VvD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846252; c=relaxed/simple;
	bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzUJ/Z3KcLXAPn5g+lq3kMXjjaZqCi1Hmhvos2PIFonb3+0r204nld4mDaUYjfBV9tPHYLqwJl0qo7uB9T3Hg3iR5WBSroyFKTqoIWxlmTEImHgWBzD5fzK7c9qlsKTZ8TxJtSmjmeHjnZVGHUrgofiCDmxf07Cv5KXgMy2RLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMoYBoMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMoYBoMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722846250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
	b=TMoYBoMIOsTS85hJhpT8KqTIBEXGl12AwUZznWleRCKtY72K0DBtbxjDTYz10xvJpaeeVC
	d2zHV+Yn6lel6FIKL54Yc26v0qB7RoA1YLscB3NGusY191htGosP359kNCnyJBEnWMKfNE
	TSQTBCl+QfCmFkuCOA0dknlHrACV6rU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-tGo7UFrVPFilx5y2HZpxtw-1; Mon, 05 Aug 2024 04:24:08 -0400
X-MC-Unique: tGo7UFrVPFilx5y2HZpxtw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb4d02f34cso10306964a91.3
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 01:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846247; x=1723451047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZC/JUb0Bd5ny5AOzMQmgwCXo1oUUPkAQl3rIxUYCGA=;
        b=rlODxVUB9vqSIj6sAKTqoh8Zht8kQmSEZWqJsbaNnu97+z9AlqQ8EBeEfTmBNeiTMS
         RrM/k7F8DUTimbxZPAS00yd8aOsamQoENO1uaqgT+Zr3oRP/pLog3IUIAM/opB8+7N1X
         mmHKkzCPq2k+gzH/7XcaUhtTwHlEFimE7C4sQPzyvoM0aBvBtCPBGdGBVS8Bcg8t6Mub
         75WAn0sdJnelr5ESef+2fMvwmgbLf2ry/OiUW4R1dfn+RvkLLOBGjTnAYT6aj4fO8vLJ
         yIeeLpXlS9eNefPLQDBLN0onUVi7gejB2QQB7ls+bT6ehEbKfHHRQd0fFIiB9LOGse6S
         +sDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8sSRYfGgYsF9IPpc8axBGQA1GZ8WqDc7az5inW8L0F75gNHZ+CUbtUdnMkDXZ2YkNNY3by9hFHQHgXvYBWItv2Qaf7bHM/68mwuMjzRA=
X-Gm-Message-State: AOJu0Yx/XDoiABiIgg5fsXOLQKqTkt5mHs3FG87qTqQuDh8mqLtjo0jz
	09ejiHKDQYx6z4sROoARcmxt/3gcGpuRYz5iHKlaGAiwmV5jmuH6/hEpnJCVikYwU0FjrRZx7OY
	43o/BZ3Egrzg+RIYx/nRto+uw6pYDviJscT1IdAZIhL3IzbPqYN2aE+34tzpagNMqmA38ANtqrc
	AQXWqdAygxPkUuCszBMjh0K1c2h2taEdB3l0ZxglE=
X-Received: by 2002:a17:90a:7846:b0:2cf:c2df:67de with SMTP id 98e67ed59e1d1-2cff93c59f0mr9462391a91.9.1722846246918;
        Mon, 05 Aug 2024 01:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSNr/tffEf9orQJMuzIpDgMZ45fJMrYavKup4rOkDBdZro389KPHkDEY8ZwIfz9x8bfEImYDLvFDJMKuW2qw=
X-Received: by 2002:a17:90a:7846:b0:2cf:c2df:67de with SMTP id
 98e67ed59e1d1-2cff93c59f0mr9462370a91.9.1722846246368; Mon, 05 Aug 2024
 01:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com>
In-Reply-To: <20240805082106.65847-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 16:23:54 +0800
Message-ID: <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: xieyongji@bytedance.com
Cc: maxime.coquelin@redhat.com, xuanzhuo@linux.alibaba.com, 
	jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	akpm@linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Barry said [1]:
>
> """
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> __GFP_NOFAIL without direct reclamation may just result in a busy
> loop within non-sleepable contexts.
> ""=E2=80=9C
>
> Unfortuantely, we do that under read lock. A possible way to fix that
> is to move the pages allocation out of the lock into the caller, but
> having to allocate a huge number of pages and auxiliary page array
> seems to be problematic as well per Tetsuon [2]:
>
> """
> You should implement proper error handling instead of using
> __GFP_NOFAIL if count can become large.
> """
>
> So I choose another way, which does not release kernel bounce pages
> when user tries to register usersapce bounce pages. Then we don't need
> to do allocation in the path which is not expected to be fail (e.g in
> the release). We pay this for more memory usage but further
> optimizations could be done on top.
>
> [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2sa=
LnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
>
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buff=
er")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Note for YongJi:

I can only test it without usersapce bounce pages as neither DPDK nor
libvduse users use that. Would you want to review and have a test for
this?

Thanks

