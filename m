Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AA8C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 18:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3E39402D2;
	Mon, 13 Feb 2023 18:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3E39402D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcMmUDWo-WBH; Mon, 13 Feb 2023 18:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3AB834046D;
	Mon, 13 Feb 2023 18:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AB834046D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04462C0032;
	Mon, 13 Feb 2023 18:41:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7249EC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3687040949
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:41:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3687040949
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yx3WvRHTGAYw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:41:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D93A4014B
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D93A4014B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 18:41:04 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id fi26so14224495edb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 10:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDtFU2Jc95gLjieOysLnzEfFJTUgaL6A5DtFJMyaKWg=;
 b=FfmKT8+nGlPGy7TnBvJWYehFRwP4ayXwAaRZa7xDi45fz0rwBmBxHo82DIMuSZdiBe
 KWnofRGKupkd4Da0gomuGhigotLaZGngXfcM9gHXMw22dp9k1J+tpYCed5k9Xs4+9BNn
 QcsmYD/U0RSg+Ykh86Ai4TCtje+ZbFelsjR7ywy0aNQKN1za+cH5IxVZ3zcXKvF3y+NY
 eKkt4kGbYzI3dBBZGS0pfdfmNGp3jxFZr56xhhidozM3A0c3Il6Wts53ST+MWbFqdn7m
 AxrgP5MFMop36MAMabYtnEOhqV44Jvc2z9LmYV7Z3bjn3G6dATnvJcQ0a2qzHv7hURW7
 +ESQ==
X-Gm-Message-State: AO0yUKVajMlzW6U75YvlG62JV6xlAGK+3MVaVzE2K2BEX+uHoUBhFeDV
 rLWhVqOZ+Wjkq9pfggDIYQkyFhDVJxeHbOrlYBw=
X-Google-Smtp-Source: AK7set9c7MrFAu9f5jlejY00/6IQgCiFdmwotU5SX7kkOfHGG0KHlQp9HH4RhJUJiR5WCISRbhRFTSlDhAMhz5lGcPE=
X-Received: by 2002:a50:baab:0:b0:4ac:cdd9:1c97 with SMTP id
 x40-20020a50baab000000b004accdd91c97mr1386918ede.6.1676313662522; Mon, 13 Feb
 2023 10:41:02 -0800 (PST)
MIME-Version: 1.0
References: <1676021646-2619-1-git-send-email-ssengar@linux.microsoft.com>
 <1676021646-2619-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1676021646-2619-3-git-send-email-ssengar@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Feb 2023 19:40:51 +0100
Message-ID: <CAJZ5v0ivddzCoYFd4TauH3G83KxCWQK1NZSvn25oWt_iy0LOfQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] ACPI: bus: Add stub acpi_sleep_state_supported()
 in non-ACPI cases
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, mikelley@microsoft.com,
 linux-hyperv@vger.kernel.org, rafael@kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 robh+dt@kernel.org, dphadke@linux.microsoft.com,
 krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de, lenb@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Feb 10, 2023 at 10:34 AM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> acpi_sleep_state_supported() is defined only when CONFIG_ACPI=y. The
> function is in acpi_bus.h, and acpi_bus.h can only be used in
> CONFIG_ACPI=y cases. Add the stub function to linux/acpi.h to make
> compilation successful for !CONFIG_ACPI cases.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to toute this patch whichever way is convenient.

Thanks!

> ---
>  include/linux/acpi.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index efff750f326d..d331f76b0c19 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1075,6 +1075,11 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
>         return 0;
>  }
>
> +static inline bool acpi_sleep_state_supported(u8 sleep_state)
> +{
> +       return false;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
