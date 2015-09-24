From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: RFC: virtio-peer shared memory based peer communication device
Date: Thu, 24 Sep 2015 13:04:20 +0300
Message-ID: <20150924125725-mutt-send-email-mst__45308.5123481744$1443089097$gmane$org@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AD9AB0B@SHSMSX104.ccr.corp.intel.com>
	<55EFF03A.4000109@huawei.com> <55FC3BE7.5010503@huawei.com>
	<20150921150953-mutt-send-email-mst@redhat.com>
	<55FFF8CA.3020008@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55FFF8CA.3020008@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Claudio Fontana <claudio.fontana@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Zhang,
	Yang Z" <yang.z.zhang@intel.com>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 21, 2015 at 02:32:10PM +0200, Jan Kiszka wrote:
> On 2015-09-21 14:13, Michael S. Tsirkin wrote:
> > On Fri, Sep 18, 2015 at 06:29:27PM +0200, Claudio Fontana wrote:
> >> Hello,
> >>
> >> this is a first RFC for virtio-peer 0.1, which is still very much a work in progress:
> >>
> >> https://github.com/hw-claudio/virtio-peer/wiki
> >>
> >> It is also available as PDF there, but the text is reproduced here for commenting:
> >>
> >> Peer shared memory communication device (virtio-peer)
> >>
> >> General Overview
> >>
> >> (I recommend looking at the PDF for some clarifying pictures)
> >>
> >> The Virtio Peer shared memory communication device (virtio-peer) is a
> >> virtual device which allows high performance low latency guest to
> >> guest communication. It uses a new queue extension feature tentatively
> >> called VIRTIO_F_WINDOW which indicates that descriptor tables,
> >> available and used rings and Queue Data reside in physical memory
> >> ranges called Windows, each identified with an unique identifier
> >> called WindowID.
> > 
> > So if I had to summarize the difference from regular virtio,
> > I'd say the main one is that this uses window id + offset
> > instead of the physical address.
> > 
> > 
> > My question is - why do it?
> > 
> > All windows are in memory space, are they not?
> > 
> > How about guest using full physical addresses,
> > and hypervisor sending the window physical address
> > to VM2?
> > 
> > VM2 can uses that to find both window id and offset.
> > 
> > 
> > This way at least VM1 can use regular virtio without changes.
> 
> What would be the value of having different drivers in VM1 and VM2,
> specifically if both run Linux?
> 
> Jan

It's common to have a VM act as a switch between others.

In this setup, there's value in being able to support existing guests as
endpoints, with new drivers only required for the switch.

> -- 
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
