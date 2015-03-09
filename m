From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio fixes pull for 4.0?
Date: Mon, 9 Mar 2015 09:50:28 +0100
Message-ID: <20150309095028.3f24c6c1.cornelia.huck@de.ibm.com>
References: <20150307193049.GA32459@redhat.com>
	<87y4n6wsmo.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87y4n6wsmo.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org, pawel.moll@arm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 09 Mar 2015 17:43:19 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:

> > 	virtio-balloon: do not call blocking ops when !TASK_RUNNING
> >
> > Rusty, it seems you prefer a different fix for this issue,
> > while Cornelia prefers mine. Maybe both me and Cornelia misunderstand the
> > issue? I know you dealt with a ton of similar issues recently
> > so you are more likely to be right, but I'd like to understand
> > what's going on better all the same. Could you help please?
> 
> In the longer run, we should handle failures from these callbacks.  But
> we don't need to do that right now.  So we want the minimal fix.
> 
> And an annotation is the minimal fix.  The bug has been there for ages;
> it's just the warning that is new (if we *always* slept, we would
> spin, but in practice we'll rarely sleep).

I don't think doing_io() in virtio-ccw will sleep often, although it
might happen under loads that delay posting the interrupt.

I understand why you'd like to do the minimal fix, and it's not likely
that new problems start popping up now.

So I'm OK with doing the annotation for 4.0 and more involved changes
for 4.1.
