From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Thu, 11 Jun 2009 11:29:44 +0300
Message-ID: <20090611082944.GA20270__41483.9179757566$1244709315$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101830.21537.paul@codesourcery.com>
	<20090610180756.GM28601@redhat.com>
	<200906102004.17905.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906102004.17905.paul@codesourcery.com>
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

On Wed, Jun 10, 2009 at 08:04:13PM +0100, Paul Brook wrote:
> > > If we can't start a new qemu with the same hardware configuration then we
> > > should not be allowing migration or loading of snapshots.
> >
> > OK, so I'll add an option in virtio-net to disable msi-x, and such
> > an option will be added in any device with msi-x support.
> > Will that address your concern?
> 
> Yes, as long as migration fails when you try to migrate to the wrong kind of 
> device.
> 
> Paul

I think the right way to do this, is to make sure that standard
read-only registers in PCI config space are not modified in migration
(device-specific registers could have changed as a result of guest
actions, so we can't make assumptions).
-- 
MST
