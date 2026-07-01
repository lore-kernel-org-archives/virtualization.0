Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5348B39C;
	Wed,  1 Jul 2026 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912915; cv=none; b=R0iw+pHmaRVPDEiUslmV8U1ivi0gx5Ifkl9QKl3LEEvhLo8Sm7SlGiG8d2QFuKC+XsgtnE8VJgSptzjbTqmOWT/ecIBswkr+pkvfImz5SO5bQDEvDBja4E4Socy9R0kL/eo6F7kZIH03G3YEs/yY/m+dHSx2p3Nt2TFPY+4F6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912915; c=relaxed/simple;
	bh=8zmM3nS5JDP7Whs7pyvlwa6MpB93nmm41PuAEpM1spk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/pzyh2p74LRY8w5vKSwHoTO9Ykv9WDmaF68kX1xnnULDGeJ9Pm3qMjm+SZgCIM/DYlUhC1SRYhw6BScH/hzGMEZWoygvNbmbyKUYNAk8uhK5Qpy1qT6HWhL3Oi71Pq4MoMJqtcS1Jogs2wLwZavoIqheXo1RRtVFNA81uTSYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1aUVHJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1aUVHJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA0C1F00A3A;
	Wed,  1 Jul 2026 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782912912;
	bh=TDtIVXdwymmau5YBonxKDiyA8oWA/yXad6fZUU/kE9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1aUVHJVCw1/e9U+LeS6Rho8g5wTrGdzD/n79X6pXJxqKm+8m7rBfjUEDZjfeJbbH
	 A89qEU6wptFKuLN6DSUvfD8ex7+0hNZMZGWe9CIXxlBR/kNaBauELfJu4Smb8KZb62
	 0rbrTpTjD5T/cIYBxsxNUI167b6TSMoLE+3OLIyH2PABDt29z1I3DsULcE1Ws97x6v
	 vUs+pyVPVjIrjOB6DaccGEGSBbsQGsYDiJcBZACa3A7eaZrq2OjdPXL9x4X0cmex43
	 9r7KslF+GpNiliFN2ssox6ltqVIJLp6a4dIsDNKmDc4tDuh9Z7hiPmqdt0KPoXCla3
	 SQ2C6xlz+XBEQ==
From: SJ Park <sj@kernel.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: SJ Park <sj@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] tools/include: Include stdint.h for SIZE_MAX in overflow.h
Date: Wed,  1 Jul 2026 06:35:02 -0700
Message-ID: <20260701133503.41823-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629022124.131894-3-chenyichong@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 10:21:24 +0800 Yichong Chen <chenyichong@uniontech.com> wrote:

> tools/include/linux/overflow.h uses SIZE_MAX in its size helper
> functions.
> 
> Include stdint.h so tools users that include overflow.h without another
> SIZE_MAX provider can build.

On the latest mm-new reverting this patch (for test), I was able to build
tools/virtio.

    git checkout akpm.korg.mm/mm-new
    [...]
    HEAD is now at f5ea2fbe68e0c mm/swap, PM: hibernate: atomically replace hibernation pin
    $ git revert 9d462d8b9b705548451325ee4376dfd549e14aa2 -s --no-edit
    [detached HEAD f2202247e38d9] Revert "tools/include: include stdint.h for SIZE_MAX in overflow.h"
     Date: Wed Jul 1 06:33:03 2026 -0700
     1 file changed, 1 deletion(-)
    $ make -C tools/virtio/ clean
    make: Entering directory '/home/lkhack/worktree.linux/tools/virtio'
    rm -f *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
                  vhost_test/.*.cmd vhost_test/Module.symvers \
                  vhost_test/modules.order *.d
    make: Leaving directory '/home/lkhack/worktree.linux/tools/virtio'
    $ make -C tools/virtio/ test
    make: Entering directory '/home/lkhack/worktree.linux/tools/virtio'
    cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o virtio_test.o virtio_test.c
    cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o virtio_ring.o ../../drivers/virtio/virtio_ring.c
    cc -pthread  virtio_test.o virtio_ring.o   -o virtio_test
    cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o vringh_test.o vringh_test.c
    cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o vringh.o ../../drivers/vhost/vringh.c
    cc -pthread  vringh_test.o vringh.o virtio_ring.o   -o vringh_test
    cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register -pthread   -c -o vhost_net_test.o vhost_net_test.c
    cc -pthread  vhost_net_test.o virtio_ring.o   -o vhost_net_test
    make: Leaving directory '/home/lkhack/worktree.linux/tools/virtio'


Am I missing something?

> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  tools/include/linux/overflow.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/linux/overflow.h b/tools/include/linux/overflow.h
> index 3427d7880326..98963688143f 100644
> --- a/tools/include/linux/overflow.h
> +++ b/tools/include/linux/overflow.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +#include <stdint.h>
>  #ifndef __LINUX_OVERFLOW_H
>  #define __LINUX_OVERFLOW_H

Shouldn't the include placed after #define __LINUX_OVERFLOW_H ?


Thanks,
SJ

[...]
