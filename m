From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v4 00/16] qemu: towards virtio-1 host support
Date: Thu, 27 Nov 2014 18:35:40 +0200
Message-ID: <20141127163540.GC27124@redhat.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141127152422.GA26747@redhat.com>
	<20141127163139.7db48144.cornelia.huck@de.ibm.com>
	<20141127154211.GC26747@redhat.com>
	<20141127170651.67f918e2.cornelia.huck@de.ibm.com>
	<20141127161825.GA27124@redhat.com>
	<20141127172842.42782626.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141127172842.42782626.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27, 2014 at 05:28:42PM +0100, Cornelia Huck wrote:
> On Thu, 27 Nov 2014 18:18:25 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Nov 27, 2014 at 05:06:51PM +0100, Cornelia Huck wrote:
> 
> > > So we should have a per-device callback into the transport layer, say
> > > check_legacy()?
> > 
> > I would just have 2 masks: legacy_features and features.
> 
> But these belong to the device type and the transport just needs to
> trigger usage of the right one, right?

Yes.

> > 
> > > For ccw, this would check for the negotiated revision; for mmio, it
> > > could check a device property configured with the device; and for pci,
> > > whatever the mechanism is there :)
> > > 
> > > A transport not implementing this callback is simply considered
> > > legacy-only.
> > 
> > I dislike callbacks. Let's just give all info to core,
> > and have it DTRT.
> > 
> Have a is_legacy flag in the vdev that is initialized to 1, and
> transports can unset it when the revision is negotiated or during init?

I would say have modern_features, legacy_features, and set host_features
correctly.

-- 
MST
