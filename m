From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Mon, 25 Mar 2013 09:05:16 +0200
Message-ID: <20130325070516.GC32581@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com> <514F8BD3.8010306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514F8BD3.8010306@zytor.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 24, 2013 at 04:27:15PM -0700, H. Peter Anvin wrote:
> On 03/24/2013 01:19 PM, Michael S. Tsirkin wrote:
> >>  struct virtio_pci_cap {
> >>  	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
> >> @@ -150,7 +153,9 @@ struct virtio_pci_common_cfg {
> >>  	__le16 queue_size;	/* read-write, power of 2. */
> >>  	__le16 queue_msix_vector;/* read-write */
> >>  	__le16 queue_enable;	/* read-write */
> >> -	__le16 queue_notify;	/* read-only */
> >> +	__le16 unused2;
> >> +	__le32 queue_notify_val;/* read-only */
> >> +	__le32 queue_notify_off;/* read-only */
> >>  	__le64 queue_desc;	/* read-write */
> >>  	__le64 queue_avail;	/* read-write */
> >>  	__le64 queue_used;	/* read-write */
> > 
> > So how exactly do the offsets mesh with the dual capability?  For IO we
> > want to use the same address and get queue from the data, for memory we
> > want a per queue address ...
> > 
> 
> How about having a readonly field which is "address increment per trigger"?
> 
> The guest would be required to always write the queue number as the
> data, however, the host would not be required to interpret it if the
> address increment is nonzero?
> 
> 	-hpa

Not sure what increment means here. The interface that Rusty proposes
reports queue offset for each queue. My question was that we probably
can't affort offsets for IO since the address space is so restricted.
Maybe rename memory_offset/memory_val and have it only apply to memory?


-- 
MST
