From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PULL] virtio
Date: Wed, 02 Nov 2011 06:52:44 +0200
Message-ID: <1320209564.9173.6.camel@lappy>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com> <1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>  <8739e7uy87.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8739e7uy87.fsf@rustcorp.com.au>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wang Sheng-Hui <shhuiw@gmail.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-02 at 11:39 +1030, Rusty Russell wrote:
> On Tue, 1 Nov 2011 14:42:23 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 01, 2011 at 02:33:33PM +0200, Sasha Levin wrote:
> > > Unless Michael pointed this patch out, it would have broken (at least)
> > > the kvm tool in a non obvious way which would require a rather long
> > > session of 'git bisect' to figure out whats wrong.
> 
> I assumed not, until QEMU provided the second BAR it would simply fall
> back.  Or am I completely misunderstanding?

QEMU uses two bars within each virtio-pci device. First one (BAR 0) is
the PIO config BAR, and the second one (BAR 1) is the MSI-X BAR used for
the MSI-X table and the PBA.

Since the PCI spec allows you to have the MSI-X table and the PBA in
completely different regions pointed by two different BARs, we did so in
kvm tools and have BAR 1 pointing to the MSI-X table, and BAR 2 pointing
to the PBA ( - we *already* provided the second BAR and used it for
something else).

This means that with this patch, we'd load BAR 2 and use it as the
config space, instead of the PBA table which it really represents.

-- 

Sasha.
