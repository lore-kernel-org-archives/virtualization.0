From: Joel Schopp <joel.schopp@amd.com>
Subject: Re: [Qemu-devel] [RFC PATCH] virtio-mmio: support for multiple irqs
Date: Wed, 5 Nov 2014 09:27:29 -0600
Message-ID: <545A41E1.10303__44793.3171330535$1415631790$gmane$org@amd.com>
References: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>
	<5459D8E8.6060709@huawei.com>
	<022C7612790E20489F80A6F0D54B849F3B26F4F3@EXDAG0-B1.intra.cea.fr>
	<5459EA0E.8020309@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5459EA0E.8020309@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shannon Zhao <zhaoshenglong@huawei.com>, =?windows-1252?Q?GAUGUEY_R?= =?windows-1252?Q?=E9my_228890?= <remy.gauguey@cea.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "hangaohuai@huawei.com" <hangaohuai@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "john.liuli@huawei.com" <john.liuli@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "peter.huangpeng@huawei.com" <peter.huangpeng@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org


On 11/05/2014 03:12 AM, Shannon Zhao wrote:
> Hi R=E9my,
>
> On 2014/11/5 16:26, GAUGUEY R=E9my 228890 wrote:
>> Hi Shannon, =

>>
>>> Type of backend         bandwith(GBytes/sec)
>>> virtio-net              0.66
>>> vhost-net               1.49
>>> vhost-net with irqfd    2.01
>>>
>>> Test cmd: ./iperf -c 192.168.0.2 -P 1 -i 10 -p 5001 -f G -t 60
>> Impressive results !
>> Could you please detail your setup ? which platform are you using and wh=
ich GbE controller ?
> Sorry for not telling the test scenario. This test scenario is from Host =
to Guest. It just
> compare the performance of different backends. I did this test on ARM64 p=
latform.
>
> The setup was based on:
> 1)on host kvm-arm should support ioeventfd and irqfd
> 	The irqfd patch is from Eric "ARM: KVM: add irqfd support".
> 	http://www.spinics.net/lists/kvm-arm/msg11014.html
>
> 	The ioeventfd patch is reworked by me from Antonios.
> 	http://www.spinics.net/lists/kvm-arm/msg08413.html
>
> 2)qemu should enable ioeventfd support for virtio-mmio
> 	This patch is refer to Ying-Shiuan Pan and reworked for new qemu branch.
> 	https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg00594.html
>
> 3)qemu should enable multiple irqs for virtio-mmio
> 	This patch isn't sent to qemu maillist as we want to check whether this =
is the right direction.
> 	If you want to test, I'll send it to you.
I'm not a maintainer so my opinion isn't worth a lot here, but this
seems like the right direction to me.  I'd like to see the qemu patch
(do mention the dependency on the kernel patch) on the qemu-devel
mailing list.  I think these numbers also support some of the prereqs
listed above that have gone through several iterations getting queued up
for 3.19.
