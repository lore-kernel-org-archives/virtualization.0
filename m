Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF649C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:47:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B5C61058
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0B5C61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61D7D83AE3;
	Wed, 11 Aug 2021 20:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYvR0ex2scxU; Wed, 11 Aug 2021 20:47:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2E5983AAF;
	Wed, 11 Aug 2021 20:47:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 925B0C001A;
	Wed, 11 Aug 2021 20:47:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8343FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E8D94057C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBharRsS0l5O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:47:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBF744056D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:47:10 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id n12so3651404plf.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=KEwB6Qw4lEC0fIXNQl09WBpglFRwigNGMZ/Ov5z4gtg=;
 b=gXj0y2a7cVYw7Ywo0ZOEnWi9MmcZOG9+YfaS4PzdpBf6tuJNaT4s+T7hCWXPxPYxWU
 ufEs/bMJhoHT5rBxckc+jJS13LOtpchF972E7dvlhO4DQVQze3qldmGS235LZ+T75z1h
 YQqmjWgI9jcmDFUFUKRUpG1xmL16CwB1Zg3d9dJM5tXg5ZrUNX7kyfZR7kM0zbiKT4Sv
 8grH/06YzB4/S+CRb05bnBFwx/Mv7/9kUKY/XPS5XGl4ZiGw24uSpLuslk+ODkj7DrTH
 3767gDlWWYQpwup14mQuzo9EMyeqyPbBCjp3EjCpCQUx2F+R07UjsGUihc7rhXELrgJm
 /VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=KEwB6Qw4lEC0fIXNQl09WBpglFRwigNGMZ/Ov5z4gtg=;
 b=tXlOoXRchB9PjiEg+TUMGaqJv+awfze7HxiyiqOjnezzzHOKvPEHNuYtgdrInIMWpX
 QrPhO2LwaL7oXnrh00XEna3TTMVlFOnk2rLUVs92WKVCu7S6wDvWZxafaS5cPLUIQnK8
 hRwu0i2YHjqmASFi65IvHyF/37BCkImhakF348bClxZiPU9DfvqCToIxMDX4yC83IsOf
 +IMlQhJFftqpvPdMfUaQpBlrKyct+/Q4Wm5s4YEyXtmsuDortINC6FBxNutKmDZfL7Zp
 ma8l565JCmCyO7e0xtZlklXHMj5qkk4zauxk+NOt6p7IYjG76INAoHPPG58g6c3AZJo9
 kb9A==
X-Gm-Message-State: AOAM531KnK8fGwJMqxAP0vL39Jf/HGfqPKT6VFohO3xFFishlzyk98nu
 UPXxApNQM3Q0XGu2yrIRP6sFLM1dYSxleCRs1JI=
X-Google-Smtp-Source: ABdhPJxlg4PW+VNSqZvn06H62b3WVz9yN6fw3zxPgJOsrR0ZxYMRhZRRVpCUTUKHopfsnNH3lwWYsHZhWGm3KuMk5rI=
X-Received: by 2002:a17:90a:604e:: with SMTP id
 h14mr9384064pjm.181.1628714830139; 
 Wed, 11 Aug 2021 13:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4c4e:0:0:0:0 with HTTP; Wed, 11 Aug 2021 13:47:09
 -0700 (PDT)
In-Reply-To: <20210811203612.138506-4-david@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Aug 2021 23:47:09 +0300
Message-ID: <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1280597868768180634=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1280597868768180634==
Content-Type: multipart/alternative; boundary="000000000000e4135305c94eb805"

--000000000000e4135305c94eb805
Content-Type: text/plain; charset="UTF-8"

On Wednesday, August 11, 2021, David Hildenbrand <david@redhat.com> wrote:

> Let's clean it up a bit, removing the unnecessary usage of r_next() by
> next_resource(), and use next_range_resource() in case we are not
> interested in a certain subtree.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/resource.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 2938cf520ca3..ea853a075a83 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
>   */
>  bool iomem_is_exclusive(u64 addr)
>  {
> -       struct resource *p = &iomem_resource;
> +       struct resource *p;
>         bool err = false;
> -       loff_t l;
>         int size = PAGE_SIZE;
>
>         if (!strict_iomem_checks)
> @@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
>         addr = addr & PAGE_MASK;
>
>         read_lock(&resource_lock);
> -       for (p = p->child; p ; p = r_next(NULL, p, &l)) {
> +       for (p = iomem_resource.child; p ;) {


I consider the ordinal part of p initialization is slightly better and done
outside of read lock.

Something like
p= &iomem_res...;
read lock
for (p = p->child; ...) {



>                 /*
>                  * We can probably skip the resources without
>                  * IORESOURCE_IO attribute?
>                  */
>                 if (p->start >= addr + size)
>                         break;
> -               if (p->end < addr)
> +               if (p->end < addr) {
> +                       /* No need to consider children */
> +                       p = next_resource_skip_children(p);
>                         continue;
> +               }
> +
>                 /*
>                  * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
>                  * or CONFIG_IO_STRICT_DEVMEM is enabled and the
>                  * resource is busy.
>                  */
> -               if ((p->flags & IORESOURCE_BUSY) == 0)
> -                       continue;
> -               if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
> -                               || p->flags & IORESOURCE_EXCLUSIVE) {
> +               if (p->flags & IORESOURCE_BUSY &&
> +                   (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM) ||
> +                    p->flags & IORESOURCE_EXCLUSIVE)) {
>                         err = true;
>                         break;
>                 }
> +               p = next_resource(p);
>         }
>         read_unlock(&resource_lock);
>
> --
> 2.31.1
>
>

-- 
With Best Regards,
Andy Shevchenko

--000000000000e4135305c94eb805
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, August 11, 2021, David Hildenbrand &lt;<a href=3D"mai=
lto:david@redhat.com">david@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Let&#39;s clean it up a bit, removing the unnecessary usage o=
f r_next() by<br>
next_resource(), and use next_range_resource() in case we are not<br>
interested in a certain subtree.<br>
<br>
Signed-off-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">da=
vid@redhat.com</a>&gt;<br>
---<br>
=C2=A0kernel/resource.c | 19 +++++++++++--------<br>
=C2=A01 file changed, 11 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/kernel/resource.c b/kernel/resource.c<br>
index 2938cf520ca3..ea853a075a83 100644<br>
--- a/kernel/resource.c<br>
+++ b/kernel/resource.c<br>
@@ -1754,9 +1754,8 @@ static int strict_iomem_checks;<br>
=C2=A0 */<br>
=C2=A0bool iomem_is_exclusive(u64 addr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *p =3D &amp;iomem_resource;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool err =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0loff_t l;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int size =3D PAGE_SIZE;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strict_iomem_checks)<br>
@@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr =3D addr &amp; PAGE_MASK;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_lock(&amp;resource_lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D p-&gt;child; p ; p =3D r_next(NULL, =
p, &amp;l)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D iomem_resource.child; p ;) {</blockq=
uote><div><br></div><div>I consider the ordinal part of p initialization is=
 slightly better and done outside of read lock.</div><div><br></div><div>So=
mething like</div><div>p=3D &amp;iomem_res...;</div><div>read lock</div><di=
v>for (p =3D p-&gt;child; ...) {</div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We can prob=
ably skip the resources without<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* IORESOURCE_=
IO attribute?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p-&gt;start &gt=
;=3D addr + size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;end &lt; =
addr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;end &lt; =
addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* No need to consider children */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p =3D next_resource_skip_children(p)<wbr>;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* A resource =
is exclusive if IORESOURCE_EXCLUSIVE is set<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or CONFIG_I=
O_STRICT_DEVMEM is enabled and the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* resource is=
 busy.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((p-&gt;flags &a=
mp; IORESOURCE_BUSY) =3D=3D 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ENABLED(CONF=
IG_IO_STRICT_<wbr>DEVMEM)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| p-&gt;flags &amp; IORESOURCE_EXCLU=
SIVE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;flags &am=
p; IORESOURCE_BUSY &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(IS_E=
NABLED(CONFIG_IO_STRICT_<wbr>DEVMEM) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&g=
t;flags &amp; IORESOURCE_EXCLUSIVE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D next_resource=
(p);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_unlock(&amp;resource_lock);<br>
=C2=A0<br>
-- <br>
2.31.1<br>
<br>
</blockquote><br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><br><b=
r>

--000000000000e4135305c94eb805--

--===============1280597868768180634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1280597868768180634==--
