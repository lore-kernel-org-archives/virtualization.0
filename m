From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio PCI on KVM without IO BARs
Date: Wed, 6 Mar 2013 14:02:16 +0200
Message-ID: <20130306120216.GA18381@redhat.com>
References: <20130228152433.GA13832@redhat.com> <5136882C.8040700@zytor.com>
	<5136ECD7.3020501@zytor.com> <20130306092140.GA16921@redhat.com>
	<51372544.7090409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51372544.7090409@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2013 at 03:15:16AM -0800, H. Peter Anvin wrote:
> On 03/06/2013 01:21 AM, Michael S. Tsirkin wrote:
> > 
> > Right. Though even with better granularify bridge windows
> > would still be a (smaller) problem causing fragmentation.
> > 
> > If we were to extend the PCI spec I would go for a bridge without
> > windows at all: a bridge can snoop on configuration transactions and
> > responses programming devices behind it and build a full map of address
> > to device mappings.
> > 
> > In partucular, this would be a good fit for an uplink bridge in a PCI
> > express switch, which is integrated with downlink bridges on the same
> > silicon, so bridge windows do nothing but add overhead.
> > 
> 
> True, but the real problem is that the downlink (type 1 header) is
> typically on a different piece of silicon than the device BAR (type 0
> header).
> 
> I am not sure that a snooping-based system will work and not be
> prohibitive in its hardware cost on an actual hardware system.  I
> suspect it would decay into needing a large RAM array in every bridge.
> 
> 	-hpa

This might be more difficult if you allow arbitrary number of functions
behind a bridge.  However, this is not a problem for integrated functions
(e.g. on the same silicon or board).

Bridge could specify which slots host integrated functions and do
snooping for these, and have regular window rules apply to open slots.


-- 
MST
