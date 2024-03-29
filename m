Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958338F9A
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684570; cv=none; b=nsAxSi/Jwo44RbFoC2vhi6tXRzKvLSO6vVhMW4D3pgrrKswUZC4YEVTaEAPIQTx/ZGPFKbso2hl1N8JtZGXjpCPpa+rgB/yGg5xxTMPp5mIy1QHhJSGqTsHl5RmM6CXoljcHA4LpLvjdLIdnrC1Gi3kWboNnqxMoM45yz8pwPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684570; c=relaxed/simple;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8WqK4cnjreuKNtBV+S0qq2AGaBwcjEEBrcApu93J6kc7MjvHfUxpNobPirdMUyFM9JTpA6cu7byJh1A/tKwa58R0ZeIxt2SAA+QIqmpG4dSdDbkt3YkaD5f9T/TyFlMAZE73Vaj50IJruWGey1E02mIcqhoqqSSID9bPAeiuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyGiD1Wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyGiD1Wy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711684566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	b=gyGiD1Wyt+1Jhi83kuzdCNeLA3KxmqJ6x+wJBZW3eahEfRuahfIEzaDFnCPrGqTeCp71QT
	3VCLYRE5BmjaoJKw4pS0ME+helrX6ZlWXWrNCV5f8mjBN0eb7XcmbBzcOnOb3AefSR0We9
	O6fy+fdU3Tulx1KyCcX2S3WgouojH6M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ir-JhUKWO5-g8VG3z6OhIw-1; Thu, 28 Mar 2024 23:56:03 -0400
X-MC-Unique: ir-JhUKWO5-g8VG3z6OhIw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e0ae06181eso18924335ad.0
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 20:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684562; x=1712289362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
        b=MJ6tIXsJWNLyY0NvWFqiMiVbqQqP4NRORcqiEuodV/AsfH7fbaoslX1Z9+zCaNkj0A
         cGZw1s9vWIQvxSttqNtSdq4fz/mT5TiBdVrAZqJTOpfLVT7bViJFuK2zxwxMhx68F7VE
         RveKlDhP7HqytG5V6FMPJkvKxqkwxYYxCMN89QVzMFE258j+MEapVxP3iqcEXHMiUMHf
         V4l8DqNUg/F1DLve6VrEn3Pg4lTqSpcA9h210LNHuHYSzRjmVFWkMtRz+z92EwUpji3r
         5Gj3zY2ROleNxaFbubYpcQKkhFmXsXwLso1JjQ5T+a/h+CA1EmMefzzF1IAuZJXBiDbg
         0r8w==
X-Forwarded-Encrypted: i=1; AJvYcCXvJoeqSfdxGOOCQkEhKIqwDvcZbAHvbyUPfVcFDAhL80QDaLguyZtPVmRiPVQVyMiIojedUD4JOTBWo8u6tKRdsaeCdh+XN7KY8TpV2aE=
X-Gm-Message-State: AOJu0YzitguAGiwOVTcJkxpPGVwjS6OBmjKg+6FOn0QDLNa1yGUsxlRW
	cEwzf2yKlwLbaaoJE5GZJgo23AFmxlUeexo8bNmr/HtEH1ZgRVC4PHbYWlZ7Z8xHUnOiXDQRqMq
	ZRY99z7VNHRxtPXPvT9mtMN0Dvod/Ys7/6ug27MLjgUBVW2X3hNs7L8b4htAz+4/jOUNdr0Zehn
	XzBYq1zew1Lz3NTP2oI00Qb5lmfRnSRj8N8TFGtq8=
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id t21-20020a17090ad51500b002a08d17948dmr1838128pju.1.1711684562667;
        Thu, 28 Mar 2024 20:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5WpbyriUxjePwEjGO5X6q+YKYhB1eZJaJgrj4rVieoGSzVLIkn+ALnR8ZipwbzdgGvrRXqkbuUUu/vp0RL8A=
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id
 t21-20020a17090ad51500b002a08d17948dmr1838120pju.1.1711684562345; Thu, 28 Mar
 2024 20:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
In-Reply-To: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:55:50 +0800
Message-ID: <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > From: Rong Wang <w_angrong@163.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> > >
> > > Change log
> > > ----------
> > >
> > > v1->v2:
> > > - add resv iotlb to avoid overlap mapping.
> > > v2->v3:
> > > - there is no need to export the iommu symbol anymore.
> > >
> > > Signed-off-by: Rong Wang <w_angrong@163.com>
> >
> > There's in interest to keep extending vhost iotlb -
> > we should just switch over to iommufd which supports
> > this already.
>
> IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> makes vDPA run without a backporting of full IOMMUFD in the production
> environment. I think it's worth.
>
> If you worry about the extension, we can just use the vhost iotlb
> existing facility to do this.
>
> Thanks

Btw, Wang Rong,

It looks that Cindy does have the bandwidth in working for IOMMUFD support.

Do you have the will to do that?

Thanks

