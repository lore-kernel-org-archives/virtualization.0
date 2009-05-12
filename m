From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Wed, 13 May 2009 00:00:02 +0930
Message-ID: <200905130000.03032.rusty__8708.26528775996$1242138705$gmane$org@rustcorp.com.au>
References: <cover.1242080138.git.mst@redhat.com>
	<20090511221932.GA22915@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090511221932.GA22915@redhat.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 May 2009 07:49:32 am Michael S. Tsirkin wrote:
> This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
> and updates all drivers. This is needed for MSI support, because MSI
> needs to know the total number of vectors upfront.

Sorry, is this not on top of my virtio_device vq linked list patch?

Two other things: prefer vq_callback_t as the type name, and perhaps consider 
varargs for the callbacks (or would that be too horrible at the implementation 
end?)

Thanks,
Rusty.
