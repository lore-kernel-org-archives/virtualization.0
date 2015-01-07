From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 13/20] virtio: allow to fail setting status
Date: Wed, 7 Jan 2015 17:13:32 +0100
Message-ID: <20150107171332.597d428c.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-14-git-send-email-cornelia.huck@de.ibm.com>
	<20141230122537.GA17903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141230122537.GA17903@redhat.com>
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

On Tue, 30 Dec 2014 14:25:37 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Dec 11, 2014 at 02:25:15PM +0100, Cornelia Huck wrote:
> > virtio-1 allow setting of the FEATURES_OK status bit to fail if
> > the negotiated feature bits are inconsistent: let's fail
> > virtio_set_status() in that case and update virtio-ccw to post an
> > error to the guest.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Right but a separate validate_features call is awkward.
> How about we defer virtio_set_features until FEATURES_OK,
> and teach virtio_set_features that it can fail?

Hm. But we would need to keep virtio_set_features() where it is called
now for legacy devices, as they will never see FEATURES_OK, right? So
we need to make this depending on revisions (or whatever the equivalent
is for pci/mmio), as we cannot check for VERSION_1. Not sure whether
this makes the code easier to follow.
