Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A824C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:14:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321FC6104F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 07:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 321FC6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB8E860890;
	Thu, 12 Aug 2021 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORcNMZ8bgzsl; Thu, 12 Aug 2021 07:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AB0860B8A;
	Thu, 12 Aug 2021 07:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 268C1C001A;
	Thu, 12 Aug 2021 07:14:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACF32C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 89A6880B66
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sVvaf8e8Qtp8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:14:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C4E9802BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 07:14:17 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 w13-20020a17090aea0db029017897a5f7bcso9247166pjy.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uTpuPc6jybGb8/DvYBQSSW/IZuaDxvXztvE6S4Hicb4=;
 b=sOyqW7iTclNbSetuTzyFasL3dzFtTN+bLyAwmBY6LlQXReYYAe8slkDoAvt+rGT8fS
 MJniPIh9uxD9XEQ5uNEw6uzZ9HCYsUIQ01gPNQri12s684OGlzYB5pL9GFsPgXup3Xog
 QfH7WN8lcLN+lUxkPJT5J5ED32MUxQwhad7OVEuUTlWtRJbhmHEbd3NAEO0Eg6s83jM4
 SBwQ1A3GL3Oj5LffEE1uGIDyYGBr7zvyvKT7LoivSdv9EziZGyoSel0sYIRj6MWY1Dj2
 TUM5my2966TT4Hnq6RDPzbSO11RoI/xij5s+amJgawu2zGshW8jFIZ31GRDkTuRGlI9/
 DxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uTpuPc6jybGb8/DvYBQSSW/IZuaDxvXztvE6S4Hicb4=;
 b=cxh1w5KaN6Y3nxlMUKvAKiXl60grO2b7QheVOuapSQ5LTmjM8r7p62drbZhaD85WGZ
 t9Qn7L0n66G0n94EfdtiWbX8/nM1OsacHiXIiOeFhPtCyqLLJJitebLDguYjzD8JArMa
 fXQMWBGwdG2G3SqevXpe78O1GokiDiHpIaH4MnSWYX+u0Hrk0URCbxzRUZPuoVhXXSJl
 68CY1Kvd7o4K70yL4GBNqMDG5wlPshlO8fuuZj/fRX/uxjH9iV2JF9aFvmCBLa7Rfnb5
 4DnUw0D55WFJNdZRM4DD3Lav+tpb/GH4OUdrkGgtvPFibSkx8bYkuZ4y/i/sUUpbpCxv
 I79g==
X-Gm-Message-State: AOAM531FUOuHbOxh05fzOL2DgyMoxXxlEoPgYPTyzJzw5UpyWu1L9BdJ
 Ff6fNW8KAyz9h86ithjKJMRzaROHsQ+JZLOufX4=
X-Google-Smtp-Source: ABdhPJycl3YPcVTG/5S7l85T8vjJVmFk80phN0hpMs/FjQrcfKM+Rgn2LAnOaxX+/woLbx7ZOAVmPYWhxgRWhuRBT6I=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr2668987pgg.4.1628752456522;
 Thu, 12 Aug 2021 00:14:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4c4e:0:0:0:0 with HTTP; Thu, 12 Aug 2021 00:14:16
 -0700 (PDT)
In-Reply-To: <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
 <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Aug 2021 10:14:16 +0300
Message-ID: <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
To: David Hildenbrand <david@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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
Content-Type: multipart/mixed; boundary="===============2094614550704725218=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2094614550704725218==
Content-Type: multipart/alternative; boundary="000000000000991e6a05c9577b03"

--000000000000991e6a05c9577b03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, August 12, 2021, David Hildenbrand <david@redhat.com> wrote:

> On 11.08.21 22:47, Andy Shevchenko wrote:
>
>>
>>
>> On Wednesday, August 11, 2021, David Hildenbrand <david@redhat.com
>> <mailto:david@redhat.com>> wrote:
>>
>>     Let's clean it up a bit, removing the unnecessary usage of r_next() =
by
>>     next_resource(), and use next_range_resource() in case we are not
>>     interested in a certain subtree.
>>
>>     Signed-off-by: David Hildenbrand <david@redhat.com
>>     <mailto:david@redhat.com>>
>>     ---
>>       kernel/resource.c | 19 +++++++++++--------
>>       1 file changed, 11 insertions(+), 8 deletions(-)
>>
>>     diff --git a/kernel/resource.c b/kernel/resource.c
>>     index 2938cf520ca3..ea853a075a83 100644
>>     --- a/kernel/resource.c
>>     +++ b/kernel/resource.c
>>     @@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
>>        */
>>       bool iomem_is_exclusive(u64 addr)
>>       {
>>     -       struct resource *p =3D &iomem_resource;
>>     +       struct resource *p;
>>              bool err =3D false;
>>     -       loff_t l;
>>              int size =3D PAGE_SIZE;
>>
>>              if (!strict_iomem_checks)
>>     @@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
>>              addr =3D addr & PAGE_MASK;
>>
>>              read_lock(&resource_lock);
>>     -       for (p =3D p->child; p ; p =3D r_next(NULL, p, &l)) {
>>     +       for (p =3D iomem_resource.child; p ;) {
>>
>>
> Hi Andy,
>
>
>> I consider the ordinal part of p initialization is slightly better and
>> done outside of read lock.
>>
>> Something like
>> p=3D &iomem_res...;
>> read lock
>> for (p =3D p->child; ...) {
>>
>
> Why should we care about doing that outside of the lock? That smells like
> a micro-optimization the compiler will most probably overwrite either way
> as the address of iomem_resource is just constant?
>
> Also, for me it's much more readable and compact if we perform a single
> initialization instead of two separate ones in this case.
>
> We're using the pattern I use in, find_next_iomem_res() and
> __region_intersects(), while we use the old pattern in
> iomem_map_sanity_check(), where we also use the same unnecessary r_next()
> call.
>
> I might just cleanup iomem_map_sanity_check() in a similar way.
>
>

Yes, it=E2=80=99s like micro optimization. If you want your way I suggest t=
hen to
add a macro

#define for_each_iomem_resource_child() \
 for (iomem_resource...)



>
> Thanks,
>
> David / dhildenb
>
>

--=20
With Best Regards,
Andy Shevchenko

--000000000000991e6a05c9577b03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, August 12, 2021, David Hildenbrand &lt;<a href=3D"mail=
to:david@redhat.com">david@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 11.08.21 22:47, Andy Shevchenko wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Wednesday, August 11, 2021, David Hildenbrand &lt;<a href=3D"mailto:davi=
d@redhat.com" target=3D"_blank">david@redhat.com</a> &lt;mailto:<a href=3D"=
mailto:david@redhat.com" target=3D"_blank">david@redhat.com</a>&gt;&gt; wro=
te:<br>
<br>
=C2=A0 =C2=A0 Let&#39;s clean it up a bit, removing the unnecessary usage o=
f r_next() by<br>
=C2=A0 =C2=A0 next_resource(), and use next_range_resource() in case we are=
 not<br>
=C2=A0 =C2=A0 interested in a certain subtree.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: David Hildenbrand &lt;<a href=3D"mailto:david@=
redhat.com" target=3D"_blank">david@redhat.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:david@redhat.com" target=3D"_bla=
nk">david@redhat.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0kernel/resource.c | 19 +++++++++++--------<br>
=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 11 insertions(+), 8 deletions(-)<=
br>
<br>
=C2=A0 =C2=A0 diff --git a/kernel/resource.c b/kernel/resource.c<br>
=C2=A0 =C2=A0 index 2938cf520ca3..ea853a075a83 100644<br>
=C2=A0 =C2=A0 --- a/kernel/resource.c<br>
=C2=A0 =C2=A0 +++ b/kernel/resource.c<br>
=C2=A0 =C2=A0 @@ -1754,9 +1754,8 @@ static int strict_iomem_checks;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0bool iomem_is_exclusive(u64 addr)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
=C2=A0 =C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *p =3D &amp;iomem=
_resource;<br>
=C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *p;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool err =3D false;<br>
=C2=A0 =C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0loff_t l;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 int size =3D PAGE_SIZE;<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strict_iomem_checks)<b=
r>
=C2=A0 =C2=A0 @@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D addr &amp; PAGE_MA=
SK;<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_lock(&amp;resource_loc=
k);<br>
=C2=A0 =C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D p-&gt;child; p ; p =3D=
 r_next(NULL, p, &amp;l)) {<br>
=C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D iomem_resource.child; =
p ;) {<br>
<br>
</blockquote>
<br>
Hi Andy,<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
I consider the ordinal part of p initialization is slightly better and done=
 outside of read lock.<br>
<br>
Something like<br>
p=3D &amp;iomem_res...;<br>
read lock<br>
for (p =3D p-&gt;child; ...) {<br>
</blockquote>
<br>
Why should we care about doing that outside of the lock? That smells like a=
 micro-optimization the compiler will most probably overwrite either way as=
 the address of iomem_resource is just constant?<br>
<br>
Also, for me it&#39;s much more readable and compact if we perform a single=
 initialization instead of two separate ones in this case.<br>
<br>
We&#39;re using the pattern I use in, find_next_iomem_res() and __region_in=
tersects(), while we use the old pattern in iomem_map_sanity_check(), where=
 we also use the same unnecessary r_next() call.<br>
<br>
I might just cleanup iomem_map_sanity_check() in a similar way.<br>
<br></blockquote><div><br></div><div><br></div><div>Yes, it=E2=80=99s like =
micro optimization. If you want your way I suggest then to add a macro</div=
><div><br></div><div>#define for_each_iomem_resource_child() \</div><div>=
=C2=A0for (iomem_resource...)</div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><br>
Thanks,<br>
<br>
David / dhildenb<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--000000000000991e6a05c9577b03--

--===============2094614550704725218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2094614550704725218==--
