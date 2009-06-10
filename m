From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 20:03:06 +0300
Message-ID: <20090610170306.GL28601__1391.47948143563$1244657236$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101708.27815.paul@codesourcery.com>
	<20090610162644.GJ28601@redhat.com>
	<200906101746.06740.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906101746.06740.paul@codesourcery.com>
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

On Wed, Jun 10, 2009 at 05:46:03PM +0100, Paul Brook wrote:
> > > If you can't create an identical machine from scratch then I don't
> > > consider snapshot/migration to be a useful feature. i.e. as soon as you
> > > shutdown and restart the guest it is liable to break anyway.
> >
> > Why is liable to break?
> 
> A VM booted on an old version of qemu and migrated to a new version will 
> behave differently to a the same VM booted on a new version of qemu.

It will behave identically. That's what the patch does: discover
how did the device behave on old qemu, and make it behave the same way
on new qemu.

> I hope I don't need to explain why this is bad.
> 
> As previously discussed, any guest visible changes are liable to break a guest 
> OS, particularly guests like Windows which deliberately break when run on 
> "different" hardware. Personally I don't particularly care, but if we support 
> live migration we also need to support "cold" migration - i.e. shutdown and 
> restart.
> 
> >So once you load and image with MSIX capability off,
> >it will stay off across guest restarts.
> 
> I'm assuming guest restart includes restarting qemu.
> 
> Paul

If you restart qemu, and load an image, what we should do is look at the
image and behave in a way consistent with how the qemu that created the
image behaved. If you load an image, you switch to a VM, and should be
consistent with the VM you just loaded. And we do not need a flag or a
machine description file to tell us this.


-- 
MST
