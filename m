From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v6 13/20] virtio: allow to fail setting status
Date: Thu, 8 Jan 2015 10:09:58 +0200
Message-ID: <20150108080958.GB12425@redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-14-git-send-email-cornelia.huck@de.ibm.com>
	<20141230122537.GA17903@redhat.com>
	<20150107171332.597d428c.cornelia.huck@de.ibm.com>
	<20150107190821.GA8734@redhat.com>
	<20150108082037.448d8102.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150108082037.448d8102.cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 08, 2015 at 08:20:37AM +0100, Cornelia Huck wrote:
> On Wed, 7 Jan 2015 21:08:21 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jan 07, 2015 at 05:13:32PM +0100, Cornelia Huck wrote:
> > > On Tue, 30 Dec 2014 14:25:37 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Thu, Dec 11, 2014 at 02:25:15PM +0100, Cornelia Huck wrote:
> > > > > virtio-1 allow setting of the FEATURES_OK status bit to fail if
> > > > > the negotiated feature bits are inconsistent: let's fail
> > > > > virtio_set_status() in that case and update virtio-ccw to post an
> > > > > error to the guest.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > 
> > > > Right but a separate validate_features call is awkward.
> > > > How about we defer virtio_set_features until FEATURES_OK,
> > > > and teach virtio_set_features that it can fail?
> > > 
> > > Hm. But we would need to keep virtio_set_features() where it is called
> > > now for legacy devices, as they will never see FEATURES_OK, right?
> > > So
> > > we need to make this depending on revisions (or whatever the equivalent
> > > is for pci/mmio), as we cannot check for VERSION_1. Not sure whether
> > > this makes the code easier to follow.
> > 
> > So let's make this a separate callback then.
> > virtio_legacy_set_features?
> 
> I'm not sure I like that. We'd need to touch every transport, right?

Yes but there aren't so many.
