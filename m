From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH RFC 1/2] virtio: introduce packed ring defines
Date: Tue, 27 Feb 2018 09:26:27 +0000
Message-ID: <e7a7f045b87a420a8863030b9378cb38__34924.1033466116$1519723459$gmane$org@AcuMS.aculab.com>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
	<20180223111801.15240-2-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180223111801.15240-2-tiwei.bie@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Tiwei Bie' <tiwei.bie@intel.com>, "mst@redhat.com" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "wexu@redhat.com" <wexu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Tiwei Bie
> Sent: 23 February 2018 11:18
...
> +struct vring_packed_desc_event {
> +	/* Descriptor Event Offset */
> +	__virtio16 desc_event_off   : 15,
> +	/* Descriptor Event Wrap Counter */
> +		   desc_event_wrap  : 1;
> +	/* Descriptor Event Flags */
> +	__virtio16 desc_event_flags : 2;
> +};

This looks like you are assuming that a bit-field has a defined
layout and can be used to map a 'hardware' structure.
The don't, don't use them like that.

	David
