From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio for 3.20
Date: Thu, 22 Jan 2015 11:29:44 +1030
Message-ID: <8761bzwry7.fsf@rustcorp.com.au>
References: <20150115183618.GA31025@redhat.com>
	<87egqrcxpn.fsf@rustcorp.com.au>
	<20150121174017.GA21032@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150121174017.GA21032@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Mon, Jan 19, 2015 at 12:56:28PM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > Hi Rusty, all
>> >
>> > I parked outstanding virtio patches here:
>> > git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-next
>> > this way they are merged in linux-next as well.
>> >
>> > Rusty if you'll be doing 3.20 window, would you mind
>> > checking that tree to verify nothing's lost?
>> 
>> Hi Michael,
>> 
>>         Thanks, now I've returned from linux.conf.au, I'm starting to
>> organize the 3.20 queue.  I've merged this branch into my virtio-next
>> branch.
>> 
>> Cheers,
>> Rusty.
>
> Thanks, good to know.
> I tweaked some patches since due to test failure reports by Gerd.
> Updated patches are tagged "post-squash", if you want to see what
> changed, see fixup patches in the series tagged "pre-squash".
>
> Or you can look at my tree:
>         git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git virtio-next
> is pre-squash.
>         git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-next
> is post-squash.

OK, I merged your vhost-next with my virtio-next, and the merge was
empty.

So we're up-to-date.  Please send patches against my virtio-next from
now on.

Thanks,
Rusty.
