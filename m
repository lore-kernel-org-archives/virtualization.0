Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179985626
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160239; cv=none; b=lYbejkWbwEUYs0EdVfxlcCzlWkRUVN9/d2rZYp/+fLRxthAlRk0yTZ4AASp4r1Fz3/zBfaTO/khCmJddeeGymtDOWRFrVpXO4xKouEcza1/Ci0hD1R94Onco099Uujczqc86gNQ227ZyNaCyh1YyA9dbHuaO2Ir+bT6pj7Zcgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160239; c=relaxed/simple;
	bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJcNuK2grgpOWCS6otZxbGQswYgmcTRwfBF0ypw3ro+dnU7e0lTwf5H0YCl5inDrbdssbXGJBN4bjgwTwHvlu/uHw+9SP+IWt+oBY9iVBg+QMgn64Qj4bfcg1EOyMGILxStfAjcLtVmqZlR2vAMhXQdBDB3BUBI9ueOUeMZKEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fANOq17H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fANOq17H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
	b=fANOq17HOki4t+ATFi62mAV6GeKZWCSZ/m97rT6U0kMMYInpBuNisKAQK9KaFAd9d9xjZa
	fzW9aiZpOrXz0/nSlFlcuIdQ/+CpszJCnV1o6ETJLgjSYXDq1Rqv8oL+JBOKvxT6oSpIv5
	sjblsyajzHpU4p6G17MrLkZmpakPkyg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-EElwGPkmPRqMzHQrrmak1w-1; Sat, 11 Oct 2025 01:23:55 -0400
X-MC-Unique: EElwGPkmPRqMzHQrrmak1w-1
X-Mimecast-MFC-AGG-ID: EElwGPkmPRqMzHQrrmak1w_1760160234
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-335276a711cso8696326a91.2
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160234; x=1760765034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3d4b/N4FyQKMJi87oEP73YGkldUtfGC4FpI51qq0t4=;
        b=e/ypFiTzLikqG3fkcsYvxuRD9GshmdcXDECWRPWeiCdpZbqaoevcZC+Ynqy5AS1WhI
         +5gX3MnUi/Y+Pc2EVpd8Sc711DjWxj6suChUl5mPnph8Esg3jX1MkgSZ4EEcxzceHX76
         QcX1qvVK1bFDlkIqHzON8u0X5+rKlWHdjZy6Cy/HG//2nUi0OKnU6fGZsLSs4532u72S
         HD0V76Je5svAsYRkd/VwNTpbaVTfPbccn7YO0GS56vN/rQSgVF1CQ9nKVsTUFBtqbZrs
         HlE/GTONF+LUf/ylbIeQMrEy693rKRqYOMXhUNzWu2m4c0gPfQ96KNCLCSEsbWK8h8Wz
         G+7w==
X-Forwarded-Encrypted: i=1; AJvYcCWiyCLjfVR3yeBrTgdu4wr4eCu2qZBrqs6cWaPVYrZ2afGiR/RYevB45dklLawnvb8CZSz1zKE94EHYHdmbRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxQ31+EQUanbAiIcF65gcFmVN1yGWpacy2ngsv3yVyfqnEXkB6
	XwGQhHC+4lV94Hev96nAFMp50m+YVtDlwZZN2woyK16Jk7rFm3+qBdJ+rCaRjzrE0goDWdffYeE
	dV/t9iTtXm0vvE4Z5kg6CnTwlbyb3OIBm+2ee5PQZOVwlq9uTYlqVxQphwjF0KeO6Qwzy2im4lw
	//ALr2+51WTIUGGvy4/t1M0Y39tO1/LU7oLQkoWwlsD2A=
X-Gm-Gg: ASbGncudz+yAjcuJl3n32WZkkhQJqz9lPg1B6sbXncENIEX0lIWxnycmhU/5cABHiRG
	G8/n2Pn+1JfMu3I3cXYSB9gaDe/jfza839Ubwk4BJ99dtA0B+ObBKqj42TrRJDQBACBk24vtWrb
	dx3O+wGhHBmFoc8WXw/Q==
X-Received: by 2002:a17:90b:4f4e:b0:32b:6ac0:8633 with SMTP id 98e67ed59e1d1-33b51149788mr21426253a91.16.1760160234044;
        Fri, 10 Oct 2025 22:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqdXPAS2ssgsKHgD5+QnWtQ1lApDRF+iswoN8NlyEK29EMvNGRiuCBOFj30yFf8WhsUrmzk6ZCikFrT+2WxBg=
X-Received: by 2002:a17:90b:4f4e:b0:32b:6ac0:8633 with SMTP id
 98e67ed59e1d1-33b51149788mr21426235a91.16.1760160233656; Fri, 10 Oct 2025
 22:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-8-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:40 +0800
X-Gm-Features: AS18NWAGyWlLirjUfX97UwGc0J9nSt_XHJxxToD8sgbypOyWBOyMc98S03FQ6J8
Message-ID: <CACGkMEsW+v1+rzbr4k5Jpxi0JfVBTJW2R1-QYYf=_3cNFBZtWw@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OvgpXW-gEmX3Ae-iQ4CPeXmBODVdNMgqcqd2-Shvfuc_1760160234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:59=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

