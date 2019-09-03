From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
	machines
Date: Tue, 3 Sep 2019 10:07:52 -0400
Message-ID: <20190903140752.GA10983__28396.922855039$1567519696$gmane$org@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
	<CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
	<20190903041507-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190903041507-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:

[..]
> +	/* TODO lock */
> give me pause.
> 
> Cleanup generally seems broken to me - what pauses the FS

I am looking into device removal aspect of it now. Thinking of adding
a reference count to virtiofs device and possibly also a bit flag to
indicate if device is still alive. That way, we should be able to cleanup
device more gracefully.

> 
> What about the rest of TODOs in that file?

I will also take a closer look at TODOs now. Better device cleanup path
might get rid of some of them. Some of them might not be valid anymore.

> 
> use of usleep is hacky - can't we do better e.g. with a
> completion?

Agreed.

Thanks
Vivek
