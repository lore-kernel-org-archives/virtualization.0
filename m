Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58E2F0661
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834579; cv=none; b=dfV/iWY+PAQdwxV2CTtGpu2nzDSLnLF8SVoJoxpAIuZxeLIFv1PhShOrkF1JYSrC5ImZ2aKnUK/Kxw8p1M+kTxJ+9+qJjLIAZlKh4PchPvLnD61KYqXAiCW6bdxQBOM0MkJRZ81tN8vrqiiEdrd0HA1hnBP71gl1y9AZy6E2hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834579; c=relaxed/simple;
	bh=fbxDeYvyvxjoR5ZFTwmONVXbzci/IqOHoqKa7M5aQpg=;
	h=From:Message-ID:Date:Subject:To:MIME-Version:Content-Type; b=lWVx8uhSbBSA0KFcHa2N6xcnV3sXp3A4fLp6TaVLDWK7PM6driWPgqf3sz26HFmGbPL8wpujO8J+f9k1ElOoEjLLaWADjXHyxmYw9HEODWqZxGPk7uf2+bIPd0RWumCgFHrZYmfRy24j3xVpRH4rnXPLtW73NdIF/+qeRBkL2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=G69/3lBk; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=TkEO/kMc; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="G69/3lBk";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="TkEO/kMc"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834570; x=1788439370; bh=xolQtDTvcx7Ik7f2ae
	NUamIlZy97liYAIRbX4sTp+f0=; b=G69/3lBklflC7YrNW/j+EJdPep2EqfmTxt80/w9Q5lVNp
	ORG5XAMIXdM4uqq3RWLiuXGpGM8Y5ArL7E3aJZL/s68+v1E6RSWuG+o2E4rZ0W/y9xuJmOAzLzD
	r9d34bizivge2OnTh9/OVQFiz7n0rHb2zkfTj1JrhWcBSRPG/Be3rco4AiDUy4HcBSKEfjAAry9
	8RUYrdpdJB+sUDEQXqDbGbQMgLQTUMv0ZfS9GvfmnS9VYWc4SFq4n1pptPc3QYwe8bzhGn+0CF5
	0/c+beysb4AMWn2RBa7IaOeFqaweeT4jJ3GdQGZ1AhfAIpaWb0+Q8N4mqxVHAbnRtqM5Yhfg==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=To:Subject:Date:From:Feedback-ID:from:reply-to:cc:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1787834570; x=1788439370; bh=xolQtDTvcx7Ik7f2ae
	NUamIlZy97liYAIRbX4sTp+f0=; b=TkEO/kMcXCLa1kpLf+TWbbklQigspml+s4nOGj+jKMaEN
	fYhepbWSUbrfyJWy9rfO/dCIgHRfcnOb8AFL33XWAfnoHyvtEz0iQr/K4NgBReD7uO+l8vA7lJC
	Tg6OVz5q43bLo2YVJ23eTAT7b2TlDB5GLHOuOtk57QPj9EvFJxNs2qySsqiIPF1jJ98/1dNFoX9
	/2PLtICTVA0ZwFEjIfaQK/RSaXt9Q/Y3F7EvOqWPLoqhDkn4w9I3b+f6m86FSP3CnIfYZCVNxWw
	+0mcMIW7ZQkHazuF7KQu3obChC5APDEv5xaW4TEbQZK/deJrEncE1R7xwYQkE3EPDYp73h9w==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+6dcbccedc9ec6452@bugs.sh>
Message-ID: <ILTHcT8oe1HP47sY25JVxssvKmkCTjYlX9Hs@bugs.sh>
Date: Thu, 27 Aug 2026 12:42:43 +0000
Subject: [BUG] drivers/vdpa: use-after-free in sk_skb_reason_drop()
To: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowangio@gmail.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?b?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "Parav Pandit" <parav@nvidia.com>, "Eli
 Cohen" <elic@nvidia.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/vdpa
    crash   use-after-free in sk_skb_reason_drop()
    commit  bd5f485f3f02 ("Merge tag 'soc-arm-7.3' of git://git.kernel.org/=
pub/scm/linux/kernel/git/soc/soc")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+6dcbccedc9ec6452@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/6dcbccedc9ec6452/patch.diff
        report.md   https://bugs.sh/b/6dcbccedc9ec6452/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  bd5f485f3f02 ("Merge tag 'soc-arm-7.3' of git://git.kern=
el.org/pub/scm/linux/kernel/git/soc/soc")
    VM setup       https://bugs.sh/b/6dcbccedc9ec6452/run.sh
    config         https://bugs.sh/b/6dcbccedc9ec6452/config.gz
    poc            https://bugs.sh/b/6dcbccedc9ec6452/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in sk_skb_reason_drop (./include/linux/inst=
rumented.h:82 ./include/linux/atomic/atomic-instrumented.h:32 ./include/lin=
ux/refcount.h:170 ./include/linux/skbuff.h:1290 net/core/skbuff.c:1220 net/=
core/skbuff.c:1249)
Read of size 4 at addr ffff888013ca3adc by task exploit/145
CPU: 1 UID: 65534 PID: 145 Comm: exploit Not tainted 7.2.0+ #8 PREEMPTLAZY
Call Trace:
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
sk_skb_reason_drop (./include/linux/instrumented.h:82 ./include/linux/atomi=
c/atomic-instrumented.h:32 ./include/linux/refcount.h:170 ./include/linux/s=
kbuff.h:1290 net/core/skbuff.c:1220 net/core/skbuff.c:1249)
vdpa_nl_cmd_dev_config_get_doit (./include/linux/skbuff.h:1323 ./include/li=
nux/skbuff.h:1332 ./include/net/netlink.h:1131 drivers/vdpa/vdpa.c:1324)
genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
netlink_rcv_skb (net/netlink/af_netlink.c:2556)
genl_rcv (net/netlink/genetlink.c:1218)
netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:134=
5)
netlink_sendmsg (net/netlink/af_netlink.c:1900)
__sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discrimi=
nator 1) net/socket.c:2277 (discriminator 1))
__x64_sys_sendto (net/socket.c:2284 net/socket.c:2280 net/socket.c:2280)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff888013ca3a00
which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 220 bytes inside of


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


