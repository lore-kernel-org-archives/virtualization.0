From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 18 Jun 2012 14:28:26 -0700
Message-ID: <20120618212826.GB32733@google.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<87hau9yse7.fsf@rustcorp.com.au> <4FDEE0CB.1030505@redhat.com>
	<87zk81x7dp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87zk81x7dp.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hello, guys.

On Mon, Jun 18, 2012 at 07:35:22PM +0930, Rusty Russell wrote:
> On Mon, 18 Jun 2012 16:03:23 +0800, Asias He <asias@redhat.com> wrote:
> > On 06/18/2012 03:46 PM, Rusty Russell wrote:
> > > On Mon, 18 Jun 2012 14:53:10 +0800, Asias He <asias@redhat.com> wrote:
> > >> This patch introduces bio-based IO path for virtio-blk.
> > >
> > > Why make it optional?
> > 
> > request-based IO path is useful for users who do not want to bypass the 
> > IO scheduler in guest kernel, e.g. users using spinning disk. For users 
> > using fast disk device, e.g. SSD device, they can use bio-based IO path.
> 
> Users using a spinning disk still get IO scheduling in the host though.
> What benefit is there in doing it in the guest as well?

Another thing is that some of cgroup features are impelmented in IO
scheduler (cfq).  e.g. bio based driver will be able to use cgroup
based throttling but IO weights won't work.  Not sure how meaningful
this is tho.

With that said, I think this sort of feature switching is quite ugly.
The pros and cons of each choice aren't obvious unless one is familiar
with implementation details.  IMHO, if the benefits of ioscheds aren't
critical, it would be better to just go with bio based implementation.

Thanks.

-- 
tejun
