From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 12:46:04 +0300
Message-ID: <20090610094604.GD6844__17657.6193226085$1244627522$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<20090525122541.GF5046@redhat.com>
	<200906100019.59981.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906100019.59981.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2009 at 12:19:42AM +0100, Paul Brook wrote:
> On Monday 25 May 2009, Michael S. Tsirkin wrote:
> > Add functions implementing MSI-X support. First user will be virtio-pci.
> > Note that platform must set a flag to declare MSI supported.
> > For PC this will be set by APIC.
> 
> This sounds wrong. The device shouldn't know or care whether the system has a 
> MSI capable interrupt controller. That's for the guest OS to figure out.
> 
> Paul 

You are right of course. In theory there's nothing that breaks if I
set this flag to on, on all platforms. OTOH if qemu emulates some
controller incorrectly, guest might misdetect MSI support in the
controller, and things will break horribly.

It seems safer to have a flag that can be enabled by people
that know about a specific platform.

What do you think?

-- 
MST
