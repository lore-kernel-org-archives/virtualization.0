From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Tue, 16 Jun 2009 19:32:22 +0100
Message-ID: <20090616183222.GH11893__9201.56767028875$1245177210$gmane$org@shareable.org>
References: <4A364B53.9080007@codemonkey.ws> <4A364FE0.40204@redhat.com>
	<4A3651EB.3070204@codemonkey.ws> <4A36555A.4090303@redhat.com>
	<4A3659A0.3050108@codemonkey.ws>
	<20090615143737.GB14405@redhat.com>
	<4A3662BA.6030304@codemonkey.ws>
	<20090615150804.GH7233@redhat.com> <4A3664EE.30207@redhat.com>
	<4A3665A0.7000702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A3665A0.7000702@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Mark McLoughlin <markmc@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Another issue is enumeration.  Guests will present their devices in the 
> order they find them on the pci bus (of course enumeration is guest 
> specific).  So if I have 2 virtio controllers the only way I can 
> distinguish between them is using their pci slots.

virtio controllers really should have a user-suppliable string or UUID
to identify them to the guest.  Don't they?

-- Jamie
