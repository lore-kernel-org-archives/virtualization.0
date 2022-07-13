Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A745DC43334
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1081261322;
	Wed, 13 Jul 2022 05:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1081261322
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/7UAQi+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATYJjJq9UEkm; Wed, 13 Jul 2022 05:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EA0C61326;
	Wed, 13 Jul 2022 05:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EA0C61326
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CEE5C0033;
	Wed, 13 Jul 2022 05:23:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A32C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12ED041A16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:23:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12ED041A16
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I/7UAQi+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sU5JYSxJupKc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E87641A13
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E87641A13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657689807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mx2Am9gFTCNI9BaWsLgkeiQH68t9VBPnMVGfxTXXM9A=;
 b=I/7UAQi+Nht6UBLAmSVlWR5aFECWKugWZ9TEU4UGsQovJlatkDp8NckstD3eugv436H8qd
 lAVqWx9ma4DtM8aGRdstrGeQLQtu93IYKZR9aARcnXL3jbnRsyDWslQ/EJQ511BP24W8Op
 ciCftpJuATonFGnS7LTHYjyJO2wCwPU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-QdiAX9bpP7KgNrEf7wrIJg-1; Wed, 13 Jul 2022 01:23:26 -0400
X-MC-Unique: QdiAX9bpP7KgNrEf7wrIJg-1
Received: by mail-ej1-f69.google.com with SMTP id
 qw8-20020a1709066a0800b0072abb95c0caso2940426ejc.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mx2Am9gFTCNI9BaWsLgkeiQH68t9VBPnMVGfxTXXM9A=;
 b=HC/Od8skb5nD4I3OrONaJw4FW1SpBQSqKwajWRvggoc+wIRhIA0MfLwLAl6Yt4SgXd
 wVbaerQTdxZLYLKeOVzrzdR42T3sPP+DeN4jh4M47tGKP9nUozOxI46BZaNwpIdVdciE
 /uSTRnISRQIX7rT+YH2+kaKiDBTUpt4D2BdEAgoABgA8IhnD4EQMumCesg7/Ijs5GdUs
 m4CBGSlu49zFcLExVuCBp6IrZvyT8TE6a9VcG75cibEdgN5ZEw0MB8f7OxrHfYXFwGEn
 hp6Lc+PGUXlSFPIn+kIWQVr8iB2f0nl8VsHVYfVTkjucnyxEAmUfSXuqsasZZzhD67PN
 K1aQ==
X-Gm-Message-State: AJIora8jqGXBxuaJKJPGc7l2vaSHgCKe0QAbroSbhGz6SHEWVHkjiajW
 aLFOIcwOtW+Zzc5btB79SPfHtrhmkxvJiiRzih3Iw0iU5CP/d2/zaTtdIMeujNbdXfODYFSMor/
 tfk/x/rsCnJ9EsQJ3kCgv1tK5vP2W3oTo15xABBpUdw==
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id
 t4-20020a056402240400b00437d11fb9c7mr2445828eda.176.1657689805117; 
 Tue, 12 Jul 2022 22:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulI8KDZUKTkP1k/mb9cJbdGBS7J5mail0dNkB2X4x2IaCDX5VdTO5ksVFYiZ6954aIE61/NQ==
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id
 t4-20020a056402240400b00437d11fb9c7mr2445806eda.176.1657689804869; 
 Tue, 12 Jul 2022 22:23:24 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 r17-20020a1709061bb100b0072b616ade26sm2473478ejg.216.2022.07.12.22.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 22:23:23 -0700 (PDT)
Date: Wed, 13 Jul 2022 01:23:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Message-ID: <20220713012048-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Fri, Jul 01, 2022 at 10:12:49PM +0000, Parav Pandit wrote:
> 
> 
> > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > Sent: Friday, July 1, 2022 9:28 AM
> > 
> > Users may want to query the config space of a vDPA device, to choose a
> > appropriate one for a certain guest. This means the users need to read the
> > config space before FEATURES_OK, and the existence of config space
> > contents does not depend on FEATURES_OK.
> > 
> > The spec says:
> > The device MUST allow reading of any device-specific configuration field
> > before FEATURES_OK is set by the driver. This includes fields which are
c> > conditional on feature bits, as long as those feature bits are offered by the
> > device.
> > 
> > Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
> Fix is fine, but fixes tag needs correction described below.
> 
> Above commit id is 13 letters should be 12.
> And 
> It should be in format
> Fixes: 30ef7a8ac8a0 ("vdpa: Read device configuration only if FEATURES_OK")

Yea you normally use

--format='Fixes: %h (\"%s\")'


> Please use checkpatch.pl script before posting the patches to catch these errors.
> There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.


I don't think checkpatch complains about this if for no other reason
that sometimes the 6 byte hash is not enough.

> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >  drivers/vdpa/vdpa.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > 9b0e39b2f022..d76b22b2f7ae 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
> > struct sk_buff *msg, u32 portid,  {
> >  	u32 device_id;
> >  	void *hdr;
> > -	u8 status;
> >  	int err;
> > 
> >  	down_read(&vdev->cf_lock);
> > -	status = vdev->config->get_status(vdev);
> > -	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> > -		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not
> > completed");
> > -		err = -EAGAIN;
> > -		goto out;
> > -	}
> > -
> >  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> >  			  VDPA_CMD_DEV_CONFIG_GET);
> >  	if (!hdr) {
> > --
> > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
