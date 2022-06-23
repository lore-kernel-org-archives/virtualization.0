Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54934C433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 08:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE3A540123;
	Thu, 23 Jun 2022 08:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE3A540123
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFj8nsoy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFY6Ugqvt-YM; Thu, 23 Jun 2022 08:58:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33C5D405A9;
	Thu, 23 Jun 2022 08:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33C5D405A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD35C0032;
	Thu, 23 Jun 2022 08:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 311A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03B6C60E86
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03B6C60E86
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PFj8nsoy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBXqWUMOQ0CT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:58:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99EB760B54
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99EB760B54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655974716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QA4QBFkDM19s/kmNbbq6WAZHuSSj0hjTnufoIU8Ro9o=;
 b=PFj8nsoygWTg1I9lkxPLpzZMRczDLd5VAgMHyPm2XaonF2hOft7ui29OaVieedGV1eaPSk
 nNgVAfYYtlRiPqsxzexezqZZns1zWYr8u0jO4Z4b4NlQzbbCL+FPx3Ut26NXUJvi2LVarc
 k3d4vIBKnekE2UHZQT4BFnssmAtw3mc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-TAxjICeYOfmcqc6lg2XXqA-1; Thu, 23 Jun 2022 04:58:35 -0400
X-MC-Unique: TAxjICeYOfmcqc6lg2XXqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 c187-20020a1c35c4000000b003970013833aso6690379wma.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 01:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QA4QBFkDM19s/kmNbbq6WAZHuSSj0hjTnufoIU8Ro9o=;
 b=PWzT/CCxtSZ5Cg01t2hfbzu9fKGjsePsm42TiCFunqkcb29ydNeXKdMMcMtvDawt2I
 MCGsIeYK1TRh5TwcTxKp9PCdmGlJneUwhIuC8mh4exO3wsUWt4zoWDAa24zUYdN1/2Em
 BebkyX3Lt+WcHgrTAI5xS0SYbtuNxJTwoyUJqnPCAOB4fJeVftoxxt03xXMqXNbRdvvz
 wpzW6nbxIAVfi2LJZj7sINr0lPLnek9t7/SdbnBLOwcfb9xrCRXF4hr3xj75dzuDUc5K
 ZEEqBWJfgy5AKNSB/PLuNDw26/6nwGelxCnmBq/8yoC7DHDLVu0GAeO/jXnHZfcvC94F
 fBCA==
X-Gm-Message-State: AJIora9Yr9l9Fe8zU+JSI9YVB5iV6NSzV9IDNS8yCAIA4D185vEbPA0Q
 zICyphPG1RqAiwjN6TME9Zher79cZDG1cCA8NyJNGS74/8A5BKGNmimAK3NeF1Mzn9o8QZdo6aX
 gFPW/eaFzllnJ121Io2SvAW7/fEg+ezIghb8G4KvGWQ==
X-Received: by 2002:a05:600c:1553:b0:39c:87fc:5784 with SMTP id
 f19-20020a05600c155300b0039c87fc5784mr2834936wmg.90.1655974713530; 
 Thu, 23 Jun 2022 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uKzKYT9XjrtQPHP5sn9zFHwuvBaPFsVvMSjtZr6AU7TKAY9p+ZWuznb3fG50371xljWLlAVQ==
X-Received: by 2002:a05:600c:1553:b0:39c:87fc:5784 with SMTP id
 f19-20020a05600c155300b0039c87fc5784mr2834921wmg.90.1655974713318; 
 Thu, 23 Jun 2022 01:58:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 b1-20020adfe301000000b00219b391c2d2sm26623088wrj.36.2022.06.23.01.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 01:58:32 -0700 (PDT)
Date: Thu, 23 Jun 2022 10:58:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled
 per batch
Message-ID: <20220623085830.voi6gixpikz64nm2@sgarzare-redhat>
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Jun 23, 2022 at 11:50:22AM +0800, Jason Wang wrote:
>On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> =
wrote:
>>
>> Limit the number of requests (4 per queue as for vdpa_sim_net) handled
>> in a batch to prevent the worker from using the CPU for too long.
>>
>> Suggested-by: Eugenio P=E9rez <eperezma@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_si=
m/vdpa_sim_blk.c
>> index a83a5c76f620..ac86478845b6 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *v=
dpasim,
>>  static void vdpasim_blk_work(struct work_struct *work)
>>  {
>>         struct vdpasim *vdpasim =3D container_of(work, struct vdpasim, w=
ork);
>> +       bool reschedule =3D false;
>>         int i;
>>
>>         spin_lock(&vdpasim->lock);
>> @@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struct *w=
ork)
>>
>>         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>>                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
>> +               bool vq_work =3D true;
>> +               int reqs =3D 0;
>>
>>                 if (!vq->ready)
>>                         continue;
>>
>> -               while (vdpasim_blk_handle_req(vdpasim, vq)) {
>> +               while (vq_work) {
>> +                       vq_work =3D vdpasim_blk_handle_req(vdpasim, vq);
>> +
>
>Is it better to check and exit the loop early here?

Maybe, but I'm not sure.

In vdpa_sim_net we call vringh_complete_iotlb() and send notification =

also in the error path, so I thought was better to send notification =

also when vdpasim_blk_handle_req() return false, since we will update =

the used.idx.

However, I don't think it's a common path, so if you think it's better =

to exit the loop early, I can do it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
