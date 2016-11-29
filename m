From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] crypto: add virtio-crypto driver
Date: Tue, 29 Nov 2016 10:44:06 +0100
Message-ID: <20161129104406.6c110ae0.cornelia.huck__14649.319536011$1480412670$gmane$org@de.ibm.com>
References: <1480334903-6672-1-git-send-email-arei.gonglei@huawei.com>
	<1480334903-6672-2-git-send-email-arei.gonglei@huawei.com>
	<20161128141244.4defcfa1.cornelia.huck@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA14A53D@DGGEMA505-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA14A53D@DGGEMA505-MBX.china.huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hanweidong (Randy)" <hanweidong@huawei.com>, Luonengjun <luonengjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "salvatore.benedetto@intel.com" <salvatore.benedetto@intel.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "davem@davemloft.net" <davem@davemloft.>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 29 Nov 2016 01:37:44 +0000
"Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:

> > On Mon, 28 Nov 2016 20:08:23 +0800
> > Gonglei <arei.gonglei@huawei.com> wrote:
> > 
> > > +static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
> > > +{
> > > +	u32 status;
> > > +	int err;
> > > +
> > > +	virtio_cread(vcrypto->vdev,
> > > +	    struct virtio_crypto_config, status, &status);
> > > +
> > > +	/* Ignore unknown (future) status bits */
> > > +	status &= VIRTIO_CRYPTO_S_HW_READY;
> > 
> > I'm wondering what the driver really should do if it encounters unknown
> > status bits.
> > 
> > I'd expect that new status bits are guarded by a feature bit and that
> > the device should not set status bits if the respective feature bit has
> > not been negotiated. Therefore, unknown status bits would be a host
> > error and the driver should consider the device to be broken.
> > 
> > Thoughts?
> > 
> I agree with you. 
> 
> The reasonable way is reset the device if the driver
> receive an unknown status IMO.

What about setting FAILED in the generic virtio status? This indicates
to the host that the driver 'has given up on the device', as the spec
puts it. If the driver simply resets it, chances are that we will end
up in the same situation again (after all, that's a host bug).

Or/additionally use virtio_break_device(), as a quick grep revealed
that qemu, for one, does not do anything with FAILED. That way at least
the driver will stop mucking with the device.
