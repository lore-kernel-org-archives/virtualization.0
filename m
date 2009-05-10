From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Sun, 10 May 2009 20:51:40 +0200
Message-ID: <200905102051.41221.borntraeger__28864.1652012759$1241981591$gmane$org@de.ibm.com>
References: <cover.1241700929.git.mst@redhat.com>
	<20090508124821.GA3073@redhat.com>
	<200905101337.06836.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905101337.06836.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: avi@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Sunday 10 May 2009 06:07:06 schrieb Rusty Russell:
> Yes, and in fact a rough look at your patch reveals that we don't actually 
> need del_vq: now we track them, we can just do that as part of vdev 
> destruction, right?

Some of my students are working on a test module for virtio. Its a driver that matches all virtio IDs which can be used via bind/unbind. We currently use del_vq/find_vq in non device_release code. I will recheck but my feeling is that I want to keep del_vq.

Christian
