Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5418C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 06:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FA9560B6E;
	Mon, 19 Dec 2022 06:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FA9560B6E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g2mQmwYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUgCHLoyUc5t; Mon, 19 Dec 2022 06:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA64060B15;
	Mon, 19 Dec 2022 06:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA64060B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88985C0032;
	Mon, 19 Dec 2022 06:31:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54CA9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A5094018D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:31:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A5094018D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g2mQmwYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lDLQcO4D2gCL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB4C7400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB4C7400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671431484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nc7qTxlmUz2RecvbE0nK25yMVU3Hb8QsUzmKfC5XdbQ=;
 b=g2mQmwYcDFLtuFhThVTqiF2olAV22HbYB07Qnoh3OpZXdJqW+BqKdkLnt0HggYVUBctI1/
 hOd81041uGUM8XgF69TOkYB9Dh5cufDlwH7VMEzMhmOn0ePQ6B0jiIMiKfU6aOrBxkjobk
 1BMhmPmODIhdDG63DA4waNOlz2XVMls=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-_mTdoJz-OLG41EHGEL5viQ-1; Mon, 19 Dec 2022 01:31:23 -0500
X-MC-Unique: _mTdoJz-OLG41EHGEL5viQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 ks19-20020a056214311300b004df5465b26eso5168270qvb.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Dec 2022 22:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nc7qTxlmUz2RecvbE0nK25yMVU3Hb8QsUzmKfC5XdbQ=;
 b=Gzhmwz5vZR0h6Mwy9Zy+WamESbfXN3C8PBvIbCIAfATdRIa/rXlauz79NyH/m7z6TI
 OGMTe5blp4ssFh5yqJjPUKcYsUjbbez9+ayZ9ZsBx4trE58LaigndYd2faZBCF4tVYav
 pYv1jNMqzv4aGxyRNMkDOx8mLUqp/r9Sk7F0i++1NdHT7lOuZz7XaBdA3WuCBsQaF1He
 hmltnlOm+RtoJI30XU3zvOFhgcgSy4aGufcZsxMKueNgRZNzEmZI8Girlvw7H0rPtq8u
 DBN/fOIzZ57ZYTlkITZQ8rsWYmvq0Cxp8Y9x9CG/R1OVeL58fUmfU4g/r+0qaNirC7g8
 Px2Q==
X-Gm-Message-State: AFqh2kpSrarZMpGGv9t1YoEBiLMcRbJvrGTxapqU3lYH7k/AwNGK/5YK
 9D4MaAoBrlD6WBYcsEExu9j7wYHtpe80iiHVab0Ni2NeUH53FmcYJm8AslC8i8sGUNgVjvNWdVn
 7uOCnai41B10x1ZzP+qejwY5nDdKBwEMPnLw3GPxxEg==
X-Received: by 2002:a05:622a:18a4:b0:3a9:72ea:5a5d with SMTP id
 v36-20020a05622a18a400b003a972ea5a5dmr23750543qtc.57.1671431482771; 
 Sun, 18 Dec 2022 22:31:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsf9g6iVZ3MBQo8GBfcGOF/jhGlUYTzvh+tWoYw/gMab8c126S4XzxMGZdlF1YaJHg23LXvUA==
X-Received: by 2002:a05:622a:18a4:b0:3a9:72ea:5a5d with SMTP id
 v36-20020a05622a18a400b003a972ea5a5dmr23750526qtc.57.1671431482538; 
 Sun, 18 Dec 2022 22:31:22 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 d14-20020ac8668e000000b0039492d503cdsm5580246qtp.51.2022.12.18.22.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Dec 2022 22:31:22 -0800 (PST)
Date: Mon, 19 Dec 2022 01:31:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Message-ID: <20221219012917-mutt-send-email-mst@kernel.org>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
 <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
 <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
 <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
 <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

On Fri, Oct 28, 2022 at 04:23:49PM -0700, Si-Wei Liu wrote:
> I can post a v3 that shows the code, it shouldn't be
> too hard.

I take it another version of this patchset is planned?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
