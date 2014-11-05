From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [RFC PATCH] virtio-mmio: support for multiple irqs
Date: Wed, 5 Nov 2014 15:59:36 +0800
Message-ID: <5459D8E8.6060709__15937.5470517718$1415631738$gmane$org@huawei.com>
References: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: peter.maydell@linaro.org, hangaohuai@huawei.com, joel.schopp@amd.com, john.liuli@huawei.com, remy.gauguey@cea.fr, mst@redhat.com, qemu-devel@nongnu.org, n.nikolaev@virtualopensystems.com, virtualization@lists.linux-foundation.org, peter.huangpeng@huawei.com
List-Id: virtualization@lists.linuxfoundation.org


On 2014/11/4 17:35, Shannon Zhao wrote:
> As the current virtio-mmio only support single irq,
> so some advanced features such as vhost-net with irqfd
> are not supported. And the net performance is not
> the best without vhost-net and irqfd supporting.
> 
Hi Joel, Peter, Mst,

Some virtio-net with virtio-mmio performance data on ARM added as followed:

Type of backend         bandwith(GBytes/sec)
virtio-net              0.66
vhost-net               1.49
vhost-net with irqfd    2.01

Test cmd: ./iperf -c 192.168.0.2 -P 1 -i 10 -p 5001 -f G -t 60

From this test data, irqfd has great improvement (about 30%) on performance.
So maybe it's necessary to enable multiple irq support to make vhost-net
with virtio-mmio on ARM be able to use irqfd.

How do you guys think? Look forward for your feedback.

Thanks,
Shannon

> This patch support virtio-mmio to request multiple
> irqs like virtio-pci. With this patch and qemu assigning
> multiple irqs for virtio-mmio device, it's ok to use
> vhost-net with irqfd on arm/arm64.
> 
