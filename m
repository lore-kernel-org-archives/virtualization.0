From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 0/2] make mac programming for virtio net more robust
Date: Fri, 11 Jan 2013 12:53:07 +1030
Message-ID: <87fw281mr8.fsf__23194.4873733029$1357876577$gmane$org@rustcorp.com.au>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
	<20130110152829.GG30731@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130110152829.GG30731@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, akong@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 10, 2013 at 10:45:39PM +0800, akong@redhat.com wrote:
>> From: Amos Kong <akong@redhat.com>
>> 
>> Currenly mac is programmed byte by byte. This means that we
>> have an intermediate step where mac is wrong. 
>> 
>> Second patch introduced a new vq control command to set mac
>> address in one time.
>
> As you mention we could alternatively do it without
> new commands, simply add a feature bit that says that MACs are
> in the mac table.
> This would be a much bigger patch, and I'm fine with either way.
> Rusty what do you think?

Hmm, mac filtering and "my mac address" are not quite the same thing.  I
don't know if it matters for anyone: does it?  The mac address is abused
for things like identifying machines, etc.

If we keep it as a separate concept, Amos' patch seems to make sense.

Cheers,
Rusty.
