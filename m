From: =?iso-8859-1?Q?GAUGUEY_R=E9my_228890?= <remy.gauguey@cea.fr>
Subject: RE: [RFC PATCH] virtio-mmio: support for multiple irqs
Date: Wed, 5 Nov 2014 08:26:35 +0000
Message-ID: <022C7612790E20489F80A6F0D54B849F3B26F4F3__14627.0536505201$1415631749$gmane$org@EXDAG0-B1.intra.cea.fr>
References: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>
	<5459D8E8.6060709@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5459D8E8.6060709@huawei.com>
Content-Language: fr-FR
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shannon Zhao <zhaoshenglong@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, "joel.schopp@amd.com" <joel.schopp@amd.com>, "john.liuli@huawei.com" <john.liuli@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "peter.huangpeng@huawei.com" <peter.huangpeng@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Shannon, =


>Type of backend         bandwith(GBytes/sec)
>virtio-net              0.66
>vhost-net               1.49
>vhost-net with irqfd    2.01
>
>Test cmd: ./iperf -c 192.168.0.2 -P 1 -i 10 -p 5001 -f G -t 60

Impressive results !
Could you please detail your setup ? which platform are you using and which=
 GbE controller ?
As a reference, it would be good also to have result with an iperf to the H=
OST to see how far we are from a native configuration...

Also, I assume a pending Qemu patch is necessary to assign multiple irqs ? =
I'm correct ? =


Thanks a lot, =

Best regards
R=E9my

-----Message d'origine-----
De=A0: Shannon Zhao [mailto:zhaoshenglong@huawei.com] =

Envoy=E9=A0: mercredi 5 novembre 2014 09:00
=C0=A0: linux-kernel@vger.kernel.org
Cc=A0: mst@redhat.com; peter.maydell@linaro.org; john.liuli@huawei.com; joe=
l.schopp@amd.com; GAUGUEY R=E9my 228890; qemu-devel@nongnu.org; n.nikolaev@=
virtualopensystems.com; virtualization@lists.linux-foundation.org; peter.hu=
angpeng@huawei.com; hangaohuai@huawei.com
Objet=A0: Re: [RFC PATCH] virtio-mmio: support for multiple irqs


On 2014/11/4 17:35, Shannon Zhao wrote:
> As the current virtio-mmio only support single irq, so some advanced =

> features such as vhost-net with irqfd are not supported. And the net =

> performance is not the best without vhost-net and irqfd supporting.
> =

Hi Joel, Peter, Mst,

Some virtio-net with virtio-mmio performance data on ARM added as followed:

Type of backend         bandwith(GBytes/sec)
virtio-net              0.66
vhost-net               1.49
vhost-net with irqfd    2.01

Test cmd: ./iperf -c 192.168.0.2 -P 1 -i 10 -p 5001 -f G -t 60

From this test data, irqfd has great improvement (about 30%) on performance.
So maybe it's necessary to enable multiple irq support to make vhost-net wi=
th virtio-mmio on ARM be able to use irqfd.

How do you guys think? Look forward for your feedback.

Thanks,
Shannon

> This patch support virtio-mmio to request multiple irqs like =

> virtio-pci. With this patch and qemu assigning multiple irqs for =

> virtio-mmio device, it's ok to use vhost-net with irqfd on arm/arm64.
> =
