From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/6] virtio_add_buf replacement.
Date: Thu, 07 Mar 2013 11:35:16 +1100
Message-ID: <878v609hdn.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au>
	<20130306080940.GA4034@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130306080940.GA4034@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

Asias He <asias@redhat.com> writes:
> On Wed, Mar 06, 2013 at 04:15:02PM +1100, Rusty Russell wrote:
>> OK, so I've spent a few days benchmarking.  Turns out 80% of
>> virtio_add_buf cases are uni-directional (including the
>> always-performance-sensitive networking code), and that gets no
>> performance penalty (though tests with real networking would be
>> appreciated!).
>> 
>> I'm not reposting all the "convert driver to virtio_add_outbuf()"
>> patches: just the scsi one which I didn't have before.  I won't actually
>> remove virtio_add_buf() until the *following* merge window, just to be
>> sure.
>
> Why not send out all the patches in this series? It would be much easier
> for people to read in one thread.

I could re-spam people, but the patches are unchanged and uninteresting:
the scsi one I wanted an Ack for, however.

I really want people to review the core patches, and if they're fine,
I'll post the whole thing one last time before putting them in my
virtio-next branch (where they can't change).

Cheers,
Rusty.
