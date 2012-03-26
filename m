From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC V2 PATCH] virtio-spec: ack the announce notification through
	ctrl_vq
Date: Mon, 26 Mar 2012 11:12:05 +1030
Message-ID: <878viochwi.fsf@rustcorp.com.au>
References: <20120323030501.6912.96218.stgit@jason-ThinkPad-T400>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120323030501.6912.96218.stgit@jason-ThinkPad-T400>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 23 Mar 2012 11:05:01 +0800, Jason Wang <jasowang@redhat.com> wrote:
> During link announcement, driver needs a method to notify device that it has
> received the notification and let it clear the VIRITO_NET_S_ANNOUNCE bit in the
> status field. Doing this through a dedicated command looks suitable for all
> platforms (especially for the ones who don't trap the status read or write) with
> a ctrl vq and can solve the race between host and guest.
> 
> So this patch makes VIRTIO_NET_F_ANNOUNCE depends on VIRTIO_NET_F_CTRL_VQ and
> introduces a dedicated command VIRTIO_NET_CTRL_ANNOUNCE_ACK to let device clear
> the VIRTIO_NET_S_ANNOUNCE bit in the status field.

Applied, thanks!

Cheers,
Rusty.
-- 
  How could I marry someone with more hair than me?  http://baldalex.org
