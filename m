From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/8] virtio: add request_vqs/free_vqs operations
Date: Mon, 4 May 2009 21:02:20 +0930
Message-ID: <200905042102.21218.rusty__45723.0493579575$1241436985$gmane$org@rustcorp.com.au>
References: <cover.1240832196.git.mst@redhat.com>
	<20090427123153.GA1156@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090427123153.GA1156@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 27 Apr 2009 10:01:53 pm Michael S. Tsirkin wrote:
> This adds 2 new optional virtio operations: request_vqs/free_vqs. They will be
> used for MSI support, because MSI needs to know the total number of vectors
> upfront.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi Michael,

  Thanks for this work!  But this interface is horrible.  Either probe for the
number of vqs in virtio_pci, or change find_vq to

	int (*find_vqs)(struct virtio_device *, unsigned max,
						     struct virtqueue *vqs[]);

Thanks,
Rusty.
