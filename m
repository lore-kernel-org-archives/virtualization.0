Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCF6C25B6B
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 16:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 253BB83D5D;
	Thu, 26 Oct 2023 16:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 253BB83D5D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aOxTrXER
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QuCcS6FrrcRR; Thu, 26 Oct 2023 16:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8AEEE83D6D;
	Thu, 26 Oct 2023 16:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AEEE83D6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58E7FC0039;
	Thu, 26 Oct 2023 16:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9873DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 16:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 663D883DCC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 16:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 663D883DCC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cTAU7opAz18X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 16:30:38 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D92983D5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 16:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D92983D5D
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9c5b313b3ffso168881466b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698337836; x=1698942636;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=K49sQJlsvQ6YWsPJ1ZrLdAhGXeZjXDwIwIeJaPYwsv4=;
 b=aOxTrXERx1oijUGMQlxiPnh3KY/rtYK6zU09xtmQMQLxscT6d5Efb77Q/NIvbSj+nA
 XBdwlhQqfHfmPZz/jqyEyy35qDccxuQGni9yPr0AzEeUmxw+yk+Q+olGEYmFZ7i1UumQ
 dThOLwmqyOhzFsxWRjk4W9/uq6nUPAc3ArBoKBG0pfhk2Smz9bs4fk92bTHshYY8SzJo
 Gj+KAbIy+YhRYjh98zCI0H/vR56U55mnaiiw8UxZjXvTldeW5WgNxirwnVYPuB53Z/HV
 A2fSe6dsoWVL9XJ/W3q+E5Mv1ppQpBSTPOzy5dIWf899SSJay9KYI6YH1adjxS1wqIT/
 GfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698337836; x=1698942636;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K49sQJlsvQ6YWsPJ1ZrLdAhGXeZjXDwIwIeJaPYwsv4=;
 b=hhlzdbJnJJlVjzDH0ukFwuIh/Md50xFjEPGscjRcb07qYQTCgy3UxOYcOArIglp7lt
 h1CqYYs+GzVA40pxawqfhs7MzdA/lZCKXR/SfSc41x9Jct57pJaavm37fVqPWflYkrX4
 9LGHYKh++Dax3afmYBeLbavDu/K7ewl3XN9W3c/TWY6hlvhpyy/wDGyjfrgbj7nKiWQn
 Shhw62Hyql6tsOMD1oeDnYwf4TJwTpGUW5EsvI2RVqAiKLmvw3EH1vE2ZbRYOGp84ekO
 SvdsXMa3hFl/MUylG7iUGN5WcTwkO5Em0Sb7WMt/sY4Za4PQIkBWWM+A+6NEV+OinYe8
 ZAeQ==
X-Gm-Message-State: AOJu0Yzyl2FG4EXXRWthZEn7NSzWtCkYzhS0B4GeoJ3UIVk9oHh04WW1
 uylwZVWsJuKfPvXD2oNcHX625baoF3lAfL82wZMasw==
X-Google-Smtp-Source: AGHT+IEX/vQ8j+z414JDsP93agMdjngSMn6VsCTV63ESqZ4tZjLeA+a50cbNzX+sVxTam8CrLzyhEA==
X-Received: by 2002:a17:907:31c8:b0:9a1:891b:6eed with SMTP id
 xf8-20020a17090731c800b009a1891b6eedmr139103ejb.76.1698337836027; 
 Thu, 26 Oct 2023 09:30:36 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl.
 [79.184.154.62]) by smtp.gmail.com with ESMTPSA id
 k15-20020a1709065fcf00b00997d7aa59fasm12151449ejv.14.2023.10.26.09.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 09:30:35 -0700 (PDT)
References: <20231025145319.380775-1-jakub@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Thu, 26 Oct 2023 18:25:08 +0200
In-reply-to: <20231025145319.380775-1-jakub@cloudflare.com>
Message-ID: <87wmv91h3p.fsf@cloudflare.com>
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kernel-team@cloudflare.com,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> hints") irq_set_affinity_hint is being phased out.
>
> Switch to new interfaces for setting and applying irq affinity hints.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> v2:
>  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>    Proposed a change to IRQ affinity interface to address this limitation:
>    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com

Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
we could call irq_set_affinity directly, instead of calling it through
irq_set_affinity[_and]_hint.

The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
but the same information can be gathered from /proc/irq/N/smp_affinity.

[...]
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
