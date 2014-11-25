From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v2 00/12] qemu: towards virtio-1 host support
Date: Tue, 25 Nov 2014 18:16:31 +0100
Message-ID: <20141125181631.3f92d395.cornelia.huck@de.ibm.com>
References: <1416921863-16523-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141125164410.GA21646@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141125164410.GA21646@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 18:44:10 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 25, 2014 at 02:24:11PM +0100, Cornelia Huck wrote:
> > Hi,
> > 
> > here's the next version of my virtio-1 qemu patchset. Using virtio-1
> > virtio-blk and virtio-net devices with a guest kernel built from
> > <1416829787-14252-1-git-send-email-mst@redhat.com> still seems to
> > work for the virtio-ccw transport.
> 
> I posted v4, would appreciate an explicit tested-by from you
> on that thread.

I was still reviewing v3 :)

I'll put it on my todo list for tomorrow.

> 
> > 
> > Changes from v1:
> > - rebased against current master
> > - don't advertise VERSION_1 for all devices, make devices switch it on
> >   individually
> 
> So from ccw perspective, all that's left is to convert more devices?
> 

I'll probably need to look into the explicit command reject for
FEATURES_OK, but other than that, only the individual devices are left
AFAICS.
