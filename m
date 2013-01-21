From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3] virtio-spec: set mac address by a new vq command
Date: Mon, 21 Jan 2013 13:35:06 +1030
Message-ID: <87y5fnutgd.fsf@rustcorp.com.au>
References: <20130118104351.GA22481@stefanha-thinkpad.redhat.com>
	<1358507141-27585-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358507141-27585-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

akong@redhat.com writes:
> From: Amos Kong <akong@redhat.com>
>
> Virtio-net driver currently programs MAC address byte by byte,
> this means that we have an intermediate step where mac is wrong.
> This patch introduced a new control command to set MAC address
> in one time, and added a new feature flag VIRTIO_NET_F_MAC_ADDR
> for this feature.
>
> "mac" field will be set to read-only when VIRTIO_NET_F_CTRL_MAC_ADDR
>  is acked.

Thanks, applied.

Cheers,
Rusty.
