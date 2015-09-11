From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Fri, 11 Sep 2015 08:48:08 +0100
Message-ID: <CAJSP0QXbjY5kbz0jTJSDyo=Zh9B+DRZorTY0m3bRC8yhJT=Nvw@mail.gmail.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441906098.18716.21.camel@ssi>
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

On Thu, Sep 10, 2015 at 6:28 PM, Ming Lin <mlin@kernel.org> wrote:
> On Thu, 2015-09-10 at 15:38 +0100, Stefan Hajnoczi wrote:
>> On Thu, Sep 10, 2015 at 6:48 AM, Ming Lin <mlin@kernel.org> wrote:
>> > These 2 patches added virtio-nvme to kernel and qemu,
>> > basically modified from virtio-blk and nvme code.
>> >
>> > As title said, request for your comments.
>> >
>> > Play it in Qemu with:
>> > -drive file=disk.img,format=raw,if=none,id=D22 \
>> > -device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4
>> >
>> > The goal is to have a full NVMe stack from VM guest(virtio-nvme)
>> > to host(vhost_nvme) to LIO NVMe-over-fabrics target.
>>
>> Why is a virtio-nvme guest device needed?  I guess there must either
>> be NVMe-only features that you want to pass through, or you think the
>> performance will be significantly better than virtio-blk/virtio-scsi?
>
> It simply passes through NVMe commands.

I understand that.  My question is why the guest needs to send NVMe commands?

If the virtio_nvme.ko guest driver only sends read/write/flush then
there's no advantage over virtio-blk.

There must be something you are trying to achieve which is not
possible with virtio-blk or virtio-scsi.  What is that?

Stefan
