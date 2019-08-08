From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] virtio_ring: packed ring: fix
	virtqueue_detach_unused_buf
Date: Thu, 8 Aug 2019 14:42:32 +0200
Message-ID: <20190808124232.GA32144__41826.2701293983$1565268164$gmane$org@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
	<20190808113606.19504-3-pagupta@redhat.com>
	<20190808115630.GB2015@kroah.com>
	<1512438873.7425183.1565267326035.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1512438873.7425183.1565267326035.JavaMail.zimbra@redhat.com>
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

On Thu, Aug 08, 2019 at 08:28:46AM -0400, Pankaj Gupta wrote:
> 
> 
> > > This patch makes packed ring code compatible with split ring in function
> > > 'virtqueue_detach_unused_buf_*'.
> > 
> > What does that mean?  What does this "fix"?
> 
> Patch 1 frees the buffers When a port is unplugged from the virtio
> console device. It does this with the help of 'virtqueue_detach_unused_buf_split/packed'
> function. For split ring case, corresponding function decrements avail ring index.
> For packed ring code, this functionality is not available, so this patch adds the
> required support and hence help to remove the unused buffer completely.

Explain all of this in great detail in the changelog comment.  What you
have in there today does not make any sense.

thanks,

greg k-h
