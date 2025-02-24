Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44E1624E8
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361039; cv=none; b=UDs5+0YFKP2lx3cpCxBqVzJgCvvGu8NiROCXBN+2Lsck7UeIpKgg6oOyqNIncmo7g1Wn3Iuw5SxokA+BNgVVeMT0o+dpGhJtUt6Byk8tTmpytoZLQ6kNKT/c8yD8rb83DHs6Khc7rZSJSEj5qOJVZYIGqyTTsPEt30ArJoU0OtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361039; c=relaxed/simple;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsJHGnxALbDB3awwUzFxbSQOhWFg6ZOO2Iz1T3QYERjzTm2944QGEQM7EeSwVEWjUoE7SKKk87sVtK5gRFHDn65wResOod+eit0WPVKwvz8xyYUrYUgiH26Zorn/k2IWRM25Xd1jIxT0l2r5UXq1HCUthbd0pnkBx8gmUIU8OOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfN7SlaO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfN7SlaO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EE95400BD
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOqpSaYkrWiR for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 01:37:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF26540002
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF26540002
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BfN7SlaO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF26540002
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
	b=BfN7SlaO9AVWCpDb0a8RQZOpw4cHvj3xpMrvFcbOUmj8P4Bn7Md14G32g+82Vdjc3Wqm6J
	jzlTRy4O497hWti3rtRIZaH1I17ZS1Y07/azxGqbq50AoHcr3m5azNB/KnBqWa1xhLupG6
	zvFjV9fznR+XhvE2FwX1/rqMk9aoXT0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-NrTO42fMOHGx59sHkjPT-Q-1; Sun, 23 Feb 2025 20:37:10 -0500
X-MC-Unique: NrTO42fMOHGx59sHkjPT-Q-1
X-Mimecast-MFC-AGG-ID: NrTO42fMOHGx59sHkjPT-Q_1740361030
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220ee2e7746so78596845ad.2
        for <virtualization@lists.linux-foundation.org>; Sun, 23 Feb 2025 17:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361030; x=1740965830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDKUEoznc8DiQSa7ZxGO5iBmi1tdihrjqHIjWG5bkvE=;
        b=CHUII0+30yrqFbdcVCM4DUoLAmUR7VF1Sh/GICukaFovGxV2PEDJpz/YGxAeEcTSZg
         7Z0zUmOkW99kgNqASknGbjciLrt5mZa5Vf3MMzrN3AvtOsFp+e70WrVWP6WZRI64PwJh
         rsulU4lUCAzEGxMAXjDojDU8vPPPQZCUB4ltpWYmddP3ROsfO/Yp2cAhuxmH3YTFWjcM
         GXqDHZ8MTLelFhokTrCY3UaU5MWOnIJujK0kt1FYYcMevr/Un4cAhCnIKee3pu1mzGjh
         EnI4M/S/8/su0ZggDo1dr2X34BCy5zUPDk12CNbNth2oR9ZAKgE8/wiPKYajUKiTCImK
         1atQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcYvlMdykuyu3zYgERbGPVssOaDZgNy2It5zrMaJWG693n1UrGDqqRFBC0esU1oHDSISrulpirlkNlFxNEuA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxLS/DmjNMlHLh1kzfGm6L5l+1u+oU8KJ4uxJesrzfJxo0i/57P
	PegpNow7TlYlT5/q8ixX+Hr75MHe57lbKPNY7adTmbPORwyrnj66SOnxgwAw9a5JLxCdzSEYjH3
	JyuGmS4lieQC/K2h+CRXntnLwFB1qNiMSkjhnthx/SHBhMjvwUfZ0+8o2xrpxWEXaS6Yq57WXX/
	OMHyyjb9zTcCJOnzJz1SmfT/GbyMIGJ+MxnBcIU0PMRo6Ou+6ED3QJHg==
X-Gm-Gg: ASbGncvh1xF09rjW4ve9v2LIA79dlh6a/FAJxhrYE1Whr8r+YPzIJ1K5EJNb+C96r41
	ZX/GJbC5C+S59N3glMB9ewRBR1H9GSoxS9//D+8Q+jF09JnvglhrraN5dy466Y5nidUdToR6lDA
	==
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id d9443c01a7336-2219ffd270dmr177749655ad.38.1740361029788;
        Sun, 23 Feb 2025 17:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOeXKHHqb4Fy7D0duuUsqaBjQ5JEjIFblCv4/RR6Cjx6kySGlfKNdzXcRttM48rlOR+pU3OSFf2tpAQIg5Gho=
X-Received: by 2002:a17:902:da8e:b0:220:f869:1e6e with SMTP id
 d9443c01a7336-2219ffd270dmr177749415ad.38.1740361029317; Sun, 23 Feb 2025
 17:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-3-lulu@redhat.com>
In-Reply-To: <20250223154042.556001-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 09:36:57 +0800
X-Gm-Features: AWEUYZkUhaSykDfVeHI8T77xwBRzCjQxyzGy4NNFOVme4_LjDEohqSIX-n4QmYY
Message-ID: <CACGkMEsmX7v8ta4D3vgzi3S=G9nzjmTs3pG3FBou+2mNa__vpQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] vhost: Reintroduce vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGu4apgJr6_qAWZ4LuHtmSkl21P7x6CStcnwBSEhCMQ_1740361030
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the previously removed function vhost_worker() back
> to support the kthread and rename it to vhost_run_work_kthread_list.
>
> The old function vhost_worker was change to support task in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> change to xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

