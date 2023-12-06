Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718B2DF88
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 10:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A9FD801EC
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 10:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A9FD801EC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zy4LZv1aq086
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 10:40:02 +0000 (UTC)
X-Greylist: delayed 2595 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 06 Dec 2023 10:40:01 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D353B801CF
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D353B801CF
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 10:40:01 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rAoe1-0001Jn-NU; Wed, 06 Dec 2023 10:56:41 +0100
Message-ID: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
Date: Wed, 6 Dec 2023 10:56:40 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1054514: linux-image-6.1.0-13-amd64: Debian VM with qxl
 graphics freezes frequently
Content-Language: en-US, de-DE
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: 1054514@bugs.debian.org, Dave Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Timo Lindfors <timo.lindfors@iki.fi>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <alpine.DEB.2.20.2310242308150.28457@mail.home>
 <ZTgydqRlK6WX_b29@eldamar.lan>
 <alpine.DEB.2.20.2310250027230.28685@mail.home>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <alpine.DEB.2.20.2310250027230.28685@mail.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701859201;b8ed3364;
X-HE-SMSGID: 1rAoe1-0001Jn-NU

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Gerd, it seems this regression[1] fell through the cracks. Could you
please take a look? Or is there a good reason why this can't be
addressed? Or was it dealt with and I just missed it?

[1] apparently caused by 5a838e5d5825c8 ("drm/qxl: simplify
qxl_fence_wait") [v5.13-rc1] from Gerd; for details see
https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 24.10.23 23:39, Timo Lindfors wrote:
> Hi,
> 
> On Tue, 24 Oct 2023, Salvatore Bonaccorso wrote:
>> Thanks for the excelent constructed report! I think it's best to
>> forward this directly to upstream including the people for the
>> bisected commit to get some idea.
> 
> Thanks for the quick reply!
> 
>> Can you reproduce the issue with 6.5.8-1 in unstable as well?
> 
> Unfortunately yes:
> 
> ansible@target:~$ uname -r
> 6.5.0-3-amd64
> ansible@target:~$ time sudo ./reproduce.bash
> Wed 25 Oct 2023 12:27:00 AM EEST starting round 1
> Wed 25 Oct 2023 12:27:24 AM EEST starting round 2
> Wed 25 Oct 2023 12:27:48 AM EEST starting round 3
> bug was reproduced after 3 tries
> 
> real    0m48.838s
> user    0m1.115s
> sys     0m45.530s
> 
> I also tested upstream tag v6.6-rc6:
> 
> ...
> + detected_version=6.6.0-rc6
> + '[' 6.6.0-rc6 '!=' 6.6.0-rc6 ']'
> + exec ssh target sudo ./reproduce.bash
> Wed 25 Oct 2023 12:37:16 AM EEST starting round 1
> Wed 25 Oct 2023 12:37:42 AM EEST starting round 2
> Wed 25 Oct 2023 12:38:10 AM EEST starting round 3
> Wed 25 Oct 2023 12:38:36 AM EEST starting round 4
> Wed 25 Oct 2023 12:39:01 AM EEST starting round 5
> Wed 25 Oct 2023 12:39:27 AM EEST starting round 6
> bug was reproduced after 6 tries
> 
> 
> For completeness, here is also the grub_set_default_version.bash script
> that I had to write to automate this (maybe these could be in debian
> wiki?):
> 
> #!/bin/bash
> set -x
> 
> version="$1"
> 
> idx=$(expr $(grep "menuentry " /boot/grub/grub.cfg | sed 1d |grep -n
> "'Debian GNU/Linux, with Linux $version'"|cut -d: -f1) - 1)
> exec sudo grub-set-default "1>$idx"
> 
> 
> 
> -Timo
> 
> 
> 
