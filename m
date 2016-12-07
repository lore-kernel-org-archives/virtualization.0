From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v5 1/1] crypto: add virtio-crypto driver
Date: Wed, 7 Dec 2016 17:48:43 +0800
Message-ID: <20161207094843.GA19970__397.769796154712$1481106857$gmane$org@gondor.apana.org.au>
References: <1480595945-63656-1-git-send-email-arei.gonglei@huawei.com>
	<1480595945-63656-2-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA1546F2@DGGEMA505-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1546F2@DGGEMA505-MBX.china.huawei.com>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hanweidong (Randy)" <hanweidong@huawei.com>, Luonengjun <luonengjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, arei.gonglei@hotmail.co
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 06, 2016 at 09:01:49AM +0000, Gonglei (Arei) wrote:
> 
> Would you please review and/or ack the virtio_crypto_algs.c?
> It is the realization of specified algs based on Linux Crypto Framework.

I have no issues with it.  If the virtio folks are happy with
the interface with the host then I'll take this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
