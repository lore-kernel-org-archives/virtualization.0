From: Amos Kong <akong@redhat.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v2] virtio-net: introduce a new macaddr
	control
Date: Thu, 17 Jan 2013 13:45:11 +0800
Message-ID: <20130117054511.GA12468@t430s.redhat.com>
References: <1358315821-29519-1-git-send-email-akong@redhat.com>
	<1358317007-29972-1-git-send-email-akong@redhat.com>
	<87mww8y5bb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87mww8y5bb.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2013 at 11:49:20AM +1030, Rusty Russell wrote:
> akong@redhat.com writes:
> > @@ -349,6 +351,14 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
> >  {
> >      struct virtio_net_ctrl_mac mac_data;
> >  
> > +    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2 &&
> > +        elem->out_sg[1].iov_len == ETH_ALEN) {
> > +        /* Set MAC address */
> > +        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);
> > +        qemu_format_nic_info_str(&n->nic->nc, n->mac);
> > +        return VIRTIO_NET_OK;
> > +    }
> 
> Does the rest of the net device still rely on the layout of descriptors?

No, only info string of net client relies on n->mac

> If so, OK, we'll fix them all together.  If not, this introduces a new
> one.
> 
> Cheers,
> Rusty.
