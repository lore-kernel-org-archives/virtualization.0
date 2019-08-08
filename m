From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] virtio_console: free unused buffers with port
	delete
Date: Thu, 8 Aug 2019 13:55:55 +0200
Message-ID: <20190808115555.GA2015__41482.1758911543$1565265368$gmane$org@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
	<20190808113606.19504-2-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190808113606.19504-2-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: arnd@arndb.de, mst@redhat.com, amit@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 08, 2019 at 05:06:05PM +0530, Pankaj Gupta wrote:
>   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
>   deferred detaching of unused buffer to virtio device unplug time.
> 
>   This causes unplug/replug of single port in virtio device with an
>   error "Error allocating inbufs\n". As we don't free the unused buffers
>   attached with the port. Re-plug the same port tries to allocate new
>   buffers in virtqueue and results in this error if queue is full.
> 
>   This patch removes the unused buffers in vq's when we unplug the port.
>   This is the best we can do as we cannot call device_reset because virtio
>   device is still active.

Why is this indented?

> 
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")

Fixes: b3258ff1d608 ("virtio: Decrement avail idx on buffer detach")

is the correct format to use.

And given that this is from 2.6.39 (and 2.6.38.5), shouldn't it also be
backported for the stable kernels?

thanks,

greg k-h
