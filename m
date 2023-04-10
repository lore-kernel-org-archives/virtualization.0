Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11DFC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 07:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34F3E81F31;
	Mon, 10 Apr 2023 07:26:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34F3E81F31
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvUm3J8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Era_Cs8SepcD; Mon, 10 Apr 2023 07:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D499F8196A;
	Mon, 10 Apr 2023 07:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D499F8196A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0E5BC0037;
	Mon, 10 Apr 2023 07:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47FCEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15E6440129
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15E6440129
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvUm3J8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U_9u77D4MpSn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D96B840017
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D96B840017
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681111587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrvVxo21idMV1/dSs6Nrb77Sy2dOvVe9CN/0Xcvw6B8=;
 b=CvUm3J8AAOIlAF4b0wCYifqZEvknJyb782RF7HQJ99Gc6nyKMjmtPK4/jcovv8TlfUGrnE
 7gspJx4RhFxaB6ngyQfIKgpYTbPZ6uE1VkDIlVKn/EocEe2SHTAHcsvQ4Fh36ra5Kg8TYL
 pdliFrAHrL2cKfzvJhF2T9V4RRX46MY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-K0zhIg4UNyek4egbEgOtdQ-1; Mon, 10 Apr 2023 03:26:25 -0400
X-MC-Unique: K0zhIg4UNyek4egbEgOtdQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 h8-20020a170902f54800b001a1f5f00f3fso3018334plf.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 00:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681111585; x=1683703585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CrvVxo21idMV1/dSs6Nrb77Sy2dOvVe9CN/0Xcvw6B8=;
 b=dWCi5iHVgbseQKKKgynStKwIzDwa4hIPe0erOhiYTJE9cB8luc4DlqioOzE/nNa7tl
 HGWChlwcnOMx5zR9Cr0m4kaQgQtsy3oz5zr1iTfx39hejzLIEXtMe5SHWSoaycNvalcZ
 fmPt1cbxT4Eic3TTxgBv5SqUV2BiDPoXAiz8ScpkcBUwrMDziELEob2IyhBDIJ+nASx/
 43v2S/e0acvNv2D4ObODBGT6dHrmgj0kx5gicBI43Dlp5JxfeZ8+3xymy4Si7uBf1luL
 gs8GFY3GFvaYUNCvB8Wg7FzADqiXJMyoD7/N9QJS+2JGSgqzCapPmTflmJ7DWiSqP0wb
 TyXQ==
X-Gm-Message-State: AAQBX9fVmMCW5Zk7UiH77QvtpG9zRee9ArytF17E772ACQsp0aojTzPc
 vnSmV+VSvNT/3SENRgkEy8VkyKxoHjbkHWBVO45iGn3643mDWeo4K3nAU8t2nsT2pvn/T8K8SRX
 hGyjQ5Ql7HzVdRIYJtn0UWTChPFfyhhcmmb3sjZuPsw==
X-Received: by 2002:a17:902:dad0:b0:1a1:da3c:605f with SMTP id
 q16-20020a170902dad000b001a1da3c605fmr14217248plx.58.1681111584935; 
 Mon, 10 Apr 2023 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOoX5xtJIFPcbkKHMgMD2HmccXWFDYMY3gwwawovq9SgEj4EAOiRXqka7TDKcgVADcinuyfg==
X-Received: by 2002:a17:902:dad0:b0:1a1:da3c:605f with SMTP id
 q16-20020a170902dad000b001a1da3c605fmr14217231plx.58.1681111584602; 
 Mon, 10 Apr 2023 00:26:24 -0700 (PDT)
Received: from [10.72.12.209] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1709026b8600b001a04ff0e2eesm7008724plk.58.2023.04.10.00.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 00:26:24 -0700 (PDT)
Message-ID: <b2ba29e1-e2cd-45c9-c6c5-85e7ef739dd3@redhat.com>
Date: Mon, 10 Apr 2023 15:26:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
 <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEsFVidKuqmKghZyQv=YnmcfaUt=ZFwv3Wf=MXs0ypCggA@mail.gmail.com>
 <AM0PR04MB4723CD9EAC42CC7CA2381EBDD4959@AM0PR04MB4723.eurprd04.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <AM0PR04MB4723CD9EAC42CC7CA2381EBDD4959@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzQvMTAgMTU6MDksIEFsdmFybyBLYXJzeiDlhpnpgZM6Cj4+PiBJbiB0aGlzIGNh
c2UsIEkgY2FuIGp1c3QgcmVtb3ZlIHRoZSB3bWIgYW5kIHRoYXQncyBpdCwgcmlnaHQ/Cj4+IEJ1
dCB3aG8gb3IgaG93IHRvIHByZXZlbnQgdGhlIHByZWVtcHRpb24/Cj4gV2UgdXNlIGEgbXV0ZXgg
dG8gcHJvdGVjdCB0aGUgY29udHJvbCBtZWNoYW5pc20gKHNuZXQtPmN0cmxfbG9jaykuCgoKSSBt
ZWFudCBtdXRleCBkb2Vzbid0IHByZXZlbnQgdGhlIHByZWVtcHRpb24gc28gdGhlIHByb2Nlc3Mg
Y291bGQgYmUgCm1pZ3JhdGVkIHRvIGFub3RoZXIgY3B1LgoKVGhhbmtzCgoKPgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
