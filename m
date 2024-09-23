Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A623AD
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054199; cv=none; b=rAZMwGwr0QmMfMV0QOINdLzQPLwyG2/YTcNhABmos6kOAk05VOQwm4iRu5LhYUVE0qQ5J4Lx/V6LUx4G0yr9J0sfHa6zGU02Stf6za2URvDtzDw49NbR1EETOW3inNsSsaDfi9DNoEamtZJOlX6qcrATawha3lS/odkxBZf/x3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054199; c=relaxed/simple;
	bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIqE1M2pD9oSSNmdnV547rtx3+ZHrijJszUnViKqnV0pXf75XVtlnk+YbNw/e7elKipRNk5WjOKqFAg1Y8G+EYEfGxP/UB/F6rCEaVLfoMjBFJDWEtYsdjj0lLv6BdxqiclYfjVXKJeQzno/COQkIoB4ofH83y3xHfYBetzVZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlvSAj0l; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlvSAj0l"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D327404D0
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 01:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 98hlWolNouwW for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Sep 2024 01:16:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 03291404CE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03291404CE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HlvSAj0l
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03291404CE
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 01:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727054193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
	b=HlvSAj0lNISkkNEVtbE/zcqaU4cPW3zClfcSOzxqrJ3crTLf/hfBlThSv/R2EIsr7kP7A9
	h6Wlk/bpSgAi3Kf+S6YG1OdQZSJBo6RPO7haLN0vlCBwfQDi7f6/lyxIwjh9YIofZwmAWM
	KEy06WUZJhDQGgx1dQvPMGG8gj/n5e8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-8gneBlBiMRKDD3hpcJWQZg-1; Sun, 22 Sep 2024 21:16:32 -0400
X-MC-Unique: 8gneBlBiMRKDD3hpcJWQZg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c44684d214so2414566a12.3
        for <virtualization@lists.linux-foundation.org>; Sun, 22 Sep 2024 18:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054191; x=1727658991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGlFEwneXtdHCSd6YUaSS9Rs+Ie1kHnFGRiAH9QblTQ=;
        b=UofS/0LnKnFwNG2ZmMwhAVikoJupmL/czuRqHZURhNKiK4BwIUJGzVI3IQM6Sb2iG8
         vRUCAVVzOeYCVzPEFNIVw16FDOUssT4YwEw+6WOYQhzZ4o+dShslRYr6kVtK3XAKUfhQ
         zKeAane5EdItBtYyKW/xE6CxcWmxYYppBgdQmP/By4rqTsNME1erlTrW3QOhAwAR+hrS
         J8MUW1hZgabu8hYdue7fxIaMWYFXfInAvrD8PsGfRLUyhVumdV+6p4mBEpoOZJxyOO4b
         5otd1Nzpw8q/0xwN15sUoNUGNZ9kgGqlfsXhSLPCGGYyNiwggEMiPvZ03uzWwz3qHMhv
         /s7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9jWfQH+3xJeYWIVRk4ECSn2WPLJ1CNIZX1eSdgGPcJzL0oyOIdpyPJBNnzM62cTOAJf4EjujZXao0aH1jRw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxw5GwQmNadhuGHPs6mQMYrtNkySgh40OmT5j0be3YDYHTrbNBj
	s5K6eNofgrB8WZrPTs+FK6/3Bx+HgjAi/qZzA6hx1b0b6LLcNaSUDUzEXqLOnFz22WyYpk+h8Y8
	3EYzZimzn2J/yR5LF6mSfRs84UOBjtRCSZ5TWjh/ZdKp4hVn9jj1AOrVOWagweleijAwWU/8sEt
	EwLbHYbO98Z/ex7yv744IM08ZWDrZ9L+zwjInzRkyCs4zOb8rRv0saLg==
X-Received: by 2002:a17:907:3daa:b0:a8a:6e20:761e with SMTP id a640c23a62f3a-a90d512796cmr914370266b.48.1727054191249;
        Sun, 22 Sep 2024 18:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLLV6DDO/qImWlmUkG7cp+y/TF1dZ2NGr2SXwRJp/tFhd3JDdFBV4oXjYWMZYgf3yJhQ5jZKJEo1GY6mfRngM=
X-Received: by 2002:a17:907:3daa:b0:a8a:6e20:761e with SMTP id
 a640c23a62f3a-a90d512796cmr914369266b.48.1727054190879; Sun, 22 Sep 2024
 18:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
 <20240910044139-mutt-send-email-mst@kernel.org> <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
 <94c76200-05b2-4142-a637-bf2115827116@oracle.com> <CACGkMEvAR_2j=PdKZZyAZ1yK7H5OO+Ldc0Eygwyo8rMR=_uGBQ@mail.gmail.com>
In-Reply-To: <CACGkMEvAR_2j=PdKZZyAZ1yK7H5OO+Ldc0Eygwyo8rMR=_uGBQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 23 Sep 2024 09:15:53 +0800
Message-ID: <CACLfguWXFOJK=YGZ1=bKYWEKp5_=mk3wVKbq_LSAzMGu1vODkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: Jason Wang <jasowang@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sept 2024 at 10:11, Jason Wang <jasowang@redhat.com> wrote:
>
>
>
> On Thu, Sep 12, 2024 at 12:17=E2=80=AFAM Mike Christie <michael.christie@=
oracle.com> wrote:
>>
>> On 9/10/24 10:45 PM, Jason Wang wrote:
>> >>> It depends on how we define "secure". There's plenty of users of
>> >>> kthread and if I was not wrong, mike may still need to fix some bugs=
.
>> >>>
>> >>
>> >> which bugs?
>> >
>> > https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracl=
e.com/T/
>>
>> The SIGKILL issue in that specific email is fixed. The patches are
>> merged upstream. I don't know of any other bugs like that (crashes,
>> hangs, etc).
>
>
> Ah, ok. Good to know that.
>
>>
>> There is the one we can't reproduce so are not sure if
>> it's the vhost changes.
>>
>>
>> There is the change in behavior type of bug we discussed in that
>> thread:
>>
>> https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.=
com/T/#m026f7dd96e064e3a604155e45e7ae9d5c949ae23
>
>
> Yes.
>
> Thanks
Thank you, Michael and Jason. I will continue to work on this
Thanks
cindy

