From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio_mmio: fix devm cleanup
Date: Tue, 12 Dec 2017 14:31:48 +0100
Message-ID: <20171212143148.4a022816.cohuck__21187.521183356$1513085524$gmane$org@redhat.com>
References: <20171212125302.6846-1-mark.rutland@arm.com>
	<20171212140952.64d7908a.cohuck@redhat.com>
	<20171212132902.t5vxs2yujsth2v2h@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171212132902.t5vxs2yujsth2v2h@lakrids.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: virtualization@lists.linux-foundation.org, weiping zhang <zhangweiping@didichuxing.com>, linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Dec 2017 13:29:02 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Dec 12, 2017 at 02:09:52PM +0100, Cornelia Huck wrote:

> > Shouldn't the cleanup in _remove() then be removed as well?  
> 
> Ah, I'd missed that.
> 
> I believe that can be removed, yes.
> 
> Should I spin a v2 with that folded in?

I think it has the same devm_ioremap vs. iounmap discrepancy, so it
should probably be folded in.
