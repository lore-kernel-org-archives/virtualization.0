From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] [RFC] virtio: Limit the retries on a virtio device reset
Date: Fri, 25 Aug 2017 19:43:35 +0300
Message-ID: <20170825193824-mutt-send-email-mst@kernel.org>
References: <1503505982-29568-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<20170824130746.25f80368.cohuck@redhat.com>
	<af4aa628-3583-50b3-1007-4c8b6d4e2183@linux.vnet.ibm.com>
	<20170824170725-mutt-send-email-mst@kernel.org>
	<d75121e6-5685-295a-7430-6aa8d713060b@linux.vnet.ibm.com>
	<20170825001411-mutt-send-email-mst@kernel.org>
	<20170825102612.39a5ca60.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170825102612.39a5ca60.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 25, 2017 at 10:26:12AM +0200, Cornelia Huck wrote:
> On Fri, 25 Aug 2017 00:16:05 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Aug 24, 2017 at 07:07:42PM +0200, Pierre Morel wrote:
> > > > - we'll have to spread these tests all over the place.  
> > > 
> > > I counted 19 places where to check if the reset went OK.
> > > 
> > > None of them touch the device anymore after reset and just free driver's
> > > resources.  
> > 
> > ... and then hypervisor uses the resources after free. Not good.
> 
> The only place where we can simply give up on the device and be sure
> that nothing bad happens is during initial setup. In the other places,
> it seems we have the choice between looping (as now) or panic.

Right. Whether it's even worth it to handle just this corner case,
I don't really know.

-- 
MST
