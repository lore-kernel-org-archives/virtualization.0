Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0163F20FC
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473560; cv=none; b=oCWnVV5+kROh7vTplkoO1MwKnNtHWM5ZMhK62VWgrZUjnyi2dFMvHilJ1hrKEatTiLammi/ClxPiX2EELMlR6l8OTpi3yAGERiMai9nkVUrHyXd8fSJhwItSoyy2bi2R/f4VZjIgTWRZqny8/VGhnaih2bk+L396+FzKXDdAmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473560; c=relaxed/simple;
	bh=wvBn6e2zZVZyJRVO6FTn9idn63IqtNcAsXkmlHdOuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy7KZhJmL3ITHids/8+AcWYq8KVh1Bg5ZyEmOsv4rVVlrJkFaA+R/W2zTzEk2jK1+yJZa3WJoz2lEYZTv4vSE2Lk+a8NjD9NGPZQuNGzHjV8k/qCCk6HoqSz1KQ1tVCGqdgJE5so9r/KmXiVA7VkWhUiBu6eXSU/CQs8KW0uv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SARTKU0s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SARTKU0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
	b=SARTKU0sMlqscoYYpVra6F1vXFq15HZU4ZqzvD2Plki8mC0NJ3QFbMX9wZjj9bnCaetbZb
	8fxAg2/Kj4zArOkYqwdi3tC2rpWEMHQARYw3wsXVZUdjGAMCwlNMforqlUCuokK1Cf1HM2
	BRoDjVKxYcRV8ZXlPDdyj8CAWhi3y6g=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-OheFBDy4NimZLm12G_O4Tw-1; Fri, 26 Jun 2026 07:32:34 -0400
X-MC-Unique: OheFBDy4NimZLm12G_O4Tw-1
X-Mimecast-MFC-AGG-ID: OheFBDy4NimZLm12G_O4Tw_1782473554
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6648eb63d18so1120750d50.0
        for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 04:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473554; x=1783078354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        b=iHWelDrI6vAVndxFmo95boWhR/umevMUflgSQlds6KSfB0STIkwChYqV8X/wvx8xxT
         0WFKP+xPmWFrCwqBr4H/lir3Vy19XiYe3BQA8HdxytLneRQxYRwHqNumvZkCxdFPQbGA
         JzQalgug3V4MZV3clSBVrOOhct9RLcZXqfglTHmsn0coCQhdPazdHXU8GceW15I4Hgjd
         xd9M75u+Bt4MmlZ2LDdbKYup05XnZWmHZAqeUpsdtmoduAMErDMDNulsdD0JMW1t4mBa
         Vpz/j79mQYVsViR641VxTgVFoIIHOLQv1gtF08WKTSKA1FTp/BGLdYD4FOZd14fAFWoa
         7EDg==
X-Forwarded-Encrypted: i=1; AHgh+RrtSBpbfX54MthV0iBxgy8T9MjNjzDtmr75E/6CPBe7svf5xCKn+1ukrS07kjvuFwFsD0UDVSthQRTE196PUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXC4OsIAv3gkfb7e3r4AZBl/15xsPsMW5O54O3MyDK1RRJ6pTu
	xujIXb78mHwoRo6K1sxAXnp+UFCt/QCakg5vu/0l/Qfwd0CM1JsQBDBsJbbXIDX61oUAaFohPR/
	DPPgfyHBQUNgSra74sPL4mfSupz4rGeTZAtD4ziJQiOWgq4vOwUi4tn1h0z2pVFsaH776SzbpUi
	lNCq6lEu1gNH9sIQJYdiifE6KEqzTZBJQyUJss30EtUWw=
X-Gm-Gg: AfdE7cnD+zTwD8slnfAwNpLhEl2mdA6ZIijmDRB8/CWMtsh+shKRrtBOe8QFYD3j+YO
	04DWtcPKWIohswgV1UZcqtJ4QTDUdMUl69CjmpBhAnH8H7csk3HSVE7qOIk3+3Cwl9q/k04KTFv
	3H6DKUycgk/QCCEpgSWjSajakW6jkADwVuXHkAXkM+15qJE8HsoVeB7J0pMok4HGZPDbo=
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id 956f58d0204a3-66488344efbmr5117680d50.60.1782473553789;
        Fri, 26 Jun 2026 04:32:33 -0700 (PDT)
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id
 956f58d0204a3-66488344efbmr5117666d50.60.1782473553142; Fri, 26 Jun 2026
 04:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260626070438.59149-1-r4o5m6e8o@163.com>
In-Reply-To: <20260626070438.59149-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jun 2026 13:31:55 +0200
X-Gm-Features: AVVi8CdX7YAE0vZmUHYTRxuB_yZ_qwok6xv6BtZ9RLd4G6r_QlmLWG0P771exiQ
Message-ID: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0LUaEr5YKXOKZAUzPEnzFzxu0ZNw8T-QjLfy9Du2ido_1782473554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 9:05=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Use size_mul() for both the offset and length calculations so the
> arithmetic stays consistent with the surrounding code and remains
> overflow-safe.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
>
> ---
> Changes in v2:
> - Use size_mul() for the offset calculation as well, per review feedback.
>
> Link to v1: https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@=
163.com/
>
> Note:
> Thank you for your review and suggestions.
>
> I tried to add a switch in tools/virtio/vhost_net_test.c.
> The switch is meant to use VHOST_GET_FEATURES_ARRAY and
> VHOST_SET_FEATURES_ARRAY instead of the legacy versions.
>
> However, when I ran `make virtio` in the tools directory,
> the build failed with an error: missing asm/percpu_types.h.
> I fixed that error, but then another error appeared.
>
> Would it be acceptable to postpone the submission of
> this test case until I have sorted out all the build
> errors?
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..4b963dafa233 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1784,7 +1784,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + size_mul(copied, sizeof(u64)),
> +                              size_mul(count - copied, sizeof(u64))))

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>

