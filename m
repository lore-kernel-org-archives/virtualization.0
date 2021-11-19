Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15FC433EF
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 12:47:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC98761ACE
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 12:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC98761ACE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9725360656;
	Fri, 19 Nov 2021 12:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CazdXb8b-ldY; Fri, 19 Nov 2021 12:47:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E465361BF4;
	Fri, 19 Nov 2021 12:47:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C631BC001E;
	Fri, 19 Nov 2021 12:47:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E961AC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 12:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E490761BF4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 12:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHR7hNkQRmTA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 12:47:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A60460656
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 12:47:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="258199391"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; d="scan'208";a="258199391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 04:47:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; d="scan'208";a="507883791"
Received: from sgconnee-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.252.21.83])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 04:47:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Alejandro Colomar <alx.manpages@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211119113644.1600-1-alx.manpages@gmail.com>
Date: Fri, 19 Nov 2021 14:47:08 +0200
Message-ID: <87mtm0jos3.fsf@intel.com>
MIME-Version: 1.0
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
 Corey Minyard <cminyard@mvista.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Chris Mason <clm@fb.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ketan Mukadam <ketan.mukadam@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, linux-scsi@vger.kernel.org,
 Subbu Seetharaman <subbu.seetharaman@broadcom.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-acpi@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Borislav Petkov <bp@suse.de>,
 virtualization@lists.linux-foundation.org, Len Brown <lenb@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org,
 Josef Bacik <josef@toxicpanda.com>,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 "John S . Gruber" <JohnSGruber@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org
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

On Fri, 19 Nov 2021, Alejandro Colomar <alx.manpages@gmail.com> wrote:
> Hi all,
>
> I simplified some xxxof() macros,
> by adding a new macro memberof(),
> which implements a common operation in many of them.
>
> I also splitted many of those macros into tiny headers,
> since I noticed that touching those headers implied
> recompiling almost the whole kernel.
>
> Hopefully after this patch there will be less
> things to recompile after touching one of those.
>
> Having simpler headers means that now one can
> include one of those without pulling too much stuff
> that might break other stuff.
>
> I removed some unnecessary casts too.
>
> Every few commits in this series
> and of course after the last commit
> I rebuilt the kernel and run for a while with it without any problems.
>
> Please note that I have written very few kernel code
> and for example some files wouldn't let me include some of these files,
> so I didn't change those.
>
> What I mean is that,
> even though this is super obvious and shouldn't break stuff,
> and I'm not new to C,
> I'm quite new to the kernel,
> and ask that reviewers take deep look, please.
>
>
> In the first and second commits
> I changed a lot of stuff in many parts,
> and that's why I CCd so many people (also in this cover letter).
> However, to avoid spamming,
> and since it would be a nightmare to
> find all the relevant people affected in so many different areas,
> I only CCd in 01, 02 and in the cover letter.
> If anyone is interested in reading the full patch set,
> I sent it to the LKML.

I think with the patch split you have this would be a nightmare to get
merged. Please consider refactoring the headers first, and once those
are reviewed and merged, you can proceed with using them elsewhere. For
example, we'd want the drm/i915 changes in patches separate from changes
to other drivers or the core headers.

BR,
Jani.



>
>
> Thanks,
> Alex
>
>
> Alejandro Colomar (17):
>   linux/container_of.h: Add memberof(T, m)
>   Use memberof(T, m) instead of explicit NULL dereference
>   Replace some uses of memberof() by its wrappers
>   linux/memberof.h: Move memberof() to separate header
>   linux/typeof_member.h: Move typeof_member() to a separate header
>   Simplify sizeof(typeof_member()) to sizeof_field()
>   linux/NULL.h: Move NULL to a separate header
>   linux/offsetof.h: Move offsetof(T, m) to a separate header
>   linux/offsetof.h: Implement offsetof() in terms of memberof()
>   linux/container_of.h: Implement container_of_safe() in terms of
>     container_of()
>   linux/container_of.h: Cosmetic
>   linux/container_of.h: Remove unnecessary cast to (void *)
>   linux/sizeof_field.h: Move sizeof_field(T, m) to a separate header
>   include/linux/: Include a smaller header if just for NULL
>   linux/offsetofend.h: Move offsetofend(T, m) to a separate header
>   linux/array_size.h: Move ARRAY_SIZE(arr) to a separate header
>   include/: Include <linux/array_size.h> for ARRAY_SIZE()
>
>  arch/x86/include/asm/bootparam_utils.h        |  3 +-
>  arch/x86/kernel/signal_compat.c               |  5 ++--
>  drivers/gpu/drm/i915/i915_sw_fence.c          |  1 +
>  drivers/gpu/drm/i915/i915_utils.h             |  5 ++--
>  drivers/gpu/drm/i915/intel_runtime_pm.h       |  3 +-
>  drivers/net/ethernet/emulex/benet/be.h        | 10 +++----
>  drivers/net/ethernet/i825xx/ether1.c          |  7 +++--
>  drivers/platform/x86/wmi.c                    |  3 +-
>  drivers/scsi/be2iscsi/be.h                    | 12 ++++----
>  drivers/scsi/be2iscsi/be_cmds.h               |  5 +++-
>  fs/btrfs/ctree.h                              |  5 ++--
>  fs/proc/inode.c                               |  1 +
>  include/acpi/actypes.h                        |  4 ++-
>  include/crypto/internal/blake2b.h             |  1 +
>  include/crypto/internal/blake2s.h             |  1 +
>  include/crypto/internal/chacha.h              |  1 +
>  include/drm/drm_mipi_dbi.h                    |  1 +
>  include/drm/drm_mode_object.h                 |  1 +
>  include/kunit/test.h                          |  1 +
>  include/linux/NULL.h                          | 10 +++++++
>  include/linux/arm_ffa.h                       |  1 +
>  include/linux/array_size.h                    | 15 ++++++++++
>  include/linux/blk_types.h                     |  1 +
>  include/linux/can/core.h                      |  1 +
>  include/linux/clk-provider.h                  |  1 +
>  include/linux/container_of.h                  | 28 ++++++++++-------
>  include/linux/counter.h                       |  1 +
>  include/linux/crash_core.h                    |  1 +
>  include/linux/efi.h                           |  1 +
>  include/linux/extable.h                       |  2 +-
>  include/linux/f2fs_fs.h                       |  1 +
>  include/linux/filter.h                        |  3 ++
>  include/linux/fs.h                            |  1 +
>  include/linux/genl_magic_func.h               |  1 +
>  include/linux/hashtable.h                     |  1 +
>  include/linux/ieee80211.h                     |  1 +
>  include/linux/kbuild.h                        |  3 ++
>  include/linux/kernel.h                        |  7 +----
>  include/linux/kfifo.h                         |  1 +
>  include/linux/kvm_host.h                      |  3 ++
>  include/linux/libata.h                        |  1 +
>  include/linux/llist.h                         |  1 +
>  include/linux/memberof.h                      | 11 +++++++
>  include/linux/mlx5/device.h                   |  1 +
>  include/linux/mlx5/driver.h                   |  1 +
>  include/linux/mm_types.h                      |  1 +
>  include/linux/moduleparam.h                   |  3 ++
>  include/linux/mtd/rawnand.h                   |  1 +
>  include/linux/netdevice.h                     |  1 +
>  include/linux/netfilter.h                     |  1 +
>  include/linux/nvme-fc.h                       |  2 ++
>  include/linux/offsetof.h                      | 17 +++++++++++
>  include/linux/offsetofend.h                   | 19 ++++++++++++
>  include/linux/pagemap.h                       |  1 +
>  include/linux/phy.h                           |  1 +
>  include/linux/phy_led_triggers.h              |  1 +
>  include/linux/pinctrl/machine.h               |  1 +
>  include/linux/property.h                      |  1 +
>  include/linux/rcupdate.h                      |  1 +
>  include/linux/rcupdate_wait.h                 |  1 +
>  include/linux/regmap.h                        |  1 +
>  include/linux/sched/task.h                    |  1 +
>  include/linux/sizeof_field.h                  | 14 +++++++++
>  include/linux/skb_array.h                     |  1 +
>  include/linux/skbuff.h                        |  1 +
>  include/linux/skmsg.h                         |  3 ++
>  include/linux/slab.h                          |  2 ++
>  include/linux/spinlock_types.h                |  1 +
>  include/linux/stddef.h                        | 30 +++----------------
>  include/linux/string.h                        |  5 +++-
>  include/linux/surface_aggregator/controller.h |  1 +
>  include/linux/surface_aggregator/serial_hub.h |  1 +
>  include/linux/swap.h                          |  1 +
>  include/linux/ti-emif-sram.h                  |  1 +
>  include/linux/typeof_member.h                 | 11 +++++++
>  include/linux/ucs2_string.h                   |  2 +-
>  include/linux/vdpa.h                          |  1 +
>  include/linux/virtio_config.h                 | 17 ++++++-----
>  include/linux/wireless.h                      |  2 ++
>  include/net/bond_3ad.h                        |  1 +
>  include/net/dsa.h                             |  1 +
>  include/net/ip_vs.h                           |  1 +
>  include/net/netfilter/nf_conntrack_tuple.h    |  1 +
>  include/net/netfilter/nf_tables.h             |  1 +
>  include/net/netlink.h                         |  1 +
>  include/rdma/uverbs_ioctl.h                   |  1 +
>  include/rdma/uverbs_named_ioctl.h             |  1 +
>  include/scsi/scsi_host.h                      |  1 +
>  include/sound/soc-dapm.h                      |  1 +
>  include/sound/soc.h                           |  1 +
>  include/trace/events/wbt.h                    |  1 +
>  include/uapi/linux/netfilter/xt_sctp.h        |  1 +
>  include/xen/hvm.h                             |  1 +
>  kernel/kallsyms.c                             |  3 +-
>  94 files changed, 255 insertions(+), 79 deletions(-)
>  create mode 100644 include/linux/NULL.h
>  create mode 100644 include/linux/array_size.h
>  create mode 100644 include/linux/memberof.h
>  create mode 100644 include/linux/offsetof.h
>  create mode 100644 include/linux/offsetofend.h
>  create mode 100644 include/linux/sizeof_field.h
>  create mode 100644 include/linux/typeof_member.h

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
