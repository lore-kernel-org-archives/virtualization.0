Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC1CC433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 20:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F48B60B70;
	Fri, 14 Jan 2022 20:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ah6oghOW9AEz; Fri, 14 Jan 2022 20:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5708960B03;
	Fri, 14 Jan 2022 20:25:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 212F4C0030;
	Fri, 14 Jan 2022 20:25:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C48FBC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E4B760B48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AohoA8qvfTz8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F182F60B03
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642191940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+U49Mg4vHgZQ+U2ijwfUpSn+gRnEdVr75gDfA+KVos=;
 b=XxBJcKcjvjquPjSvykDPNyNhvkwMAKSkTXwDxsKstH82XIhakhz5ke2fdRLANz/XLfodIr
 A7xRTDjp2MrJ1YUcWaNwTaE+TojrOIHdCSTAAXmLXqLc614fBJ9+8s4kz3wynTqjtF1tJx
 j+6jl23XZpEgP+4wJWVC59WjLLw90PU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-CjlL33THMGWYZJaW_jm4fg-1; Fri, 14 Jan 2022 15:25:40 -0500
X-MC-Unique: CjlL33THMGWYZJaW_jm4fg-1
Received: by mail-wm1-f70.google.com with SMTP id
 s190-20020a1ca9c7000000b00347c6c39d9aso6192460wme.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q+U49Mg4vHgZQ+U2ijwfUpSn+gRnEdVr75gDfA+KVos=;
 b=x2qb6VTUXbuU0ddFIzGwwz9b2v3b3vexBmTa0EsX/SWNyKal8QCcx+eafXtKucuY5i
 EQmhN+zxIs8mupL9SJU4h0HTklH5zRuptHlDQvTmpGGgJTERD6IQh2jtDMrtTaEYGAQ7
 g83jLSz8qwRZI50TKAsTyatrkgBALnJPLdC4JvC9bjZskOvlJFAyZ09TVpfaHo/cSEkO
 /N260305UoIBBRZumNweJPuQxHC6ln9zgAP3x07AeWoH/BHiaejMjXtZrKIFF0jcN2/E
 PWfJqxsPtQWhaz4NoxjJIFvUIoI4Rp3GRCyzUem32fAYJo9bTpfav/L9w7jUe8Yg7l+N
 eSKQ==
X-Gm-Message-State: AOAM530MQ6qPTm/j1NBXp0x3y/Q3w8lIHl1/imBGRnhlg5ymoic77wkX
 VBOBj22Q0FNcK3cTkNuOuCt2W4HvEihfVzJ2PIxSPFWGP4jYRDilXiBpJDQfg0XlWIF6kqYK4ui
 BPzYP+WN2OQgOgdPDWTku0kpujSop+Dk7aWICX7uQsQ==
X-Received: by 2002:adf:f312:: with SMTP id i18mr9440573wro.589.1642191938196; 
 Fri, 14 Jan 2022 12:25:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz47RNLqMFpqD/QxjE8TQyTVssH1p4du77rQTPOwEnHsO07Oiqjo5CvIxDDfozikHu9Up+cNA==
X-Received: by 2002:adf:f312:: with SMTP id i18mr9440563wro.589.1642191937985; 
 Fri, 14 Jan 2022 12:25:37 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id g9sm7253003wmq.22.2022.01.14.12.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 12:25:37 -0800 (PST)
Date: Fri, 14 Jan 2022 15:25:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
Message-ID: <20220114152443-mutt-send-email-mst@kernel.org>
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
 <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eli Cohen <elic@nvidia.com>
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

On Tue, Jan 11, 2022 at 02:14:47PM -0800, Si-Wei Liu wrote:
> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>

Note: the correct format is:

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

(with a space before <>).

Pls take care in the future.
Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
