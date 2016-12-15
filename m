From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
Date: Thu, 15 Dec 2016 01:08:51 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA16320F__4654.85004610873$1481764181$gmane$org@DGGEMA505-MBX.china.huawei.com>
References: <1481716249-185392-1-git-send-email-arei.gonglei@huawei.com>
	<1481716249-185392-2-git-send-email-arei.gonglei@huawei.com>
	<bcf62fa0-8fc9-daaf-ea7b-e09eb83b593a@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA163033@DGGEMA505-MBX.china.huawei.com>
	<82063967A54EF84C8AFCD6BD7F6AD93310C14374@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <82063967A54EF84C8AFCD6BD7F6AD93310C14374@SHSMSX103.ccr.corp.intel.com>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zeng, Xin" <xin.zeng@intel.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "Hanweidong (Randy)" <hanweidong@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, Luonengjun <luonengjun@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>
List-Id: virtualization@lists.linuxfoundation.org





Regards,
-Gonglei


> -----Original Message-----
> From: Zeng, Xin [mailto:xin.zeng@intel.com]
> Sent: Thursday, December 15, 2016 8:59 AM
> To: Gonglei (Arei); Halil Pasic; linux-kernel@vger.kernel.org;
> qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org;
> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org
> Cc: Huangweidong (C); Claudio Fontana; mst@redhat.com; Luonengjun;
> Hanweidong (Randy); Xuquan (Quan Xu); Wanzongshun (Vincent);
> stefanha@redhat.com; Zhoujian (jay, Euler); cornelia.huck@de.ibm.com;
> longpeng; arei.gonglei@hotmail.com; davem@davemloft.net; Wubin (H);
> herbert@gondor.apana.org.au
> Subject: RE: [Qemu-devel] [PATCH v7 1/1] crypto: add virtio-crypto driver
> 
> On Thursday, December 15, 2016 8:45 AM, Gonglei (Arei) Wrote:
> < > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> < > b/drivers/crypto/virtio/virtio_crypto_core.c
> < > > new file mode 100644
> < > > index 0000000..c0854a1
> < > > --- /dev/null
> < > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> < > > @@ -0,0 +1,474 @@
> < > [..]
> < > > +
> < > > +static void virtcrypto_dataq_callback(struct virtqueue *vq)
> < > > +{
> < > > +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> < > > +	struct virtio_crypto_request *vc_req;
> < > > +	unsigned long flags;
> < > > +	unsigned int len;
> < > > +	struct ablkcipher_request *ablk_req;
> < > > +	int error;
> < > > +
> < > > +	spin_lock_irqsave(&vcrypto->lock, flags);
> < >
> < > Would it make sense to use a per virtqueue lock
> < > like in virtio_blk for example instead of locking on the whole
> < > device? OK, it seems you use only one dataqueue, so it
> < > may not be that relevant.
> < >
> < Currently yes, both the backend device (cryptodev-backend-builtin)
> < and the frontend driver use one dataqueue.
> <
> 
> I think it makes sense to use per virtqueue lock here though it only uses one
> queue so far,
> but in the spec we already have multi queues support.
> 
Yes, I agree. Will do that in V8 soon. 
Hope to catch up with Michael's pull request for 4.10.

Regards,
-Gonglei
