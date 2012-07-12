From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Thu, 12 Jul 2012 12:06:01 -0400
Message-ID: <x498vepklqu.fsf__16840.7349651263$1342460718$gmane$org@segfault.boston.devel.redhat.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342107302-28116-1-git-send-email-asias@redhat.com> (Asias He's
	message of "Thu, 12 Jul 2012 23:35:01 +0800")
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:

> Hi folks,
>
> This patchset adds vhost-blk support. vhost-blk is a in kernel virito-blk
> device accelerator. Compared to userspace virtio-blk implementation, vhost-blk
> gives about 5% to 15% performance improvement.
>
> Asias He (5):
>   aio: Export symbols and struct kiocb_batch for in kernel aio usage
>   eventfd: Export symbol eventfd_file_create()
>   vhost: Make vhost a separate module
>   vhost-net: Use VHOST_NET_FEATURES for vhost-net
>   vhost-blk: Add vhost-blk support

I only saw patches 0 and 1.  Where are the other 4?  If the answer is,
"not on lkml," then please resend them, CC'ing lkml.  I'd like to be
able to see the usage of the aio routines.

Cheers,
Jeff
