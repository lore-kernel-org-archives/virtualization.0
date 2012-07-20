From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND 0/5] Add vhost-blk support
Date: Fri, 20 Jul 2012 22:30:35 +0300
Message-ID: <20120720193035.GA20031__33375.5966312767$1342812624$gmane$org@redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1342169711-12386-1-git-send-email-asias@redhat.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Moyer <jmoyer@redhat.com>, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 13, 2012 at 04:55:06PM +0800, Asias He wrote:
> 
> Hi folks,
> 
> [I am resending to fix the broken thread in the previous one.]
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


OK so given the state it's in, and assuming you think it is helpful
to let it mature in tree and not out of tree, I think it's
reasonable to try to do it like tcm_vhost is going to do it:
- send me changes to vhost core ASAP (and keep it minimal, e.g.
  use your own header file to export to userspace)
- for other stuff - put in drivers/staging, and ask Greg to merge

-- 
MST
