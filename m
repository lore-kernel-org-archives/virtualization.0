From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 15/16] virtio-fs: add virtiofs filesystem
Date: Wed, 4 Sep 2019 14:58:40 -0400
Message-ID: <20190904145656-mutt-send-email-mst__17295.9375356854$1567623566$gmane$org@kernel.org>
References: <20190903113640.7984-1-mszeredi@redhat.com>
	<20190903114203.8278-10-mszeredi@redhat.com>
	<20190903092222-mutt-send-email-mst@kernel.org>
	<20190904181630.GB26826@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190904181630.GB26826@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 04, 2019 at 07:16:30PM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 03, 2019 at 09:55:49AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 03, 2019 at 01:42:02PM +0200, Miklos Szeredi wrote:
> > Endian-ness for fuse header also looks wrong.
> [...]
> > > +struct virtio_fs_forget {
> > > +	struct fuse_in_header ih;
> > > +	struct fuse_forget_in arg;
> > 
> > These structures are all native endian.
> > 
> > Passing them to host will make cross-endian setups painful to support,
> > and hardware implementations impossible.
> > 
> > How about converting everything to LE?
> 
> The driver dictates the endianness of the FUSE protocol session.  The
> virtio-fs device specification states that the device looks at the first
> request's fuse_in_header::opcode field to detect the guest endianness.
> 
> If it sees FUSE_INIT in its native endianness then no byte-swapping is
> necessary.  If it sees FUSE_INIT in the opposite endianness then
> byte-swapping is necessary on the device side.


You are right.  Pls ignore the comment.  We need to reserve the
byte-swapped FUSE_INIT to make sure future versions of fuse don't try to
send that though.  I sent a patch to that effect, let's see whether it
gets accepted.


-- 
MST
