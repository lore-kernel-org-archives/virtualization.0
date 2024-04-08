Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3CA224C9
	for <virtualization@lists.linux.dev>; Mon,  8 Apr 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558277; cv=none; b=hpEEKv1gSDnJl5vWsjYxA9FinnJtrhqP4HQY2SaK0l32DYJkR+zja8mSy6vlv7JvqWEvhMnAiskh4BkpnsLk+0LQo5/GmhwkwFvU3pto8biR7rGnRiQbtWM7+SxJQYiN+CKFHDopAhRMsyFt0+aSsxaIUqtVK66PA1ZBaLE7ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558277; c=relaxed/simple;
	bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBcYNEUsA/vzbVatinXbTa8PtPIyhDwt+RtJ2MWkTkjfDdOA4CZXP1V2xFl1spB443dcE6DkG0M9Eb0VOGUyu8qqvJsZBtRNYtxUTFiA5Qq0O6ZWYFEEJvsVTIHhiQGmOIXDKbN8z8h8+i9zsnsjPSWuWBkNR7ic5KcWWk+GU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnuJ+uVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnuJ+uVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712558274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
	b=dnuJ+uVzB2cJCX0Xko9nfDKzZLH3/0SbZ6G7/HFmrOaSeWsDiBarwczywM8QnwJZu62DFr
	B5/GkkGeCfwZ4bIRT490UKxcj6fQmcplA5pmuzCngJXfP5N3p4+nDSsMmFFM8COMTImwRG
	UDI7hEl5KvIHIDQmxsFjoSiEgbr9gVc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-U8QWmZzUNjqiqqnViXggIQ-1; Mon, 08 Apr 2024 02:37:53 -0400
X-MC-Unique: U8QWmZzUNjqiqqnViXggIQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cfda2f4716so2285366a12.3
        for <virtualization@lists.linux.dev>; Sun, 07 Apr 2024 23:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558272; x=1713163072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfJdkB5yl6go/ImD3Jt1aZ7iRc8UE3YZ3XaVQ0OB+L0=;
        b=a/iBqy2Nl5amHvV5UUwUrxNvS8EH8e4j8Cx2FOInoFkWfk6Q2f9U+f1ug/JhBSbkDY
         p1JHSAVdYAAxv3MS1YQcppJKOaCK4jEEwv78Z1/CDPrUnK/K6eZ+3G3CqIr+oecHFaom
         zogiZAZrqST8vl38Jb4N276Xo/tjREem1OP6ag4cm7PHRbw68CpQDVJr/nGVKUIjIlkn
         mwfGAUzLaPKdGa3r4RlGYfgQRz2Z6ePiIqbkAWP9MVLqyI+7P7mF1Jt1JwoyoCCwzTac
         7lOnFQk4syVWiD6X51bNr3uT0UMw2HH4Ek3TOIC1cKA5KvM9rSTq0qZ1FNSgnpWMH3su
         UqHA==
X-Forwarded-Encrypted: i=1; AJvYcCVtbka9RK73NUMJu5LlCSGfteAE0/O1rmYw1Tqt/oxArrOlK/C3tFF6/ptVBj2qoc0ewl4k5VWAgshnXaAWp8cTDbeLXQ7bT8SFbPYCoss=
X-Gm-Message-State: AOJu0YzqDJzJNKNPB+Ky3ObA8OSPoe65FA+coDi4INgQaBqNn8YdKATz
	tncBo3vEF8rYx2/Cnk3HSRi3LkW0JpCwgi7jw9eeKNcEpXv3iHyn2p4AGWAicfxXBL/nGgEWEzq
	vgmwr10CrfG65lQ19GnPu0u6grLTTnYDnJCb06WiHu+/8oNSu1RN2mg1hD0EDUcHTQU0sK9Hegn
	YrBNtjxttdp112rP1vkz6Ig4W1nUo/SugTEFH3D7k=
X-Received: by 2002:a05:6a20:c90c:b0:1a3:ae18:f1e4 with SMTP id gx12-20020a056a20c90c00b001a3ae18f1e4mr6736144pzb.34.1712558272043;
        Sun, 07 Apr 2024 23:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE++t+kDRwQTjzBUO1mfVfERd3l7rNbc0xIi9zTeBPMF1iq2N0XXvk4NSGNqvS3RADG9LQmO1bzc88Z/Zq0VA=
X-Received: by 2002:a05:6a20:c90c:b0:1a3:ae18:f1e4 with SMTP id
 gx12-20020a056a20c90c00b001a3ae18f1e4mr6736131pzb.34.1712558271762; Sun, 07
 Apr 2024 23:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
 <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
 <20240329051334-mutt-send-email-mst@kernel.org> <CACGkMEvdw4Yf2B1QGed0W7wLhOHU9+Vo_Z3h=4Yr9ReBfvuh=g@mail.gmail.com>
 <17068236.8b8.18ea1d8622f.Coremail.w_angrong@163.com>
In-Reply-To: <17068236.8b8.18ea1d8622f.Coremail.w_angrong@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:37:40 +0800
Message-ID: <CACGkMEtYPwhkDJFxiZZHUtVy3NTY_f3DWG7K_5ZJ7Yknu_y8cw@mail.gmail.com>
Subject: Re: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu
 for software-managed MSI
To: tab <w_angrong@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:47=E2=80=AFAM tab <w_angrong@163.com> wrote:
>
> > >
> > > On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > > > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > > > From: Rong Wang <w_angrong@163.com>
> > > > > > >
> > > > > > > Once enable iommu domain for one device, the MSI
> > > > > > > translation tables have to be there for software-managed MSI.
> > > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > > irq bypass function, can not get a correct memory write event
> > > > > > > from pcie, will not get irqs.
> > > > > > > The solution is to obtain the MSI phy base address from
> > > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > > then translation tables will be created while request irq.
> > > > > > >
> > > > > > > Change log
> > > > > > > ----------
> > > > > > >
> > > > > > > v1->v2:
> > > > > > > - add resv iotlb to avoid overlap mapping.
> > > > > > > v2->v3:
> > > > > > > - there is no need to export the iommu symbol anymore.
> > > > > > >
> > > > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > > > >
> > > > > > There's in interest to keep extending vhost iotlb -
> > > > > > we should just switch over to iommufd which supports
> > > > > > this already.
> > > > >
> > > > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > > > makes vDPA run without a backporting of full IOMMUFD in the produ=
ction
> > > > > environment. I think it's worth.
> > > > >
> > > > > If you worry about the extension, we can just use the vhost iotlb
> > > > > existing facility to do this.
> > > > >
> > > > > Thanks
> > > >
> > > > Btw, Wang Rong,
> > > >
> > > > It looks that Cindy does have the bandwidth in working for IOMMUFD =
support.
> > >
> > > I think you mean she does not.
> >
> > Yes, you are right.
> >
> > Thanks
>
> I need to discuss internally, and there may be someone else will do that.
>
> Thanks.

Ok, please let us know if you have a conclusion.

Thanks

>
> >
> > >
> > > > Do you have the will to do that?
> > > >
> > > > Thanks
> > >
>
>
>
>
> --
> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84=E7=BD=91=E6=98=93=E9=82=AE=E7=AE=B1=
=E5=B9=B3=E6=9D=BF=E9=80=82=E9=85=8D=E7=89=88
> <br/><br/><br/>
>
>
> ----- Original Message -----
> From: "Jason Wang" <jasowang@redhat.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: "Wang Rong" <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@=
lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Cin=
dy Lu" <lulu@redhat.com>
> Sent: Fri, 29 Mar 2024 18:39:54 +0800
> Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu f=
or software-managed MSI
>
> On Fri, Mar 29, 2024 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Mar 29, 2024 at 11:55:50AM +0800, Jason Wang wrote:
> > > On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > > > > From: Rong Wang <w_angrong@163.com>
> > > > > >
> > > > > > Once enable iommu domain for one device, the MSI
> > > > > > translation tables have to be there for software-managed MSI.
> > > > > > Otherwise, platform with software-managed MSI without an
> > > > > > irq bypass function, can not get a correct memory write event
> > > > > > from pcie, will not get irqs.
> > > > > > The solution is to obtain the MSI phy base address from
> > > > > > iommu reserved region, and set it to iommu MSI cookie,
> > > > > > then translation tables will be created while request irq.
> > > > > >
> > > > > > Change log
> > > > > > ----------
> > > > > >
> > > > > > v1->v2:
> > > > > > - add resv iotlb to avoid overlap mapping.
> > > > > > v2->v3:
> > > > > > - there is no need to export the iommu symbol anymore.
> > > > > >
> > > > > > Signed-off-by: Rong Wang <w_angrong@163.com>
> > > > >
> > > > > There's in interest to keep extending vhost iotlb -
> > > > > we should just switch over to iommufd which supports
> > > > > this already.
> > > >
> > > > IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> > > > makes vDPA run without a backporting of full IOMMUFD in the product=
ion
> > > > environment. I think it's worth.
> > > >
> > > > If you worry about the extension, we can just use the vhost iotlb
> > > > existing facility to do this.
> > > >
> > > > Thanks
> > >
> > > Btw, Wang Rong,
> > >
> > > It looks that Cindy does have the bandwidth in working for IOMMUFD su=
pport.
> >
> > I think you mean she does not.
>
> Yes, you are right.
>
> Thanks
>
> >
> > > Do you have the will to do that?
> > >
> > > Thanks
> >

