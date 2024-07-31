Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12E18B04
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396094; cv=none; b=bFVvRSe+foPtz1P6SuO7D7RMvwX5PhVeiRTkJEsGF2i7k3O444+Wqrz0lqdz+d2PksATsadzhpAXCjLt03d9mIua/7vbv/RQLkP4QOl/kmcxvIFIxBdkn/Lmjt/uyqcCRc+Ff7KLRpwMDiSQvxKx7rrI8athE5hru24Sk93mEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396094; c=relaxed/simple;
	bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn6ub5jXUy0DQc0+jgO2VPZgCVgCuH6RTwDqbynShT+vDTh/wPW6DT7IZXAr3NCC+FCOV6cT8l2FoDscjxYsrSbXAbpaz4WpSWhd4O7/FIbhWiNyL+WhnJnjJlYb9V8LF/uhpxehnsAK6zc4hVLJ0aiuXCeb3r+q+NNi+Y7gRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUKq3CBn; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUKq3CBn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6119140210
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ve-zhV8sFCYL for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Jul 2024 03:21:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 86EEF40174
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86EEF40174
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DUKq3CBn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86EEF40174
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jul 2024 03:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
	b=DUKq3CBnyDd2OTq6jxGz+DTy4/QZv2N7yADUcNbEMM39qcMV3q04FZT692rkL0Qxc1z7tL
	JxYc8SppCOg8JRMRnzn/RRDaKVNOk7K7i13rpNdzFQzEMNz4itwpq/33nvoBDYc1dC/Cnb
	nbhVbpoxlUzsoyTdvRgzKjoKUBjW4K8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-S0tMTVwiMLSgHAGf_YJh8Q-1; Tue, 30 Jul 2024 23:21:30 -0400
X-MC-Unique: S0tMTVwiMLSgHAGf_YJh8Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d1a9bad5dso5721291b3a.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 20:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396089; x=1723000889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+9z5mMlcdAWMW3cReFctIogTSgAXib8SXPR/OCNbSU=;
        b=kFrJfEGLiusJSuClAqIRpXzqUtdKVALf2CuC7uG0DRt1066eVoqgpomhygXfWn3e22
         urcF5ggOVRWhaXHXjbe0BOSGwaXXlYQpYBbBcGDgnVHn65ZDboEOCHwyh1xIqdDrSdgj
         H4zbFhvje5ihHNSiaqo4TIF/Bb+0pu0s4qyOnY6dcw67SMrSd/Rl/m5IToQ3LAgnnD0F
         wI4DFJTTL73MP8Fiv1Bs27VN7V5raYv5r9dXIc8ZyFPBjF/vPUXPZaEMzmkjAg8MW6/9
         zDSLXvt7HR1nCKEDJ82w32olzZaj2wOcMPHpp/kZm61XSuGmmxRLd2rL5znZfKOAIM9w
         JTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Gx3x3jaXBt9svLUyBKGj9Wqkt6fkmViy/274pANpKn9aNivVeHJg4kd0c0mA96IAnyL735AzPjX9moX7Nba/z2hgB/JdQP6mhojZHjSiZnVP9AaX/fk/2Q==
X-Gm-Message-State: AOJu0YwjLwPW6/1ov1QmcghJNlZtbINQVZ/YlGucunmbIGeo4wmB+X2w
	HNHjZp4E9+4kmIsj6qIcS6XdJHCNmtcEPNswV0HcuF3rAaZ/zVLlQG+uLrZMNW1UsXc3i7B9z8T
	P64KTjtQA7MTEF8/MymkS8jCjX7nOisptTnNsTkcUkhnVqyIp9GoznfVEf6hqJk3v+Jr+alFUWl
	fE68Le7FR7OKygO04dSwdFk7A853VUPMCCwfyvxDtsT2z9rOXaFeFj1g==
X-Received: by 2002:a05:6a20:431e:b0:1c4:8650:d6da with SMTP id adf61e73a8af0-1c4a1184098mr18137300637.1.1722396088967;
        Tue, 30 Jul 2024 20:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHyW4udyXgOynWPU6sFEx+eYkhyApxZ3M3JsIfoMTHydwIbe/BHy5bvZP7PulcbNJ8nlYxgYYxKYiSilfMjmE=
X-Received: by 2002:a05:6a20:431e:b0:1c4:8650:d6da with SMTP id
 adf61e73a8af0-1c4a1184098mr18137275637.1.1722396088530; Tue, 30 Jul 2024
 20:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-4-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:21:17 +0800
Message-ID: <CACGkMEs9T17z2oBk2dYZnqt+FX_wr=hWUAbXaG__s5qo3XQtVQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

