From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Tue, 27 Feb 2018 19:31:39 +0800
Message-ID: <20180227113138.4untitgk6ufnatvb@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
	<20180223111801.15240-2-tiwei.bie@intel.com>
	<e7a7f045b87a420a8863030b9378cb38@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e7a7f045b87a420a8863030b9378cb38@AcuMS.aculab.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "wexu@redhat.com" <wexu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 27, 2018 at 09:26:27AM +0000, David Laight wrote:
> From: Tiwei Bie
> > Sent: 23 February 2018 11:18
> ...
> > +struct vring_packed_desc_event {
> > +	/* Descriptor Event Offset */
> > +	__virtio16 desc_event_off   : 15,
> > +	/* Descriptor Event Wrap Counter */
> > +		   desc_event_wrap  : 1;
> > +	/* Descriptor Event Flags */
> > +	__virtio16 desc_event_flags : 2;
> > +};
> 
> This looks like you are assuming that a bit-field has a defined
> layout and can be used to map a 'hardware' structure.
> The don't, don't use them like that.
> 
> 	David
> 

Thanks for the comments! Above definition isn't used in
this RFC, and the corresponding parts (event suppression)
haven't been implemented yet. It's more like some pseudo
code (I should add some comments about this in the code).

I planned to change it to something like this in the next
version:

struct vring_packed_desc_event {
	__virtio16 off_wrap;
	__virtio16 flags;  // XXX maybe not a good name for future
};                         // extension. Only 2bits are used now.

But it seems that I had a misunderstanding about the spec
on this previously:

https://lists.oasis-open.org/archives/virtio-dev/201802/msg00173.html

Anyway, it will be addressed. Thank you very much! ;-)

Best regards,
Tiwei Bie
