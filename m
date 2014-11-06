From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [Qemu-devel] [RFC PATCH] virtio-mmio: support for multiple irqs
Date: Thu, 6 Nov 2014 11:26:28 +0800
Message-ID: <545AEA64.9010308__34695.422955747$1415631822$gmane$org@huawei.com>
References: <1415093712-15156-1-git-send-email-zhaoshenglong@huawei.com>	<5459D8E8.6060709@huawei.com>	<022C7612790E20489F80A6F0D54B849F3B26F4F3@EXDAG0-B1.intra.cea.fr>
	<5459EA0E.8020309@huawei.com> <545A41E1.10303@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <545A41E1.10303@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joel Schopp <joel.schopp@amd.com>, =?windows-1252?Q?GAUGUEY_R=E9my_?= =?windows-1252?Q?228890?= <remy.gauguey@cea.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, "n.nikolaev@virtualopensystems.com" <n.nikolaev@virtualopensystems.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "hangaohuai@huawei.com" <hangaohuai@huawei.com>, "john.liuli@huawei.com" <john.liuli@huawei.com>, "peter.huangpeng@huawei.com" <peter.huangpeng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On 2014/11/5 23:27, Joel Schopp wrote:
> =

> On 11/05/2014 03:12 AM, Shannon Zhao wrote:
>> Hi R=E9my,
>>
>> On 2014/11/5 16:26, GAUGUEY R=E9my 228890 wrote:
>>> Hi Shannon, =

>>>
>>>> Type of backend         bandwith(GBytes/sec)
>>>> virtio-net              0.66
>>>> vhost-net               1.49
>>>> vhost-net with irqfd    2.01
>>>>
>>>> Test cmd: ./iperf -c 192.168.0.2 -P 1 -i 10 -p 5001 -f G -t 60
>>> Impressive results !
>>> Could you please detail your setup ? which platform are you using and w=
hich GbE controller ?
>> Sorry for not telling the test scenario. This test scenario is from Host=
 to Guest. It just
>> compare the performance of different backends. I did this test on ARM64 =
platform.
>>
>> The setup was based on:
>> 1)on host kvm-arm should support ioeventfd and irqfd
>> 	The irqfd patch is from Eric "ARM: KVM: add irqfd support".
>> 	http://www.spinics.net/lists/kvm-arm/msg11014.html
>>
>> 	The ioeventfd patch is reworked by me from Antonios.
>> 	http://www.spinics.net/lists/kvm-arm/msg08413.html
>>
>> 2)qemu should enable ioeventfd support for virtio-mmio
>> 	This patch is refer to Ying-Shiuan Pan and reworked for new qemu branch.
>> 	https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg00594.html
>>
>> 3)qemu should enable multiple irqs for virtio-mmio
>> 	This patch isn't sent to qemu maillist as we want to check whether this=
 is the right direction.
>> 	If you want to test, I'll send it to you.
> I'm not a maintainer so my opinion isn't worth a lot here, but this
> seems like the right direction to me.  I'd like to see the qemu patch
> (do mention the dependency on the kernel patch) on the qemu-devel
> mailing list.  I think these numbers also support some of the prereqs
> listed above that have gone through several iterations getting queued up
> for 3.19.
> .
> =

Hi,

Thanks for your reply :)
If this patch get accepted by maintainers, I'll send the qemu patch to qemu=
-devel mailing list.

In addition, I think this is worth on arm32 platform as arm32 with GICv2 do=
esn't support MSI.
So it can't use virtio-pci if I don't miss something. And it's also worth o=
n arm64 platform
as we can't make sure when the PCI and MSI are supported on arm. It give us=
ers an alternative
choice for virtualization network.

Rusty, MST, Peter Maydell, do you have any ideas about this? Waiting for yo=
ur feedback :)

Thanks
-- =

Shannon
