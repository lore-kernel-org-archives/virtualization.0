From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC qemu PATCH] only writing out the last byte of MAC makes it
	have effect
Date: Fri, 22 Mar 2013 10:45:09 +1030
Message-ID: <87hak4ffxu.fsf@rustcorp.com.au>
References: <1363834956-9409-1-git-send-email-akong@redhat.com>
	<1363848290-30344-1-git-send-email-akong@redhat.com>
	<20130321105152.GB30874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321105152.GB30874@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Amos Kong <akong@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 21, 2013 at 02:44:50PM +0800, Amos Kong wrote:
>> The lengcy guests don't have mac programming command, we don't know when
>> it's safe to use MAC. This patch changed qemu to makes MAC change effect
>> when the last byte of MAC is written to config space.
>> 
>> MAC address takes first 6 bytes of config space of virtio-net, the addr
>> is 5 when the last byte is written in virtio_config_writeb().
>> 
>> MAC change will effect when n->mac is updated in virtio_net_set_config().
>> 
>> Signed-off-by: Amos Kong <akong@redhat.com>
>
> Let's see what Rusty says about the spec change.

Implementation notes like this belong as a footnote, eg:

        For older systems, it is recommended and typical that the device
        write byte 5 of the mac address last, so devices can use that as
        a trigger to commit the mac address change.

Now, is this a real, or theoretical issue?  Have we seen this problem in
practice, or should we continue to ignore it?

Cheers,
Rusty.
