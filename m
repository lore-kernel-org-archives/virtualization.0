Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEDEE7E633
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 13:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98B224018A;
	Tue, 26 Sep 2023 13:10:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98B224018A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGRj70Lk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EWlHTsBXxM4M; Tue, 26 Sep 2023 13:10:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7CA44015F;
	Tue, 26 Sep 2023 13:10:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7CA44015F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD16C0071;
	Tue, 26 Sep 2023 13:10:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E9E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A24F813F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A24F813F9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGRj70Lk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzjbujtNrF_t
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:10:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 499D08213D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:10:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 499D08213D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695733830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
 b=NGRj70LkD0MMjgiHDYGjLXrP3Ob3DD4gxhD48/ghqOtA+Ddhkvx+LdVeMirh9jM1LCZQnA
 fiTcYaoYz1UhuRDLTRZERMKkXWGG4lTIgTjEtGlMAhHbuLU5XTOtROGyeR7P7zEmNEdhuM
 yNVoObEm3E9cmBkq1/p0X5zPqPuSjfg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Jj_jyr_GNQOZ7CbJuD3iUQ-1; Tue, 26 Sep 2023 09:10:28 -0400
X-MC-Unique: Jj_jyr_GNQOZ7CbJuD3iUQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so482981366b.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 06:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695733827; x=1696338627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53RN2iEKcF7cesjBINs3uKbZmoYEjMUrrV2QK4YxQVs=;
 b=AMg9a2+R6Ihc8IEDm2mjUAUxzjqfNkVsNFZ0cAxaTfR03pAlZv+rX6ntWDIcaZU6DY
 cVkDz8UzXnyarC2a+f+RxF1yno1WNWKlFZkyg30W/kf7rvkd2gVmkVtBmCn0qrsIYwUe
 4xrLQyw8x635MsNC3tUmTaaXRHPDfd71EZXwNOVwUYejO6fYq4KgvvLNFdDJYntJlhme
 0b7lmyuxfxRgyYrM7YUzZX79Yc04/RiGg8NQ+SfGxinNrzVFfIuwFLObm5+1hbo/R5jB
 EBpqw6CZRt7qds4AC0h+CL8ZFeswGIc+UpN8+1v7nI1KHpUWDv1OgrXOyRwv5+QxmmFv
 qZVA==
X-Gm-Message-State: AOJu0YydYfu9jUCXXwAeZumTz3LKE4ffv+HMqnuPajmyYL+nHvbK/utV
 BkR1IPl8rqpBsEvwJeO62aAkihFCL8PJ0G5wOk1KeuyWsCOV/63cS7ngoD1HMV5W3g1c7yxGwDt
 ievRJaliY0QPyJeUW0cxhJ+rRBUYy0sb4tZzKTUxVPA==
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id
 hp11-20020a1709073e0b00b009ae5a56be32mr4084901ejc.38.1695733827489; 
 Tue, 26 Sep 2023 06:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhr8aocGYblGQIkanfvgdcYkJGgnxjzR7Ndhh5heLB5k61gMBi2Cpl5HUKWX7e6D9TEIPTRA==
X-Received: by 2002:a17:907:3e0b:b0:9ae:5a56:be32 with SMTP id
 hp11-20020a1709073e0b00b009ae5a56be32mr4084743ejc.38.1695733825833; 
 Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a17090634ca00b00997e00e78e6sm7780777ejb.112.2023.09.26.06.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 06:10:25 -0700 (PDT)
Date: Tue, 26 Sep 2023 15:10:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 00/12] vsock/virtio: continue MSG_ZEROCOPY
 support
Message-ID: <zurqqucjbdnyxub6u7ya5gzt2nxgrgp4ggvz76smljqzfi6qzb@lr6ojra35bab>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Arseniy,

On Fri, Sep 22, 2023 at 08:24:16AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset contains second and third parts of another big patchset
>for MSG_ZEROCOPY flag support:
>https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
>
>During review of this series, Stefano Garzarella <sgarzare@redhat.com>
>suggested to split it for three parts to simplify review and merging:
>
>1) virtio and vhost updates (for fragged skbs) (merged to net-next, see
>   link below)
>2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>   tx completions) and update for Documentation/. <-- this patchset
>3) Updates for tests and utils. <-- this patchset
>
>Part 1) was merged:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7
>
>Head for this patchset is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=71b263e79370348349553ecdf46f4a69eb436dc7

Thanks for the series.
I did a quick review highlighting some things that need to be changed.

Overall, the series seems to be in good shape. The tests went well.

In the next few days I'll see if I can get a better look at the larger 
patches like the tests, or I'll check in the next version.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
