From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Tue, 27 Feb 2018 20:01:59 +0800
Message-ID: <20180227120159.g47rtazm3uhoht6f__44709.2115217403$1519732898$gmane$org@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
	<20180223111801.15240-2-tiwei.bie@intel.com>
	<20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180227085458.h5dytkwaeczrrijr@dhcp-192-241.str.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Freimann <jfreimann@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 09:54:58AM +0100, Jens Freimann wrote:
> On Fri, Feb 23, 2018 at 07:18:00PM +0800, Tiwei Bie wrote:
[...]
> > 
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Event Offset */
> > +	__virtio16 desc_event_off   : 15,
> > +	/* Descriptor Event Wrap Counter */
> > +		   desc_event_wrap  : 1;
> > +	/* Descriptor Event Flags */
> > +	__virtio16 desc_event_flags : 2;
> > +};
> 
> Where would the virtqueue number go in driver notifications?

This structure is for event suppression instead of notification.

You could refer to the "Event Suppression Structure Format"
section of the spec for more details:

https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd08.pdf

Best regards,
Tiwei Bie
