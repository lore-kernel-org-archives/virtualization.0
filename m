Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C3C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 08:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C75760681;
	Tue, 20 Dec 2022 08:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C75760681
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYaXF/Zn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogmw_dahSMdo; Tue, 20 Dec 2022 08:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9671606DC;
	Tue, 20 Dec 2022 08:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9671606DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 546E8C0035;
	Tue, 20 Dec 2022 08:54:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C554C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED7C680EE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:54:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED7C680EE0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYaXF/Zn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3LJdoVL-SMIO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:54:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4315080D2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4315080D2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671526466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5UexBayMe6AI+Hs5yA1OlvLAoluoNMOSv7goOJy2Ko8=;
 b=HYaXF/ZnJ33mGz30qLzfIQUc0FzZtnXY6is5gg2/4cnwhK45zgmcY6qj+vpfYA+GG+0iK6
 JAB8+ZyVmb0VCxGRCqNscUp5R2cEAdy1vYCS8VzA7fB1Mod8kH4Bkcc6SfgVTq3DdeMoTe
 HvlFXtitJtQHVe6XbQhL4tzuQuQFzm0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-yzhC55FbNjuawFbUTCKfnw-1; Tue, 20 Dec 2022 03:54:25 -0500
X-MC-Unique: yzhC55FbNjuawFbUTCKfnw-1
Received: by mail-oo1-f72.google.com with SMTP id
 g1-20020a4a9241000000b0049fd16671b4so5371917ooh.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 00:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5UexBayMe6AI+Hs5yA1OlvLAoluoNMOSv7goOJy2Ko8=;
 b=bgVbCcmeJRJvIQXdxvczD7A3JOmIBibETr52ckgyGLKtti/Eu5K/M19Jh9WnEkJEdg
 9XmJQbcty71p4Alv0R4WhkcglydMMLWjzI1tLdkVVwimgQ/G7L2O4e5AAwO/owUyOkaL
 bmyGhL7RahAMY7IQqynxoKj8NCdVCe/V2fYOLl0tnXKT6vgFHCydt7oUzPuCGaSMCUPv
 3+qHFON98WC9mwqFMcqJcDebMXCzPdk0CVj9WWEh8VhtQGs1bl7w3gMvy815rHc0ui8v
 JAzsbXcaJ8zF9Vp3n9BrpnNvKKzEMewkGNNrvEwODo7zKO95oajG88dkbJQ4qf4xoCBn
 6sBw==
X-Gm-Message-State: ANoB5pnQj/Lx8zovV0v3Tq8UUoXd75t+IcmuGe6awz1JaMUdwKR6/o/z
 ZOfE+FMbIYSizTBmFedtsP0ZrGFhGBXOT4w9HZVQ6QTjWnk0Lh4MJTNQjGs9s+MtAOX2G1OZbJ/
 AH3fHGdd5fTWDJ42PZlnrtzYHi1+FJZ1ZyFuQrCR8n6RiykS6Xf8pP/WkyQ==
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr33112261ooo.93.1671526464594; 
 Tue, 20 Dec 2022 00:54:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7BR3395fR8pIO336Y3NbjHh2AmeHBRaBq20l/roQen6xvxw83TnPt4KOTRhVYaIFG94QZCn2UmhXn1jLKb18g=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr33112254ooo.93.1671526464291; Tue, 20
 Dec 2022 00:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
 <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
In-Reply-To: <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 16:54:13 +0800
Message-ID: <CACGkMEsUvukNxAmMF5zodKj+fo8XbVtB4N=0PZfjrbx0s_Acgg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 20, 2022 at 3:26 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Hi Jason,
>
> > So I think we actually don't need to depend on HWMON here?
> >
> > hwmon.c is only complied when HWMON is enabled and we use IS_ENABLED to
> > exclude the hwmon specific does.
>
> We are not really depending on HWMON with "(HWMON || HWMON=n)"
> If HWMON=n, the driver can be compiled either as a module or built-in.
> If HWMON=y, the driver can be compiled either as a module or built-in.
> If HWMON=m, the driver will be forced to be compiled as a module.
>
> This technique allows us to use IS_ENABLED instead of IS_REACHABLE

Ok, right.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
