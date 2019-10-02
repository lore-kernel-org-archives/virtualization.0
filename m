From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: virtq questions
Date: Wed, 2 Oct 2019 09:27:34 -0400
Message-ID: <20191002132734.GA6972@redhat.com>
References: <CAJfpegsGNoT4NUai-=HHkqOrmjgMb=4TDk79EgxDBCd8fxCGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJfpegsGNoT4NUai-=HHkqOrmjgMb=4TDk79EgxDBCd8fxCGZA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 02, 2019 at 09:40:11AM +0200, Miklos Szeredi wrote:
> Looking at the ugly retry logic in virtiofs and have some questions.

Hi Miklos,

What are you thinking w.r.t cleanup of retry logic. As of now we put
requests in a list and retry later with the help of a worker.

Other option will probably be block the submitter if queue is full. Make
it sleep, wake up after a while and retry submission.

> First one is, where do these features come from:
> 
> VIRTIO_F_RING_PACKED
> VIRTIO_RING_F_INDIRECT_DESC

Looks like these feature bits are supposed to be advertised by the device
if device supports these capabilities.

I see in qemu code that bunch of drivers are advertisig this capability.
(virtio_scsi, virtio_blk etc).

> 
> I see that in virtiofs "packed" is off and "indirect" is on.  Is this
> guaranteed?

I can't find specifying any feature bits in vhost-user-fs.c. So we
probably are getting a default value.

Thanks
Vivek
