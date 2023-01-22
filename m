Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F69BC25B4E
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 08:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D06D040AA6;
	Sun, 22 Jan 2023 08:34:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D06D040AA6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TctIM1ka
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjTGcemNLQMT; Sun, 22 Jan 2023 08:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BE5A40A93;
	Sun, 22 Jan 2023 08:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BE5A40A93
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D85C0033;
	Sun, 22 Jan 2023 08:34:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99611C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 08:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80F204146F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 08:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80F204146F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TctIM1ka
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXLAQwgsHzHL
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 08:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F60D4155E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F60D4155E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674376481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBOy3GEyTxqSKd3pw0Cq7/zzqUVdT2OzA5ZHrT96yhk=;
 b=TctIM1ka4wlmHpfP3FMKRldXGp098rmGxDU8OelNNh3ultcAirYzHdLDK84a1lGE1Za2bq
 wYCbXLgUA9xXWVtSKKxmoUBuBFUq9DYYj7PJnbihqYaoJci/SPtAo18Q8TPXhAOvtG1AYa
 5edC2o4YMPq9fDXDgd35o+qSrkuJ3R0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-cbeEfVKeNI-RuB9i_G0f-Q-1; Sun, 22 Jan 2023 03:34:37 -0500
X-MC-Unique: cbeEfVKeNI-RuB9i_G0f-Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 v8-20020a056402348800b0049e1913bd43so6610473edc.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 00:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBOy3GEyTxqSKd3pw0Cq7/zzqUVdT2OzA5ZHrT96yhk=;
 b=Ac+w9bfmERykwMmp4UqkJrzZQBxis6GUZzJrI71SNXDYeJ2P+UQeSF1czEMJMxntMo
 zF834IkuupkqabKvk4PToGRX+aQxnsP8CS97pF/ghHCR7e8IQMXeTGJGjV9K8Oy/yige
 eTBGScHvBtZIYC3SEx1Ch7830l9L6IQm2mP7we8LE++E4o/sE/z5sq3rOi2Qj/LXpEr+
 69SwAI3plphCqK/dT0RtZxtLG3G+31E+IIrZ0KIlwcginErkTVR4scCEVdU/3IbGzLNK
 uCbRPKaYLw44HcUDRRyU9HwNBUXxESlMOuBjHGadbcr8CGlB+S1QKfG96KXRqy8GSByF
 SC7w==
X-Gm-Message-State: AFqh2krDQ2JWPNZatjAVFzzfc0XLXlUXLHejzsOTTdjCD4QXvPj0OiQY
 9R8mlp53lL7XwrEFc6j+RY5c0sePXQ1bU1efWlfLt2efWHT2ES5PV2+KaMIIld5zNyOgmU11DR7
 ON2usxucoxKRoYqexJFlAr/iLNrsqoKE9Tg+/YXRlhg==
X-Received: by 2002:a17:906:d8ad:b0:875:54f5:740d with SMTP id
 qc13-20020a170906d8ad00b0087554f5740dmr18980188ejb.51.1674376471264; 
 Sun, 22 Jan 2023 00:34:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXupkktggRT0GhSuPRcESSXkQviODPyb9ZmRHAGX+AHHUI13v12MW9XOdnRYvnmjPv5GEmYCQw==
X-Received: by 2002:a17:906:d8ad:b0:875:54f5:740d with SMTP id
 qc13-20020a170906d8ad00b0087554f5740dmr18980169ejb.51.1674376471041; 
 Sun, 22 Jan 2023 00:34:31 -0800 (PST)
Received: from redhat.com ([2.52.149.29]) by smtp.gmail.com with ESMTPSA id
 lb19-20020a170907785300b0084d1efe9af6sm20325371ejc.58.2023.01.22.00.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jan 2023 00:34:30 -0800 (PST)
Date: Sun, 22 Jan 2023 03:34:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@digitalocean.com>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <20230122032944-mutt-send-email-mst@kernel.org>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 kvm@vger.kernel.org, netdev@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@kernel.org>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>
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

On Fri, Jan 20, 2023 at 04:12:20PM -0600, Seth Forshee (DigitalOcean) wrote:
> We've fairly regularaly seen liveptches which cannot transition within kpatch's
> timeout period due to busy vhost worker kthreads. In looking for a solution the
> only answer I found was to call klp_update_patch_state() from a safe location.
> I tried adding this call to vhost_worker(), and it works, but this creates the
> potential for problems if a livepatch attempted to patch vhost_worker().
> Without a call to klp_update_patch_state() fully loaded vhost kthreads can
> never switch because vhost_worker() will always appear on the stack, but with
> the call these kthreads can switch but will still be running the old version of
> vhost_worker().
> 
> To avoid this situation I've added a new function, klp_switch_current(), which
> switches the current task only if its stack does not include any function being
> patched. This allows kthreads to safely attempt switching themselves if a patch
> is pending. There is at least one downside, however. Since there's no way for
> the kthread to track whether it has already tried to switch for a pending patch
> it can end up calling klp_switch_current() repeatedly when it can never be
> safely switched.
> 
> I don't know whether this is the right solution, and I'm happy to try out other
> suggestions. But in my testing these patches proved effective in consistently
> switching heavily loaded vhost kthreads almost immediately.
> 
> To: Josh Poimboeuf <jpoimboe@kernel.org>
> To: Jiri Kosina <jikos@kernel.org>
> To: Miroslav Benes <mbenes@suse.cz>
> To: Petr Mladek <pmladek@suse.com>
> To: Joe Lawrence <joe.lawrence@redhat.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>
> To: Jason Wang <jasowang@redhat.com>
> Cc: live-patching@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

Don't know enough about live patching to judge this.

I'll let livepatch maintainers judge this, and merge through
the livepatch tree if appropriate. For that:
Acked-by: Michael S. Tsirkin <mst@redhat.com>
but pls underestand this is more a 'looks ok superficially and
I don't have better ideas'  than 'I have reviewed this thoroughly'.

> 
> ---
> Seth Forshee (DigitalOcean) (2):
>       livepatch: add an interface for safely switching kthreads
>       vhost: check for pending livepatches from vhost worker kthreads
> 
>  drivers/vhost/vhost.c         |  4 ++++
>  include/linux/livepatch.h     |  2 ++
>  kernel/livepatch/transition.c | 11 +++++++++++
>  3 files changed, 17 insertions(+)
> ---
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> change-id: 20230120-vhost-klp-switching-ba9a3ae38b8a
> 
> Best regards,
> -- 
> Seth Forshee (DigitalOcean) <sforshee@kernel.org>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
