From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer
	in host
Date: Thu, 13 Dec 2018 09:50:28 -0500
Message-ID: <20181213094935-mutt-send-email-mst__12205.9227237061$1544712515$gmane$org@kernel.org>
References: <5C10D4FB.6070009@huawei.com>
	<20181212.110944.1077302806391053539.davem@davemloft.net>
	<5C11CDF4.4040405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5C11CDF4.4040405@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 11:11:48AM +0800, jiangyiwen wrote:
> On 2018/12/13 3:09, David Miller wrote:
> > From: jiangyiwen <jiangyiwen@huawei.com>
> > Date: Wed, 12 Dec 2018 17:29:31 +0800
> > 
> >> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> >> index 1d57ed3..2292f30 100644
> >> --- a/include/uapi/linux/virtio_vsock.h
> >> +++ b/include/uapi/linux/virtio_vsock.h
> >> @@ -63,6 +63,11 @@ struct virtio_vsock_hdr {
> >>  	__le32	fwd_cnt;
> >>  } __attribute__((packed));
> >>
> >> +/* It add mergeable rx buffers feature */
> >> +struct virtio_vsock_mrg_rxbuf_hdr {
> >> +	__le16  num_buffers;    /* number of mergeable rx buffers */
> >> +} __attribute__((packed));
> >> +
> > 
> > I know the rest of this file uses 'packed' but this attribute should
> > only be used if absolutely necessary as it incurs a
> > non-trivial performance penalty for some architectures.
> > 
> > .
> > 
> 
> Hi David,
> 
> I hope Host can fill fewer bytes into rx virtqueue, so
> I keep structure virtio_vsock_mrg_rxbuf_hdr one byte
> alignment.
> 
> Thanks,
> Yiwen.

It doesn't work like this now though, does it?
Buffers are preallocated and they are always aligned.
So I do not see the point.

-- 
MST
