From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Tue, 01 Dec 2015 08:26:11 -0800
Message-ID: <1448987171.3041.2.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448925639.27669.7.camel@ssi>
	<565DC48B.6030903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <565DC48B.6030903@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2015-12-01 at 17:02 +0100, Paolo Bonzini wrote:
> 
> On 01/12/2015 00:20, Ming Lin wrote:
> > qemu-nvme: 148MB/s
> > vhost-nvme + google-ext: 230MB/s
> > qemu-nvme + google-ext + eventfd: 294MB/s
> > virtio-scsi: 296MB/s
> > virtio-blk: 344MB/s
> > 
> > "vhost-nvme + google-ext" didn't get good enough performance.
> 
> I'd expect it to be on par of qemu-nvme with ioeventfd but the question
> is: why should it be better?  For vhost-net, the answer is that more
> zerocopy can be done if you put the data path in the kernel.
> 
> But qemu-nvme is already using io_submit for the data path, perhaps
> there's not much to gain from vhost-nvme...

What do you think about virtio-nvme+vhost-nvme?
I also have patch for vritio-nvme:
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-split/virtio

Just need to change vhost-nvme to work with it.

> 
> Paolo
> 
> > Still tuning.
