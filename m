From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v3] crypto: add virtio-crypto driver
Date: Tue, 29 Nov 2016 06:47:52 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA14A720__45555.1553088755$1480402129$gmane$org@DGGEMA505-MBX.china.huawei.com>
References: <1480334903-6672-1-git-send-email-arei.gonglei@huawei.com>
	<1480334903-6672-2-git-send-email-arei.gonglei@huawei.com>
	<20161128162055.GB11196@stefanha-x1.localdomain>
	<20161128185747-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luonengjun <luonengjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "salvatore.benedetto@intel.com" <salvatore.benedetto@intel.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "herbert@gondor.apana.org.au" <herbe>
List-Id: virtualization@lists.linuxfoundation.org

>
> > > > +
> > > > +/* Note: kernel crypto API realization */
> > > > +static int virtio_crypto_ablkcipher_setkey(struct crypto_ablkcipher *tfm,
> > > > +					 const uint8_t *key,
> > > > +					 unsigned int keylen)
> > > > +{
> > > > +	struct virtio_crypto_ablkcipher_ctx *ctx =
> > crypto_ablkcipher_ctx(tfm);
> > > > +	int ret;
> > > > +
> > > > +	spin_lock(&ctx->lock);
> > > > +
> > > > +	if (!ctx->vcrypto) {
> > > > +		/* New key */
> > > > +		int node = virtio_crypto_get_current_node();
> > > > +		struct virtio_crypto *vcrypto =
> > > > +				      virtcrypto_get_dev_node(node);
> > > > +		if (!vcrypto) {
> > > > +			vcrypto = virtcrypto_devmgr_get_first();
> >
> > Is this the standard way to do this? How does this work with
> > multiple crypto devices (e.g. with different capabilities)?
> >
> Actually there is a simple schedule algorithms in virtcrypto_get_dev_node(),
> which return the device used fewest on the node.
> 
> If we don't find a device in the node, select the first on as default.
> But I forgot to check the first devices whether the device has started here.
> 
Oh, the virtcrypto_get_dev_node() had done this work, the calling of
virtcrypto_devmgr_get_first() here is superfluous. Will remove it.

Regards,
-Gonglei
