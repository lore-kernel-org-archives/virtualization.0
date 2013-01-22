From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/6] tools/virtio: add vring_test.
Date: Wed, 23 Jan 2013 09:33:44 +1030
Message-ID: <87k3r44y7j.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<1358418584-26345-4-git-send-email-rusty@rustcorp.com.au>
	<50FE4CDD.9040005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50FE4CDD.9040005@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:

> On 01/17/2013 06:29 PM, Rusty Russell wrote:
>> This is mainly to test the drivers/vhost/vringh.c code, but it also
>> uses the drivers/virtio/virtio_ring.c code for the guest side.
>
> vringh_test.c does not compile here:
> (This series on top of 9a9284153d965a57edc7162a8e57c14c97f3a935)
>
> $ cd tools/virtio
> $ make
> cc -g -O2 -Wall -I. -I ../../usr/include/ -Wno-pointer-sign
> -fno-strict-overflow  -MMD    vringh_test.c   -o vringh_test
> In file included from ./linux/vringh.h:1:0,
>                  from ./../../drivers/vhost/vringh.c:6,
>                  from vringh_test.c:7:
> ./linux/../../../include/linux/vringh.h:27:28: fatal error:
> uapi/linux/uio.h: No such file or directory

Oops, I forgot to add the file... it's a one-liner:

tools/virtio/uapi/linux/uio.h:
#include <sys/uio.h>

I'll make a new branch for this, called vringh.  It'll probably rebase
as I neaten things up, but I'll try not to go crazy...

Thanks,
Rusty.
