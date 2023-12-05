Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C63D963
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJLyu44S"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DA4B821B9
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 08:36:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DA4B821B9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QJLyu44S
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NSeMq3x1k3wN
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 08:36:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 430AB82197
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 08:36:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 430AB82197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701765367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHfdVOUnOL0Qlr54vUu/fMOtlv7Ai14q0h8egmUjQtw=;
	b=QJLyu44SpumKwgO2PmMXaYzqFdzjL5no3B7z+9L6W77Uuq0MhuUkgr+prGFMxRwUXZLpfZ
	s24ylrZfjNFjPffFSWX0wlV8Zj1U+v8ZwNTDUKdhPYn/dIgg2T5juZsmUeN6ff1/40Kkso
	bsQx6wl7JbJk/uxGjIYFj0nqiyq5Bxc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-FiAHKFm7PW2_t9LVAnHr7g-1; Tue, 05 Dec 2023 03:36:05 -0500
X-MC-Unique: FiAHKFm7PW2_t9LVAnHr7g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50be5899082so2803575e87.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 00:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765364; x=1702370164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHfdVOUnOL0Qlr54vUu/fMOtlv7Ai14q0h8egmUjQtw=;
        b=SmxDJ0nUBLnyig43SUIBxJyoD/wMl/lO7aMzG1qhuvem+cltD1kxI6BxykkADjYjNt
         zqmFArYfjVN017TdezRomce/5OpBDYNrVzRp7VI/SqNehjN0D4jVfBu+zh3MD3pEUoKn
         9r9XoZnAEXtLxfTNbBj+EUfVSd2En6fAFA4KjQh+P0Q0U4pG5LQVuhZuYWkrsRLB/GkL
         oT7acFSEOKESonQSkLKR6xTvCrPdQIBhOnxjuyCEF6Hd4h4cMt+T7gyRpvPKzzyjXPLd
         WUiS7K+sPmCy4wZJoxfEui6T4BObjAE3/PlqrntDqeo8yfpxo+OUemGg4EgeAf43ZuAE
         INsQ==
X-Gm-Message-State: AOJu0Yw3cJ9sVrsFbGdbQtSxrqcVhWZUVI4gQGmeY/CsRxP6c80CGCnv
	g/o7Iv8FTk5xwB507NffbIDJ5cUt/5Kq+PuqIESn43MDPJ+Laii+yiX/NQ8cNCCRXj/+6M+N4wi
	fK7+497w6opkhxBvP3aKNI3hl9CGorW9VK7AW5poPBsyk+mTYPBCvzBuplA==
X-Received: by 2002:a05:6512:5c2:b0:50b:ec63:8cf with SMTP id o2-20020a05651205c200b0050bec6308cfmr1484083lfo.21.1701765364333;
        Tue, 05 Dec 2023 00:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFFzTieeIVfCJJxqgO1jKvlJv6tH/20cnndeMd22aW4CQhkD8o+6+mVywjHMgfTJ+1DDzEnSckk2WXYMA10N0=
X-Received: by 2002:a05:6512:5c2:b0:50b:ec63:8cf with SMTP id
 o2-20020a05651205c200b0050bec6308cfmr1484074lfo.21.1701765364002; Tue, 05 Dec
 2023 00:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1701762688.git.hengqi@linux.alibaba.com> <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
In-Reply-To: <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 16:35:52 +0800
Message-ID: <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	mst@redhat.com, pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com, 
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org, 
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Currently access to ctrl cmd is globally protected via rtnl_lock and work=
s
> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadlock
> may occur due to cancel_work_sync for dim work.

Can you explain why?

> Therefore, treating
> ctrl cmd as a separate protection object of the lock is the solution and
> the basis for the next patch.

Let's don't do that. Reasons are:

1) virtnet_send_command() may wait for cvq commands for an indefinite time
2) hold locks may complicate the future hardening works around cvq

Thanks

