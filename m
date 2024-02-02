Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837A7C0A2
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871171; cv=none; b=hfGFfeEiP6/+gp65CCPIYgf7AXys+3NdZlRPJSbxcPtNh1IIBUfGfGhaKXURge6f0wRdvQ9VgLYzmuS75GZABlQLtXG2CXPmeFnRHiFImNO4AlaYe0pHbtm3nirSoILQpvi9ew5eaUxTPJ2PNIReoq3PkawJdFbZRRcUe5l5K/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871171; c=relaxed/simple;
	bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8JUdVGVpR+k7pzIWOYQWjbY5UbIbcpse90vPJgNKWunqLq0iEcCshaxaDEXIm3TZU7VDwBYcWfcOb/K5+QoOOl9oNz3TKbtS3XH6HgzD+7/PRCAXkeF1q4bShNrxfKbUACNDTTdMCuJmXA/Sf0weqyXJF/XYmgJj3IlgysajeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRUpZUss; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRUpZUss"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20B48404C9
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 10:52:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20B48404C9
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nRUpZUss
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLuT0gDVNTmv
	for <virtualization@lists.linux-foundation.org>;
	Fri,  2 Feb 2024 10:52:49 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0B27402E4
	for <virtualization@lists.linux-foundation.org>; Fri,  2 Feb 2024 10:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0B27402E4
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-55fec3f2f9cso1007993a12.0
        for <virtualization@lists.linux-foundation.org>; Fri, 02 Feb 2024 02:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871167; x=1707475967; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
        b=nRUpZUssmAzQm1PgYkcQ+sYgFtSLsSa7qy6rcgfxsnUtHJ/ljlqKVv7kYuBaD+YZDc
         zz+FDPQOvvrBOGHs8S/9Gey5oMktWZL2iJSe3MIO9gZkh9IdGHpJ2soY3XyUJsL4EHtu
         ctvKCK5NVw6LKk7MesIOxSccKp91gJErPdQKxgM7rez6VIAzMMv0zYIH0FDrWIY4DchI
         0OnlSDfsr0/806cRPjDBW1QKJi72wWRSWVKI/uOloXqhf7eyOzZLtVeK3sLbpLRi6Lbn
         sDIlk7ZfXyiLbv/HekYaps6jpdSnEERuGim0k8cDgwNnBa47FGri2mqZURwbZtEljtdI
         +xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871167; x=1707475967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t5jbVDnTvAudor+E0CaRyF81HbhOTZ0aJFKGbE5sB4=;
        b=iNycjpRqjBfChwjQUFjeG314KU3V8alv/zVCLhJnfDHaeD2Qlf//fjIr8366G5OTCp
         LuochsA5JM4Y/mJaByo+m3axIZCV2VemohYsT5HvekMxU7+DQhKdemnR6qe2S08ojkdE
         IftTg0D9+CY9TozOVKwK09HbpVUWJ+EL9KzSZy+injJZD78hiChXISilBO9E6fXLe52Y
         JjL3zERnzv7B1xuljEtezxp+9ce0afSHSKWVhWCO2raH52MB0wJWXHa/SGmZXwhod/LR
         Ovj+DRN/pnBHiVHSbNHati6nPuKNUIRFDJQnekfYQlBtv2MT7DDVcIqT8ZKYNXrU1Cly
         RERg==
X-Gm-Message-State: AOJu0YySPeqne2VaWxvy1bFGrA55eoOKJgxEGZeinYIJOOFYDRTEDbyz
	mCmqPr46p7TAI3y2Nuq3AfLF8NgB5UAe/oga3SpKK34Y79UCUBp6skVIcMxO++SyAQ8pdSkNbc+
	J3zUyekEb/GBjb12W/X7dJPxHVUs=
X-Google-Smtp-Source: AGHT+IHjMu+uM/BPol4nBaLioQgqb7a0TTS0b3hHo+5t7B1bjoet/E3OyH3hBnIahi0K8sQpB6yqllID4YXVtiDl7BQ=
X-Received: by 2002:a50:ab1b:0:b0:55f:4fab:8299 with SMTP id
 s27-20020a50ab1b000000b0055f4fab8299mr1372977edc.14.1706871166570; Fri, 02
 Feb 2024 02:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
 <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
 <CAKhg4tL3E_AfsEOyzUr13zcbjzzUY1v5VXdAGMLDYdy5om35NQ@mail.gmail.com> <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706867854.8480594-1-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Fri, 2 Feb 2024 18:52:34 +0800
Message-ID: <CAKhg4tJCGtPD0fyjmCfDTU3TUW6B8T9XRERT=Y6k3+D16QPeNw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 2 Feb 2024 17:25:02 +0800, Liang Chen <liangchen.linux@gmail.com>=
 wrote:
> > On Thu, Feb 1, 2024 at 1:37=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@=
gmail.com> wrote:
> > > >
> > > > The RSS hash report is a feature that's part of the virtio specific=
ation.
> > > > Currently, virtio backends like qemu, vdpa (mlx5), and potentially =
vhost
> > > > (still a work in progress as per [1]) support this feature. While t=
he
> > > > capability to obtain the RSS hash has been enabled in the normal pa=
th,
> > > > it's currently missing in the XDP path. Therefore, we are introduci=
ng
> > > > XDP hints through kfuncs to allow XDP programs to access the RSS ha=
sh.
> > > >
> > > > 1.
> > > > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@d=
aynix.com/#r
> > > >
> > > > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Thanks
> >
> > I've just realized that I forgot to include netdev@vger.kernel.org in
> > the cc list. Would it be advisable for me to resend the patch with
> > netdev@vger.kernel.org in the cc list to ensure it receives the
> > necessary attention for potential merging? Thanks!
>
> Did you use ./scripts/get_maintainer.pl?
>
> Please resend it.
>
> Thanks.
>

Sure. Thanks!

>
> >
> > Thanks,
> > Liang
> > >
