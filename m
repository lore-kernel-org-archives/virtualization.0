From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv3 RFC] virtio-pci: flexible configuration layout
Date: Wed, 30 Nov 2011 09:58:45 +1030
Message-ID: <87sjl6tsnm.fsf@rustcorp.com.au>
References: <20111122183621.GA5235@redhat.com> <87hb1v1scp.fsf@rustcorp.com.au>
	<20111123084640.GE22734@redhat.com>
	<87ty5uxso3.fsf@rustcorp.com.au>
	<20111124070728.GH29994@redhat.com>
	<87vcq5t69c.fsf@rustcorp.com.au>
	<20111128084009.GB20084@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111128084009.GB20084@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 28 Nov 2011 10:41:51 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Nov 28, 2011 at 11:25:43AM +1030, Rusty Russell wrote:
> > > > But I'm *terrified* of making the spec more complex;
> > > 
> > > All you do is move stuff around. Why do you think it simplifies the spec
> > > so much?
> > 
> > No, but it reduces the yuk factor.  Which has been important to adoption.
> 
> Sorry if I'm dense. Could you please clarify: do you think we can live
> with the slightly higher yuk factor assuming the spec moves the
> legacy mode into an appendix as you explain below and driver has a
> single 'legacy' switch?

Yep, it's all a trade-off.  A clean slate is good, but if we can make
our lives in transition less painful, I'm all for it.

> I think I see a way to do that in a relatively painless way.
> Do you prefer seeing driver patches or spec? Or are you not interested
> in reusing the same structure at all?

I think we should look at code at this point; my gut says we're going to
be not-quite-similar-enough-to-be-useful.  At which point, a clean-slate
approach is more appealing.  But the code will show, one way or another.

Thanks,
Rusty.
