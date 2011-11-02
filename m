From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PULL] virtio
Date: Wed, 02 Nov 2011 11:39:12 +1030
Message-ID: <8739e7uy87.fsf__9506.41928143359$1320207039$gmane$org@rustcorp.com.au>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
	<20111101114542.GA13434@redhat.com>
	<1320150813.3847.24.camel@lappy>
	<20111101124223.GA14060@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111101124223.GA14060@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <levinsasha928@gmail.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 1 Nov 2011 14:42:23 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Nov 01, 2011 at 02:33:33PM +0200, Sasha Levin wrote:
> > A proper solution would be for example a configuration in the PIO config
> > space which points to the MMIO BAR to use instead.
> 
> I think it makes sense to put the configuration in PCI
> configuration space, using vendor-specific capability.
> This way we can reuse existing functionality for scanning
> capability lists.

Patch welcome; first one to implement it becomes virtio PCI maintainer!
I'll keep maintaining the spec, since it covers much more than the PCI
mechanics, but everything I know about PCI I learn from these
discussions.

Meanwhile, I've dropped this patch; mea culpa.

> > Unless Michael pointed this patch out, it would have broken (at least)
> > the kvm tool in a non obvious way which would require a rather long
> > session of 'git bisect' to figure out whats wrong.

I assumed not, until QEMU provided the second BAR it would simply fall
back.  Or am I completely misunderstanding?

Thanks,
Rusty.
