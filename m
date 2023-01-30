Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A026FC54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 11:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C06B60F5F;
	Mon, 30 Jan 2023 11:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C06B60F5F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ANyYIdYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFcbRMKtrckd; Mon, 30 Jan 2023 11:34:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 828A560F3B;
	Mon, 30 Jan 2023 11:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 828A560F3B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B27AC0032;
	Mon, 30 Jan 2023 11:34:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C8DC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D97C941773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D97C941773
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ANyYIdYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zfjIM3BwTBZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:34:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83C9941772
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83C9941772
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675078467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UB2J8b8gk/JJZNMtbHw0Pqs/v7cNqjzJxZcA9pRmkMs=;
 b=ANyYIdYkVkx7NNLkKEQeOFjBb4nCTwVoRmwamXFYZevwEGxXI1GSsoY3VGp2XHzuRPMgOV
 zFytZVlPbkRARE1x98YfgS1X04PdtUPj59uu9El9DQ7F6E63tJsgAoX1O69iM5ALnHaWv5
 zN8ZXSaUYC1QHQM3vTctp4g/Iufnwoo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-Q73ivNOEPuaglwd23RngWg-1; Mon, 30 Jan 2023 06:34:25 -0500
X-MC-Unique: Q73ivNOEPuaglwd23RngWg-1
Received: by mail-ed1-f69.google.com with SMTP id
 l17-20020a056402255100b00472d2ff0e59so8021101edb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 03:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UB2J8b8gk/JJZNMtbHw0Pqs/v7cNqjzJxZcA9pRmkMs=;
 b=5SG6RoE82GwTVuYxXro1dVf73fto3VaJ4nI4TehHqPdpKvmKwmgsOntYypfU1O1bY/
 s7pXe9dqer6FEHrMIUlYHvukd7D6QM/lRioQ2g0jfxX/qyb2bhod/LqDfkqLfz/iHlXC
 2aGk/J42hXOqIKKOO3+RSXC32w4WUJDD6ivYuvFj4MtRS4HNXmi0MH4SDBw9YVApXeyM
 EclX5idL6MQCGOm6/wRn1VOlQFe4OtCFErBfDrGP4McLNr8y5FteLY27lFpw/nWjn+ZZ
 K47B+B57xeUX1obRQ8m+afbx01vzrDSJoqBh1MBnj++LhHDPaPCNd92RkWCpgHEGXhs4
 fHTQ==
X-Gm-Message-State: AO0yUKVrHVPkcQ+9EDJ8XhzpffdxJiRXNYn/B6sC6gtfYM2pV5s8gnvg
 CvSnU794xkekmjyxubQ8XtrtCPeb7hFBZ0RjOCEQmbforQHyi+hsrlOzJhXMJWMUW4AiBhVVExJ
 19z0dqYQia+Ih9b7y/MOIs472Sz+h6wE01Q6yMOvSUg==
X-Received: by 2002:a17:906:cf8e:b0:88b:1d46:4bd7 with SMTP id
 um14-20020a170906cf8e00b0088b1d464bd7mr253705ejb.20.1675078464832; 
 Mon, 30 Jan 2023 03:34:24 -0800 (PST)
X-Google-Smtp-Source: AK7set9jNXmbh/9bAPYnnc2CxnrydthiH0Hxyspp7356B7jGNH2PDt+cJpmUfq8e+EdFUY2Zr76iPw==
X-Received: by 2002:a17:906:cf8e:b0:88b:1d46:4bd7 with SMTP id
 um14-20020a170906cf8e00b0088b1d464bd7mr253692ejb.20.1675078464640; 
 Mon, 30 Jan 2023 03:34:24 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 ce4-20020a170906b24400b0078d3f96d293sm6743835ejb.30.2023.01.30.03.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 03:34:23 -0800 (PST)
Date: Mon, 30 Jan 2023 06:34:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: RFC: VDPA Interrupt vector distribution
Message-ID: <20230130063247-mutt-send-email-mst@kernel.org>
References: <bc4136ed-abe0-dcc2-4dd9-31dcf3d8c179@nvidia.com>
 <CACGkMEuTz4RVf0CA9y7sf7K3N1FbKrD6A=xC6JL7N+hzX5RLjw@mail.gmail.com>
 <23806cd9-ffde-778c-5fa5-b95bd1ff0b44@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <23806cd9-ffde-778c-5fa5-b95bd1ff0b44@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Jan 30, 2023 at 12:01:23PM +0200, Eli Cohen wrote:
> On 30/01/2023 10:19, Jason Wang wrote:
> > Hi Eli:
> > 
> > On Mon, Jan 23, 2023 at 1:59 PM Eli Cohen <elic@nvidia.com> wrote:
> > > VDPA allows hardware drivers the propagate interrupts from the hardware
> > > directly to the vCPU used by the guest. In a typical implementation, the
> > > hardware driver will assign the interrupt vectors to the virtqueues and report
> > > this information back through the get_vq_irq() callback defined in
> > > struct vdpa_config_ops.
> > > 
> > > Interrupt vectors could be a scarce resource and may be limited. For such
> > > cases, we can opt the administrator, through the vdpa tool, to set the policy
> > > defining how to distribute the available vectors amongst the data virtqueues.
> > > 
> > > The following policies are proposed:
> > > 
> > > 1. First comes first served. Assign a vector to each data virtqueue by the
> > >      virtqueue index. Virtqueues which could not be assigned a dedicated vector
> > >      would use the hardware driver to propagate interrupts using the available
> > >      callback mechanism.
> > > 
> > >      vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all
> > > 
> > >      This is the default mode and works even if "int=all" was not specified.
> > > 
> > > 2. Use round robin distribution so virtqueues could share vectors.
> > >      vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all intmode=share
> > > 
> > > 3. Assign vectors to RX virtqueues only.
> > > 3.1 Do not share vectors
> > >       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx
> > > 3.2 Share vectors
> > >       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx intmode=share
> > > 
> > > 4. Assign vectors to TX virtqueues only. Can share or not, like rx.
> > > 5. Fail device creation if number of vectors cannot be fulfilled.
> > >      vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 max_vq_pairs 8 int=rx intnum=8
> > I wonder:
> > 
> > 1) how the administrator can know if there's sufficient resources for
> > one of the above policies.
> There's no established way to know. The idea is to use whatever there is
> assuming interrupt bypassing is always better then the callback mechanism.
> > 2) how does the administrator know which policy is the best assuming
> > the resources are sufficient? (E.g vectors to RX only or vectors to TX
> > only)
> I don't think there's a rule of thumb here but he needs to experiment what
> works best for him.
> > 
> > If it requires a vendor specific way or knowledge, I believe it's
> > better to code them in:
> > 
> > 1) the vDPA parent or
> > 2) underlayer management tool or drivers
> > 
> > Thanks
> 
> I was wondering also about the current mechanism we have. The hardware
> driver reports irq number for each VQ.
> 
> The guest driver sees a virtio pci device with MSIX vectors as the number of
> virtqueues.
> 
> Suppose the hardware driver provided only 5 interrupt vectors while there
> are 16 VQs.
> 
> Which MSIX vector at the guest gets really posted interrupt and which one
> uses callback handled at the hardware driver?

Not sure I understand.
If you get a single interrupt from hardware callback or posted
you can only drive one interrupt to guest, no?


> > > 
> > > 
> > > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
