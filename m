From: David Howells <dhowells@redhat.com>
Subject: Re: kernel BUG at fs/pipe.c:LINE!
Date: Thu, 05 Dec 2019 13:06:30 +0000
Message-ID: <27081.1575551190__37074.9148003355$1575551214$gmane$org@warthog.procyon.org.uk>
References: <20191205072838.GA3237@sol.localdomain>
 <000000000000a376820598b2eb97@google.com>
 <20191205054023.GA772@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191205072838.GA3237@sol.localdomain>
Content-ID: <27080.1575551190.1@warthog.procyon.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: willy@infradead.org, arnd@arndb.de, jannh@google.com, syzbot <syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com>, amit@kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, virtualization@lists.linux-foundation.org, dhowells@redhat.com, miklos@szeredi.hu, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Eric Biggers <ebiggers@kernel.org> wrote:

> static __poll_t
> pipe_poll(struct file *filp, poll_table *wait)
> {
>         __poll_t mask;
>         struct pipe_inode_info *pipe = filp->private_data;
>         unsigned int head = READ_ONCE(pipe->head);
>         unsigned int tail = READ_ONCE(pipe->tail);
> 
>         poll_wait(filp, &pipe->wait, wait);
> 
>         BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);
> 
> It's not holding the pipe mutex, right?  So 'head', 'tail' and 'ring_size' can
> all be changed concurrently, and they aren't read atomically with respect to
> each other.
> 
> How do you propose to implement poll() correctly with the new head + tail
> approach?  Just take the mutex?

Firstly, the BUG_ON() check probably isn't necessary here - the same issue
with occupancy being seen to be greater than the queue depth existed
previously (there was no locking around the read of pipe->nrbufs and
pipe->buffers).  I added a sanity check.

Secondly, it should be possible to make it such that just the spinlock
suffices.  The following few patches make the main pipe read/write routines
use the spinlock so as not to be interfered with by notification insertion.

I didn't roll the spinlock out to splice and suchlike since I prohibit
splicing to a notifications pipe because of the iov_iter_revert() fun.

David
