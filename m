From: Ed Tomlinson <edt@aei.ca>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Fri, 29 Oct 2010 07:49:57 -0400
Message-ID: <201010290749.58283.edt@aei.ca>
References: <4CAC9CD1.2050601@collabora.co.uk> <4CC8226F.5080807@collabora.co.uk> <201010292148.01167.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010292148.01167.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, Ian Molton <ian.molton@collabora.co.uk>, Avi Kivity <avi@redhat.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 29 October 2010 07:18:00 Rusty Russell wrote:
> On Wed, 27 Oct 2010 11:30:31 pm Ian Molton wrote:
> > On 19/10/10 11:39, Avi Kivity wrote:
> > > On 10/19/2010 12:31 PM, Ian Molton wrote:
> > 
> > >>> 2. should start with a patch to the virtio-pci spec to document what
> > >>> you're doing
> > >>
> > >> Where can I find that spec?
> > >
> > > http://ozlabs.org/~rusty/virtio-spec/
> > 
> > Ok, but I'm not patching that until theres been some review.
> 
> Fair enough; it's a bit of a PITA to patch, so it makes sense to get the
> details nailed down first.
> 
> > There are links to the associated qemu and guest OS changes in my 
> > original email.
> > 
> > >> It doesnt, at present... It could be changed fairly easily ithout
> > >> breaking anything if that happens though.
> > >
> > > The hypervisor and the guest can be changed independently. The driver
> > > should be coded so that it doesn't depend on hypervisor implementation
> > > details.
> > 
> > Fixed - updated patch tested and attached.
> 
> OK. FWIW, I think this is an awesome idea.  I understand others are skeptical,
> but this seems simple and if it works and you're happy to maintain it I'm
> happy to let you do it :)

From a kvm user's perspective this is a GREAT idea.  Looks like Ian and friends have
though about better solutions down the line and have made their code easy
to superceed.  If this is really the case I vote to get this in qemu/kvm asap -
software opengl can be a real pain.

Thanks
Ed Tomlinson
