Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE09DC4167B
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 09:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32E734154A;
	Tue, 31 Oct 2023 09:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32E734154A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aEdh52PL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33ISOH9-2uMo; Tue, 31 Oct 2023 09:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5035140466;
	Tue, 31 Oct 2023 09:00:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5035140466
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A349C0071;
	Tue, 31 Oct 2023 09:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76A7B817A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76A7B817A9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aEdh52PL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8icz_M-Mstwl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:00:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9652181758
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 09:00:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9652181758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJaPhbcmh8rSiQ4KL2QqVbu7Ce8KpG8/Bm1tkvMPCfo=;
 b=aEdh52PLgbu13210qsLG1jIRZPzKh1gE8r8cTbxWVJeUPn2V7kqxmoHZWA3+kwI/TVIgQd
 KbtiUEZkkdfWOOXXq7O4lpDEDjHZe4jMS4cCZkJGYbEheiSXWLDFZAwU8WYwsgqZPL6DGU
 Q9VICgj2SQeEvoHzxFS33d3wYzFzhNc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-9XJJ07FHPOqerG-B4L5igQ-1; Tue, 31 Oct 2023 05:00:11 -0400
X-MC-Unique: 9XJJ07FHPOqerG-B4L5igQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so6322565e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698742809; x=1699347609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJaPhbcmh8rSiQ4KL2QqVbu7Ce8KpG8/Bm1tkvMPCfo=;
 b=TaSv0809lVDusR+K0XNhaxHmZePUDqEJ32lNLTn3MLOEVsgQ9jpsN6eNfHLzTM8YTq
 NfxI1QdZM3UzsNlQ0eS1TW93cc2Dy2nf+fU9gUnAbWpDUHOo/cw8eqoza2/D6q/BIMk0
 IgF/B7wE3Q0HW7C9JOQYuxdhzq2P3cXh+nZrmG522rvq3jmtbyGQBTmWr/j4/2HtROlG
 MlhZRrbQkyMPAdwjexEKb8Is0bgqPaoxbvOzpB9EUGh9dJcNFMNYnb/5BCeDu1Oq3NJL
 S7D3k4zhOTKuWoD5IaJU+p0sg2W5UR+wfZp/3cPr+/pFtao/0mgsKsuNUEEpz4FfkYaJ
 FUIg==
X-Gm-Message-State: AOJu0Yx3/boeaxUgBClzf5+II0bA+WQuhbGth8njbxE7NWzChp02fEgj
 3joTpdntH4CAvDkWmyv7H7glGRJW46b2dwl9WfCFDGDMPHXAjD+A+qccc3Wm6WlSWIQa6s+PRjs
 kAU+Xv9nGLjfxmJ/oxLUa5qfrAnIWEy5HbSGatGrIJg==
X-Received: by 2002:ac2:42c3:0:b0:509:2b82:4ce8 with SMTP id
 n3-20020ac242c3000000b005092b824ce8mr1849297lfl.42.1698742809668; 
 Tue, 31 Oct 2023 02:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3S35L/UQTy/U7yQi8+SVu+0V8xB9AoTI/4Vdd4oeEJ0oJwQJPeCjGFyCZnVrk7tqVWNUWCQ==
X-Received: by 2002:ac2:42c3:0:b0:509:2b82:4ce8 with SMTP id
 n3-20020ac242c3000000b005092b824ce8mr1849274lfl.42.1698742809259; 
 Tue, 31 Oct 2023 02:00:09 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 e13-20020a056000194d00b003142e438e8csm998743wry.26.2023.10.31.02.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 02:00:08 -0700 (PDT)
Date: Tue, 31 Oct 2023 05:00:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <20231031045933-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-7-yishaih@nvidia.com>
 <20231031040403-mutt-send-email-mst@kernel.org>
 <3a7c776d-1e5a-4c8d-b91e-9da5fe91db32@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <3a7c776d-1e5a-4c8d-b91e-9da5fe91db32@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Tue, Oct 31, 2023 at 10:30:41AM +0200, Yishai Hadas wrote:
> > And further, is caller expected not to invoke several of these
> > in parallel on the same device? If yes this needs to be
> > documented. I don't see where does vfio enforce this if yes.
> Please have a look at virtiovf_issue_legacy_rw_cmd() from patch #9.
> 
> It has a lock on its VF device to serialize access to the bar, it includes
> calling this API.
> 
> Yishai

OK so if caller must serialize accesses then please document this assumption.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
