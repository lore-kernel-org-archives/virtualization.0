Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495322EBDE0
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342931; cv=none; b=kNjjBYFVE0KEBBdR5AxmMRDKlvXi8wPAkjl5zJhjRG1wT0bA9iTpNTZtzZKricxdhriBKJy6SqG3w5wM7ZGN80HZwEfQwzDm5Mfa9yxItCzhwJFIW1D9s3bFzaMOuni3qPVaPcL6x+u3sru9R8SHtVe3WrvKH/xV09p9sh8DpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342931; c=relaxed/simple;
	bh=vVOvsg1+Ti0HxFSL4nhVXqF1CMG723QAbuq/zowP2JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ozfdPAkMwl7oGQvjWv7RrlGj8ARXIF+4OTS7QTbW5C3EdbTbkp796/vPUg1Tk9kwmKQ6mqaW0gM7jmQ1GUpOP5rb/LG8HmSrmh+BQKP9DAtmWjaQxRAnGOYyQUk/TO4oKzsRgmi3CQj2kFd3IxCNP37eRetreaIBq51j8LsEt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeR1TYR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeR1TYR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eWL4DN3XThSL1fpZ1rH690hipW9N7vRijRVW6Y3Oig=;
	b=ZeR1TYR+DKfFzCmCOYMFwA1EodLN3uviyxHKRFN2kIcZ4r4Fn72a/4X4oSM0ry+gwF24fA
	1jSfrAvDug2lav0ohBaIufMqz/YOJ2tY3KetYCR6tJLh20NzVS9XxBmnlVs/zE6bxKCxrk
	wAPR8Ix4oaF8bfZ7iwc9WZxAnPgefWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-H-upFOs8PH6l1AyCo4zUgg-1; Mon, 13 Oct 2025 04:08:45 -0400
X-MC-Unique: H-upFOs8PH6l1AyCo4zUgg-1
X-Mimecast-MFC-AGG-ID: H-upFOs8PH6l1AyCo4zUgg_1760342925
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-41066f050a4so2567250f8f.1
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 01:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342925; x=1760947725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eWL4DN3XThSL1fpZ1rH690hipW9N7vRijRVW6Y3Oig=;
        b=dlC1d8ziSJEa0J5n93WBuNirPpmPtSTlMZ0PDP/J1e23KUnkfdjfvxhEAgzrPWSgwt
         HECHfNWrbAJJlstQ0G2U51CwEHcpZu7Pk0I/x6P4tUTC89Ae0WoaXmohCOlE5lFWDRzs
         qTpENAnbGMia9aBG0Vs+S5SW19PvfvVirCRdJJS90az8tLXVNk96RTeBxtwn/myd5uW5
         o2mCx72lnTcMTdis/f5XhzxmilSNJdYNIxSOVBbOVuNuBs1fir+L4rct8a3WqhSvPzXZ
         qy6mZXXNaozxFLmM0Ta0l13MiijiOjYUj53Wdv/+A5tq1X8gDWVXXViIHcrnwH0zQmrQ
         v06w==
X-Forwarded-Encrypted: i=1; AJvYcCWBJbErV9JzYdC94isMly8thF4nCSb/SyieFXmCD+RIgqGwMScN9EaoJBio3qlpS9LbyWQ9frFgBRsKBb1Rjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzx/v6zyeeMyF09X9nK9lho45RTQFSmGl0wrwQbjKlVZHjcTS6
	EzFUmIFtdUmQGEVIZLiUzo/3SqGgbmTrYjHAkfJGp3kPrExA2JDhsRxRNBXa8moyRuLGZ3BIIdM
	EQdQtsV8QFCd9zIOKrJ6Qb+aGD8Er0cBFWXzk63kV/clqOM8iJvGPJfod9QRvb12l6xgj
X-Gm-Gg: ASbGnctrb6LWAh6KzlDVUxQ52XIA3EuoG+tp6iXgc9OuBluCFRzqf+EXh29IKhSp1qi
	X7fMseq4c2kLvL4qyTgfGgOaqTmeUcGb2OuGnQXw8x/RaBOFnFw8utWO7k2txYHICIBWfEBL8ue
	Ruou07i0L5Z2EOKrooCb9utBjiZ0NAdS2oz3kgzuv423o7zlknOYpRDmD+h/q7ZMT/8mAsu96JG
	+FsmiKoqqiF5FS+1AsjehBll5YS40v44SO0xnXHnZmdC/OOw0UMNTYPuehBLybLF5w4ojoTYb5s
	pxMWdd348nbYMqQvdmwhJRtbxDnexA==
X-Received: by 2002:a5d:5f86:0:b0:426:d5de:e454 with SMTP id ffacd0b85a97d-426d5dee4d1mr4608120f8f.31.1760342924565;
        Mon, 13 Oct 2025 01:08:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtNpEAunbxp8ulrBXh0wStzwV4F/kXgVIxSO9DL5r5BrnXcg7l1GKUUVmPOZKzozmdGRj6yA==
X-Received: by 2002:a5d:5f86:0:b0:426:d5de:e454 with SMTP id ffacd0b85a97d-426d5dee4d1mr4608094f8f.31.1760342924147;
        Mon, 13 Oct 2025 01:08:44 -0700 (PDT)
Received: from redhat.com ([31.187.78.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cce5sm17291452f8f.1.2025.10.13.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:08:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:08:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>,
	eperezma@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
Message-ID: <20251013040810-mutt-send-email-mst@kernel.org>
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjrPEBOt7QeCLmc__Db0f-XhJlGgnb6pr7y3bxZk2VM_1760342925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> On 10/13/25 9:20 AM, Jason Wang wrote:
> > On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
> >> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> #syz test
> >>>
> >>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
> >>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> >>
> >> Paolo, it looks like the GSO tunnel features will leave uninitialized
> >> vnet header field which trigger KMSAN warning.
> >>
> >> Please have a look at the patch (which has been tested by syzbot) or
> >> propose another one.
> > 
> > Forget the attachment.
> 
> I have a few questions. The report mentions both UaF and uninit; the
> patch addresses "just" the uninit access. It's not clear to me if and
> how the UaF is addressed, and why/if it's related to the uninit access.


I'd like to understand that, too.

> Do you know better?
> 
> It looks like the uninit root cause is on "the other side"? i.e. the
> device not initializing properly the header. Would unconditionally
> clearing the hash info implicitly disable such feature?
> 
> The syzbot dashboard mentions a (no more available) reproducer. Do you
> have it cached somewhere?
> 
> Thanks,
> 
> Paolo

