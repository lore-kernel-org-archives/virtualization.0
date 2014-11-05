From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] virtio-mmio: add irqfd support for
	vhost-net based on virtio-mmio
Date: Wed, 5 Nov 2014 10:30:53 +0100
Message-ID: <CAMJs5B-OXTCY=FWXK0ed3+VPk_9d3QUVBJ=ny3uq2z53cmv+KA__39889.9151864045$1415631782$gmane$org@mail.gmail.com>
References: <1414225494-2208-1-git-send-email-john.liuli@huawei.com>
	<CAFEAcA9o8ZsbUvZb7Yp9JeO__bRLOrYcyfj4Ug4Se_rDF0y4TA@mail.gmail.com>
	<544E2B18.8010702@huawei.com>
	<CAFEAcA8JgebH8B4i7aoSxdeon7B-eunXzZJhwOCXQr-ypSgfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFEAcA8JgebH8B4i7aoSxdeon7B-eunXzZJhwOCXQr-ypSgfsQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joel Schopp <joel.schopp@amd.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Yingshiuan Pan <yingshiuan.pan@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Li Liu <john.liuli@huawei.com>, remy.gauguey@cea.fr, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 27, 2014 at 12:58 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 27 October 2014 11:23, Li Liu <john.liuli@huawei.com> wrote:
>> So you mean virtio-mmio will be replaced by PCI/PCIe on ARM at last?
>
> That is the plan, yes. I can't make any promises on
> timescales at the moment, though...
>
Linaro has scheduled resources to work on this (Ard, cc'ed) and we
expect to be able to deliver this within a reasonable time frame.

-Christoffer
