Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8C34D4C1
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111754; cv=none; b=tSn6jmloJivs+pykunvE82AjjepfM3sefqR1PJn/kGdg7eHL1fUYiw2l71VRomgMkEVQoJASnktjxrz4f1+yfQlMy2Dq3cNu72m0EAtDi2P55QTNVYtwMAZXAjKZL4GT570PQdkxxVTTrzIs5XjUjWeDAQ2sX0KpTNllsc/xeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111754; c=relaxed/simple;
	bh=PdattfQs0bc+9K4zC+nDenMqUSHLWzFcW0pjcZPzbzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6mhsnZo6wD9amn3EiPNJBYmmXM3/jHcVKxgjAlL+9YJULiUEz24GmZElJ686BSqz39sLQNtyXvcWmhNF16b54yHSolSJec6MuJi9T9pL50CcIuJAIkesFVZJpvUNBtH2mwkWK3zRM5OZ5SW3/ErvLbmKNGg3RaliOZoFMyZlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxSgCyvQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxSgCyvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773111752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoVNDPA6BFycLg5k01/4gXbU4sI809aWTOR3NBKz+mA=;
	b=cxSgCyvQ8Gk7+oh+rc8kC/kuv/afnqdn4EhA0XyMNB99giHgJcsHgglqqbfQtrqBuh8Wpl
	rf63es5AlSn+jL3bjNYUkG/UhJqL/cZoQcX83V8WNtx3U0PRAbthv21CXFtmd/CsiPMIVl
	FwJtfieQKv6+Tfy3UDUab0Kn0hyP834=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-9XAdZQpuMz6Fy300_bwQ0w-1; Mon, 09 Mar 2026 23:02:30 -0400
X-MC-Unique: 9XAdZQpuMz6Fy300_bwQ0w-1
X-Mimecast-MFC-AGG-ID: 9XAdZQpuMz6Fy300_bwQ0w_1773111750
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae3f446ccfso90549315ad.2
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 20:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111749; x=1773716549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoVNDPA6BFycLg5k01/4gXbU4sI809aWTOR3NBKz+mA=;
        b=ceF7pyBJodar07AirKeyWzID19n094RmPivhnzYldBTchDC8oZKlglBmahue7G/JuW
         gklGrnXBtOI3V2mCLkSwqW5yRo+GICA1kmM+mW3sxcGFjDo4tU6ETGHidgTV9wi88pWk
         iI7XGAa3QM2l+/++LzITgLrfwWP3qcEOXKdkT+EXxeX3DPRikr3p4+dQAN24B1JFLqmX
         VGd7pCG9hoksY25yq3z6v1ZqDrSV4LVInFfSwIgixypIVTUE7w8KhUrUEK+QpOzeXZzA
         G5R1HgjPP74jsKNGAQBb2KAhEXyaH+XygnTmC28sfU2t10HCiJcsrMgwx16FLa4+Mucr
         4k7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5k3gKoDlNH2s7vu4qabtOrjA42zi2++rOQeYCJ+dBek4nvUwtRqY0G7U6g1nsSaDFctradPjd2X7NdulS2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFfzFAPaHOFihfqd3CdLy0+eMUiH9I4yRszwJgh8d9zQr4zyMz
	p772w1y3lvVRgc+Gf6TtB8DVqeCarC1tyoeU/eJ/ylvbPDFiN5TMvRIE2Oa1StnYTs57Yq3r2ZZ
	mxNsITQICZrbE96KF08/444fGlvRZuopPoKYHUHZRwIVbPjC/l6Ip05TBqwVSvi7HSpAIAVNmXg
	SVcXmPh7eLAhs5dH0ZcIBXHGnwYKra/wjbO5OPmoGD8oI=
X-Gm-Gg: ATEYQzzVtPX6a2Eudw7hZdUAQSQ6SH7B6JA++9wuXgxyL44/o6MCfZAt4G4JxCUORPa
	cgsXep1D3jwvW7Gm73Qpd6C6uzicREhb3T1CCK1pX38qhxvZqMkzb0zmgD9k6fTNBa2d6o5Hk4d
	Oyg9ICm6b9baubiBBILnAYMyY1iM2A4kO2WfCnq8KsYUaO3FjxmL30CbgEsesCqvW1bJgOB5xHn
	9WoJQhY
X-Received: by 2002:a17:903:2449:b0:2ae:4996:c2a3 with SMTP id d9443c01a7336-2ae8243107bmr137303905ad.35.1773111749522;
        Mon, 09 Mar 2026 20:02:29 -0700 (PDT)
X-Received: by 2002:a17:903:2449:b0:2ae:4996:c2a3 with SMTP id
 d9443c01a7336-2ae8243107bmr137303635ad.35.1773111749042; Mon, 09 Mar 2026
 20:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309023353.652650-1-yui.washidu@gmail.com>
 <CACGkMEu+fd91yCwmSPNj0fTXw5v3ZON7F4kL_PVUz6TbG-iT4g@mail.gmail.com> <d6161d2e-066e-4d85-bc5a-0129a5f116b8@gmail.com>
In-Reply-To: <d6161d2e-066e-4d85-bc5a-0129a5f116b8@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:02:17 +0800
X-Gm-Features: AaiRm50Z0EihKo-1uARp_4ArYa2pHGzEJoqE9Bnmw3iYvz9Z0RsW0bgg7h12k4c
Message-ID: <CACGkMEvQfQn-BwUA2LcJ1mQuqyLpVNF8xyJ7VxsxnU-duNRA5Q@mail.gmail.com>
Subject: Re: [PATCH] virtio: add num_vf callback to virtio_bus
To: Yui Washizu <yui.washidu@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ctd-I-4m2ciLx2U8XL6KzTBOhu7tEE64NQGy-pXe9pE_1773111750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:19=E2=80=AFPM Yui Washizu <yui.washidu@gmail.com> =
wrote:
>
>
> On 3/9/2026 12:33 PM, Jason Wang wrote:
> > On Mon, Mar 9, 2026 at 10:37=E2=80=AFAM Yui Washizu <yui.washidu@gmail.=
com> wrote:
> >> Recent QEMU versions added support for virtio SR-IOV emulation,
> >> allowing virtio devices to expose SR-IOV VFs to the guest.
> >> However, virtio_bus does not implement the num_vf callback of bus_type=
,
> >> causing dev_num_vf() to return 0 for virtio devices even when
> >> SR-IOV VFs are active.
> >>
> >> net/core/rtnetlink.c calls dev_num_vf(dev->dev.parent) to populate
> >> IFLA_NUM_VF and IFLA_VFINFO_LIST
> > Patch looks good but,
> >
> > If I understand correctly, ndo_get_vf_config is needed for
> > IFLA_VFINFO_LIST but not implemeted in this patch?
>
> Thank you for your comment.
>
> I submitted this patch because I confirmed
> that "ip link show" returns the correct VF IDs with this implementation.
>
> In the current implementation,
> I believe there is no information that would need to be referenced
> through IFLA_VFINFO_LIST.
> Therefore, I did not include ndo_get_vf_config in this patch,
> as it did not seem essential at this stage.
>
> Would it be better to implement IFLA_VFINFO_LIST support together with th=
is?

Then it's not, I think it's better to not mention IFLA_VFINFO_LIST in
the commit log as it may confuse people.

Thanks

>
> Regards,
>
>
> >> in RTM_GETLINK responses.  For a
> >> virtio-net device, dev.parent points to the virtio_device, whose bus
> >> is virtio_bus.  Without num_vf, SR-IOV VF information is silently
> >> omitted from tools that rely on rtnetlink, such as 'ip link show'.
> >>
> >> Add a num_vf callback that delegates to dev_num_vf(dev->parent),
> >> which in turn reaches the underlying transport (pci_bus_type for
> >> virtio-pci) where the actual VF count is tracked.  Non-PCI transports
> >> are unaffected as dev_num_vf() returns 0 when no num_vf callback is
> >> present.
> >>
> >> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
> >> ---
> >>   drivers/virtio/virtio.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> >> index 5bdc6b82b30b..299fa83be1d5 100644
> >> --- a/drivers/virtio/virtio.c
> >> +++ b/drivers/virtio/virtio.c
> >> @@ -435,6 +435,14 @@ static void virtio_dev_shutdown(struct device *_d=
)
> >>          dev->config->reset(dev);
> >>   }
> >>
> >> +static int virtio_dev_num_vf(struct device *dev)
> >> +{
> >> +       struct virtio_device *vdev =3D dev_to_virtio(dev);
> >> +
> >> +       return dev_num_vf(vdev->dev.parent);
> >> +}
> >> +
> >> +
> >>   static const struct bus_type virtio_bus =3D {
> >>          .name  =3D "virtio",
> >>          .match =3D virtio_dev_match,
> >> @@ -444,6 +452,7 @@ static const struct bus_type virtio_bus =3D {
> >>          .remove =3D virtio_dev_remove,
> >>          .irq_get_affinity =3D virtio_irq_get_affinity,
> >>          .shutdown =3D virtio_dev_shutdown,
> >> +       .num_vf =3D virtio_dev_num_vf,
> >>   };
> >>
> >>   int __register_virtio_driver(struct virtio_driver *driver, struct mo=
dule *owner)
> >> --
> >> 2.47.3
> >>
> > Thanks
> >
>

