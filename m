From: Paul Brook <paul@codesourcery.com>
Subject: Re: [PATCH] qemu: virtio save/load bindings
Date: Tue, 26 May 2009 11:20:29 +0100
Message-ID: <200905261120.30344.paul__7113.59195779568$1243333377$gmane$org@codesourcery.com>
References: <20090525133405.GA6166@redhat.com> <4A1BA998.8040803@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A1BA998.8040803@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > -    /* FIXME: load/save binding.  */
> > -    //pci_device_save(&vdev->pci_dev, f);
> > -    //msix_save(&vdev->pci_dev, f);
>
> qdev regressed save/restore?  What else is broken right now from the
> qdev commit?
>
> I'm beginning to think committing in the state it was in was a mistake.
> Paul, can you put together a TODO so that we know all of the things that
> have regressed so we can get things back into shape?

Sorry, this one apparently slipped past. I#'d intended to fix it, but 
apparently never ported that bit of the patch.

Paul
