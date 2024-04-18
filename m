Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA315CB8
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401997; cv=none; b=aC59Fox9p5GwaL6fIou6+CuhX9xmra00VBpxDHEK0+NAXxMH0whJ5pwPWLNqmNkQMg+QBd1h7XQahdZBik5aKwGggQh2RfYxuevvK915HhpJy/zehE8pDpR8Yh4q12AXw+bZmryZ9tKvckY3K3/rdDDOvuYQlh8QRjwAr/SM3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401997; c=relaxed/simple;
	bh=0PLswlzdRZac7fSfdw04a3qPdOrmUrMFKAUR9gvwR3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqPKU4KFmiArKCthhaRIF0MPuv63T8MfB2XOSbheVDCBv9V1PJLx2KgKAH8DT41oMKMvqMt0no4Iip1pTntSE8gYfuQ5eZ9t/6/yE/41If0UmSYDJbrACMoSwUzVfCYNRAjfN6t8JnCmnZ5RY31NhNIqtKLOKeLzxk6tPvF5iQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXvueJyf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXvueJyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713401995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRp0Lio2AX9EGb63nd6AbRw/SjgJeY4MzMTWj8Re0mo=;
	b=QXvueJyfFp18Xgck2aCtVRW8JE3linDcNqWEAlTGyT0bAM3RpeciQGZGr8e8htJ05lj+tB
	pDlwZzy2B6g2c421yttRBy2GgxZRy0c9Sn6lCX4fn9RJyiKRxtZ2N8/5DN21vb5nPEocM+
	JBxICjT4zOEAZyY7D14Ygi0zcVyHym4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-M4EkB2oUMZKlB86FEW8jYg-1; Wed, 17 Apr 2024 20:59:53 -0400
X-MC-Unique: M4EkB2oUMZKlB86FEW8jYg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4f59746f7so408395a91.1
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 17:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713401992; x=1714006792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRp0Lio2AX9EGb63nd6AbRw/SjgJeY4MzMTWj8Re0mo=;
        b=UN6cWHBfnPWDXeC0YhH02NRAyLtQtyBf2mdN3TuWjQFMmhbZI4A+MuKdlnJJhJwofm
         VvE4EHsYNHVWTSDYyVGOwYm6pm+O7oyA2UHv7GJkF+rVfJTzC371TOurUNhTPs31jjWW
         NWJTXerSDGg5wCc88prMX0ORxaCp/aLjhessUVrF2oJTsrrH4n7fl+FoQGBNofbPPr4l
         27QXmTHJiU8c0N40HfgPFH8GmpiBw1El/zH4Swy00FZ0FlmUXJhX0w+XF+9x3fnkXv5T
         b1KtwYVziZhHQBYFulojSEa7KHSW0UP0kn0HwRiK7jMGpiXG0EXzAPOkLHs+2/kRqF4T
         JIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMpg0Lf6Aa54XGgOX+QDFJKu2T5gMEMcL539dqHEpg2gaieTVvwndMcdrVr30tj5eZuKGQqxCpxrI49UHAK51EVmDK9V+7HiyJlvdFaHQ=
X-Gm-Message-State: AOJu0YykaFsOjeEOMlD2ipVEAXn0azLDgvctnwC3JjRFNv++jSKA0AI7
	8IbFcmVTVETGstPcwSIf4l7VV+zQGnlE7P7664wSXt02PRgzThDSytl3ZimgwMjVSf99wbvkTFO
	W8rWpPJ//fOsVaQTg3MqgzAE1kBUYQDEsb4+AW5DxaPwGaC/6dye9UzYZV13nijsGK+MpjhQNVw
	Ysl83lbMbbQTferg4uMuQHBz3hLx3MCRatu7W5Iys=
X-Received: by 2002:a17:90a:fd0e:b0:2a4:9183:c8fd with SMTP id cv14-20020a17090afd0e00b002a49183c8fdmr1163517pjb.18.1713401992578;
        Wed, 17 Apr 2024 17:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRSEZTbSzFpG8KTOdNp1Y148is/WdwL9i3H7sSnLKQSp+rT15RLf+aKIMtklQmrOvy1WUR7L1GIi3UypknUms=
X-Received: by 2002:a17:90a:fd0e:b0:2a4:9183:c8fd with SMTP id
 cv14-20020a17090afd0e00b002a49183c8fdmr1163505pjb.18.1713401992242; Wed, 17
 Apr 2024 17:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240415162530.3594670-1-jiri@resnulli.us> <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho> <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
 <Zh94zX-oQs96tuKk@nanopsycho>
In-Reply-To: <Zh94zX-oQs96tuKk@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:59:41 +0800
Message-ID: <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:23=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
> >On Tue, Apr 16, 2024 at 5:37=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
> >> >On Tue, Apr 16, 2024 at 12:25=E2=80=AFAM Jiri Pirko <jiri@resnulli.us=
> wrote:
> >> >>
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >>
> >> >> Currently there is no way for user to set what features the driver
> >> >> should obey or not, it is hard wired in the code.
> >> >>
> >> >> In order to be able to debug the device behavior in case some featu=
re is
> >> >> disabled, introduce a debugfs infrastructure with couple of files
> >> >> allowing user to see what features the device advertises and
> >> >> to set filter for features used by driver.
> >> >>
> >> >> Example:
> >> >> $cat /sys/bus/virtio/devices/virtio0/features
> >> >> 1110010111111111111101010000110010000000100000000000000000000000
> >> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> >> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> >> >> 5
> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> >> >> $ cat /sys/bus/virtio/devices/virtio0/features
> >> >> 1110000111111111111101010000110010000000100000000000000000000000
> >> >>
> >> >> Note that sysfs "features" know already exists, this patch does not
> >> >> touch it.
> >> >>
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> ---
> >> >
> >> >Note that this can be done already with vp_vdpa feature provisioning:
> >> >
> >> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
> >> >Author: Jason Wang <jasowang@redhat.com>
> >> >Date:   Tue Sep 27 15:48:10 2022 +0800
> >> >
> >> >    vp_vdpa: support feature provisioning
> >> >
> >> >For example:
> >> >
> >> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300=
020000
> >>
> >> Sure. My intension was to make the testing possible on any virtio
> >> device.
> >
> >It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
> >with mediation layer (like feature filtering etc). So it can only run
> >on top of standard virtio-pci device.
> >
> >> Narrowing the testing for vpda would be limitting.
> >
> >Unless you want to use other transport like virtio-mmio.
>
> Also, the goal is to test virtio_net emulated devices.
> There are couple
> of implementation. Non-vdpa.

So what I want to say is, vp_vdpa works for all types of virtio-pci
devices no matter if it is emulated or hardware.

Thanks

>
>
> >
> >Thanks
> >
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >>
> >
>

