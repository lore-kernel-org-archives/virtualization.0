From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v6 2/2] crypto: add virtio-crypto driver
Date: Tue, 13 Dec 2016 01:13:25 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA15BDD8__43767.897578846$1481591657$gmane$org@DGGEMA505-MBX.china.huawei.com>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
	<1481171829-116496-3-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA15A07C@DGGEMA505-MBX.china.huawei.com>
	<20161212105407.GA3033@gondor.apana.org.au>
	<20161212234941-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161212234941-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luonengjun <luonengjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay,
	Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>
List-Id: virtualization@lists.linuxfoundation.org

>
> Subject: Re: [PATCH v6 2/2] crypto: add virtio-crypto driver
> 
> On Mon, Dec 12, 2016 at 06:54:07PM +0800, Herbert Xu wrote:
> > On Mon, Dec 12, 2016 at 06:25:12AM +0000, Gonglei (Arei) wrote:
> > > Hi, Michael & Herbert
> > >
> > > Because the virtio-crypto device emulation had been in QEMU 2.8,
> > > would you please merge the virtio-crypto driver for 4.10 if no other
> > > comments? If so, Miachel pls ack and/or review the patch, then
> > > Herbert will take it (I asked him last week). Thank you!
> > >
> > > Ps: Note on 4.10 merge window timing from Linus
> > >  https://lkml.org/lkml/2016/12/7/506
> > >
> > > Dec 23rd is the deadline for 4.10 merge window.
> >
> > Sorry but it's too late for 4.10.  It needed to have been in my
> > tree before the merge window opened to make it for this cycle.
> >
> > Cheers,
> 
> 
> Objections to me merging this? I'm preparing my tree right now.
> 
That's great if so since 4.11 merge window opens 
at least three months later.

Do you agree with it Herbert? Thanks.

Regards,
-Gonglei
