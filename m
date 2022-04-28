Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9287DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 05:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46570812E0;
	Thu, 28 Apr 2022 05:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohEh_oqOyhS0; Thu, 28 Apr 2022 05:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00D08812DB;
	Thu, 28 Apr 2022 05:52:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98B3BC0032;
	Thu, 28 Apr 2022 05:52:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE32C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 048E74026E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z16Vz-cjY7d3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:52:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A86644025B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651125134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VG8xe0Lj4eTE8PBjFl2duBm+bHnWsA2hI9mqEPY5x1M=;
 b=hbROdJuK/dex2novTUjm+kgshKmg/9kOoJmD/rQRVX3nFdNDxS1sMt0hMC16xd+IWfhQSG
 3GLz57tsR/iN5YmsrtqhksftUXVCAD2Q7mRiDPHV734Gza/CldW/kpOmEHzRq9lnJdMwo2
 UU8HaNpYqXeT6aIB6MMy0JuayR29EVs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-lpDxbzetOjSoHOBwn3YKxQ-1; Thu, 28 Apr 2022 01:52:12 -0400
X-MC-Unique: lpDxbzetOjSoHOBwn3YKxQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 bp36-20020a05651215a400b004722f090903so1367679lfb.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 22:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VG8xe0Lj4eTE8PBjFl2duBm+bHnWsA2hI9mqEPY5x1M=;
 b=l85hcEG5SAN4Ti43p6kppK3HVjILYLkeumtSuIW+6Pq2DvaxdOGqJmuu2Pw1tTc3dR
 E/T3bHlfhSbdxpY/n8IkV0sHmanO1LxsXvwVaTHvxET+9uuEeIDVIGU9BrJIuZ/93slo
 544XQe+w4k3biC6R6hVMGmQqnA8RGUWMqhaJU+wVr0oPaIuuusByplL3rc1D5cTOF55I
 34ZR+BluFmiAG7SpQCXCDBUZDY45hX3n24STcOqu5XEARc16BNze3P+XP14x4k5V8qkX
 6M1PGk1y6RvBetRN4Q8CI2KiwenEWDPQJbIiTFVq3SliuekdWRLzeuczwSOo3MQ87dRu
 KeDw==
X-Gm-Message-State: AOAM5315LQOGsbybbxDrquc2Oa36HwOz8DnlfD5dtLN/Mz6GdV7epiFa
 JaSqyIwlHB584E/hTgUltLnPToHfRGTQeqrdCfZCLxa+fD7feEVU9ZhYhKgsTqRHIhBOZ5Seyfl
 DS6A1U6t/MZPNxnvCY7Og2+epj7gLgTsRmembaA815HTJ85MiI5ezov0lXg==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr22834529lfv.257.1651125130907; 
 Wed, 27 Apr 2022 22:52:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ1RzrfWfSkhGClXkO34qKBaipySKvQusBGIxeNu+GZHGD2TZarCmX1ullRo8BzpxyDgwoENa2ajgmtrv0F3g=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr22834515lfv.257.1651125130719; Wed, 27
 Apr 2022 22:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com> <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428012156-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 13:51:59 +0800
Message-ID: <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > But my guess is that rwlock + some testing for the legacy indicator case
> > > just to double check if there is a heavy regression despite of our
> > > expectations to see none should do the trick.
> >
> > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > at worst case it will cause cache line bouncing. But I wonder if it's
> > noticeable (anyhow it has been used for airq).
> >
> > Thanks
>
> Which existing rwlock does airq use right now? Can we take it to sync?

It's the rwlock in airq_info, it has already been used in this patch.

                write_lock(&info->lock);
                write_unlock(&info->lock);

But the problem is, it looks to me there could be a case that airq is
not used, (virtio_ccw_int_hander()). That's why the patch use a
spinlock, it could be optimized with using a rwlock as well.

Thanks

>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
