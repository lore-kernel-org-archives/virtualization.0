From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Sun, 10 May 2009 10:25:38 +0300
Message-ID: <20090510072538.GA5335__33920.1830830008$1241940618$gmane$org@redhat.com>
References: <cover.1241700929.git.mst@redhat.com>
	<200905081637.09729.rusty@rustcorp.com.au>
	<20090508124821.GA3073@redhat.com>
	<200905101337.06836.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905101337.06836.rusty@rustcorp.com.au>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 10, 2009 at 01:37:06PM +0930, Rusty Russell wrote:
> Yes, and in fact a rough look at your patch reveals that we don't actually 
> need del_vq: now we track them, we can just do that as part of vdev 
> destruction, right?

Let's assume that a driver encounters an error in probe
after it calls find_vq. It would need a way to revert
find_vq, won't it?

It seems to me that bus->remove does not get called
on probe failure. Isn't that right?

-- 
MST
