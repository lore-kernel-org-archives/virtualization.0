From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 15:07:34 +0100
Message-ID: <200906101507.39823.paul__7838.67823561213$1244642957$gmane$org@codesourcery.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906100019.59981.paul@codesourcery.com>
	<20090610094604.GD6844@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090610094604.GD6844@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > > Note that platform must set a flag to declare MSI supported.
> > > For PC this will be set by APIC.
> >
> > This sounds wrong. The device shouldn't know or care whether the system
> > has a MSI capable interrupt controller. That's for the guest OS to figure
> > out.
>
> You are right of course. In theory there's nothing that breaks if I
> set this flag to on, on all platforms. OTOH if qemu emulates some
> controller incorrectly, guest might misdetect MSI support in the
> controller, and things will break horribly.
>
> It seems safer to have a flag that can be enabled by people
> that know about a specific platform.

No. The solution is to fix whatever is broken.

If we really need to avoid MSI-X capable devices then that should be done 
explicity per-device. i.e. you have a different virtio-net device that does 
not use MSI-X.

Paul
