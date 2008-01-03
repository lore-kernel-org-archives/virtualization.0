From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [kvm-devel] [PATCH 1/3] Make virtio modules GPL
Date: Thu, 03 Jan 2008 09:13:15 -0600
Message-ID: <477CFB8B.6060204__23281.739842105$1199373618$gmane$org@us.ibm.com>
References: <1199307694277-git-send-email-aliguori@us.ibm.com>
	<10EA09EFD8728347A513008B6B0DA77A02976D62@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A02976D62@pdsmsx411.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Dong, Eddie wrote:
> Curuious: should we consider it to be dual licensed from beginning?
>  =20

AFAIK, they are GPLv2+. I think Rusty was talking about dual licensing
the headers. He'll have to comment on that though.

Regards,

Anthony Liguori

> thx,eddie
>
>  =20
>> -----Original Message-----
>> From: kvm-devel-bounces@lists.sourceforge.net=20
>> [mailto:kvm-devel-bounces@lists.sourceforge.net] On Behalf Of=20
>> Anthony Liguori
>> Sent: 2008=C4=EA1=D4=C23=C8=D5 5:02
>> To: virtualization@lists.linux-foundation.org
>> Cc: kvm-devel@lists.sourceforge.net
>> Subject: [kvm-devel] [PATCH 1/3] Make virtio modules GPL
>>
>> The virtio modules do not advertise themselves as GPL but rely=20
>> on exported
>> GPL symbols.  This makes them unloadable as modules.
>>
>> This patch adds the appropriate MODULE_LICENSE().
>>
>> Signed-off: Anthony Liguori <aliguori@us.ibm.com>
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 54a8017..8f6040d 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -8,6 +8,8 @@
>>
>> #define VIRTIO_MAX_SG	(3+MAX_PHYS_SEGMENTS)
>>
>> +MODULE_LICENSE("GPL");
>> +
>> static unsigned char virtblk_index =3D 'a';
>> struct virtio_blk
>> {
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index ebe4b03..9789e68 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -28,6 +28,8 @@
>> static int napi_weight =3D 128;
>> module_param(napi_weight, int, 0444);
>>
>> +MODULE_LICENSE("GPL");
>> +
>> /* FIXME: MTU in config. */
>> #define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 646f716..6e27c08 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -2,6 +2,8 @@
>> #include <linux/spinlock.h>
>> #include <linux/virtio_config.h>
>>
>> +MODULE_LICENSE("GPL");
>> +
>> static ssize_t device_show(struct device *_d,
>> 			   struct device_attribute *attr, char *buf)
>> {
>> diff --git a/drivers/virtio/virtio_ring.c=20
>> b/drivers/virtio/virtio_ring.c
>> index 951e4c7..15ee2fa 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -20,6 +20,8 @@
>> #include <linux/virtio_ring.h>
>> #include <linux/device.h>
>>
>> +MODULE_LICENSE("GPL");
>> +
>> #ifdef DEBUG
>> /* For development, we want to crash whenever the ring is screwed. */
>> #define BAD_RING(vq, fmt...)			\
>>
>> ---------------------------------------------------------------
>> ----------
>> This SF.net email is sponsored by: Microsoft
>> Defy all challenges. Microsoft(R) Visual Studio 2005.
>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>> _______________________________________________
>> kvm-devel mailing list
>> kvm-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>>
>>    =20
