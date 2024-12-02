Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35F273FE
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113318; cv=none; b=r8AMDQMJbovaz8ENTZYACtS2ndBDeJE8o8XnKlcAwWDbavL26zRM2nrmHdJlvBLQk/X3lLGSGzSnwCp1OIhTa7cMJSfcx4aDwi1cfJygbMO+qe+eJGO3iTgf4AAiHIMjSqS89ilhnpkHHBLH0E5+aLxxFqgc33qWtkdAw7+jzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113318; c=relaxed/simple;
	bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ3OxfkdLB9GtLsPnCvxLz7L2UZjCSMfEQDNUXGtnYbc0thmUz2elPdg9K5QOai2qvDJqlf/hD1prOyJsqUMrMm4PuhypQcARthYCKScNzho2TpQhFozVR3groPOd9zj5Hk7Gjy4+LbKAi3RQFQi+YwDupYc7IK2hy0PPJQZX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8QpXA+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8QpXA+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733113315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
	b=R8QpXA+WQKS5vf71gh2NVKKE4M6+8KWeRxbEQDQF5UlccK+W+uh7m92qgbJ2+3KaTNnvuK
	RbNq9x/LndquDjghulf3a1va0xnEnCWw2U/s5b8TSIK6ZmRqzCgdDK3f9YW6cmguz0ezrv
	S6/d/o4vTp3safajhq6sL5rs06ptze8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-EUbNRNEYNhyIfT0pIRgVtA-1; Sun, 01 Dec 2024 23:21:54 -0500
X-MC-Unique: EUbNRNEYNhyIfT0pIRgVtA-1
X-Mimecast-MFC-AGG-ID: EUbNRNEYNhyIfT0pIRgVtA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee4866c419so3892758a91.0
        for <virtualization@lists.linux.dev>; Sun, 01 Dec 2024 20:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113313; x=1733718113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
        b=O+17IkEU3YeYmtJPxvSaO3nzLafABk3XJSSKvDWR2glUVmtMUybmSgIQsd/jFRwWkt
         iWe6JuiCeC4Rd9OXPYMmAU+A+SmyYOvr6hctiUfnrbEYXPOu7cuoN/tVXvBeM46roKB4
         Q4FzopNl0a8MURqrx1mdFecnSItVjTb2VWcFz+9XwWUNeymCM6Yoii/V2Tr3aOARHzqS
         RJYh7+TF+VE2AMKAeF/OadYCDcmqL0F2LsKAZ894+ZyQGsK3VJ5sScu/AqJfy0KWVPPG
         Q+694igSiTUFuNEZkyqFdCOrgCw0GmYBncVQYqXG5HKm4BpefuBv1Gyw7J8J57gHYxGN
         54YA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8LsyEQUDtW3laN17TbZY9TgHSv4L/O3Xtba8rR58vuP8ZEnAIBgqWshTY+y63Js77lCRFJ6Yos5MNf7oZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzBeeD30Jrfn6EwlCGCXQJ2uFvmXT9pIKrf4VX2SmNTGmWU+KM
	PKP05t6PFVxLrKCeGj3+AZllHmRam9lcH4rEBulmta4y3W/8rz2/UDBf8SiDohVI+4e4VJgPxU8
	yPJpABZqBlVpPLpEkIezPXmGy2xZaW1knQLztui6njGIe23WpQvIA8u6RIrkblRiMKPSfCtJXIV
	KNllrICH2oB7oKzrx0TCCHroIHCcJp/Noz20WH+b4=
X-Gm-Gg: ASbGncvh8oOCdFiyvpBbsOvt+0ZWjPt3Jo04lpQ1WiCud44aliBfhpWbhLNnx9HdGw4
	q2EkTdUhlwEhGc1/K7GtfIXoCA/rFnp6E
X-Received: by 2002:a17:90b:4d8f:b0:2ea:b0f9:ff73 with SMTP id 98e67ed59e1d1-2ee093d5f46mr25606409a91.25.1733113313161;
        Sun, 01 Dec 2024 20:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKXyYMGmxaU8kARMMowKLrTa9w7H4WpfRpBSe/paz4rHEQfwNjNrrRCMqScBY4D67rx1jdhBOk1f5dA0leBqU=
X-Received: by 2002:a17:90b:4d8f:b0:2ea:b0f9:ff73 with SMTP id
 98e67ed59e1d1-2ee093d5f46mr25606387a91.25.1733113312765; Sun, 01 Dec 2024
 20:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Dec 2024 12:21:41 +0800
Message-ID: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R5ytybKHShvb-cHZlVaoJamJn_0DZbiyw23IIGzguAI_1733113313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:36=E2=80=AFAM Yuxue Liu yuxue.liu@jaguarmicro.com
<yuxue.liu@jaguarmicro.com> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> Implement the kick_vq_with_data vDPA callback.
> On kick, we pass the next available data to the hardware by writing it in
> the kick offset.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

