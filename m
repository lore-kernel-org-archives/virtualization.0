Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81FACCA47B
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 13:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40BB28470A;
	Fri,  8 Jul 2022 13:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40BB28470A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCEeuR7V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWwl4D172lXx; Fri,  8 Jul 2022 13:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C12D84626;
	Fri,  8 Jul 2022 13:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C12D84626
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F23AC0035;
	Fri,  8 Jul 2022 13:51:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 702A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 13:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CAC5613E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 13:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CAC5613E9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCEeuR7V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tlyzOQ1ZLfZf
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 13:51:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CDAE613DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CDAE613DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657288314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVefCn2Sr2XDtcSF1e802d6x0OPOMy5L9rDF1Zp3WNI=;
 b=UCEeuR7V675yczouLZGyT2PSI0G2l2A5fjwFfsnzyKzbsEWdjFUZ8HAonxmeWeKU0e6VDG
 b3eUwQLbCuSzJVD8PWCDcNA6CVPaVXsqq24tVYHwsX0P1IA9RorxmdIJuNZP7bRZ2b1wC+
 BZugZVbAnviZda/AqEe/3Ok5qiE78Jc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-5IjoYOvmNpO2qrjk-QHpGg-1; Fri, 08 Jul 2022 09:51:53 -0400
X-MC-Unique: 5IjoYOvmNpO2qrjk-QHpGg-1
Received: by mail-qt1-f198.google.com with SMTP id
 cr13-20020a05622a428d00b0031d3463f241so18335596qtb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Jul 2022 06:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yVefCn2Sr2XDtcSF1e802d6x0OPOMy5L9rDF1Zp3WNI=;
 b=21h81x7CurVSbRMKciE47vJTcmmYlmKRuyE2/DG9knzKPeY+UV0SovilFwtm9g71Fv
 k155BzudqSpzroulOFBKSWv5j+VOz7H05H2cHmWseDlDCmLzLtw1vxQXJkvL4g5SbN72
 ZuvIljP138xnlylDNbJpDUOK+Q6hdkGwaBF1rfncelWWMWrtT/Q5ei91K/kx+gvIcvWE
 12tWjnFdyNZehmnsNO7izO6nlLrZG9NHJSXKGZnqJeMN6zbnhojeAUV12yrSmjR/TD6B
 1KEeEGEOjH7ZuG0KJC5JlIDIP3gO1uz/gu7pQqranXGBEXuawVaUmPWG0F8r/DCv8IFQ
 X6Uw==
X-Gm-Message-State: AJIora/3u99TmERuK1q82eW/ItVD/FLuIJpjuE2tNAyisgJobJDHSeAm
 cgC43BMT/R+k4yvwAOHVtt7vVgwRaQxE5y6KjojTuLb48uc4vkjPbog7ZfMfAcCnqlgakDrEkmO
 xWSB9Zvi4sAxERFRz//TbPqb5yiuUl3RMrTx8DL9bBg==
X-Received: by 2002:a05:6214:20ea:b0:473:421d:d459 with SMTP id
 10-20020a05621420ea00b00473421dd459mr1714720qvk.27.1657288313019; 
 Fri, 08 Jul 2022 06:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9HR4FiVcyVsBfX00aQKPJWG12vBD+uxGxuwJDaIa2y0QoQQjiF0NRy0pY+w9XGYubd8flkg==
X-Received: by 2002:a05:6214:20ea:b0:473:421d:d459 with SMTP id
 10-20020a05621420ea00b00473421dd459mr1714693qvk.27.1657288312809; 
 Fri, 08 Jul 2022 06:51:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05620a004e00b006a6d20386f6sm31658212qkt.42.2022.07.08.06.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jul 2022 06:51:50 -0700 (PDT)
Date: Fri, 8 Jul 2022 15:51:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v6 2/4] vhost-vdpa: introduce SUSPEND backend feature bit
Message-ID: <20220708135138.kjdnnxelgll2p3cv@sgarzare-redhat>
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-3-eperezma@redhat.com>
 <20220628134340.5fla7surd34bwnq3@sgarzare-redhat>
 <CAJaqyWd8yNdfGEDJ3Zesruh_Q0_9u_j80pad-FUA=oK=mvnLGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd8yNdfGEDJ3Zesruh_Q0_9u_j80pad-FUA=oK=mvnLGQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>, "Uminski,
 Piotr" <Piotr.Uminski@intel.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jul 08, 2022 at 01:38:45PM +0200, Eugenio Perez Martin wrote:
>On Tue, Jun 28, 2022 at 3:43 PM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>>
>> On Thu, Jun 23, 2022 at 06:07:36PM +0200, Eugenio P=E9rez wrote:
>> >Userland knows if it can suspend the device or not by checking this fea=
ture
>> >bit.
>> >
>> >It's only offered if the vdpa driver backend implements the suspend()
>> >operation callback, and to offer it or userland to ack it if the backend
>> >does not offer that callback is an error.
>>
>> Should we document in the previous patch that the callback must be
>> implemented only if the drive/device support it?
>>
>
>It's marked as optional in the doc, following other optional callbacks
>like set_group_asid for example. But I'm ok with documenting this
>behavior further.
>
>> The rest LGTM although I have a doubt whether it is better to move this
>> patch after patch 3, or merge it with patch 3, for bisectability since
>> we enable the feature here but if the userspace calls ioctl() with
>> VHOST_VDPA_SUSPEND we reply back that it is not supported.
>>
>
>I'm fine with moving it, but we will have that behavior with all the
>devices anyway. Regarding userspace, we just replace ENOIOCTL with
>EOPNOTSUPP. Or I'm missing something?

Yep, you're right, this is fine! ;-)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
