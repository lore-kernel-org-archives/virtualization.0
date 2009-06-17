From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Wed, 17 Jun 2009 09:33:52 +0100
Message-ID: <1245227632.27028.29.camel__48859.3581285842$1245227834$gmane$org@blaa>
References: <4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>
	<4A368F12.2090504@codemonkey.ws> <1245154451.11407.22.camel@blaa>
	<4A378FE5.5050303@redhat.com> <1245155992.30082.8.camel@blaa>
	<20090616184404.GJ11893@shareable.org>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090616184404.GJ11893@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2009-06-16 at 19:44 +0100, Jamie Lokier wrote:
> Mark McLoughlin wrote:
> > > Worst case we hardcode those numbers (gasp, faint).
> > 
> > Maybe we can just add the open slots to the -help output. That'd be nice
> > and clean.

I was being sarcastic - libvirt currently must parse qemu -help, and
even has some test infrastructure to check that it works with various
versions of qemu. Extending this would not be nice and clean :-)

> I particularly don't like the idea of arcane machine-dependent slot
> allocation knowledge living in libvirt, because it needs to be in Qemu
> anyway for non-libvirt users.  No point in having two implementations
> of something tricky and likely to have machine quirks, if one will do.

Indeed.

Cheers,
Mark.
