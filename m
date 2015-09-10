From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Thu, 10 Sep 2015 15:38:48 +0100
Message-ID: <CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441864112-12765-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lin <mlin@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 10, 2015 at 6:48 AM, Ming Lin <mlin@kernel.org> wrote:
> These 2 patches added virtio-nvme to kernel and qemu,
> basically modified from virtio-blk and nvme code.
>
> As title said, request for your comments.
>
> Play it in Qemu with:
> -drive file=disk.img,format=raw,if=none,id=D22 \
> -device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4
>
> The goal is to have a full NVMe stack from VM guest(virtio-nvme)
> to host(vhost_nvme) to LIO NVMe-over-fabrics target.

Why is a virtio-nvme guest device needed?  I guess there must either
be NVMe-only features that you want to pass through, or you think the
performance will be significantly better than virtio-blk/virtio-scsi?

At first glance it seems like the virtio_nvme guest driver is just
another block driver like virtio_blk, so I'm not clear why a
virtio-nvme device makes sense.

> Now there are lots of duplicated code with linux/nvme-core.c and qemu/nvme.c.
> The ideal result is to have a multi level NVMe stack(similar as SCSI).
> So we can re-use the nvme code, for example
>
>                         .-------------------------.
>                         | NVMe device register    |
>   Upper level           | NVMe protocol process   |
>                         |                         |
>                         '-------------------------'
>
>
>
>               .-----------.    .-----------.    .------------------.
>  Lower level  |   PCIe    |    | VIRTIO    |    |NVMe over Fabrics |
>               |           |    |           |    |initiator         |
>               '-----------'    '-----------'    '------------------'

You mentioned LIO and SCSI.  How will NVMe over Fabrics be integrated
into LIO?  If it is mapped to SCSI then using virtio_scsi in the guest
and tcm_vhost should work.

Please also post virtio draft specifications documenting the virtio device.

Stefan
