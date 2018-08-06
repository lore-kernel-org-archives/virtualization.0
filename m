From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V2] vhost: switch to use new message format
Date: Mon, 06 Aug 2018 10:41:48 -0700 (PDT)
Message-ID: <20180806.104148.1576759632957723909.davem__14291.9295737103$1533577190$gmane$org@davemloft.net>
References: <1533525467-17787-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533525467-17787-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Aug 2018 11:17:47 +0800

> We use to have message like:
> 
> struct vhost_msg {
> 	int type;
> 	union {
> 		struct vhost_iotlb_msg iotlb;
> 		__u8 padding[64];
> 	};
> };
> 
> Unfortunately, there will be a hole of 32bit in 64bit machine because
> of the alignment. This leads a different formats between 32bit API and
> 64bit API. What's more it will break 32bit program running on 64bit
> machine.
> 
> So fixing this by introducing a new message type with an explicit
> 32bit reserved field after type like:
> 
> struct vhost_msg_v2 {
> 	__u32 type;
> 	__u32 reserved;
> 	union {
> 		struct vhost_iotlb_msg iotlb;
> 		__u8 padding[64];
> 	};
> };
> 
> We will have a consistent ABI after switching to use this. To enable
> this capability, introduce a new ioctl (VHOST_SET_BAKCEND_FEATURE) for
> userspace to enable this feature (VHOST_BACKEND_F_IOTLB_V2).
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - use __u32 instead of int for type

Applied, thanks Jason.
