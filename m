From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCHv3 RFC] virtio-pci: flexible configuration layout
Date: Wed, 30 Nov 2011 15:12:43 +0200
Message-ID: <1322658763.3985.4.camel@lappy>
References: <20111122183621.GA5235@redhat.com>
	<87hb1v1scp.fsf@rustcorp.com.au> <20111123084640.GE22734@redhat.com>
	<87ty5uxso3.fsf@rustcorp.com.au> <20111124070728.GH29994@redhat.com>
	<87vcq5t69c.fsf@rustcorp.com.au> <1322471731.3577.10.camel@lappy>
	<87pqgats49.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqgats49.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wang Sheng-Hui <shhuiw@gmail.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-30 at 10:10 +1030, Rusty Russell wrote:
> On Mon, 28 Nov 2011 11:15:31 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> > On Mon, 2011-11-28 at 11:25 +1030, Rusty Russell wrote:
> > > I'd like to see kvmtools remove support for legacy mode altogether,
> > > but they probably have existing users.
> > 
> > While we can't simply remove it right away, instead of mixing our
> > implementation for both legacy and new spec in the same code we can
> > split the virtio-pci implementation into two:
> > 
> > 	- virtio/virtio-pci-legacy.c
> > 	- virtio/virtio-pci.c
> > 
> > At that point we can #ifdef the entire virtio-pci-legacy.c for now and
> > remove it at the same time legacy virtio-pci is removed from the kernel.
> 
> Hmm, that might be neat, but we can't tell the driver core to try
> virtio-pci before virtio-pci-legacy, so we need detection code in both
> modules (and add a "force" flag to virtio-pci-legacy to tell it to
> accept the device even if it's not a legacy-only one).

I was thinking more in the direction of fallback code in virtio-pci.c to
virtio-pci-legacy.c.

Something like:
#ifdef VIRTIO_PCI_LEGACY
[Create BAR0 and map it to virtio-pci-legacy.c]
#endif

So BAR0 isn't defined as long as legacy code is there, which makes
falling back to legacy pretty simple.

-- 

Sasha.
