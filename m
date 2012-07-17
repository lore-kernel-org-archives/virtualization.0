From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/5] Add vhost-blk support
Date: Tue, 17 Jul 2012 12:36:32 +0100
Message-ID: <CAJSP0QX4VqP+_YdfrqHtK5GrB+c8xmziBr=k9PE1WeyWWH_cgQ__38892.4221894287$1342525003$gmane$org@mail.gmail.com>
References: <1342107302-28116-1-git-send-email-asias@redhat.com>
	<CAJSP0QWgmXns89se+xdGgM6i1_hsfVWPQ8caHua9d-dDA4CTDQ@mail.gmail.com>
	<50052276.2080906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50052276.2080906@redhat.com>
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
Cc: linux-aio@kvack.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 9:29 AM, Asias He <asias@redhat.com> wrote:
> On 07/16/2012 07:58 PM, Stefan Hajnoczi wrote:
>> Does the vhost-blk implementation do anything fundamentally different
>> from userspace?  Where is the overhead that userspace virtio-blk has?
>
>
>
> Currently, no. But we could play with bio directly in vhost-blk as Christoph
> suggested which could make the IO path from guest to host's real storage
> even shorter in vhost-blk.

Wait :).  My point is that writing new code without systematically
investigating performance means that we're essentially throwing random
things and seeing what sticks.

Adding bio mode would make vhost-blk and kvmtool more different.
It'll probably make vhost-blk slightly faster but harder to compare
against kvmtool.  It's easier to start profiling before making that
change.

The reason I said "special-purpose kernel module" is because kvmtool
could be suffering from a bottleneck that can be fixed.  Other
userspace applications would also benefit from that fix - it would be
generally useful.  Adding a vhost-blk kernel module works around this
but only benefits KVM specifically.

Stefan
