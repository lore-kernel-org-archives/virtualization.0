Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BA1D014E
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799149; cv=none; b=Yt5pFtnXgrss2jencgd/ulkLp7vmLOIEJ3WmzDTHQ94XBrTEWN1q+g6yIb91nRs/SKbneC9rugzIoVaYjIMgvquFkPMZ2cbrGYFeSMe5dKiieEsL57saWFJZfywCFckoMNVpQKNpPbAf/B45E529XXc+cfpnLcD7KKPTK1yjw7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799149; c=relaxed/simple;
	bh=3boYlIm7+ysYJZ8hI0p5HudoZgakBgOBlMRjSuXyXRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbmwEspiXHfbnMQ7HJ6B/ptKdln4Ks6b97xuwzeZ/HuziNKCxxAHPDrJuyLBUOHPoeSk2kSYcuE/smNoxDGmHpdFOBYdC9GWDzjmEPqN1HtQbWGtxJF4gWe+QvbKESwmYbqVmMJnkN2eNt6GGy8YzXnDn91BznZv954IZQNg0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grX96xee; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grX96xee"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ACDB80D02
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-ErddUtWSUC for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 09:32:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4774E80595
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4774E80595
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=grX96xee
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4774E80595
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
	b=grX96xee7qCq0ye4CSboji+bGs4Yh5jkzkWAwJXm637///8I9S9ts2PAGnS0OCM7s7LUz+
	2WMfKbe2JqQwhz3DYTuePtlHB22Mvdr849Ncc61fCJFgvbsHhebhew6/ISJeRzfKCEPnMr
	WsacZRUZ+h0u8CZNS8ryNbaYsmRp7dI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-5vqPh-5vNoSp86hS7pnwlA-1; Tue, 05 Nov 2024 04:32:23 -0500
X-MC-Unique: 5vqPh-5vNoSp86hS7pnwlA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2e8a71e3aso6677892a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 01:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799143; x=1731403943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
        b=QhkfcksPeiP3tu+INTAYpYZNnHN8UFrHrbLKB8aI9xQRu1dR7VfzLe+svpIQZXgy02
         BX7URvyo9H0tAylrBMxUq41ourEeSKNSB7LDOXwwC1LlCY0hbFS17lTOqBe59eoRwqtb
         0f3739C7X2PFF6mvhaDMcH+dgznXmy1fv3ruYhAVJN4UOQQHYJj+SPPmPi4LFbc2SEN/
         1DJVJWIOgISR7sF1kjHUpfQ0gy1HeZV6+5+edUQKkl8cbzNrSCOPKXn5VFehJstCd6FK
         81bfgkjmZ/5dwjvSOC+7uZgNOHmbWWYxJbTrM++1tso0LHpiLxY8pp6vQ04tSX/9XDKb
         sBiw==
X-Forwarded-Encrypted: i=1; AJvYcCX2bsAzPh+JsWVrWMGVNAaf8AyLShB6n8shAez95X/rJ13ZDCiCIvDwLNKS92TKh4BH5HoE4nq9ptpCKVl2Vg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwWNP0+5qMi+7bfLTkg9pA0wRbsEtX2G4VJNp6zcyJNcEbsYxRV
	KkXrzrE39DIQ8OuOZb/b6AyAbG3D6lDn3MszE+9YICkdj7Rujf0178ODO41MacnasEf8Df/u7u3
	2L2bslqqLCnJmfsWf0Gs8DOQmOa6nQeMi1Biv6Mb4Kf4x85ABCcofVKPf0V4UqckusRCx4tGuFr
	XvBQhhSs0xJatSsiy2TZuZj20+nHfeScZm9DeoQDOz39NPFFDuIjkNRg==
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id 98e67ed59e1d1-2e94c2b086cmr21054740a91.12.1730799142813;
        Tue, 05 Nov 2024 01:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrI2dYkCr6bnvyp62rgLDstJjcAcnHOsb+T5y5D8ck5xShQL7y314TViGgIjvrllU676F8agf4RY2ewZHmgK4=
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e94c2b086cmr21054719a91.12.1730799142429; Tue, 05 Nov 2024
 01:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-2-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:32:10 +0800
Message-ID: <CACGkMEveK1uOg=Hq2WuYFW7+DbMoF_g6QjV5cUFkBHUEQXkcow@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] vhost: Add a new parameter to allow user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode. This will be exposed by module_param() later.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  drivers/vhost/vhost.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9ac25d08f473..eff6acbbb63b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,7 @@ static int max_iotlb_entries =3D 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>         "Maximum number of iotlb entries. (default: 2048)");
> +static bool inherit_owner_default =3D true;

I wonder how management can make a decision for this value.

Thanks

