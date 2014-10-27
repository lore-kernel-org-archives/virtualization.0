From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] virtio-mmio: add irqfd support for
	vhost-net based on virtio-mmio
Date: Mon, 27 Oct 2014 09:37:09 +0000
Message-ID: <CAFEAcA9o8ZsbUvZb7Yp9JeO__bRLOrYcyfj4Ug4Se_rDF0y4TA@mail.gmail.com>
References: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "john.liuli" <john.liuli@huawei.com>
Cc: Joel Schopp <joel.schopp@amd.com>, Yingshiuan Pan <yingshiuan.pan@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, remy.gauguey@cea.fr, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, peter.huangpeng@huawei.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 25 October 2014 09:24, john.liuli <john.liuli@huawei.com> wrote:
> To get the interrupt reason to support such VIRTIO_NET_F_STATUS
> features I add a new register offset VIRTIO_MMIO_ISRMEM which
> will help to establish a shared memory region between qemu and
> virtio-mmio device. Then the interrupt reason can be accessed by
> guest driver through this region. At the same time, the virtio-mmio
> dirver check this region to see irqfd is supported or not during
> the irq handler registration, and different handler will be assigned.

If you want to add a new register you should probably propose
an update to the virtio spec. However, it seems to me it would
be better to get generic PCI/PCIe working on the ARM virt
board instead; then we can let virtio-mmio quietly fade away.
This has been on the todo list for ages (and there have been
RFC patches posted for plain PCI), it's just nobody's had time
to work on it.

thanks
-- PMM
