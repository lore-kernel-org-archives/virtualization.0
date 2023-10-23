Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC831C001E0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 15:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40EF841F57;
	Mon, 23 Oct 2023 15:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40EF841F57
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R6J8Dgg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMMNc2KpRXsw; Mon, 23 Oct 2023 15:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8DDBB41F1F;
	Mon, 23 Oct 2023 15:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DDBB41F1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57C47C0039;
	Mon, 23 Oct 2023 15:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A8F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29111822E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29111822E1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=R6J8Dgg6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDNqcl1fIZbD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:13:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75E86821F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 15:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75E86821F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698074006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63ahJT05F/ZrGQ5TMqsUAmjRR9M+pviQlbczcdS3kqc=;
 b=R6J8Dgg63Y9NkBQFUQ+dRO3xVV2zFEw5OC37V1U43njG+ncFUDp/eYodpYOXCp5bNgZOwQ
 TTgSpKu6UBydpDeq7DzbO33IItiGzp2M4MmhS2u0yTu8o/Ujv+rYFl9FPyPi/75BwWiPXu
 o/E7aF1Ci9QRElXr0hRV6xQpMAEzoBo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-QT1ySEAxN9CBL2rOsiPZsQ-1; Mon, 23 Oct 2023 11:13:24 -0400
X-MC-Unique: QT1ySEAxN9CBL2rOsiPZsQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778964b7c8bso451976885a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698074004; x=1698678804;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63ahJT05F/ZrGQ5TMqsUAmjRR9M+pviQlbczcdS3kqc=;
 b=vP5jjOVl+NsMggrSUtSODNoBg044qq7lDI4vry679AfIBefk6l5OVykYhcKO/2/TeE
 H9K1Dkfk6Tc+cmrPjiNKtSa3ZHNSifib7WTH6hE7gVFUU2Al4e5vyECRX2DE+mZaX/07
 GYJEDcdnXUY52qG8zEcvRlDJxq7FEjz5EzB5Q6JGlNmX9/XYij2OQAlKBMj+MTdsq7qi
 M6vRp1Ssf87AUe/LWmSnafRAl9r55RFIPFAdKLsy4f0zz3/YPeWS2Sns/vOhGEcZM7fB
 Bv4tJw0sVbxQqUcDLYorn2mo9qhnhpjFyLhlEz9qn10iRnL0/7MxGi0YB4zRn/QpXOsC
 xFcQ==
X-Gm-Message-State: AOJu0YyhzzdRgOLdPMRsBut28r+HvPa8Ku9FBtHFzb6K6IZOVsTKTWzD
 S3FjPap6nwD2XpAbggPw7AQlee0WVS9iVWAi8QBVUzXn4vy+ofvkqIhT5X94ZzxYiYmpcZpXyxB
 CJ0nQTGLYFoPOYCCL6y+FGHohCWMlTu5+R4yVys8upA==
X-Received: by 2002:a0c:df92:0:b0:66d:38e3:4ffd with SMTP id
 w18-20020a0cdf92000000b0066d38e34ffdmr9704299qvl.5.1698074004155; 
 Mon, 23 Oct 2023 08:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw5D/o5lkfr0V2xwj4iuqyXgrqpujFSbZWbAX/eMHBKn/lQ9LUbBZ9xVTrW6OSbaPfZVQ9iw==
X-Received: by 2002:a0c:df92:0:b0:66d:38e3:4ffd with SMTP id
 w18-20020a0cdf92000000b0066d38e34ffdmr9704288qvl.5.1698074003872; 
 Mon, 23 Oct 2023 08:13:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 ml14-20020a056214584e00b0066d04196c3dsm2939797qvb.49.2023.10.23.08.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:13:23 -0700 (PDT)
Date: Mon, 23 Oct 2023 17:13:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <dynlbzmgtr35byn5etbar33ufhweii6gk2pct5wpqxpqubchce@cltop4aar7r6>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
 <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
 <0624137c-85cf-4086-8256-af2b8405f434@uipath.com>
 <632465d0-e04c-4e10-abb9-a740d6e3dc30@uipath.com>
MIME-Version: 1.0
In-Reply-To: <632465d0-e04c-4e10-abb9-a740d6e3dc30@uipath.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Viorel Canja <viorel.canja@uipath.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mihai Petrisor <mihai.petrisor@uipath.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

On Mon, Oct 23, 2023 at 05:59:45PM +0300, Alexandru Matei wrote:
>On 10/23/2023 5:52 PM, Alexandru Matei wrote:
>> On 10/23/2023 5:29 PM, Stefano Garzarella wrote:
>>> On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>>>> Once VQs are filled with empty buffers and we kick the host,
>>>> it can send connection requests.=A0 If 'the_virtio_vsock' is not
>>>> initialized before, replies are silently dropped and do not reach the =
host.
>>>>
>>>> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on=
 the_virtio_vsock")
>>>> Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>>>> ---
>>>> v2:
>>>> - split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>>>> =A0the_virtio_vsock initialization after vqs_init
>>>>
>>>> net/vmw_vsock/virtio_transport.c | 9 +++++++--
>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_t=
ransport.c
>>>> index e95df847176b..92738d1697c1 100644
>>>> --- a/net/vmw_vsock/virtio_transport.c
>>>> +++ b/net/vmw_vsock/virtio_transport.c
>>>> @@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vs=
ock *vsock)
>>>> =A0=A0=A0=A0vsock->tx_run =3D true;
>>>> =A0=A0=A0=A0mutex_unlock(&vsock->tx_lock);
>>>>
>>>> +=A0=A0=A0 return 0;
>>>> +}
>>>> +
>>>> +static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>>>
>>> What about renaming this function in virtio_vsock_vqs_start() and move =
also the setting of `tx_run` here?
>>
>> It works but in this case we also need to move rcu_assign_pointer in vir=
tio_vsock_vqs_start(),
>> the assignment needs to be right after setting tx_run to true and before=
 filling the VQs.

Why?

If `rx_run` is false, we shouldn't need to send replies to the host =

IIUC.

If we need this instead, please add a comment in the code, but also in =

the commit, because it's not clear why.

>>
>
>And if we move rcu_assign_pointer then there is no need to split the funct=
ion in two,
>We can move rcu_assign_pointer() directly inside virtio_vsock_vqs_init() a=
fter setting tx_run.

Yep, this could be another option, but we need to change the name of =

that function in this case.

Stefano

>
>>>
>>> Thanks,
>>> Stefano
>>>
>>>> +{
>>>> =A0=A0=A0=A0mutex_lock(&vsock->rx_lock);
>>>> =A0=A0=A0=A0virtio_vsock_rx_fill(vsock);
>>>> =A0=A0=A0=A0vsock->rx_run =3D true;
>>>> @@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vso=
ck *vsock)
>>>> =A0=A0=A0=A0virtio_vsock_event_fill(vsock);
>>>> =A0=A0=A0=A0vsock->event_run =3D true;
>>>> =A0=A0=A0=A0mutex_unlock(&vsock->event_lock);
>>>> -
>>>> -=A0=A0=A0 return 0;
>>>> }
>>>>
>>>> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>> @@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device=
 *vdev)
>>>> =A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>
>>>> =A0=A0=A0=A0rcu_assign_pointer(the_virtio_vsock, vsock);
>>>> +=A0=A0=A0 virtio_vsock_vqs_fill(vsock);
>>>>
>>>> =A0=A0=A0=A0mutex_unlock(&the_virtio_vsock_mutex);
>>>>
>>>> @@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_devi=
ce *vdev)
>>>> =A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>
>>>> =A0=A0=A0=A0rcu_assign_pointer(the_virtio_vsock, vsock);
>>>> +=A0=A0=A0 virtio_vsock_vqs_fill(vsock);
>>>>
>>>> out:
>>>> =A0=A0=A0=A0mutex_unlock(&the_virtio_vsock_mutex);
>>>> --=A0
>>>> 2.34.1
>>>>
>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
