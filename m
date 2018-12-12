From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer
	in host
Date: Wed, 12 Dec 2018 11:09:44 -0800 (PST)
Message-ID: <20181212.110944.1077302806391053539.davem__5792.48075741834$1544641685$gmane$org@davemloft.net>
References: <5C10D4FB.6070009@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C10D4FB.6070009@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen@huawei.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: jiangyiwen <jiangyiwen@huawei.com>
Date: Wed, 12 Dec 2018 17:29:31 +0800

> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 1d57ed3..2292f30 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -63,6 +63,11 @@ struct virtio_vsock_hdr {
>  	__le32	fwd_cnt;
>  } __attribute__((packed));
> 
> +/* It add mergeable rx buffers feature */
> +struct virtio_vsock_mrg_rxbuf_hdr {
> +	__le16  num_buffers;    /* number of mergeable rx buffers */
> +} __attribute__((packed));
> +

I know the rest of this file uses 'packed' but this attribute should
only be used if absolutely necessary as it incurs a
non-trivial performance penalty for some architectures.
