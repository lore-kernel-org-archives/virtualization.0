Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F17C001E0
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 08:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAACD41EAC;
	Thu, 27 Jul 2023 08:55:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAACD41EAC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H955EESa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pFmvd2TLbnQ5; Thu, 27 Jul 2023 08:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1EF241DFA;
	Thu, 27 Jul 2023 08:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1EF241DFA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B371C0071;
	Thu, 27 Jul 2023 08:55:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F40A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B869141E69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B869141E69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBit3aIsEACU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:54:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C4DB41DFA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:54:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C4DB41DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690448098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/5paF6Ykf/HR83J793r3ewLreNBy44O4jgk14P4ZU8=;
 b=H955EESaArrm4U0/PbLujsB1wQdnG+cdqIyGTPt0R/JpkbhRqIqhyAXP/9nDbVfYtTXauQ
 /h5nX9Sr3P0cPJE21SP7HzVBNHsLjlroSz5dBmYgA1uNQelOTwTrGacVV7/9786tDOnM+w
 EEsb2l2Y3G67HG5Rc+wEgqdMTSC8RXo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421--Dgyvm_LND6a4z3LRKWTFg-1; Thu, 27 Jul 2023 04:54:57 -0400
X-MC-Unique: -Dgyvm_LND6a4z3LRKWTFg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355cf318so40275866b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 01:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690448096; x=1691052896;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T/5paF6Ykf/HR83J793r3ewLreNBy44O4jgk14P4ZU8=;
 b=fs+bDmyELtNTeYqoV6aaDoUeMzBLyYha/LFIpeFXzzGASjNwyZGsMpItKuVai+IE4n
 PBnUavm0FjFRO08GAoQNIQr2FFkk1O7voQec3d6JK5CU7/hWXfXQ4p42tM6Iqgqyg7De
 BuxOBksHiQf5mo6trOSAAWKattngS1t6tqMt2+SnDnYqOZ6/HSTb8j/2mab/ZlXJmCGX
 M5HWYMWOsel3nHTTeouRTGISFVs8xWVylQydoE1yYFVOCq4q+J/JouT9V6OtR/uSZBzr
 thotYT2ioHQCxIWr86oaPcReAPBUrLUeJMlQErUqdJ2i/Nr7FU16AGCHtenwLbKFEAIL
 HYLQ==
X-Gm-Message-State: ABy/qLZc6mHOrmiBJCnQO5qXtB+JJkTBB7LtA3WlWWLPetllTByIVBx1
 4gGzx7u8Zixtp3HxqG5blbMy7LMjBK5qblT6jYwpAUpQ7+S43ZSdb6PSpKi+4k3lYAZf70lI2qo
 AlrVxh3RHO2QfpA+4NqQSO1NQn3A7+VnCrm3gw76cwA==
X-Received: by 2002:a17:906:4e:b0:994:54ff:10f6 with SMTP id
 14-20020a170906004e00b0099454ff10f6mr1252757ejg.30.1690448095934; 
 Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcD3CURJMdg3NYZ8AZsEK4plNky1gLjXd8Cwvx/xUzv38SfV6WriScq+IHFtwAhFGzRaQCvg==
X-Received: by 2002:a17:906:4e:b0:994:54ff:10f6 with SMTP id
 14-20020a170906004e00b0099454ff10f6mr1252744ejg.30.1690448095632; 
 Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.102])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170906960f00b00988dbbd1f7esm500842ejx.213.2023.07.27.01.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
Date: Thu, 27 Jul 2023 10:54:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <p4v23nvilf45gl3snuyvypnhi3zfrmbi7qxtrdalluflt773sf@yt6tkgxiliar>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
 <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
 <f020405e-86af-1b66-c5f4-9bec98298f44@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f020405e-86af-1b66-c5f4-9bec98298f44@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jul 27, 2023 at 11:32:00AM +0300, Arseniy Krasnov wrote:
>On 25.07.2023 15:28, Stefano Garzarella wrote:
>> On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
>>> On 25.07.2023 11:46, Arseniy Krasnov wrote:
>>>> On 25.07.2023 11:43, Stefano Garzarella wrote:
>>>>> On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:

[...]

>>>>>>> +=A0=A0=A0 t =3D vsock_core_get_transport(info->vsk);
>>>>>>>
>>>>>>> -=A0=A0=A0=A0=A0=A0=A0 if (msg_data_left(info->msg) =3D=3D 0 &&
>>>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->type =3D=3D VIRTIO_VSOCK_T=
YPE_SEQPACKET) {
>>>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to_le32(VIRT=
IO_VSOCK_SEQ_EOM);
>>>>>>> +=A0=A0=A0 if (t->msgzerocopy_check_iov &&
>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 !t->msgzerocopy_check_iov(iov_iter))
>>>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>>
>>>>> I'd avoid adding a new transport callback used only internally in vir=
tio
>>>>> transports.
>>>>
>>>> Ok, I see.
>>>>
>>>>>
>>>>> Usually the transport callbacks are used in af_vsock.c, if we need a
>>>>> callback just for virtio transports, maybe better to add it in struct
>>>>> virtio_vsock_pkt_info or struct virtio_vsock_sock.
>>>
>>> Hm, may be I just need to move this callback from 'struct vsock_transpo=
rt' to parent 'struct virtio_transport',
>>> after 'send_pkt' callback. In this case:
>>> 1) AF_VSOCK part is not touched.
>>> 2) This callback stays in 'virtio_transport.c' and is set also in this =
file.
>>> =A0 vhost and loopback are unchanged - only 'send_pkt' still enabled in=
 both
>>> =A0 files for these two transports.
>>
>> Yep, this could also work!
>>
>> Stefano
>
>Great! I'll send this implementation when this patchset for MSG_PEEK will =
be merged
>to net-next as both conflicts with each other.
>
>https://lore.kernel.org/netdev/20230726060150-mutt-send-email-mst@kernel.o=
rg/T/#m56f3b850361a412735616145162d2d9df25f6350

Ack!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
