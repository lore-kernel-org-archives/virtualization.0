From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 15:39:05 +0100
Message-ID: <200906101539.12367.paul__21488.7196118527$1244644802$gmane$org@codesourcery.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906101507.39823.paul@codesourcery.com>
	<20090610142508.GA28409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090610142508.GA28409@redhat.com>
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

> > If we really need to avoid MSI-X capable devices then that should be done
> > explicity per-device. i.e. you have a different virtio-net device that
> > does not use MSI-X.
> >
> > Paul
>
> Why should it be done per-device?


Because otherwise you end up with the horrible hacks that you're currently 
tripping over: devices have to magically morph into a different device when 
you load a VM. That's seems just plain wrong to me. Loading a VM shouldn't not 
do anything that can't happen during normal operation.

Paul
