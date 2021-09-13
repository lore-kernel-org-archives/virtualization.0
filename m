Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 14:49:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB8460698
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 14:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AB8460698
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E687C40461;
	Mon, 13 Sep 2021 14:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xV_GXWcc7Lcs; Mon, 13 Sep 2021 14:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9781B40472;
	Mon, 13 Sep 2021 14:49:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9CFC0011;
	Mon, 13 Sep 2021 14:49:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 777B2C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 14:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6123140402
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 14:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DirTTxNHCjfA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 14:49:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC11540430
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 14:49:07 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 y3-20020a4ab403000000b00290e2a52c71so3477334oon.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=q4jWiRn0EuHca/77FmGUXr9JidHyCu6zqvvX4/H4GKc=;
 b=Oz4McVU7NUlBp5WhDmQCi6Kh7HTc5Rl7MA17CpdMCeyAedY8PqerQ5ZMsO/oZQTcsq
 ebPiBeex7sZpeptcYzJqjjwz6CrqjN1Or0saJf+j4AYRMZlE99FzKEif5S14Ehj9nh3t
 O4MooFl+HRGB5LkqXqsakryHdEoj3qZoK7HykK67I0OTTEkZfLpif0em+R9t1LR5KSKI
 3Y0hx5mRM2GJ6yxywzA5zISi0maQgwJZZr3lyAxVL+1TEq905c6zvmoWmm7RffqxhZwJ
 wpnn6Js5pBeJR40DrhMSD3euygHa1KIGBT6y6iv+JIIexebTrbLrolzv8kjSKR+p/wCa
 KWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=q4jWiRn0EuHca/77FmGUXr9JidHyCu6zqvvX4/H4GKc=;
 b=1n5Sl9gy6X0LkCm5ax2H1I3DPbJAC2FAKF5esV3cnawV3Z1atf+KsuCJmYA3ajoGkf
 kLfJWhjlclKae4Un2GJoSHm9G0Da/WiMXRL4eSR/sJFHTMOH0632MfFBWB45ZmqWclbS
 4hEM/gcnRdW+MiiDe7KMpwTv7SJn4TsMhh0darJXNedQfCzziYHhM+UXggPMmZodR+5I
 CrAPQtxSCGrJJljtuP2XTQyBVx7mh4ZeY3b4KD5HCxGq8eWBJANnKs7kHxjVkJGfR63/
 jEoeMlKtLC0Mjqp/Cy2lqdnC4OGHlxxmH+5lxY2Nbi+0QurADin1R8PGKUKlxcn+OkSn
 /qKQ==
X-Gm-Message-State: AOAM530iEzLVfFalImC9nLzOdZB0Vm4kAF5UvfOMk5JueG+E++RB6qIr
 xt9ugl4uzBTq4KWbFQI4ru4=
X-Google-Smtp-Source: ABdhPJzBzQ6oFo9K/fhw61EZCPISGz1/7xiPnY6usVy1xPG080I7ZprWhAO98fijOUj6RgBYRpPmbw==
X-Received: by 2002:a4a:a8c9:: with SMTP id r9mr9488940oom.49.1631544546943;
 Mon, 13 Sep 2021 07:49:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b2sm1893686ook.46.2021.09.13.07.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 07:49:06 -0700 (PDT)
Date: Mon, 13 Sep 2021 07:49:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210913144905.GA1267554@roeck-us.net>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bill Mills <bill.mills@linaro.org>
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

On Mon, Jul 26, 2021 at 10:21:45AM +0530, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This patch causes a boot failure on sparc64: The virtio device no longer
instantiates. Reverting this patch fixes the problem. Bisect log attached.

Guenter

---
# bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
# good: [926de8c4326c14fcf35f1de142019043597a4fac] Merge tag 'acpi-5.15-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect start 'HEAD' '926de8c4326c'
# good: [8177a5c96229ff24da1e362789e359b68b4f34f5] Merge tag 'libata-5.15-2021-09-11' of git://git.kernel.dk/linux-block
git bisect good 8177a5c96229ff24da1e362789e359b68b4f34f5
# bad: [78e709522d2c012cb0daad2e668506637bffb7c2] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad 78e709522d2c012cb0daad2e668506637bffb7c2
# bad: [7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca] Documentation: Add documentation for VDUSE
git bisect bad 7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca
# bad: [41116599a0731f4cd451e9d191d879ab45e31945] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
git bisect bad 41116599a0731f4cd451e9d191d879ab45e31945
# good: [5262912ef3cfc5e518892c3d67fb36412cb813e2] vdpa/mlx5: Add support for control VQ and MAC setting
git bisect good 5262912ef3cfc5e518892c3d67fb36412cb813e2
# good: [7f815fce08d563006e43d1b7d2f9a0a4f3b832f3] dt-bindings: i2c: Add bindings for i2c-virtio
git bisect good 7f815fce08d563006e43d1b7d2f9a0a4f3b832f3
# good: [d5a8680dfab0547a4ecd708b1fe9de48598a6757] uapi: virtio_ids: Sync ids with specification
git bisect good d5a8680dfab0547a4ecd708b1fe9de48598a6757
# bad: [9af8f1061646e8e22b66413bedf7b3e2ab3d69e5] virtio/vsock: rename 'EOR' to 'EOM' bit.
git bisect bad 9af8f1061646e8e22b66413bedf7b3e2ab3d69e5
# bad: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
git bisect bad 694a1116b405d887c893525a6766b390989c8606
# first bad commit: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
