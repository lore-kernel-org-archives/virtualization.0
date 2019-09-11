From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
Date: Wed, 11 Sep 2019 10:52:47 -0400
Message-ID: <20190911145247.GA7271__38679.0439531737$1568213584$gmane$org@redhat.com>
References: <20190910151206.4671-1-mszeredi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> Git tree for this version is available here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v5
> 
> Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-v5).
> 
> I've folded the series from Vivek and fixed a couple of TODO comments
> myself.  AFAICS two issues remain that need to be resolved in the short
> term, one way or the other: freeze/restore and full virtqueue.

Hi Miklos,

We are already handling full virtqueue by waiting a bit and retrying.
I think TODO in virtio_fs_enqueue_req() is stale. Caller already
handles virtqueue full situation by retrying.

Havind said that, this could be improved by using some sort of wait
queue or completion privimitve.

Thanks
Vivek
