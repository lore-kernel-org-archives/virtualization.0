Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697438DF9
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174159; cv=none; b=TCdLNmZN3tj4TuNbwYxk4XIFNg9I0sCCXIwt7wNFJRJd9SN1y4gsFaxumoqZ4wBK2VlAVrgjZBHZd80nuelzA15WiTYziT06P1afpTSFC9M5W3wsKPBUeH/NA9TDYyUAOlFieyTzI/F8RaDTt11mzOqlTFHEgfLKQqIQTKIg/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174159; c=relaxed/simple;
	bh=Q0+PIJ88a4iRAsJs1W5fwyu0AoevhoEEr/zt+lUAKjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BavvSaFIJOoYKWEfjmIhomoMe6l7Lmw81wzFJDL/lGIdgH+JVh4/D2hS2snZHn2baIy53zmTlPQV7ecYZDCxfLGfoQh+XdXmPTWM5ceeA4rGxmBov9ffp3V1i2Txu90GZFx8hr2o2qwfwLbG+jECJVSiWCcBj5peoRI1yfo+TeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSx4eidn; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSx4eidn"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD97D81FE3
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hb93knpolsZv for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 01:15:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E33F982011
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E33F982011
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aSx4eidn
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E33F982011
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqiRITvym1c0onqrnYAcV6zc/1khgZbdXRXq4ArYjQA=;
	b=aSx4eidnJm0TX99TX2t55AeBona4fd3S8VQ+cMiSgBQGx0pV8gcQGytxpSJQH3NiHFTxDT
	ooq66XCDORA9wl/JHvuNvDhcL8JPI+EB8nzYFGHk1vrPbRehAXWWtDyuC9Z+s9euc6elCT
	Dd5CGq072bmfJ4SMqq8GY2i6RImxP0Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-v6YgIw5qOZ2E0rzyPbp0cQ-1; Sun, 16 Mar 2025 21:15:54 -0400
X-MC-Unique: v6YgIw5qOZ2E0rzyPbp0cQ-1
X-Mimecast-MFC-AGG-ID: v6YgIw5qOZ2E0rzyPbp0cQ_1742174153
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2174968a91.0
        for <virtualization@lists.linux-foundation.org>; Sun, 16 Mar 2025 18:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174153; x=1742778953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqiRITvym1c0onqrnYAcV6zc/1khgZbdXRXq4ArYjQA=;
        b=bP12a2q55y42Mr5pU3wZWNgp23A7dJtY9dPOgFxKnkdUPGXmdbOrk6tOxOEBMlD/1l
         xa0CWdMGG2uONn5sn215ffy4rrLdRXZXLqLSV6G+SuLBwGb6c8Y5ggWmTS7YeZuGbiCB
         033uYsTlYhisNVGfGvuakmiEpcM0hIf89x8ZX18jfWBINBBudwTHZJ/7tM3Y1qxJyYCG
         8K7Y0w9d33BuIJPjH3muOV2ryEjwf97DasKWmxJ47U665B9dbS+IHpP+GYjsTYy/vYB2
         YB7GDCxgo0cywywEMHLRVcFWPycdSM2X5H+xWJV+0MTBh9EGnBZvMIxn4+WIdb5tGCjE
         aLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS+NOQd6LPFFvi1q6MYCvlNQezMP+SnbfH7Y+HLo4iMATK2JCXeURZt5u+OTmzwWxibhOjyx32zorXSE/VSA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZn09y1c2QgAeftIjOM3cYvTYEHLZoVMeHyc6cy3fnnIEm8uBU
	cDOhZWe/CWyuxlF3Ew0btXcmCk7SGNpAngjIio5he2B3hhcP5fXXTZwWUJ/FafDm2X6sm+saE6n
	UVWsNxBIsRDliovbqWea/bsNqiNee6LEMysPEPZipz+uIrkgjxWBp7ZxxR6q3qx9DXfegcGENvq
	8EdP0sKNxbN9io4MPyLpXybzHk3hFgqGIAC7VasYqeNXhBSF1KplySdw==
X-Gm-Gg: ASbGnct2rjg4jetORwoalkV40zxiOjUD6H0qttXTdetoSOQEVFpZJQXQAffshYNYfEA
	b6ZmwX7dwfdZqmN3ZInBDL2Q6B9Yq7XOjQh7piZoYvxgsNhJ1X1zs5mWVZipS1l3Ct9O2b8qd2Q
	==
X-Received: by 2002:a17:90a:d610:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-30151d80d72mr13059899a91.29.1742174152922;
        Sun, 16 Mar 2025 18:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpVZEUCtxPZyh7hATJuGyGFLhT6k6detJv2gwkDBKiP/VApC5tJcX/mSZDxnZ+e+OpQEJWcYXL+Lqzu0fpMQ=
X-Received: by 2002:a17:90a:d610:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-30151d80d72mr13059874a91.29.1742174152536; Sun, 16 Mar 2025
 18:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com> <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
 <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com> <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
 <77c21953-b850-4962-8673-6effb593d819@daynix.com>
In-Reply-To: <77c21953-b850-4962-8673-6effb593d819@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:15:40 +0800
X-Gm-Features: AQ5f1JpR0mxXkmVnrSX1gXa2p5ktJxpo4uYjioUOGsjKMLFJ1-a0iSEE4BZ4sls
Message-ID: <CACGkMEtMghoZbMO8c+30vqtOr3daEYrU2gG-QAZjOJev8NnBhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QRUsQ8CnOU5RqPOYNt3KQotBxFsX8H6ov7JlwggEeeo_1742174153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/12 12:36, Jason Wang wrote:
> > On Tue, Mar 11, 2025 at 2:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/11 9:42, Jason Wang wrote:
> >>> On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/03/10 13:43, Jason Wang wrote:
> >>>>> On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated o=
n the
> >>>>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report =
no
> >>>>>> hash values (i.e., the hash_report member is always set to
> >>>>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by th=
e
> >>>>>> underlying socket will be reported.
> >>>>>>
> >>>>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------=
------------
> >>>>>>     1 file changed, 29 insertions(+), 20 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42=
c302f3586ea6bb5e0d4289 100644
> >>>>>> --- a/drivers/vhost/net.c
> >>>>>> +++ b/drivers/vhost/net.c
> >>>>>> @@ -73,6 +73,7 @@ enum {
> >>>>>>            VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>>>>>                             (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>>>>>                             (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >>>>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>>>>>                             (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>>>>>                             (1ULL << VIRTIO_F_RING_RESET)
> >>>>>>     };
> >>>>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net=
)
> >>>>>>                    .msg_controllen =3D 0,
> >>>>>>                    .msg_flags =3D MSG_DONTWAIT,
> >>>>>>            };
> >>>>>> -       struct virtio_net_hdr hdr =3D {
> >>>>>> -               .flags =3D 0,
> >>>>>> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>>>> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >>>>>> +               .hdr =3D {
> >>>>>> +                       .flags =3D 0,
> >>>>>> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>>>> +               }
> >>>>>>            };
> >>>>>>            size_t total_len =3D 0;
> >>>>>>            int err, mergeable;
> >>>>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>>>>>            bool set_num_buffers;
> >>>>>>            struct socket *sock;
> >>>>>>            struct iov_iter fixup;
> >>>>>> -       __virtio16 num_buffers;
> >>>>>>            int recv_pkts =3D 0;
> >>>>>>
> >>>>>>            mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >>>>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *ne=
t)
> >>>>>>                            vhost_discard_vq_desc(vq, headcount);
> >>>>>>                            continue;
> >>>>>>                    }
> >>>>>> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcou=
nt);
> >>>>>>                    /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_=
NET_HDR */
> >>>>>>                    if (unlikely(vhost_hlen)) {
> >>>>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >>>>>> -                                        &fixup) !=3D sizeof(hdr))=
 {
> >>>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>>>> +                                        &fixup) !=3D vhost_hlen) =
{
> >>>>>>                                    vq_err(vq, "Unable to write vne=
t_hdr "
> >>>>>>                                           "at addr %p\n", vq->iov-=
>iov_base);
> >>>>>>                                    goto out;
> >>>>>
> >>>>> Is this an "issue" specific to RSS/HASH? If it's not, we need a sep=
arate patch.
> >>>>>
> >>>>> Honestly, I'm not sure if it's too late to fix this.
> >>>>
> >>>> There is nothing wrong with the current implementation.
> >>>
> >>> Note that I meant the vhost_hlen part, and the current code is tricky=
.
> >>>
> >>> The comment said:
> >>>
> >>> """
> >>> /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> >>> """
> >>>
> >>> So it tries to only offer virtio_net_hdr even if vhost_hlen is the se=
t
> >>> to mrg_rxbuf len.
> >>>
> >>> And this patch changes this behaviour.
> >>
> >> mrg_rxbuf only adds the num_buffers field, which is always set for
> >> mrg_rxbuf.
> >>
> >> The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but th=
is
> >> was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers f=
or
> >> virtio 1.0")
> >>
> >> So there is no behavioral change for existing features with this patch=
.
> >
> > I meant this part.
> >
> >>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>>> +                                        &fixup) !=3D vhost_hlen) {
> >
> > We should copy only sizeof(hdr) instead of vhost_hlen.> > Anything I mi=
ss?
>
> sizeof(hdr) will be greater than vhost_hlen when neither
> VIRTIO_NET_F_MRG_RXBUF or VIRTIO_F_VERSION_1 is negotiated.

Just to make sure we are on the same page I meant we should only
advance sizeof(struct virtio_net_hdr) here to make sure we can set the
num_buffers correctly.

But this is not what the code did here.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>>> The current
> >>>> implementation fills the header with zero except num_buffers, which =
it
> >>>> fills some real value. This functionality is working fine with
> >>>> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the head=
er size.
> >>>>
> >>>> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> >>>> field, which also needs to be initialized with zero, so I'm making s=
ure
> >>>> vhost_net will also initialize it.
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>>
> >>>>> Others look fine.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>
> >>
> >
>

