Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A8EC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 01:28:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A3960EBC
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 01:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92A3960EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57AB060642;
	Fri, 23 Jul 2021 01:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otDvWtPAXEGB; Fri, 23 Jul 2021 01:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA77C60622;
	Fri, 23 Jul 2021 01:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AE40C001A;
	Fri, 23 Jul 2021 01:28:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EA6EC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D55083412
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2A_YSUp0THy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:28:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D6D983410
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 01:28:47 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id e19so1249291ejs.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 18:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Netb+ect03+36FLGwDHd6H/dLS0TneICG6z+ys8RBN4=;
 b=jd75CZ9uyiu7T5nJkgc6IoWFAvuBhHaJ2SgKAP4XsSSzq73Xx283ucqTgWtAfHNuqN
 syMFdfhLRxRWvucUws8Qp+KKWY/E14Z2aqna7FqFNP7FWV6tlRjfZyYcokAxWiJBWqk0
 yvS92VCOqgl6oNuRRoBM+iQv/MlPBzHASqVHmpr/h4E2YokVM0lY+KUzTzYn65vSgawx
 crVLsTZMqBfaGY5wO5j9eAPqWwlL5QsxwxMV5MwIRuxfq2cBYQ7ItuG3ipeRfI818Wkf
 8FAf7S1u6+3rX3ihs2bwZWpAdt4VbCs8oPMJYZN/YRF3vX4tOHtrvicRQhncPygEns9w
 uMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Netb+ect03+36FLGwDHd6H/dLS0TneICG6z+ys8RBN4=;
 b=b7PRl/myxk4HiFYfZ7Zk01Ida4hDnXoxU8ggCzfziUILBoDWDm18Oe8jKl56hTUTBQ
 G33TnY+wfKGDgp9rgM3jghzuP6iEwflAoAaQ1Ma/25XxQquoj+CagTHQ7yLEP1vbKpOO
 CiZoneM/fAC6EZYUgww1ziBUPQuw67capviYX9Lxaqf5Rr+aOz9DDYlKCrietk+xJx77
 8sybP9kGPkEZAy8qUTxbsOKEQvznr/6pmCyEv/jCEGgKXD5j3GhmSPun1XvcGg1UYxMX
 yG/nd9TlJKSQvSaoj4jeoQCoJE0NrK0ealRpu6CAahtSSqRT62S3SoQZ3qi3Svri19gw
 /HnQ==
X-Gm-Message-State: AOAM532aLPirWsDj20A1WJFacz9HcGkhAiWAKA1tYimzxbVDxov0FNj1
 3R1Nqh+hd56v0bf6heoHbPCF9jK4L2YEYQl6ssva+ciFGCo=
X-Google-Smtp-Source: ABdhPJwsNGw2VvPCLcsOKeXj5j9KiWbeRSlK189AMju2NBWTm1qMTx7tDIWWOM4mDXNn2ySIhJim9s4xLyeYzxuHJDc=
X-Received: by 2002:a17:907:7293:: with SMTP id
 dt19mr2504373ejc.122.1627003725810; 
 Thu, 22 Jul 2021 18:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
In-Reply-To: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Fri, 23 Jul 2021 09:28:09 +0800
Message-ID: <CAMDZJNXthLpAPHn62gA1qSmfLOoDFcFGdgnNwW6yA+wjn0FjgQ@mail.gmail.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
To: Ivan <ivan@prestigetransportation.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Fri, Jul 23, 2021 at 7:29 AM Ivan <ivan@prestigetransportation.com> wrote:
>
> Dear Sir,
>
> I've been plagued with kernel panics recently. The problem is easily
> reproducible on any virtual machine that uses the virtio-net driver
> from stock Linux kernel. Simply isuse this command:
>
> echo 1 > /proc/sys/net/ipv4/ip_forward
> ...and the kernel panics.
>
> Is there any way we can possibly fix this?
Hi
what is your kernel version, and features of your netdevice.
I set the option, and the kernel does not panic. 5.13.0+

echo 1 > /proc/sys/net/ipv4/ip_forward

root@localhost-upstream:~# ethtool -k eth0
Features for eth0:
rx-checksumming: on [fixed]
tx-checksumming: on
tx-checksum-ipv4: off [fixed]
tx-checksum-ip-generic: on
tx-checksum-ipv6: off [fixed]
tx-checksum-fcoe-crc: off [fixed]
tx-checksum-sctp: off [fixed]
scatter-gather: on
tx-scatter-gather: on
tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
tx-tcp-segmentation: on
tx-tcp-ecn-segmentation: on
tx-tcp-mangleid-segmentation: off
tx-tcp6-segmentation: on
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off
rx-vlan-offload: off [fixed]
tx-vlan-offload: off [fixed]
ntuple-filters: off [fixed]
receive-hashing: off [fixed]
highdma: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: on [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: off [fixed]
tx-gre-csum-segmentation: off [fixed]
tx-ipxip4-segmentation: off [fixed]
tx-ipxip6-segmentation: off [fixed]
tx-udp_tnl-segmentation: off [fixed]
tx-udp_tnl-csum-segmentation: off [fixed]
tx-gso-partial: off [fixed]
tx-tunnel-remcsum-segmentation: off [fixed]
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: off [fixed]
tx-gso-list: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: off [fixed]
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: off [fixed]
tls-hw-tx-offload: off [fixed]
tls-hw-rx-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
rx-gro-list: off
macsec-hw-offload: off [fixed]
rx-udp-gro-forwarding: off
hsr-tag-ins-offload: off [fixed]
hsr-tag-rm-offload: off [fixed]
hsr-fwd-offload: off [fixed]
hsr-dup-offload: off [fixed]

> kernel: ------------[ cut here ]------------
> kernel: netdevice: eth0: failed to disable LRO!
> kernel: WARNING: CPU: 1 PID: 424 at net/core/dev.c:1768
> dev_disable_lro+0x108/0x150
> kernel: Modules linked in: nls_iso8859_1 nls_cp437 vfat fat usbhid
> atkbd libps2 ahci libahci virtio_net ohci_pci net_failover failover
> i8042 serio lpc_ich mfd_core libata ohci_hcd ehci_pci ehci_hcd usbcore
> rng_core i2c_piix4 i2c_core virtio_pci usb_common
> virtio_pci_modern_dev virtio_ring virtio loop unix
> kernel: CPU: 1 PID: 424 Comm: bash Not tainted 5.13.4-gnu.4-NuMini #1
> kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> kernel: RIP: 0010:dev_disable_lro+0x108/0x150
> kernel: Code: ae 88 74 14 be 25 00 00 00 48 89 df e8 f1 54 ed ff 48 85
> c0 48 0f 44 eb 4c 89 e2 48 89 ee 48 c7 c7 00 c6 ae 88 e8 7a 76 0c 00
> <0f> 0b e9 2d ff ff ff 80 3d e8 70 97 00 00 49 c7 c4 73 bb ae 88 75
> kernel: RSP: 0018:ffffb596c0237d80 EFLAGS: 00010282
> kernel: RAX: 0000000000000000 RBX: ffff9af9c1835000 RCX: ffff9af9fed17538
> kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9af9fed17530
> kernel: RBP: ffff9af9c1835000 R08: ffffffff88c96ac8 R09: 0000000000004ffb
> kernel: R10: 00000000fffff000 R11: 3fffffffffffffff R12: ffffffff88ac7c3d
> kernel: R13: 0000000000000000 R14: ffffffff88cb2748 R15: ffff9af9c12166c8
> kernel: FS:  00007fd4911b8740(0000) GS:ffff9af9fed00000(0000)
> knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000532008 CR3: 000000000115c000 CR4: 00000000000406e0
> kernel: Call Trace:
> kernel:  devinet_sysctl_forward+0x1ac/0x1e0
> kernel:  proc_sys_call_handler+0x127/0x230
> kernel:  new_sync_write+0x114/0x1a0
> kernel:  vfs_write+0x18c/0x220
> kernel:  ksys_write+0x5a/0xd0
> kernel:  do_syscall_64+0x45/0x80
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> kernel: RIP: 0033:0x7fd4912b79b3
> kernel: Code: 8b 15 b9 74 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb
> b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05
> <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> kernel: RSP: 002b:00007ffe96fdd858 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> kernel: RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4912b79b3
> kernel: RDX: 0000000000000002 RSI: 0000000000536810 RDI: 0000000000000001
> kernel: RBP: 0000000000536810 R08: 000000000000000a R09: 0000000000000000
> kernel: R10: 00007fd49134f040 R11: 0000000000000246 R12: 0000000000000002
> kernel: R13: 00007fd4913906c0 R14: 00007fd49138c520 R15: 00007fd49138b920
> kernel: ---[ end trace ee7985b10570603d ]---
> kernel: ------------[ cut here ]------------



-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
