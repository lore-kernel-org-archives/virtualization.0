From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] virtio_mmio: fix devm cleanup
Date: Tue, 12 Dec 2017 13:34:00 +0000
Message-ID: <20171212133400.4qzfkp5wcrtuwxz6__6132.08556683293$1513085683$gmane$org@lakrids.cambridge.arm.com>
References: <20171212125302.6846-1-mark.rutland@arm.com>
	<20171212140952.64d7908a.cohuck@redhat.com>
	<20171212132902.t5vxs2yujsth2v2h@lakrids.cambridge.arm.com>
	<20171212143148.4a022816.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171212143148.4a022816.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtualization@lists.linux-foundation.org, weiping zhang <zhangweiping@didichuxing.com>, linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 12, 2017 at 02:31:48PM +0100, Cornelia Huck wrote:
> On Tue, 12 Dec 2017 13:29:02 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, Dec 12, 2017 at 02:09:52PM +0100, Cornelia Huck wrote:
> 
> > > Shouldn't the cleanup in _remove() then be removed as well?  
> > 
> > Ah, I'd missed that.
> > 
> > I believe that can be removed, yes.
> > 
> > Should I spin a v2 with that folded in?
> 
> I think it has the same devm_ioremap vs. iounmap discrepancy, so it
> should probably be folded in.

Ah, yes. I'll spin a v2 now.

Thanks,
Mark.
