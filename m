From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 19/20] virtio-blk: revision specific feature bits
Date: Fri, 30 Jan 2015 15:10:49 +0100
Message-ID: <20150130151049.2e4c5331.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-20-git-send-email-cornelia.huck@de.ibm.com>
	<20141228102446.GA9260@redhat.com>
	<20150107172949.11f374bf.cornelia.huck@de.ibm.com>
	<20150107191144.GC8734@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150107191144.GC8734@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 7 Jan 2015 21:11:44 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 07, 2015 at 05:29:49PM +0100, Cornelia Huck wrote:
> > On Sun, 28 Dec 2014 12:24:46 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Dec 11, 2014 at 02:25:21PM +0100, Cornelia Huck wrote:
> > > > Wire up virtio-blk to provide different feature bit sets depending
> > > > on whether legacy or v1.0 has been requested.
> > > > 
> > > > Note that VERSION_1 is still disabled due to missing ANY_LAYOUT support.
> > > > 
> > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > 
> > > So we need some way for devices to tell transports
> > > not to negotiate rev 1.
> > > Does clearing VERSION_1 have this effect?
> > > 
> > I just noticed that my patch is running in circles here.
> > 
> > What we need is probably the transport-dependent maximum revision
> > checker (which at least for ccw is acting on a device) pass in the
> > requested revision and check if the feature bits for the revision
> > include VERSION_1. Does that make sense?
> 
> Just make devices set 'rev 1 supported' flag?

I'm now using the ->get_features() callback to check for VERSION_1
(assuming every device that supports it adds the bit in its callback)
and only allow rev 1 if it is present. Will play with this a bit as
well.
