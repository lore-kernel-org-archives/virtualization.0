From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/2] virtio nvme
Date: Fri, 11 Sep 2015 11:54:02 -0700
Message-ID: <CAF1ivSZvWfBO3vMBvi7_CfM0SwtgyrSjvAWag4kNAdDOhL-Lsw@mail.gmail.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
	<CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>
	<1441906098.18716.21.camel@ssi>
	<CAJSP0QXbjY5kbz0jTJSDyo=Zh9B+DRZorTY0m3bRC8yhJT=Nvw@mail.gmail.com>
	<1441992101.802.11.camel@ssi>
	<CAJSP0QXz_w+FasdZ2zZsVmjuBmJLgAnrG5vV+c2eLr=pdnRm5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QXz_w+FasdZ2zZsVmjuBmJLgAnrG5vV+c2eLr=pdnRm5Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 11, 2015 at 10:53 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Sep 11, 2015 at 6:21 PM, Ming Lin <mlin@kernel.org> wrote:
>> On Fri, 2015-09-11 at 08:48 +0100, Stefan Hajnoczi wrote:
>>> On Thu, Sep 10, 2015 at 6:28 PM, Ming Lin <mlin@kernel.org> wrote:
>>> > On Thu, 2015-09-10 at 15:38 +0100, Stefan Hajnoczi wrote:
>>> >> On Thu, Sep 10, 2015 at 6:48 AM, Ming Lin <mlin@kernel.org> wrote:
>>> >> > These 2 patches added virtio-nvme to kernel and qemu,
>>> >> > basically modified from virtio-blk and nvme code.
>>> >> >
>>> >> > As title said, request for your comments.
>>> >> >
>>> >> > Play it in Qemu with:
>>> >> > -drive file=disk.img,format=raw,if=none,id=D22 \
>>> >> > -device virtio-nvme-pci,drive=D22,serial=1234,num_queues=4
>>> >> >
>>> >> > The goal is to have a full NVMe stack from VM guest(virtio-nvme)
>>> >> > to host(vhost_nvme) to LIO NVMe-over-fabrics target.
>>> >>
>>> >> Why is a virtio-nvme guest device needed?  I guess there must either
>>> >> be NVMe-only features that you want to pass through, or you think the
>>> >> performance will be significantly better than virtio-blk/virtio-scsi?
>>> >
>>> > It simply passes through NVMe commands.
>>>
>>> I understand that.  My question is why the guest needs to send NVMe commands?
>>>
>>> If the virtio_nvme.ko guest driver only sends read/write/flush then
>>> there's no advantage over virtio-blk.
>>>
>>> There must be something you are trying to achieve which is not
>>> possible with virtio-blk or virtio-scsi.  What is that?
>>
>> I actually learned from your virtio-scsi work.
>> http://www.linux-kvm.org/images/f/f5/2011-forum-virtio-scsi.pdf
>>
>> Then I thought a full NVMe stack from guest to host to target seems
>> reasonable.
>>
>> Trying to achieve similar things as virtio-scsi, but all NVMe protocol.
>>
>> - Effective NVMe passthrough
>> - Multiple target choices: QEMU, LIO-NVMe(vhost_nvme)
>> - Almost unlimited scalability. Thousands of namespaces per PCI device
>> - True NVMe device
>> - End-to-end Protection Information
>> - ....
>
> The advantages you mentioned are already available in virtio-scsi,
> except for the NVMe command set.
>
> I don't understand what unique problem virtio-nvme solves yet.  If
> someone asked me to explain why NVMe-over-virtio makes sense compared
> to the existing virtio-blk/virtio-scsi or NVMe SR-IOV options, I
> wouldn't know the answer.  I'd like to learn that from you or anyone
> else on CC.
>
> Do you have a use case in mind?

One use case is for All NVMe storage array. There is no SCSI device at all.

Samsung demoed one in flash memory summit 2015.
http://www.tomsitpro.com/articles/best-of-flash-memory-summit,1-2806.html

>
> Stefan
