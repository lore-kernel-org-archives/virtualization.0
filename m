Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6D32470E
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395343; cv=none; b=gla6+Ev49fWemifewD4wkLr4JNM+cZtDELACLcPkFcdFE6owKC47uvmpXFPzZkLMGDIg+tDzk4sCN6l6kVed8Oc+Cjet2SX3Sp/hhbCaT6mjfh7IVYhhOjleApsOBRY4dlp5B+1lET/Nu6mQL8n1muvRzRN5yNRYDERUHMdVtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395343; c=relaxed/simple;
	bh=FyKAtny/z3K2aOAcLJ07FAa4Lo0Z1QSMYiY1kmIuw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv09OjYmATWQyxx4I1Zkw5nN9hg9C854w1KX5Xgklgz8CcyDQ7lm2oWYjxGTRxtnBhDiK09qZ6EPP3FP8ClEXG4McAYA3d9dBwKIPH2v28mim+SyHJOmboy6gO7t5Tc7b+J6be7mTO0XSv0zy4jUcw79V3wzOFFFVzjwrBBpdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEg25zpA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEg25zpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
	b=TEg25zpAIlyqfAcSnY6IGCBMeeR4P72s31lpVcNlp2iwAtQAtC6ZsZECcRjOsUmxHbLpbK
	sUPkHY7UaOR1riRGM2E1+jFQSVP4tjYMEkjgQKJ1egnpcu0rPgeugp+55aWb6FAMicNfoK
	a/wdzDcz3c3qpW57eyIFe2gps17KTKU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-8TA70J6tNkuqSrF2QIO-oA-1; Thu, 25 Jun 2026 09:48:59 -0400
X-MC-Unique: 8TA70J6tNkuqSrF2QIO-oA-1
X-Mimecast-MFC-AGG-ID: 8TA70J6tNkuqSrF2QIO-oA_1782395338
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aea45d8c1dso297120e87.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 06:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395338; x=1783000138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W13IHKSrmFxYZTcAI1XOj4ABHyKjyq7rqzl7Q9cJsPY=;
        b=d+RohPG+Gg+LAPjmj9tWI1ZxJo5qrk07xKREw6VHWdlFq3u9iS5MDzU5iZD2P0bys8
         7GVC/MutUZVaPzqaJmdOEnI1ABfqmM3L8TBJHrTsqEG1/MhwWbQqVH7kNNhg745UVV3j
         v09udW1fRV31d24ObCedGvwZkxz9w3j4DxFz7lhJJHSUoia7AykjN2KAa09KNYLjJ/Hd
         QL0bPLYmbHZGtnoXjHkGMM/dSJjbiGenKmzUojyphlKBJ2Me+9So3qG1BsPviGTX6uFS
         rNRTAX7ArEkNVsY80Z5uUMM6Hy2WkoEbxv1V+w2w76YdEe2+/qRes9e5McYoKVEThEue
         kYQA==
X-Forwarded-Encrypted: i=1; AHgh+RrNpnNz48jH4PnmsRASahnlIId+L5egBi94B+KG5IG6CAV0D0m9B4Hc9IMYyBGvWmMBkUY7IOACKtKz0cXfCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtYA5aztXtJQDMvzRtvoX5PV04A7K4wBbRhpJlNRBiGVJpVWQe
	m5VdOvXcN149o+UQulzZhZ0SO2d51CUw9Q3z3oiYc+umdAVm+aKRbSkEcCEd57bDBrZDKAiO3iR
	5XWvd17ATMtE46FkGoO75/YpawIApQQYT/yhKprpdFEcyCVB25WJHgmFvpeRuEIKqFMIX4dJnXA
	KvhDhApVdEQItIIjaZUO3EsS1Uhj9AmahQTx7uNzLzTf4=
X-Gm-Gg: AfdE7ckctAAhglFQupnW93ziy5wG4NhmpERPYH9efhg9JWHt+krawyBuk6tVUUCwcrk
	RvN+8YQpGkHx53Em6Devk+GAN0RgtlCcHL1HBP8f75La/xbypZQA88OaXj3DwuwsnVmjG36/d8C
	vSNqsnHzVsfSqsbY88TVnfbeVJBkBUMSdWJjyIDYPY40szrh4jegHghFs12fwKhTLDwsY=
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id 2adb3069b0e04-5aea1f648edmr586215e87.40.1782395338209;
        Thu, 25 Jun 2026 06:48:58 -0700 (PDT)
X-Received: by 2002:a05:6512:20da:b0:5ae:a021:6b37 with SMTP id
 2adb3069b0e04-5aea1f648edmr586207e87.40.1782395337730; Thu, 25 Jun 2026
 06:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:48:18 +0200
X-Gm-Features: AVVi8CfV4sl2uVjBO80B06iwl-K1gPbYL0GUC3qWAw99NMlfQNPKKN6RpIXYBRI
Message-ID: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LrmK62r7-aIcFAZKbPfYLo_BRqRNlo1mpdcnyAwjL0A_1782395338
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote=
:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index db341c922673..70c578acf840 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + copied * sizeof(u64),
> +                              size_mul(count - copied, sizeof(u64))))

The fix looks good to me, but why not use size_mul() macro for copied
* sizeof(u64) multiplication?

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>
>

