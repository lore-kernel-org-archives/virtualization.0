From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Tue, 16 Jun 2009 19:44:04 +0100
Message-ID: <20090616184404.GJ11893__24244.842984672$1245177911$gmane$org@shareable.org>
References: <4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>
	<4A368F12.2090504@codemonkey.ws>
	<1245154451.11407.22.camel@blaa> <4A378FE5.5050303@redhat.com>
	<1245155992.30082.8.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1245155992.30082.8.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Mark McLoughlin wrote:
> > Worst case we hardcode those numbers (gasp, faint).
> 
> Maybe we can just add the open slots to the -help output. That'd be nice
> and clean.

Make them part of the machine configuration.

After all, they are part of the machine configuration, and ACPI, BIOS
etc. need to know about all the machine slots anyway.

Having said that, I prefer the idea that slot allocation is handled
either in Qemu, or in a separate utility called qemu-machine-config
(for working with machine configs), or in a library
libqemu-machine-config.so.

I particularly don't like the idea of arcane machine-dependent slot
allocation knowledge living in libvirt, because it needs to be in Qemu
anyway for non-libvirt users.  No point in having two implementations
of something tricky and likely to have machine quirks, if one will do.

-- Jamie
