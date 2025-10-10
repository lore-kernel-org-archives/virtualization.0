Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB11A9FA8
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060374; cv=none; b=HON/ebQpu4LQ+d9QFYrE3zYLSOfFNl1iEUa6aLZhRmJAlGFoAtyJlrofRmi+86AtzCmq1/nfISxry/YEYTdPZoFZmd1MTj3wvJ2vuySzWPBtjFPEMWIUqNh9kedTWIJnHOfGTo/DRCVbgCpoa6TQ9B2Qmg4DbeIDfaqDuM1vvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060374; c=relaxed/simple;
	bh=4XSRVd6zjHhel0Yxft/tpVar5ofWk0brp4Y95QqP7Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igmxBR7TLV9dOvoO8Wb8uE7MPkqMnwcmQhlY0UpOH1AuxCJ3KPpb9NbVZjncSG5BTIIRxaSXtO5ljli5lICaHVyUBjIwttVT0iZZCh1y6jY0g/a9ITmGqihnoEXM8bqKWAxeq7q0hamd6pfMYQ7FZocH6aqWw69j5LSRTGMujfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2udfWXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2udfWXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760060370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ2PrnDvvtlGzC1CWb9dBshv/kwMkb9jABazEpzCcBg=;
	b=F2udfWXN2Rlr3acnWnLDabDoRIeg0iXbu+ePp0NfxtlFzzit7zEcTlmJpKiM1jCcrcpTD5
	jTyamHBykldMyH4K3QsZ8amuh5oYYGwSRHugCvUvH1ih9GUzdUouXqaEkijyxiS9rs4uEb
	EjD60/sGYr6MWjs9ifMJlqwTNR4icCM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-LM0Y9Cx8MNiVuyMQbnY-0w-1; Thu, 09 Oct 2025 21:39:29 -0400
X-MC-Unique: LM0Y9Cx8MNiVuyMQbnY-0w-1
X-Mimecast-MFC-AGG-ID: LM0Y9Cx8MNiVuyMQbnY-0w_1760060368
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2538510a12.3
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 18:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760060368; x=1760665168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ2PrnDvvtlGzC1CWb9dBshv/kwMkb9jABazEpzCcBg=;
        b=c8Bndk5cxKsOVtBeNlxzqMiURqdhvtJ9UVE5/D1gHhltb9ArXjDNmLKoaGvwKNGzfV
         9xJtE301nA6ya44DFB3T8N640FNrSgb7rfLAAYxtrXX3gBNGO5Tj3116EpKX96KF78QY
         i2tLkHpolzUAG+9fCCjr+tAhea/oxovAoFGS+HgaJmsVB5u9/CGPLxyIeIwM1ofeOA4E
         JDydK7Nx0uKjyRHEk/7kRwXPzyzoqE9ZGrgOu6J0gElSnQ87TJtnuz7KnSlpGyF+iYQs
         tI+eY2GXMAcJxFcuVGN3Y+Iynl3HPtp8apGZisIMf8UlTNnXtNsMtz/q8gGuFpuTaj4Y
         aqug==
X-Forwarded-Encrypted: i=1; AJvYcCWWy6G+qTYARfOIxf7Xy18kwznO1RRuN7Y7Wcuz86EgSD7VtfQ056FzAobJDWlA0Oc2/PJ0UlRBeLlgZUQyuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxehbQyetuc95VA1nhHV/6P9laJk0PFa7RpEDGrKpTpsZQQ1qIr
	TIQp6XC6Tj25PGdOzELS62G8YklprBnrZbwGbcPp+KJuHob+Uxl4XfUwSg7ol5gbeDKApfy8ZUl
	99EIH3l7OGhhWqVMUauWpmlNkn56lrFBrClTq9JoJJZODoNDWPRwegRurEqlHDBhngndDzKnnIT
	NDHmlIlCDBM+4Ooqxb4r61dbHuaAHLk53jVK8wcdc+dEE=
X-Gm-Gg: ASbGnctHasp6dhG4dG4B25OV6fXj00RB5YI6c/gnyif3RuenfKfuUw5GY5NZGy4l/ep
	3raw7k9QJYgiWUSUKknPeP1x2JpohrFcbCUPW7VADfsjeSD791nHR5pdO8XjmHSzJmJF1kwbUKs
	LnSdhd4GpoUXOaZA0ZKOgqat0=
X-Received: by 2002:a05:6a20:7486:b0:2ec:f29:1011 with SMTP id adf61e73a8af0-32da820e9f0mr12793212637.20.1760060368095;
        Thu, 09 Oct 2025 18:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWUCiMPfeXQJAxeOD5bsbIs4rsThpTo6HCCU59kWUmK7PnrOrxP5nmBoR6qw+ps6A1upYzM4SB9S2ZqicH+os=
X-Received: by 2002:a05:6a20:7486:b0:2ec:f29:1011 with SMTP id
 adf61e73a8af0-32da820e9f0mr12793191637.20.1760060367638; Thu, 09 Oct 2025
 18:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-3-eperezma@redhat.com>
In-Reply-To: <20251002103537.308717-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 09:39:16 +0800
X-Gm-Features: AS18NWC0f_X2gcqtgEFF8PFD0xeFfMB6NhlHaz6fkoqBYquwzREZgrTKbkviorU
Message-ID: <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: allow to specify device-specific features if
 it's multiclass
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vl5kYOgJx1_bBAIL00MEA3MgqhW1PstaQcmMfX0uyds_1760060368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Even if the device supports more than one class, there are ways to solve
> the ambiguity of which device are we creating.  In the VDUSE case it is
> the name, for example.

This may only work for VDUSE but not other parents.

>
> RFC: I fon't understand 100% the motivation of this limitation, as the
> backend should be the one filtering out the invalid features if any.

I think we can avoid these tricks. Currently, there's a one single
mgmt device, this seems to be in-convenient. Could we have a per
device mgmt device? For example, if user space creates vduse0, vdpa
mgmtdev show may see vduse0 so we won't have this issue.

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152..0fc32f3bd66f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_bu=
ff *skb, struct genl_info *i
>                 err =3D -EINVAL;
>                 goto err;
>         }
> -       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> -           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> -           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> -           config.device_features & VIRTIO_DEVICE_F_MASK) {
> -               NL_SET_ERR_MSG_MOD(info->extack,
> -                                  "Management device supports multi-clas=
s while device features specified are ambiguous");
> -               err =3D -EINVAL;
> -               goto err;
> -       }
>
>         err =3D mdev->ops->dev_add(mdev, name, &config);
>  err:
> --
> 2.51.0
>

Thanks

