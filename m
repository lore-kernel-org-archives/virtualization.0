Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61327C636CC
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 07:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D310D606EB;
	Tue, 31 Jan 2023 07:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D310D606EB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hvzgD+u/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1mdjuTKV3gm; Tue, 31 Jan 2023 07:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 564EC606BF;
	Tue, 31 Jan 2023 07:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 564EC606BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C05C0032;
	Tue, 31 Jan 2023 07:26:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFB58C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B567F81332
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:26:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B567F81332
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hvzgD+u/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtTKxihHmzqu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:26:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80074812B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80074812B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675149975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VBoflQQdAwzstaH0xtqmvvam4bU3bgBfNkuv5lXP3A=;
 b=hvzgD+u/SYLS6iS+MAXq8aozEEkLlDQNL+Qv+lNU98xkdo7Lc4Mz4XPmjFQ/oJ7RM2fSES
 rolCkWK5MpM9x5rwReJxOSF2bLtyLBYvdq//YDU+94o4hmso2ZRPV3BJ2qKEXHcgqmKubF
 swgQJSKM8Gr2P9WE/K6Wq1hx+Lo379g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-shIw2ZuuOriQ2DVenv2QCA-1; Tue, 31 Jan 2023 02:26:13 -0500
X-MC-Unique: shIw2ZuuOriQ2DVenv2QCA-1
Received: by mail-wm1-f69.google.com with SMTP id
 z22-20020a7bc7d6000000b003daf671f7b2so5436009wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 23:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VBoflQQdAwzstaH0xtqmvvam4bU3bgBfNkuv5lXP3A=;
 b=dUsogwwaR3LNyasGjSJwkdsM4xa8Yj6BynVdSUPXx7WT8Y0C1M8o30sxVCdY07SiPi
 FgkBvjm3Nswg9RfuYVNDALsbBRL73Dg2Ua/Cq2r5iz8Sn8kfns8Q8tnGIT18IIMJHcrY
 Ch/VVEBIx1q/bjCdBBhpIqw9i6MpL3e0Ca9kSAXgsNPBFJmZ94g12MLvk+3Nl4s3YIfG
 F+rj1KEQi+4uizwfKgD18UIfxQO3Lc47qs41bgHdZ9fwvdZQq1wrd+7LqJpy96Qo7IeN
 shmTEPE6iRJuc090kl1mWmRN4+AKHPA9h3Y6VmYENteS6YW6jomeDTcJpQrbcZAz3mFJ
 xfqA==
X-Gm-Message-State: AO0yUKWCf3L4UtB+lPRYjbvREwec9D/0R+C2MwJJnnf3czeQVhQDg9o5
 22e3oBe4ACptIEtxZ92MpPw7JCpmwYNMU6uAVC3QISJeFy3BNIOU4kYkCbJmtU6mj/CEk86jrjt
 aLSHDxiAk69DlYLIYRHUt0/ZpvSPM9CP8OgtjU63zOg==
X-Received: by 2002:a05:6000:2aa:b0:2c1:2a15:9dd3 with SMTP id
 l10-20020a05600002aa00b002c12a159dd3mr2618652wry.48.1675149972738; 
 Mon, 30 Jan 2023 23:26:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9osZTmlonL9/Yv2J9cmQdhoJPFjPW7ph9SzZF8TNiAC8wAvpAJuE2Go9E9/bzHo+p72QxvTw==
X-Received: by 2002:a05:6000:2aa:b0:2c1:2a15:9dd3 with SMTP id
 l10-20020a05600002aa00b002c12a159dd3mr2618628wry.48.1675149972402; 
 Mon, 30 Jan 2023 23:26:12 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 q8-20020a05600000c800b002bfef084b75sm4373953wrx.96.2023.01.30.23.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 23:26:11 -0800 (PST)
Date: Tue, 31 Jan 2023 02:26:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: RFC: VDPA Interrupt vector distribution
Message-ID: <20230131022344-mutt-send-email-mst@kernel.org>
References: <bc4136ed-abe0-dcc2-4dd9-31dcf3d8c179@nvidia.com>
 <CACGkMEuTz4RVf0CA9y7sf7K3N1FbKrD6A=xC6JL7N+hzX5RLjw@mail.gmail.com>
 <23806cd9-ffde-778c-5fa5-b95bd1ff0b44@nvidia.com>
 <20230130063247-mutt-send-email-mst@kernel.org>
 <734e2553-199f-94eb-88d1-a642ec1c7490@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <734e2553-199f-94eb-88d1-a642ec1c7490@nvidia.com>
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

On Mon, Jan 30, 2023 at 01:54:14PM +0200, Eli Cohen wrote:
> 
> On 30/01/2023 13:34, Michael S. Tsirkin wrote:
> > On Mon, Jan 30, 2023 at 12:01:23PM +0200, Eli Cohen wrote:
> > > On 30/01/2023 10:19, Jason Wang wrote:
> > > > Hi Eli:
> > > > 
> > > > On Mon, Jan 23, 2023 at 1:59 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > > VDPA allows hardware drivers the propagate interrupts from the hardware
> > > > > directly to the vCPU used by the guest. In a typical implementation, the
> > > > > hardware driver will assign the interrupt vectors to the virtqueues and report
> > > > > this information back through the get_vq_irq() callback defined in
> > > > > struct vdpa_config_ops.
> > > > > 
> > > > > Interrupt vectors could be a scarce resource and may be limited. For such
> > > > > cases, we can opt the administrator, through the vdpa tool, to set the policy
> > > > > defining how to distribute the available vectors amongst the data virtqueues.
> > > > > 
> > > > > The following policies are proposed:
> > > > > 
> > > > > 1. First comes first served. Assign a vector to each data virtqueue by the
> > > > >       virtqueue index. Virtqueues which could not be assigned a dedicated vector
> > > > >       would use the hardware driver to propagate interrupts using the available
> > > > >       callback mechanism.
> > > > > 
> > > > >       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all
> > > > > 
> > > > >       This is the default mode and works even if "int=all" was not specified.
> > > > > 
> > > > > 2. Use round robin distribution so virtqueues could share vectors.
> > > > >       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=all intmode=share
> > > > > 
> > > > > 3. Assign vectors to RX virtqueues only.
> > > > > 3.1 Do not share vectors
> > > > >        vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx
> > > > > 3.2 Share vectors
> > > > >        vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 int=rx intmode=share
> > > > > 
> > > > > 4. Assign vectors to TX virtqueues only. Can share or not, like rx.
> > > > > 5. Fail device creation if number of vectors cannot be fulfilled.
> > > > >       vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 max_vq_pairs 8 int=rx intnum=8
> > > > I wonder:
> > > > 
> > > > 1) how the administrator can know if there's sufficient resources for
> > > > one of the above policies.
> > > There's no established way to know. The idea is to use whatever there is
> > > assuming interrupt bypassing is always better then the callback mechanism.
> > > > 2) how does the administrator know which policy is the best assuming
> > > > the resources are sufficient? (E.g vectors to RX only or vectors to TX
> > > > only)
> > > I don't think there's a rule of thumb here but he needs to experiment what
> > > works best for him.
> > > > If it requires a vendor specific way or knowledge, I believe it's
> > > > better to code them in:
> > > > 
> > > > 1) the vDPA parent or
> > > > 2) underlayer management tool or drivers
> > > > 
> > > > Thanks
> > > I was wondering also about the current mechanism we have. The hardware
> > > driver reports irq number for each VQ.
> > > 
> > > The guest driver sees a virtio pci device with MSIX vectors as the number of
> > > virtqueues.
> > > 
> > > Suppose the hardware driver provided only 5 interrupt vectors while there
> > > are 16 VQs.
> > > 
> > > Which MSIX vector at the guest gets really posted interrupt and which one
> > > uses callback handled at the hardware driver?
> > Not sure I understand.
> > If you get a single interrupt from hardware callback or posted
> > you can only drive one interrupt to guest, no?
> > 
> For every VQ I have a chance to assign interrupt vector.
> 
> Consider this scenario:
> 
> mlx5_vdpa created with 16 data virtqueu
> 
> mlx5_vdpa associates VQ0 with interrupt vector. The reset of the vectors
> don't get assigned vectors and use old callback mechanism.
> 
> When you go to the VM and run lspci, you will see the device has 16 MSIX
> vectors.
> 
> Do you know which of the MSIX vectors on the guest is the vector I assigned
> for VQ0?

Me as in which component?
And I don't really understand how this answers the question.
If hardware only supports 5 vectors, how can we expose 16
vectors to guest? Host can send to guest as many as it wants,
sure (this is the callback you are referring to, right?)
but host will not know which interrupt to send.
I conclude that exposing to guest more vectors than
hardware supports is simply not something we should do.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
