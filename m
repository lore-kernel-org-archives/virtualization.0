Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562944999F
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960195; cv=pass; b=IB6JstwV6JArT2aXlQcA4oUEPAnj8DzaPUHPTzXIMeF2PWeCJZyJDYg/RadqdSV6gg2xQDDy1w3A7j0zMXidwr78ZGkmd/WFzY2AtWOttUAc+irIuCkLu6P6MKxN5jE0aFoUpzqELNtCV2+SV7lilR0apzh0jPbkXxR9pylHuIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960195; c=relaxed/simple;
	bh=kF9c+8KKO+ipWwSE4hjYVCkfFFSKZ4K0zjQHaC5WzaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zotll3bnxtjn915btt3w0epM+5kNKHYhzRjy4dHNDftnjrUjP5XRYsPB9FLbAg5JxOzuuPAbCdb59AuPRwgL5+40sujJXKebIPdQoFtrl/4LOfPb0cQ3TD/FRd+GVXH76TiHhLKQQyp/MzdWpf80bnHX8i+aJ/dd5n7XL2FnH/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIqQW+zg; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIqQW+zg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3aae898c0afso5686271fa.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 23:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791960192; cv=none;
        d=google.com; s=arc-20260327;
        b=AZys4BVva8lrD2jbReRU1r9S5Z+skOJj8IO6qL/J5J80V82YuarRHFR/m9RLuAkM+O
         Yr/VGziajy9yR4La/76qTv7DkB+ffWNg/d3pOYzGf2VU69sKHdpk1YPzPJkZeV2Myvm4
         e3MZ4rrlnvW0mUKb2iGUdcY2QbfAYbt63I3Pfg+WRZX2Z1Ckze6oci73tYuKbZ0Eoy1F
         d36S/yteVrDFn7q1DGg0HQS6vNfnBYuXsvuXz2Wy5cPTzd8VTN3NDebrIg1/W6SeTyU/
         UR7zDItbRggPBfmP7LIBQx/bkik9e/QjGGGT0BDQnRLCTwl6LpAHoJ3sm22Gj2//C/M3
         FUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        fh=tl6NNNMpQTW9sV3Ja80Fx5+O/stN6ke3F+UZ8PJlhzI=;
        b=LLtumFJuKmnM1FJZU6586gcqrrsccL1kzdAiXOcg+l0+xuNfSNtt2EK4vfg6XCJi2a
         /C5lEU8nF2loU1vWfjIc1CzpbPKV7D44XMJ3ZhevVcMcwmfHsqmBn809dBdqBfppd9+w
         rnP+SHw2x4p4cjrS9PuPTHSqYRjlhLh92JN2gcKTu2anGOFq61AdUlw4Jn+LjFtHQDX2
         9aEUwHjD7DRU20B5uYKhHXmeJBBy2pGD3ypMEHHOOTSPRK+aSrPH2TaNF8NvnaiwEsfg
         fnLmbUXpnAyoyHDjjn7F/py8devnaoOrauN8oie51Q7/RuyM5JSxrm+D79BqoEg8t88F
         /HdQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791960192; x=1792564992; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        b=KIqQW+zgiavOxE74N14wX/IuzAbQ1p8peGUb0O3L3NSKcxh2Nk7Mn2xmYNtiPA2AiC
         bnMKyUpNsY+uX0hCq8sjX6Ed4jBgvSfTWfnINnXwQjGQdeTbBcU8TkzOqE3mzgwxZt8u
         QlT03cHpH3A/TUzxgrEJtxfmsAUU0zxPR62LB/V/D4aHgukBhcDZRUo9t8NXIQ3rCAQs
         4GEj6rm8ntqv77A9Qz05X3/7nVxVw0tkxIjoJ9qejdXgiTQi2o0Xgn/E705qO6kvg3rN
         AWtVQDCCAxoYm5O3B+E2QXayNLTC8lERwePtD4R6fqgOogt2HWUrYPlTwgkWbZ8Vz6Ge
         DDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791960192; x=1792564992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZwsjYHPheqBa+JzSbow2ZB78X+lBjsll/uWCTK8ljxY=;
        b=TWZEorY8P/KLkmWV0IouqIqeu6XR5gXg9GwOFdp+tO/2+fBZgQfHLk99gzERqYeNZB
         uxU9FZBjLFVlqvjZRG1NDifL2V8YxJt873GaElpiQ4lxq0cgnP5uEjjdsaHPp2rRIFyW
         z/H9r4za7LKXFAvQbN3KGQpjOgxkZ/jPMSdV25WtGBYe9DSxxfuCiwsChDGV2f4vBVwM
         EmlHPzLjgGkBNkrJI2EPfWxZTCqxUtIeoHJzkOWYdvHXIFPU8zjtfkgYTi2lmHjPmWuY
         TjYJdSoLdFbIsVDJfgZjKQ9AJZDskg5EgmPbhTpOI/haacTT+ODE/wJVlbXxPUCGnvrX
         IT+A==
X-Forwarded-Encrypted: i=1; AKwUvBzI1vLb/uvoQskPRzG3WehgZ79cuUYydw7qi7rV4vlOOqhs6+KP/q1r7MjKiXVlK1yp3PBAdPSf4yDps6W/5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJrFpWaoPOU5mFLxXJeaRGAZii6JsRtUQOwvZSGM4/8roUCeHrP
	NS7fBqp6DmiHysILfRVT4pDuXv2efsgTD/s9CmkrqyN1ftLDDFWUAPk7H1dj0YM9RRAapx9mnhH
	KCVeOCmJrn+ulAbX7DaqXaabGteo5zLUnjpv7dNWmMmht
X-Gm-Gg: AYBFou2W/y70vIa/542Wa2Udu6VoLRW6B0S9T5F1HL5yzTxZsSJom5Ays0LlIvr184o
	UfW5FMFIqT7w1TW6wFFX76BpiwdOiHGJOva+p/VG5URhzK9ZWD3Og35UxpTX5iHeGdFgMIm/wnF
	Zi/fT+fJOYaGs+59UYC5jnriQ5f0TjV4XYWvQuwHyeWuk4SaP4HCKD8Q2sVtrZCpWUwJfyx5ThJ
	zJYjYNBlRPaSCep0EmRJHsrg1hQj52n2tNC7Fmrp8xGr7U25WRoYZbHJ1S5hK5SFg1KB8ySg/l1
	emRhb8/o/gzR/lZFnn3WJgHVb+I/kdKBi/6uMyI+tbSLyE4woC2s69EVezkMXaSByHGH3ccg9WJ
	CAQ4sRXHq6t0kvvsXoeD+MYRkKdIvoa53dbxfK/6SXoSmSQP1dZ1uP8TFShMNSWKZxttQxW6Fpg
	==
X-Received: by 2002:a2e:b888:0:b0:3a9:82c2:ec1e with SMTP id
 38308e7fff4ca-3a9c537ed07mr33111191fa.15.1791960191931; Tue, 13 Oct 2026
 23:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929094812.93374-1-tkhandelwal32@gmail.com> <CAPwBhz_ow3BFEns2WL69Gj2BmOHGiFOEzP7U-=FfzSvoH=DZSA@mail.gmail.com>
In-Reply-To: <CAPwBhz_ow3BFEns2WL69Gj2BmOHGiFOEzP7U-=FfzSvoH=DZSA@mail.gmail.com>
From: Tarun Khandelwal <tkhandelwal32@gmail.com>
Date: Wed, 14 Oct 2026 12:12:34 +0530
X-Gm-Features: AclHuK_roABVrEaRhuHK5p8P-AhgVeh6e8Rm4bmNzCFIfTidAX3p_1c6lDNfvkM
Message-ID: <CAPwBhz-yAXeZTca0iFT=9fVhD8k7rUQBtjNKCw_FKPFzYFC2gw@mail.gmail.com>
Subject: Re: [PATCH] fuse: propagate SB_POSIXACL to submounts
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Tarun Khandelwal <tarun@supabase.io>
Content-Type: text/plain; charset="UTF-8"

(Resending as plain text, the lists bounced the previous copy.)

Hi Miklos,

Gentle ping on this one.

It fixes POSIX ACLs being unusable (and not enforced) on virtiofs
submounts, so it may be a candidate for fixes. If leaving SB_POSIXACL
off submounts was intentional, I'm happy to rework or drop it.

Thanks,
Tarun

On Wed, 14 Oct 2026 at 11:22, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:
>
> Hi Miklos,
>
> Gentle ping on this one.
>
> It fixes POSIX ACLs being unusable (and not enforced) on virtiofs
> submounts, so it may be a candidate for fixes. If leaving SB_POSIXACL
> off submounts was intentional, I'm happy to rework or drop it.
>
> Thanks,
> Tarun
>
> On Tue, 29 Sept 2026 at 15:18, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:
>>
>> From: Tarun Khandelwal <tarun@supabase.io>
>>
>> fuse_fill_super_common() always sets SB_POSIXACL on the superblock, but
>> fuse_fill_super_submount() never does. Submount superblocks are created
>> from an fs_context with no sb_flags, so the superblock of an automounted
>> FUSE_ATTR_SUBMOUNT directory (e.g. a virtiofs export containing another
>> host mount) lacks SB_POSIXACL, even though it shares the fuse_conn, and
>> thus fc->posix_acl, with its parent.
>>
>> Since IS_POSIXACL() is false on such a submount, the VFS:
>>
>>  - fails setting POSIX ACLs with -EOPNOTSUPP and hides existing ACLs,
>>    without sending any request to the server;
>>  - applies the umask itself on create, so default ACLs on the server are
>>    not honoured for new files;
>>  - skips ACL checks in acl_permission_check(), so with
>>    default_permissions (implied by FUSE_POSIX_ACL) access is decided by
>>    the mode bits alone and restrictive ACL entries are not enforced.
>>
>> Copy SB_POSIXACL from the parent superblock, as is already done for the
>> other superblock fields inherited from it. It cannot be set in
>> fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
>> flag was passed at mount time to decide fc->dont_mask before setting it.
>>
>> Reproducer, with virtiofsd 1.10.0 started with --posix-acl and an export
>> containing a nested mount:
>>
>>   host# mount -t tmpfs none /srv/share
>>   host# mkdir /srv/share/child
>>   host# mount -t tmpfs none /srv/share/child
>>   host# touch /srv/share/rootfile /srv/share/child/childfile
>>   guest# mount -t virtiofs <tag> /mnt
>>   guest# setfacl -m u:12345:rw /mnt/rootfile           # works
>>   guest# setfacl -m u:12345:rw /mnt/child/childfile
>>   setfacl: /mnt/child/childfile: Operation not supported
>>
>> With this patch the second setfacl succeeds, ACLs set on the host are
>> reported by getfacl on the submount, and default ACLs and ACL-based
>> access checks behave the same as on the root mount. Tested on v7.3-rc5
>> in a QEMU guest.
>>
>> Signed-off-by: Tarun Khandelwal <tarun@supabase.io>
>> ---
>> I wasn't sure whether leaving SB_POSIXACL off submount superblocks was
>> intentional. I would have opened an issue first, but since the fix is a
>> one-liner I'm sending the patch directly. If there is a reason for the
>> current behaviour, I'm happy to rework this or drop it.
>>
>>  fs/fuse/inode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index e9552be36..ef3c7fac4 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1629,6 +1629,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
>>         WARN_ON(sb->s_bdi != &noop_backing_dev_info);
>>         sb->s_bdi = bdi_get(parent_sb->s_bdi);
>>
>> +       sb->s_flags |= parent_sb->s_flags & SB_POSIXACL;
>> +
>>         sb->s_xattr = parent_sb->s_xattr;
>>         sb->s_export_op = parent_sb->s_export_op;
>>         sb->s_time_gran = parent_sb->s_time_gran;
>> --
>> 2.43.0
>>
