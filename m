From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] virtio-mmio: add irqfd support for
	vhost-net based on virtio-mmio
Date: Mon, 27 Oct 2014 11:58:26 +0000
Message-ID: <CAFEAcA8JgebH8B4i7aoSxdeon7B-eunXzZJhwOCXQr-ypSgfsQ@mail.gmail.com>
References: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
	<CAFEAcA9o8ZsbUvZb7Yp9JeO__bRLOrYcyfj4Ug4Se_rDF0y4TA@mail.gmail.com>
	<544E2B18.8010702@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <544E2B18.8010702@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Li Liu <john.liuli@huawei.com>
Cc: Joel Schopp <joel.schopp@amd.com>, Yingshiuan Pan <yingshiuan.pan@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, remy.gauguey@cea.fr, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, peter.huangpeng@huawei.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 27 October 2014 11:23, Li Liu <john.liuli@huawei.com> wrote:
> So you mean virtio-mmio will be replaced by PCI/PCIe on ARM at last?

That is the plan, yes. I can't make any promises on
timescales at the moment, though...

-- PMM
