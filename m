From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio_ring: packed ring: fix
	virtqueue_detach_unused_buf
Date: Thu, 8 Aug 2019 08:28:46 -0400 (EDT)
Message-ID: <1512438873.7425183.1565267326035.JavaMail.zimbra__42315.0300093525$1565267336$gmane$org@redhat.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
	<20190808113606.19504-3-pagupta@redhat.com>
	<20190808115630.GB2015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808115630.GB2015@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, mst@redhat.com, amit@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



> > This patch makes packed ring code compatible with split ring in function
> > 'virtqueue_detach_unused_buf_*'.
> 
> What does that mean?  What does this "fix"?

Patch 1 frees the buffers When a port is unplugged from the virtio
console device. It does this with the help of 'virtqueue_detach_unused_buf_split/packed'
function. For split ring case, corresponding function decrements avail ring index.
For packed ring code, this functionality is not available, so this patch adds the
required support and hence help to remove the unused buffer completely.

Thanks,
Pankaj  

> 
> thanks,
> 
> greg k-h
> 
