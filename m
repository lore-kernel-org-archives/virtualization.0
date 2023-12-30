Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF0C153
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Npw/yrRX"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8061F82096
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8061F82096
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Npw/yrRX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aEyO7XLuOfuz
	for <virtualization@lists.linux-foundation.org>;
	Sat, 30 Dec 2023 20:41:33 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 81E3181AC1
	for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 20:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81E3181AC1
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a27c65bd757so48104266b.3
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703968891; x=1704573691; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqev+qKsNZg84TyjAN9i8DWy8xYTUxkGZNijcPktMwo=;
        b=Npw/yrRXrNcb3ExGT3dTu1jVFW5ioXV0yeUFRcX6DHqAjn+fCM+qQ/VUe7wtTqVvs3
         4PCbOb40R8FAUDZwKHU2LtqkHe+3qh8CJo0WbwU+838MqOpClbg8GEfOdDaev6SLuUGJ
         TPPyF5G1IW2wTiZh+bFgd0NcylRQeb/Y9iRd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703968891; x=1704573691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqev+qKsNZg84TyjAN9i8DWy8xYTUxkGZNijcPktMwo=;
        b=ao/MWDQd0Bh9BTMc8tpp5Xd8vfNYBhobT05HTXShv1uYCKrr36s/ofszHCBSPvV++8
         k3csufRK4QEzZL7szD2v+DWjPZv+/I9SurgmQ1HcNJkI7sBdlOSLPKi3oL4bop4x87Lf
         w3pkYR3aNCxrYGTuzRT9KABrb2AxqvT9KVUk79U68w6TrLhvblj7RFWWpeu/FNGAj+aW
         T0EOqo08WVR+3EjBxE1xU9ZjOKpCVJm9wTNgf2q5cIAXpsekzfNfOlSA1xfDoEsqUpKJ
         MSvO7nEkif0kxFJPVj5J7iqowWUyUl2q3w1Ta2Z14XNyrQZTk2I6EVVMOpOgRIL5Mdlg
         kHaQ==
X-Gm-Message-State: AOJu0YzReM0DLxb9oDLsK951PlrCs+lmHCUQ0iquPGPU1M40BP3d2f7V
	GpVweW3gwEzgWDYNPAgjYwqTxnY1ytTR2LnM+S2h53P3QWqPRF2z
X-Google-Smtp-Source: AGHT+IFBdpF1sXZ7Nas/VVZMkAy5DjBRj9Fsy63Sdt7dET+EWOQaY0uMGCJE78p9AXYwRuadSqdE2w==
X-Received: by 2002:a17:907:bb8a:b0:a26:ac38:df92 with SMTP id xo10-20020a170907bb8a00b00a26ac38df92mr6706920ejc.145.1703968891226;
        Sat, 30 Dec 2023 12:41:31 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id zr16-20020a170907711000b00a26af4d96c6sm8546510ejb.4.2023.12.30.12.41.30
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 12:41:30 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27874c861aso165911866b.1
        for <virtualization@lists.linux-foundation.org>; Sat, 30 Dec 2023 12:41:30 -0800 (PST)
X-Received: by 2002:a17:906:208a:b0:a26:f083:d89a with SMTP id
 10-20020a170906208a00b00a26f083d89amr3518174ejq.75.1703968889891; Sat, 30 Dec
 2023 12:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com> <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
In-Reply-To: <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Dec 2023 12:41:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
Message-ID: <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
Subject: Re: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data accesses.
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	Zeng Heng <zengheng4@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000641af2060dc02c7b"

--000000000000641af2060dc02c7b
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 12:57, David Laight <David.Laight@aculab.com> wrote:
>
> this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> the latter can use an 'offset from register' (%gs for x86-84).
>
> Add a 'self' field to 'struct optimistic_spin_node' that can be
> read with raw_cpu_read(), initialise on first call.

No, this is horrible.

The problem isn't the "this_cpu_ptr()", it's the rest of the code.

>  bool osq_lock(struct optimistic_spin_queue *lock)
>  {
> -       struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> +       struct optimistic_spin_node *node = raw_cpu_read(osq_node.self);

No. Both of these are crap.

>         struct optimistic_spin_node *prev, *next;
>         int old;
>
> -       if (unlikely(node->cpu == OSQ_UNLOCKED_VAL))
> -               node->cpu = encode_cpu(smp_processor_id());
> +       if (unlikely(!node)) {
> +               int cpu = encode_cpu(smp_processor_id());
> +               node = decode_cpu(cpu);
> +               node->self = node;
> +               node->cpu = cpu;
> +       }

The proper fix here is to not do that silly

        node = this_cpu_ptr(&osq_node);
        ..
        node->next = NULL;

dance at all, but to simply do

        this_cpu_write(osq_node.next, NULL);

in the first place. That makes the whole thing just a single store off
the segment descriptor.

Yes, you'll eventually end up doing that

        node = this_cpu_ptr(&osq_node);

thing because it then wants to use that raw pointer to do

        WRITE_ONCE(prev->next, node);

but that's a separate issue and still does not make it worth it to
create a pointless self-pointer.

Btw, if you *really* want to solve that separate issue, then make the
optimistic_spin_node struct not contain the pointers at all, but the
CPU numbers, and then turn those numbers into the pointers the exact
same way it does for the "lock->tail" thing, ie doing that whole

        prev = decode_cpu(old);

dance. That *may* then result in avoiding turning them into pointers
at all in some cases.

Also, I think that you might want to look into making OSQ_UNLOCKED_VAL
be -1 instead, and add something like

  #define IS_OSQ_UNLOCKED(x) ((int)(x)<0)

and that would then avoid the +1 / -1 games in encoding/decoding the
CPU numbers. It causes silly code generated like this:

        subl    $1, %eax        #, cpu_nr
...
        cltq
        addq    __per_cpu_offset(,%rax,8), %rcx

which seems honestly stupid. The cltq is there for sign-extension,
which is because all these things are "int", and the "subl" will
zero-extend to 64-bit, not sign-extend.

At that point, I think gcc might be able to just generate

        addq    __per_cpu_offset-8(,%rax,8), %rcx

but honestly, I think it would be nicer to just have decode_cpu() do

        unsigned int cpu_nr = encoded_cpu_val;

        return per_cpu_ptr(&osq_node, cpu_nr);

and not have the -1/+1 at all.

Hmm?

UNTESTED patch to just do the "this_cpu_write()" parts attached.
Again, note how we do end up doing that this_cpu_ptr conversion later
anyway, but at least it's off the critical path.

                 Linus

--000000000000641af2060dc02c7b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lqsj1wd50>
X-Attachment-Id: f_lqsj1wd50

IGtlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMgfCAxMiArKysrKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVs
L2xvY2tpbmcvb3NxX2xvY2suYyBiL2tlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMKaW5kZXggNzVh
NmY2MTMzODY2Li5jM2ExNjZiNzkwMGMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9sb2NraW5nL29zcV9s
b2NrLmMKKysrIGIva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYwpAQCAtOTIsMTQgKzkyLDE0IEBA
IG9zcV93YWl0X25leHQoc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9xdWV1ZSAqbG9jaywKIAogYm9v
bCBvc3FfbG9jayhzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX3F1ZXVlICpsb2NrKQogewotCXN0cnVj
dCBvcHRpbWlzdGljX3NwaW5fbm9kZSAqbm9kZSA9IHRoaXNfY3B1X3B0cigmb3NxX25vZGUpOwor
CXN0cnVjdCBvcHRpbWlzdGljX3NwaW5fbm9kZSAqbm9kZTsKIAlzdHJ1Y3Qgb3B0aW1pc3RpY19z
cGluX25vZGUgKnByZXYsICpuZXh0OwogCWludCBjdXJyID0gZW5jb2RlX2NwdShzbXBfcHJvY2Vz
c29yX2lkKCkpOwogCWludCBvbGQ7CiAKLQlub2RlLT5sb2NrZWQgPSAwOwotCW5vZGUtPm5leHQg
PSBOVUxMOwotCW5vZGUtPmNwdSA9IGN1cnI7CisJdGhpc19jcHVfd3JpdGUob3NxX25vZGUubmV4
dCwgTlVMTCk7CisJdGhpc19jcHVfd3JpdGUob3NxX25vZGUubG9ja2VkLCAwKTsKKwl0aGlzX2Nw
dV93cml0ZShvc3Ffbm9kZS5jcHUsIGN1cnIpOwogCiAJLyoKIAkgKiBXZSBuZWVkIGJvdGggQUNR
VUlSRSAocGFpcnMgd2l0aCBjb3JyZXNwb25kaW5nIFJFTEVBU0UgaW4KQEAgLTExMiw3ICsxMTIs
OSBAQCBib29sIG9zcV9sb2NrKHN0cnVjdCBvcHRpbWlzdGljX3NwaW5fcXVldWUgKmxvY2spCiAJ
CXJldHVybiB0cnVlOwogCiAJcHJldiA9IGRlY29kZV9jcHUob2xkKTsKLQlub2RlLT5wcmV2ID0g
cHJldjsKKwl0aGlzX2NwdV93cml0ZShvc3Ffbm9kZS5wcmV2LCBwcmV2KTsKKworCW5vZGUgPSB0
aGlzX2NwdV9wdHIoJm9zcV9ub2RlKTsKIAogCS8qCiAJICogb3NxX2xvY2soKQkJCXVucXVldWUK
--000000000000641af2060dc02c7b--
