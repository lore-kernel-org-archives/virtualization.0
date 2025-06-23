Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945C2036FA
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666038; cv=none; b=Fdm2lLHc/+fd5GPSvE3avbJvsiW1RYRNIMnjEaXSe2CXK1yMJ4WWfQ1TxeRc7KYzlV+KwrC2H1vndGoDJThDmiwETyQ52FOgfK8bVfFHy1Z9nvtMmhaLVLFEx+9ablsifLTjI7I28brzUPVraUL4FDjgkDG6b6tW7Atf0bHxnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666038; c=relaxed/simple;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bf0zBmdQd/QVaEoCy+0AiY7yGn5bwUcO22GaUThhme+i0wsOzfMIUWiVqeeAUhL9hW9FXuL/peYarGrs9sHrrnHMgP/LXexd5s+tR6InjkTY43GegALv5BDjrUoIs386rFQvyVG8XkwzRg7ouhFMHQTQdzsB0PO8/9HFF3kdNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcY2WHNS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcY2WHNS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14C22400BB
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bPnvZ7XCHnis for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 08:07:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3FCD1400A2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FCD1400A2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RcY2WHNS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FCD1400A2
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750666034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
	b=RcY2WHNSiDo2HhsIMDVKPuNauhTHbM7AfvkR9kZSo1acGTzV7E1vYVK4plGfaIjYx7FjUA
	Oze7uAKV5iSAHbw245SjNI01o3V4J2xUiHB3Zcf8ufXatk4zWlSkhufhkiiLDDzZ3q3TmI
	wr1k709bcP8Wp2V9t3p6MumAa4tJemw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-oZ1yXNDQNPWBY_hDzEfuQg-1; Mon, 23 Jun 2025 04:07:13 -0400
X-MC-Unique: oZ1yXNDQNPWBY_hDzEfuQg-1
X-Mimecast-MFC-AGG-ID: oZ1yXNDQNPWBY_hDzEfuQg_1750666032
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31366819969so3640583a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 01:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666032; x=1751270832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhmcYeHsQsigeZcrHk+M4JmzBnlMYZpMRTtb2dRaBIo=;
        b=IuOSCZJHVcst3W/Rd88DNj5RJA6Bgk1+qIwxCYSv+v4kB0ZNGwYVYMPhUGG06Ep40D
         1FMCA9iC8/fhC3PNxYJNDcawGj4XmlV0Ug57foOo4P8/7C1Hpy0SxdpEz5REngy52CMj
         +LugpGIWmoy3sYby08M5AbFeb6xqrCxaxzbdAdqrksCR9ZmoQao/20CrR3xLpuwy1W8F
         KtkD0fAzpiXM/fN19OeIFnUBziK+oQU5wO94RgDMSEXRjGlUxZcRzesCIl0G80HEHmD+
         A3G3JAOOlLmltY6hToDRuhlWj/qtqnv1T8bgQR53Gw9wHk+KvJ7EMnyA2rRPq+KpbOTm
         CaxA==
X-Forwarded-Encrypted: i=1; AJvYcCWVwimRro/L6/GVUI0yIoZIiLhyGkWR1FTl/paMN9YdwkhsFh09juNctbak5VSHO52isl7KbBwjrV4cXf7cEQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyN9p29SbQwnyb3sXJVTIuCnP5hGD97d073FroAOqMuLFPqmr5F
	eTrtU6eCWlP47BhoTnXyCWmHoXOHULvxxEn0E065qIljpXdsUjWQ9qGz6wzXaVQNjU0NbX/biHk
	z5wdhWbQd/o0970jn6/DftdoQHK8uB+SPQiUP6Inug7CwGi1Iv9MEL74k98VQ02s3/KtZM0XALw
	zx96uUi2M/xzMUl/e8wPKWEg4wbyGK5XhsDpdmQA88XRxKEmI9lDUOS4qihA==
X-Gm-Gg: ASbGncuhQhy2j4KTID/cYX6KByrZnydu3PP7JU5Qvpwxq4Dt2ydMvl5X3bzkOFKNpRu
	tpY/M2MfT6F896a/7BLUSo61h8nYeBybgwkqXeJUUfA5+l1mPNluHSDQ3x5Qh0fEpF+oWWpHM7D
	Os3Izw
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id 98e67ed59e1d1-3159d628b59mr18126488a91.4.1750666031652;
        Mon, 23 Jun 2025 01:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVQTOppEHtAfsayyJvo34GLVedX6rLC/x06Rbxlu1q0T6P50V9CQroeozuTXZMW8lnTkCwwxrOBTsZCaXXqkM=
X-Received: by 2002:a17:90b:5444:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-3159d628b59mr18126445a91.4.1750666031289; Mon, 23 Jun 2025
 01:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
In-Reply-To: <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Jun 2025 16:07:00 +0800
X-Gm-Features: AX0GCFtKGLSh9bwOyNMqm1wsTSYXIq66dXiloWDLmA7vjP1FAzXUnFKbCzTNLUI
Message-ID: <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9tC2iM5WsHkJ5AX2Fc_wg8Jpppqvug0DRLFMdlb4KI8_1750666032
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> > Yuri, can you help to clarify this?
>
> I see here several questions:
> 1. Whether it is ok for the device not to indicate support for XXX_EX has=
h type?
> - I think, yes (strictly speaking, it was better to test that before
> submitting the patches )
> 2. Is it possible that the guest will enable some XXX_EX hash type if
> the device does not indicate that it is supported?
> - No (I think this is part of the spec)

There's another question, is the device allowed to fallback to
VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?

> 3. What to do if we migrate between systems with different
> capabilities of hash support/reporting/whatever
> - IMO, at this moment such case should be excluded and only mechanism
> we have for that is the compatible machine version
> - in some future the change of device capabilities can be communicated
> to the driver and _probably_ the driver might be able to communicate
> the change of device capabilities to the OS

Are you suggesting implementing all hash types? Note that Akihiko
raises the issue that in the actual implementation there should be a
limitation of the maximum number of options. If such a limitation is
different between src and dst, the difference could be noticed by the
guest.

> 4. Does it make sense to have fine configuration of hash types mask
> via command-line?
> - IMO, no. This would require the user to have too much knowledge
> about RSS internals
>
> Please let me know if I missed something.
>

Thanks

