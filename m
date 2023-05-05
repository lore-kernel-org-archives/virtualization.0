Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A2CC77B75
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 14:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 948CE4006C;
	Fri,  5 May 2023 14:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 948CE4006C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xdpu0TN5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5-dCPrLGrxK; Fri,  5 May 2023 14:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8091400A6;
	Fri,  5 May 2023 14:59:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8091400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A219DC0037;
	Fri,  5 May 2023 14:59:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD1FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 14:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35D1C40492
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 14:59:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35D1C40492
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xdpu0TN5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hnT-GT9CvBBz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 14:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A1064012B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1064012B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683298784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBXNgO7aRryOo3aOK63YAEnZA6K4XoikS9SxHfhUh30=;
 b=Xdpu0TN5wUDqy1TFcaxWXsjJYrGZYlHWi+hj8K+e+VIY+DYuxSeFX0kLq5yWau31tcBkEF
 cS40AdKe38QfsHDqy+iqI9lAoJa52kf2tz8DKaxxpVmHiq09EY7sf1fYZ9rR0zYlBbu+/n
 o7OctNrG5uWmKpJaEN2HA9ndcyK90CY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-dBZema-UM3uu-MvpFprOzQ-1; Fri, 05 May 2023 10:59:42 -0400
X-MC-Unique: dBZema-UM3uu-MvpFprOzQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50bc6c6b9dbso13148734a12.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 May 2023 07:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683298781; x=1685890781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBXNgO7aRryOo3aOK63YAEnZA6K4XoikS9SxHfhUh30=;
 b=KGJ6/8SRkwUaQ/ZN8bVSnZeArwMzjKDd7ibN6NVAwbU2fQCOs+rD+hY3wKloeL32I/
 y4B+56O9mWLuXcmrWMV6s1SBvXHBMt/QAM9p46rQl0tw29H1xccEjHd/Ely8FJGZOjbP
 bLnHAc9t549D0tXHNOQOej1XU2fNo9YaaB1Rb0x+P03VL98+q7BguqQNFBGQUpDlMB0u
 oOE8xxCnYy0qwewGYXPTVpKRp3GshUPYm7eIml1FTx88/zJWEQjYRYPSf96DOH5cveuK
 c61uDK46yf4s8TOYeAQxTKUUjWAvur1q0QZQGD31jpo+mdD2KtoL9Os51/0Nw62wXoj6
 Rpvw==
X-Gm-Message-State: AC+VfDzioY5wUUI7BCFyufCU7UkvyHrf22Qqf3NTxlnzJ3ee2SlOsIDu
 QqWbjOzGu+PtCv+5rcal2dPfoHgEYcTT/Y9EWHq5xl0J7niZmXDvDrZKbAy7sOdtQcq9r0sJyAk
 kWnN3z3EDVLzVLnS2miQed+zum65E6n1VvmpvNEEeSg==
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id
 y6-20020aa7ccc6000000b0050bdfe20091mr1904395edt.7.1683298781576; 
 Fri, 05 May 2023 07:59:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41nBmpMVnXW7PKFZ8ZB30pUuvlx01dx8IxPbfnWfLUCXzpn0UbIn+XfcKAeqyn2xG3hPxzGw==
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id
 y6-20020aa7ccc6000000b0050bdfe20091mr1904374edt.7.1683298781292; 
 Fri, 05 May 2023 07:59:41 -0700 (PDT)
Received: from redhat.com ([77.137.193.128]) by smtp.gmail.com with ESMTPSA id
 h20-20020aa7c614000000b00501d73cfc86sm3024677edq.9.2023.05.05.07.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 May 2023 07:59:40 -0700 (PDT)
Date: Fri, 5 May 2023 10:59:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ye xingchen <yexingchen116@gmail.com>
Subject: Re: [PATCH] vhost_net: Use fdget() and fdput()
Message-ID: <20230505105811-mutt-send-email-mst@kernel.org>
References: <CACGkMEsmf3PgxmhgRCsPZe7fRWHDXQ=TtYu5Tgx1=_Ymyvi-pA@mail.gmail.com>
 <20230505084155.63839-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20230505084155.63839-1-ye.xingchen@zte.com.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, ye.xingchen@zte.com.cn, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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

On Fri, May 05, 2023 at 04:41:55PM +0800, ye xingchen wrote:
> >>
> >> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> >>
> >> convert the fget()/fput() uses to fdget()/fdput().
> >What's the advantages of this?
> >
> >Thanks
> >>
> >> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> >> ---
> >>  drivers/vhost/net.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index ae2273196b0c..5b3fe4805182 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -1466,17 +1466,17 @@ static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> >>
> >>  static struct socket *get_tap_socket(int fd)
> >>  {
> >> -       struct file *file = fget(fd);
> >> +       struct fd f = fdget(fd);
> >>         struct socket *sock;
> >>
> >> -       if (!file)
> >> +       if (!f.file)
> >>                 return ERR_PTR(-EBADF);
> >> -       sock = tun_get_socket(file);
> >> +       sock = tun_get_socket(f.file);
> >>         if (!IS_ERR(sock))
> >>                 return sock;
> >> -       sock = tap_get_socket(file);
> >> +       sock = tap_get_socket(f.file);
> >>         if (IS_ERR(sock))
> >> -               fput(file);
> >> +               fdput(f);
> >>         return sock;
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
> fdget requires an integer type file descriptor as its parameter, 
> and fget requires a pointer to the file structure as its parameter.

In which kernel?

include/linux/file.h:extern struct file *fget(unsigned int fd);


> By using the fdget function, the socket object, can be quickly 
> obtained from the process's file descriptor table without 
> the need to obtain the file descriptor first before passing it 
> as a parameter to the fget function. This reduces unnecessary 
> operations, improves system efficiency and performance.
> 
> Best Regards
> Ye

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
