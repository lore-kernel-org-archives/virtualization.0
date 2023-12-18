Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72D5238
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsesuWhn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E2B981B10
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E2B981B10
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JsesuWhn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id op4-gTi_-YeU
	for <virtualization@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 02:51:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02197819ED
	for <virtualization@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02197819ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702867866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISMFEsMM1g2N73O1vBRmcaqbJpJmsUd8b4uizvNzNBg=;
	b=JsesuWhng555TSELCf/0d+hTwPMH+9UgGFuDDGCw8QtjvZ537Wa68QpZdCvNrdZowoAL1P
	yW+d/8DeJPk6kkOMmaK8WlaZGwk/DZbVsWD6gzh8CglDgY9vDENzMGpEdrP2NfImTc1jHt
	VnbyxZlBhCaRj/wYNAHws8kUw/9Aomg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-WzSY5TRvMO2A4YYv6NZMBQ-1; Sun, 17 Dec 2023 21:51:02 -0500
X-MC-Unique: WzSY5TRvMO2A4YYv6NZMBQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d4adee9c25so1684218b3a.0
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 18:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867862; x=1703472662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISMFEsMM1g2N73O1vBRmcaqbJpJmsUd8b4uizvNzNBg=;
        b=G8o+IjeQgVk+HYtkvQkVayBHpg6ubbMTH6TyrpWekCQCf/f9w8M4NQlwYWBzq2dpUg
         omEPHI03wtEAQfsVRl9sEmKZxyOSUQXIwjB7+SZqxQe2yi+HP8egrbfDISeqnvI+dUEJ
         f94I0wETkfigyrfKxIIQ2CC6u3C2QcxlxNkh0fCOMkms6L/zPpi1/H4yiwbSJC5r7viq
         GLn4vNGeJyUR5Oi4kZ2vr5/cK+3ceYhqOnkjLnYwFUt+qjEEZCWDCHJOJlYRnMN/TVLO
         8zh+53PMHfyl9xqJ9a1+YfTK3WKQQ6VxHza3kb3a23A6urV9f37GB5v6ooBdqcdrT3XK
         FgTg==
X-Gm-Message-State: AOJu0YygHSP9MxeRNROv4WSgVQ6Jcl4rtNo1tstbUgvBh5VHKI9wzVDV
	8/JPdPbc0o8rckOKhOWBOHBpGyftiDF4qrWtaUW67gSnAva5+PisId9kUilt0ZV95BkRyLZCSfd
	iYuz769Ewg/l4/LKJeDF6fm+Bb4qVLcSwHQFrnYGk4QrDASd7KVWWVjbnyg==
X-Received: by 2002:a05:6a21:9985:b0:190:2ae6:c685 with SMTP id ve5-20020a056a21998500b001902ae6c685mr20022271pzb.42.1702867861871;
        Sun, 17 Dec 2023 18:51:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCv9GdFyIZMKAWiwa9SY6YkVr3sTTb5Jm6rcirsnGe0JpRLP24GGIM7M1p0A2vBwQ/GToGo563T213nOdDLUM=
X-Received: by 2002:a05:6a21:9985:b0:190:2ae6:c685 with SMTP id
 ve5-20020a056a21998500b001902ae6c685mr20022250pzb.42.1702867861638; Sun, 17
 Dec 2023 18:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
 <20231212131712.1816324-3-maxime.coquelin@redhat.com> <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
 <8afc44f7-cef5-4b4a-afac-85a4eb967d3e@redhat.com>
In-Reply-To: <8afc44f7-cef5-4b4a-afac-85a4eb967d3e@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Dec 2023 10:50:50 +0800
Message-ID: <CACGkMEtNZyHDzo2e_N9SM9dw4CK8vpZHWBrk7TFFixD1T7cdjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:23=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Hi Jason,
>
> On 12/13/23 05:52, Jason Wang wrote:
> > On Tue, Dec 12, 2023 at 9:17=E2=80=AFPM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> >>
> >> Virtio-net driver control queue implementation is not safe
> >> when used with VDUSE. If the VDUSE application does not
> >> reply to control queue messages, it currently ends up
> >> hanging the kernel thread sending this command.
> >>
> >> Some work is on-going to make the control queue
> >> implementation robust with VDUSE. Until it is completed,
> >> let's disable control virtqueue and features that depend on
> >> it.
> >>
> >> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >
> > I wonder if it's better to fail instead of a mask as a start.
>
> I think it is better to use a mask and not fail, so that we can in the
> future use a recent VDUSE application with an older kernel.

It may confuse the userspace unless userspace can do post check after
CREATE_DEV.

And for blk we fail when WCE is set in feature_is_valid():

static bool features_is_valid(u64 features)
{
        if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
                return false;

        /* Now we only support read-only configuration space */
        if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
                return false;

        return true;
}

Thanks

>
> Why would it be better to fail than negotiating?
>
> Thanks,
> Maxime
>

