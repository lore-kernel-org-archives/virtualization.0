From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 10/20] s390x/virtio-ccw: add virtio
	set-revision call
Date: Wed, 21 Jan 2015 13:39:22 +0100
Message-ID: <20150121133922.1b3e7ceb.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
	<20150120110824.GJ17631@stefanha-thinkpad.redhat.com>
	<20150121122318.22a77751.cornelia.huck@de.ibm.com>
	<20150121125141.5d905254@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150121125141.5d905254@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 21 Jan 2015 12:51:41 +0100
Thomas Huth <thuth@linux.vnet.ibm.com> wrote:

> On Wed, 21 Jan 2015 12:23:18 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > On Tue, 20 Jan 2015 11:08:24 +0000
> > Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > 
> > > On Thu, Dec 11, 2014 at 02:25:12PM +0100, Cornelia Huck wrote:
> > > > @@ -608,6 +631,25 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
> > > >              }
> > > >          }
> > > >          break;
> > > > +    case CCW_CMD_SET_VIRTIO_REV:
> > > > +        len = sizeof(revinfo);
> > > > +        if (ccw.count < len || (check_len && ccw.count > len)) {
> > > > +            ret = -EINVAL;
> > > > +            break;
> > > > +        }
> > > > +        if (!ccw.cda) {
> > > > +            ret = -EFAULT;
> > > > +            break;
> > > > +        }
> > > > +        cpu_physical_memory_read(ccw.cda, &revinfo, len);
> > > > +        if (dev->revision >= 0 ||
> > > > +            revinfo.revision > virtio_ccw_rev_max(dev)) {
> > > 
> > > In the next patch virtio_ccw_handle_set_vq() uses big-endian memory
> > > access functions to load a struct from guest memory.
> > > 
> > > Here you just copy the struct in without byteswaps.
> > > 
> > > Are the byteswaps missing here?  (I guess this normally runs big-endian
> > > guests on big-endian hosts so it's not noticable.)
> > 
> > Indeed, these are supposed to be big-endian. I'll double check the
> > other payloads.
> 
> Right. Cornelia, can you take care of this or shall I rework the patch?

Currently already working on a patch :)

> NB: Actually, there are a couple of "XXX config space endianness"
> comments in that virtio_ccw_cb() function, so there are likely a bunch
> of problems when this code should be run on little endian hosts one day.
> So far, this code only runs with big-endian guests on big-endian hosts
> since the virtio-ccw machine is currently KVM-only as far as I know,
> that's likely why nobody complained about this yet.

The transport can't take care of the config space endianness, this
needs to be done by the individual devices. Probably best to simply
ditch the comments.
