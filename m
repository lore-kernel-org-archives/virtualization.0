Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B642571D1
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204911; cv=none; b=lN2ZCHujqOQmMc5Flmdk7FbAusdyClj+HGPfEpZgZpwxm3CKl/qTV3oGzgFdsFsSRhvkoGnQGLNoWWiYA3uCv1auDprS+2ZRUp7vcyyaCoxA/+l2gABPLq8//HhZXm4lkPXh+fY0eB7AFnK0ieEBUBIV4f9np1O3GzuZphVkNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204911; c=relaxed/simple;
	bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9BT44B+i9ZiaLrFPYCg6fC/YkVejhAjAdIMq3WfoOvPu+td5T3onSBTtP+B8OiC5jENVgq4cQWBj91rGNko6Abbq4CJnkpERA2bNe2oi5GuPeWhMoUkVzoDI/kCwirKzQ7Au3snEHLTyeBQDkwzvwW6LhG4LRVWfZPYcbHOMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1vmV8by; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1vmV8by"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745204907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
	b=h1vmV8byOqyHy052+vA2B/7kftlAq5D2k6S0AzGvGh+ULdi+15ID83lWDR28OSTc8CHgGv
	B2ydvYLukq6+e7gWaVtVW6bg0gzbcM8PRHAqrGZbTd0s+b1ogqU7IVrzSCHEwEaL+0ltVu
	JtLV7Yd9zUS+sPeGLRB39PSKvnfPSBk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-AOVR5ItJPAiTrFlL7RrHPQ-1; Sun, 20 Apr 2025 23:08:25 -0400
X-MC-Unique: AOVR5ItJPAiTrFlL7RrHPQ-1
X-Mimecast-MFC-AGG-ID: AOVR5ItJPAiTrFlL7RrHPQ_1745204903
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so5317754a91.0
        for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 20:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204903; x=1745809703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hivAmNLcvTNx0c/bREHx35jQBHl8GSDmzWxh1wjb3U=;
        b=fReMUOyFjG93Q/bta8ZC3XeMogaf5ENuBhiBJqdPdmvUeYL8lSO7SGP7vW2GVCJOer
         Y05QY90KvHbQQsxYKBW/OVB9ozxBDev2IS+9HvJsogLuDhb0c9l7o2gsQp05zF/oN+xz
         aaXLlwtGrZ3TA7d+S9v+OD5fg8Hua83Z6UFWVSxfna0uZG2FxPFlx5ArIjlLdxEXJMwp
         UzAYyXginWxL6InE3Iw0MoTr3obt94mqp6LSjiwN7NlSf148/amtBsadoaHYP7g3uRnf
         O8ux3YQgGDn6ubYmYfR8UBKJDtx8QasfvMgdRt86rCaaT5SH833xHtJRy3ASrSEby3Tb
         QEfw==
X-Gm-Message-State: AOJu0YxmMv/UV/fV5on5Nki76p/EE8YXxRO5n280Gpax5XyQCI9xPKe3
	R8R/tG8h9/TREemG6IhRqTzEpytqBzKvWryDGLL06md+5JDgyuacNu0BT350cuOVMW/YyHiI0Q8
	6L0KCOZoeIu7xPtFfermW/0QVaph4OJuvL5Mhx1KWWJv8/mrIm/sUSux92FFHOYNWB7w53IvT56
	DJCu8+OPpzuIJLRSnM8/fGcOUDcSms8DwxdQB9iZ0=
X-Gm-Gg: ASbGncuMfEbWhF1TYPScrwWRM1POUdABXwKg6nU3iTW5Mb6W898Q1ndzABwdPZIZTw3
	RXTKcwlCh+yemPAfHvfStdMXYQAOAI5s7zSTgVuiNtNfugTqF0rxAsTuqqUx8hBSJn+ORpg==
X-Received: by 2002:a17:90b:2ec3:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-3087bbc9485mr12662292a91.34.1745204902906;
        Sun, 20 Apr 2025 20:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsGZidodHER7DPx6AJsb5qX7z5X9GlyzJiQZloe3T04D2Jm+L8lzs+jE/AE1c2bmOaTmkFYJEYHB7563A5Hac=
X-Received: by 2002:a17:90b:2ec3:b0:2ff:4f04:4261 with SMTP id
 98e67ed59e1d1-3087bbc9485mr12662267a91.34.1745204902583; Sun, 20 Apr 2025
 20:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250403063028.16045-1-dongli.zhang@oracle.com> <20250403063028.16045-5-dongli.zhang@oracle.com>
In-Reply-To: <20250403063028.16045-5-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:08:10 +0800
X-Gm-Features: ATxdqUFK2T-i_sGgdtK1QZ96gsa3IRjAzlkSfDUbg2Xu7DWrfBlUunqWMett7BA
Message-ID: <CACGkMEsU2nnTD7akj8im+UBYMjbyyUSAq7U9+uVS8_USAK81eQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vhost: modify vhost_log_write() for broader users
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gmg4h0CfiRDF87VwWdqObhlvqHj1S4fH2cNH4vqh50A_1745204903
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 2:32=E2=80=AFPM Dongli Zhang <dongli.zhang@oracle.co=
m> wrote:
>
> Currently, the only user of vhost_log_write() is vhost-net. The 'len'
> argument prevents logging of pages that are not tainted by the RX path.
>
> Adjustments are needed since more drivers (i.e. vhost-scsi) begin using
> vhost_log_write(). So far vhost-net RX path may only partially use pages
> shared via the last vring descriptor. Unlike vhost-net, vhost-scsi always
> logs all pages shared via vring descriptors. To accommodate this,
> use (len =3D=3D U64_MAX) to indicate whether the driver would log all pag=
es of
> vring descriptors, or only pages that are tainted by the driver.
>
> In addition, removes BUG().
>
> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

