Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA84229CB
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338914; cv=pass; b=F70CMMV9sHCwOgRcmi1oJTjLAfq3s6yr2XnHTWxWUmhBt+93qudf4ZcaeWU7A9/Pr7Y3Wg0G9Hfe+JnG4hFxq4sET32Ku1EbKhjR2zUQ23hh8MzxwQmTV6eYxBCHmiWQnl8xAs2Xav9XpuAH2TGsyOLJWZ+ecCmChdBJFZTWJwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338914; c=relaxed/simple;
	bh=oELiRmArb5ClQEoFheQBb03GBeALw9I3nDP+vOH+JTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLOBTLx4Vjpq2fKKk/B1pnAlzzwqgTrcopKGmpczOz1IDurwcuXNeOn3QWAPh8ShgMrgspM4tAGsG4eV5ah9qlNj63WqEXkZL3LMVW3QRKpso9kjg9xOVkFs6lpbeIuinlUhEKHXr/vd2QThd3ONPrvkK79R+60Kfu+ZWlKQi6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RxoD8WZs; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxoD8WZs"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cf70de986so938129fac.0
        for <virtualization@lists.linux.dev>; Mon, 06 Jul 2026 04:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783338912; cv=none;
        d=google.com; s=arc-20260327;
        b=QDUyJacsqaQaqC/IThJvMOZ2y6q38pF5LBhNFmOtJs/fong3W6auv4ifkzvztbtik6
         FhTwhEm7gE+1oUMfgjJnI+hnqKzy+p+R/u4QIejyfpF046OyXmCL/rQHhKiEJFYa5RtN
         GiZ+DQDEOyD6N8nTRtkzyb4j1tEF6rETxRMeeHjeMeJvejd13Y6SuITgpyGu0+ENmlVH
         2jdgioacY5ymPO/QYr9zNbPDZ7g//9VJB3ZkmbKUsXJT1okHweoxgT47dGU43ecEVtkG
         EM1/GZEM/ng+d1GCAMCZN5/dWjDlzR9IGlLgUxgFnLF1ttIoAFefe6du6TVmRp1kZGvG
         CvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        fh=4exaSM2OEufWQkeicvEHR+6UTHzcap1/TPB5jHXu6yE=;
        b=BNVu8RufilisMDsD63ukSCzyA6Vi6Xm/iXGWAEHFRlYAim77gGdj2xX2ZXkBOB69/B
         Zi4WWQAxccJcr+IOor5YjmxIEPJD2n6rECPQCS94AyYvv4Qnv6NN4fjyfzel6I5W/947
         VYlZue6hD/Tvai2U28qFxaqA9eOCusrF4XuQhMqIGmgVnWVjmbOx7ELsTFgZ6thEg1pw
         c9z6npLVaEPjCDoaQ9hrBxUGKDaeRhlxRWiMKX5/Dgq1YdQqaoBoh+6esjAW29cQ3Vjn
         cjJFxtKQRsOm1WCTFFg2HlEw0c3cwbk1Lq6XZYeX1dgxyEzoR5etqGlAp38/xblPSBph
         f+dA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783338912; x=1783943712; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=RxoD8WZsO8HmIlbRu6HwvjylFuwM3YodI2R2TkXIW/WkULkVSfwVFwZ6P0D0e+zV1g
         mE78l7b4uM4R0enGafQ6jLUvz9MqPTBYNch7UBb0lIb2QOm2h7LOl6BXvhRXePLEOnAr
         K2dQ+pMkpo7BkOPcp7cCPDVrtgFEVIrbQ1UckzS0Z2DnG5xoicNQfYg9RR+kUH6A4EIu
         8ojvMG9ZSu71onOw8+zZno5sUCGD51pQoE338b0XI5MXWLaQEL4CubQQv8HNR9xqluOw
         Jhm0fSEFqdtoCmdwQCxHP8PhcQZP2j6Ppq1uP0NVGTR5/bUAZI45hQmR22eTR4xsbVUV
         NODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338912; x=1783943712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IUJO7hHDOl/XD/w+GraDDTln5F69OzxpzwVyfa1liE=;
        b=c1zIcKvxv13LmOrWxeCeEbYZARZYYDZkcR3okOi/waxThZtBmKTgjTD7jCv1t6LYuD
         HQrXwj1UffANkzFUDNXc5gZs8pAKeR+EIKgEDEpoxkQ2adK3ZmuX/W9WEv15zWvxZyuJ
         Y5gjjdjsMzw7PkqUHL8MQiV2pAOOM1tXv69ITqMFnrIee2XQuvuhULyKNEqsH1uqq8Sg
         9pdmYbsPTtJ774pDFIirFzNcnZmpOrgSmWMH1PhUmKJs4eDieH/O3TvWZ6RfA3WOmlaz
         TNyCZ0LPDgGshZ6PjZh94bGZgG93PLlWR9+0spAvQL8dkXwVaKd+poJBlM0p7g/jiLOS
         C7yQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMZxUkHDrvRP2IU4NMIulguY6kOJW5f/lb/4HHNBNVl0nlenhjHvj7E04pjmeftqYKaeo5rOmQ3gtOCbsACw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ1WNk4NuJMHCQk/L6l64JyEe1KEjHbu028z57FMkkEn+2l/pP
	9H0QgsuyMDDGmE0rqZcTGlNijGt7BfHFBSU/IHM/a0LUHwXMOdNREe0aFjfI14P4SzSc2c5Tr5v
	hQIW+jSw7EAOjJ0hl/D/LcLK+erMsA6HkoRFDGu0p
X-Gm-Gg: AfdE7cn1OCQ4ROEwdimHKmg10kYLu6QDzuGPBw2oIvo64ZmEY0paL3xgZndtcPdA+y+
	gPtIRSHU3lpUXJGCdxSrTy0su1dx3hFjyIjHw13izyHXySBgcgqVWGt459rnAaKN3BwpI/XNg94
	pdzdk0nB/hYSESbaWzVg0Fw1N/NOeUK158pbQ5SZzSTGPnmj18kt0j1QhIdjYfWNT455QnwnKZA
	T00xxVOXmud/6b25dMqNjs/3RzF9+xb9AQ6IfxcHOE7aEdzg11OkT2Cx/jc/hcsJ/8cmPey+2Wk
	BhmVZABqHLNlNIrkYNYUKLXkwdFYZ0RKlsTLGnkFAF0uh7rZCVLUEH3x/OaFduOl+VmuOAgoEpc
	kRuPn064wPhUXab73GA1QXB5beXwZwnomFNLvUKvUB5VryRKp5A==
X-Received: by 2002:a05:6871:2016:b0:448:84c0:fcf5 with SMTP id
 586e51a60fabf-45106080959mr17902fac.20.1783338911104; Mon, 06 Jul 2026
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com> <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
 <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com> <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
In-Reply-To: <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 6 Jul 2026 13:54:59 +0200
X-Gm-Features: AVVi8CeBOFPrQ1zTHfcvlgKLuME2AIe_WExrBUVuPzho7a99Z1Y55-T5aiUpW6s
Message-ID: <CANp29Y6QgCh5wc=O_B-qj-t=7f-r5XYWMnbmBNY2E7mSLTn62w@mail.gmail.com>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: mawupeng <mawupeng1@huawei.com>
Cc: sgarzare@redhat.com, 
	syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, stefanha@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 1:32=E2=80=AFPM 'mawupeng' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> On =E5=91=A8=E4=B8=80 2026-7-6 17:24, Stefano Garzarella wrote:
> > On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
> >> On =E5=91=A8=E5=9B=9B 2026-6-25 04:32, syzbot wrote:
> >>> Hello virt maintainers/developers,
> >>>
> >>> This is a 31-day syzbot report for the virt subsystem.
> >>> All related reports/information can be found at:
> >>> https://syzkaller.appspot.com/upstream/s/virt
> >>>
> >>> During the period, 0 new issues were detected and 0 were fixed.
> >>> In total, 5 issues are still open and 61 have already been fixed.
> >>> There are also 2 low-priority issues.
> >>>
> >>> Some of the still happening issues:
> >>>
> >>> Ref Crashes Repro Title
> >>> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D07dcf509f=
4c013e25dc5
> >>> <2> 3       Yes   memory leak in __vsock_create (2)
> >>>                   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0=
f8708082678
> >>
> >> Hi,
> >>
> >> This is regarding the still-open "memory leak in __vsock_create (2)"
> >> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
> >>   https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678
> >>
> >> I spent some time analyzing the root cause and the previous fix
> >> attempt; below is a summary and a direction that tested out.
> >
> > [...]
> >
> >>
> >> I'm not subscribed to follow the list at full volume; happy to send a
> >> formal patch (with the af_vsock.h / pending_work changes folded in)
> >> if the direction looks right to the maintainers.
> >
> > Yes, please, a formal patch with a great commit message is much better
> > than a long text to read IMO.
>
> Thanks for replying.
>
> As we conducted more thorough testing and further analysis of our own fix=
,
> we found that it is not as comprehensive as the existing AI-generated fix
> provided[1].
>
> Could you please let us know if there are any issues with this AI-generat=
ed fix?
>
> [1]: https://syzkaller.appspot.com/ai_job?id=3Dcd978d21-2110-4f57-9525-d7=
d91c4a7e02

I'll chime in from the syzbot side.
If anything is missing, please let us know :)

Otherwise, please note that the bot can incorporate code review notes
and, once the patch is ready, submit it to the LKML:
https://github.com/google/syzkaller/blob/master/docs/syzbot_ai_patches.md

Best Regards,
Aleksandr

>
> >
> > Thanks,
> > Stefano
> >
> >
>
