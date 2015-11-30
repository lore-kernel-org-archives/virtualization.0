From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Mon, 30 Nov 2015 15:20:39 -0800
Message-ID: <1448925639.27669.7.camel@ssi>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56531F5F.3050709@redhat.com>
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

On Mon, 2015-11-23 at 15:14 +0100, Paolo Bonzini wrote:
> 
> On 23/11/2015 09:17, Ming Lin wrote:
> > On Sat, 2015-11-21 at 14:11 +0100, Paolo Bonzini wrote:
> >>
> >> On 20/11/2015 01:20, Ming Lin wrote:
> >>> One improvment could be to use google's NVMe vendor extension that
> >>> I send in another thread, aslo here:
> >>> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext
> >>>
> >>> Qemu side:
> >>> http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=vhost-nvme.0
> >>> Kernel side also here:
> >>> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0
> >>
> >> How much do you get with vhost-nvme plus vendor extension, compared to
> >> 190 MB/s for QEMU?
> > 
> > There is still some bug. I'll update.
> 
> Sure.

Fixed it after Thanksgiving holiday :)
https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0-ext

Combined with previous test results(lower to higher):

qemu-nvme: 148MB/s
vhost-nvme + google-ext: 230MB/s
qemu-nvme + google-ext + eventfd: 294MB/s
virtio-scsi: 296MB/s
virtio-blk: 344MB/s

"vhost-nvme + google-ext" didn't get good enough performance.
Still tuning.
